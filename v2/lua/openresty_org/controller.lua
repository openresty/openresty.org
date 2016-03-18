local _M = {}

local view = require "openresty_org.view"
local model = require "openresty_org.model"
local cjson = require "cjson"

local concat = table.concat
local re_find = ngx.re.find
local sub = string.sub
local byte = string.byte
local http_time = ngx.http_time
local tonumber = tonumber
local resp_header = ngx.header
local ngx_var = ngx.var
local format = string.format
local unescape_uri = ngx.unescape_uri

local MAX_SEARCH_QUERY_LEN = 128

local function gen_cache_control_headers(ts)
    resp_header["Last-Modified"] = http_time(tonumber(ts))
    resp_header["Cache-Control"] = "public,max-age=300"
end

local function search_error(main_menu, timeline, query, title, msg)
    local html = view.process("page.tt2",
                              { main_menu = main_menu,
                                skip_meta = true,
                                title = title,
                                search_query = query,
                                body = msg,
                                timeline = timeline,
                              })
    ngx.print(html)
end

function _M.run()
    local uri = ngx_var.uri
    if uri == "/" then
        return ngx.redirect("/en/", 302)
    end

    if uri == "/en" then
        return ngx.redirect("/en/", 301)
    end

    local posts = model.get_post_list()

    if uri == "/en/" then
        local main_menu = model.get_main_menu()
        local timeline = model.get_timeline()

        local home = model.get_home(posts.openresty)
        -- print("home data: ", cjson.encode(home))
        -- print(cjson.encode(home_html))

        gen_cache_control_headers(home.last_modified)

        local html = view.process("index.tt2",
                                  { main_menu = main_menu,
                                    skip_meta = true,
                                    title = home.title,
                                    body = home.html_body,
                                    timeline = timeline,
                                  })
        ngx.print(html)
        return
    end

    local fr, to, err = re_find(uri, [[^/en/([-\w]+)\.html$]], "jo", nil, 1)
    if not fr then
        return ngx.exit(404)
    end

    local tag = sub(uri, fr, to)

    -- print("tag: ", tag, ", fr: ", fr, ", to: ", to)

    if tag == "openresty" then
        return ngx.redirect("/en/", 301)
    end

    if tag == "search" then
        local main_menu = model.get_main_menu()
        local timeline = model.get_timeline()

        local query = unescape_uri(ngx_var.arg_query)
        if not query or #query == 0 then
            return search_error(main_menu, timeline, query,
                                "Bad search query",
                                "<p>No query providied.</p>")
        end

        if #query > MAX_SEARCH_QUERY_LEN then
            local title = "Bad search query"
            local msg = format("<p>Query too long (more than %d bytes).</p>",
                               MAX_SEARCH_QUERY_LEN)
            return search_error(main_menu, timeline, query, title, msg)
        end

        local res = model.get_search_results(query)

        if #res == 0 then
            return search_error(main_menu, timeline, query, "No search results found",
                                "<p>Please adjust your search query and try again.</p>")
        end

        -- print("search result: ", cjson.encode(res))

        local result_html = view.process("search-result.tt2", { hits = res })

        local html = view.process("page.tt2",
                                  { main_menu = main_menu,
                                    skip_meta = true,
                                    title = "Search result",
                                    search_query = query,
                                    body = concat(result_html),
                                    timeline = timeline,
                                  })
        ngx.print(html)
        return
    end

    local id = posts[tag]
    if not id then
        return ngx.exit(404)
    end

    local main_menu = model.get_main_menu()
    local timeline = model.get_timeline()

    local rec = model.get_post(id)

    gen_cache_control_headers(rec.last_modified)

    local html = view.process("page.tt2",
                              { main_menu = main_menu,
                                modified = rec.modified,
                                modifier = rec.modifier,
                                modifier_link = rec.modifier_link,
                                created = rec.created,
                                title = rec.title,
                                body = rec.html_body,
                                timeline = timeline,
                               })

    ngx.print(html)
end

return _M
