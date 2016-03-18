local _M = {}

local pgmoon = require "pgmoon"
local cjson = require "cjson"

local db_spec = {
    host = "127.0.0.1",
    port = "5432",
    database = "openresty_org",
    user = "openresty",
    password = "speedtheweb",
}

local function query_db(query)
    local pg = pgmoon.new(db_spec)

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

function _M.get_main_menu()
    local res = query_db("select html_body from posts where title = 'Main Menu';")

    -- print("JSON: ", cjson.encode(res))
    if #res == 0 then
        ngx.log(ngx.ERR, "no main menu found")
        return ''
    end
    return res[1].html_body
end

function _M.get_home(id)
    local res = query_db("select title, html_body from posts where id = " .. id)

    -- print("JSON: ", cjson.encode(res))
    if #res == 0 then
        ngx.log(ngx.ERR, "no home found")
        return ''
    end
    return res[1]
end

function _M.get_post(id)
    local res = query_db("select title, modifier, modifier_link, to_char(created, 'dd Mon yyyy') as created, "
                         .. "to_char(modified, 'dd Mon yyyy') as modified, html_body from posts "
                         .. "where id = " .. id)

    -- print("JSON: ", cjson.encode(res))
    if #res == 0 then
        ngx.log(ngx.ERR, "no home found")
        return ''
    end
    return res[1]
end

function _M.get_post_list()
    local res = query_db("select permlink, id from posts")
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

function _M.get_timeline()
    local res = query_db("select title, permlink, to_char(modified, 'dd Mon yyyy') as day from posts order by modified desc limit 20");
    return res
end

return _M
