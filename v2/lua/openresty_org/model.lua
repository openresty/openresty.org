local _M = {}

-- TODO: we need to employ some kind of data caching here to avoid hitting
-- the database all the times.

local pgmoon = require "pgmoon"
local cjson = require "cjson"
local quote_sql_str = ndk.set_var.set_quote_pgsql_str

local db_spec = {
    host = "127.0.0.1",
    port = "5432",
    database = "openresty_org",
    user = "openresty",
    password = "speedtheweb",
}

local function query_db(query)
    local pg = pgmoon.new(db_spec)

    print("sql query: ", query)

    local ok, err

    for i = 1, 3 do
        ok, err = pg:connect()
        if not ok then
            ngx.log(ngx.ERR, "failed to connect to database: ", err)
            ngx.sleep(0.1)
        else
            break
        end
    end

    if not ok then
        ngx.log(ngx.ERR, "fatal response due to query failures")
        return ngx.exit(500)
    end

    -- the caller should ensure that the query has no side effects
    local res
    for i = 1, 2 do
        res, err = pg:query(query)
        if not res then
            ngx.log(ngx.ERR, "failed to send query: ", err)

            ngx.sleep(0.1)

            ok, err = pg:connect()
            if not ok then
                ngx.log(ngx.ERR, "failed to connect to database: ", err)
                break
            end
        else
            break
        end
    end

    if not res then
        ngx.log(ngx.ERR, "fatal response due to query failures")
        return ngx.exit(500)
    end

    local ok, err = pg:keepalive(0, 5)
    if not ok then
        ngx.log(ngx.ERR, "failed to keep alive: ", err)
    end

    return res
end

function _M.get_main_menu(lang)
    local res = query_db("select html_body from posts_" .. lang .. " where permlink = 'main-menu';")

    -- print("JSON: ", cjson.encode(res))
    if #res == 0 then
        ngx.log(ngx.ERR, "no main menu found")
        return ''
    end
    return res[1].html_body
end

function _M.get_home(lang, id)
    local res = query_db("select title, html_body, "
                         .. "extract(epoch from modified) as last_modified "
                         .. "from posts_" .. lang .. " where id = " .. id)

    -- print("JSON: ", cjson.encode(res))
    if #res == 0 then
        ngx.log(ngx.ERR, "no home found")
        return ''
    end
    return res[1]
end

function _M.get_post(lang, id)
    local res = query_db("select title, modifier, modifier_link, to_char(created, 'dd Mon yyyy') as created, "
                         .. "to_char(modified, 'dd Mon yyyy') as modified, "
                         .. "extract(epoch from modified) as last_modified, html_body from posts_" .. lang
                         .. " where id = " .. id)

    -- print("JSON: ", cjson.encode(res))
    if #res == 0 then
        ngx.log(ngx.ERR, "no home found")
        return ''
    end
    return res[1]
end

function _M.get_post_list(lang)
    local res = query_db("select permlink, id from posts_" .. lang)
    if #res == 0 then
        ngx.log(ngx.ERR, "no posts found")
        return ngx.exit(500)
    end

    local posts = {}
    for _, row in ipairs(res) do
        posts[row.permlink] = row.id
    end
    return posts
end

function _M.get_timeline(lang)
    local res = query_db("select title, permlink, to_char(modified, 'dd Mon yyyy') as day "
                         .. "from posts_" .. lang .. " order by modified desc limit 17");
    return res
end

function _M.get_search_results(lang, query)
    -- print("search query: ", query)
    local quoted_query = quote_sql_str(query)
    local res = query_db("select title, "
                         .. "ts_headline(txt_body, q, 'MaxFragments=1') as body, "
                         .. "permlink from (select q, title, txt_body, "
                         .. "ts_rank_cd(textsearch_index_col, q) as rank, "
                         .. "permlink from posts_" .. lang .. ", plainto_tsquery("
                         .. quoted_query .. ") q "
                         .. "where textsearch_index_col @@ q "
                         .. "order by rank desc limit 10) as foo")
    return res
end

return _M
