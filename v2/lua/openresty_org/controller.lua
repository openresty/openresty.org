local _M = {}

local view = require "openresty_org.view"
local model = require "openresty_org.model"
local cjson = require "cjson"
local i18n_class = require "openresty_org.i18n"

local concat = table.concat
local re_find = ngx.re.find
local re_match = ngx.re.match
local sub = string.sub
local byte = string.byte
local http_time = ngx.http_time
local tonumber = tonumber
local resp_header = ngx.header
local ngx_var = ngx.var
local format = string.format
local unescape_uri = ngx.unescape_uri
local match_table = {}

local i18n_objs = {
    ['cn'] = i18n_class.new('cn'),
    ['en'] = i18n_class.new('en'),
}

local MAX_SEARCH_QUERY_LEN = 128

local function gen_cache_control_headers(ts)
    resp_header["Last-Modified"] = http_time(tonumber(ts))
    resp_header["Cache-Control"] = "public,max-age=300"
end

local function search_error(i18n, main_menu, timeline, query, title, msg)
    local html = view.process("page.tt2",
                              { main_menu = main_menu,
                                skip_meta = true,
                                title = title,
                                search_query = query,
                                body = "<p>" .. msg .. "</p>",
                                timeline = timeline,
                              },
                              i18n)
    ngx.print(html)
end

function _M.run()
    local uri = ngx_var.uri
    if uri == "/" then
        return ngx.redirect("/en/", 302)
    end

    if (re_find(uri, [[ ^ / (?: [a-z]{2} ) $ ]], 'jox')) then
        return ngx.redirect(uri .. "/", 301)
    end

    local m, err = re_match(uri, [[ ^ / ( [a-z]{2} ) / (?: ([-\w]+) \.html )? $ ]], 'jox', nil, match_table)
    if not m then
        return ngx.exit(404)
    end

    local lang = m[1]
    print("lang: ", lang)

    local i18n = i18n_objs[lang]
    if not i18n then
        return ngx.exit(404)
    end

    local _ = i18n.translate

    local tag = m[2]

    local posts = model.get_post_list(lang)

    if not tag then
        local main_menu = model.get_main_menu(lang)
        local timeline = model.get_timeline(lang)

        local home = model.get_home(lang, posts.openresty)
        -- print("home data: ", cjson.encode(home))
        -- print(cjson.encode(home_html))

        gen_cache_control_headers(home.last_modified)

        local html = view.process("index.tt2",
                                  { main_menu = main_menu,
                                    skip_meta = true,
                                    title = home.title,
                                    body = home.html_body,
                                    timeline = timeline,
                                  },
                                  i18n)
        ngx.print(html)
        return
    end

    -- print("tag: ", tag, ", fr: ", fr, ", to: ", to)

    if tag == "openresty" then
        return ngx.redirect("/" .. lang .. "/", 301)
    end

    if tag == "search" then
        local main_menu = model.get_main_menu(lang)
        local timeline = model.get_timeline(lang)

        local query = unescape_uri(ngx_var.arg_query)
        if not query or #query == 0 then
            return search_error(i18n, main_menu, timeline, query,
                                _("Bad search query"),
                                _("No query provided."))
        end

        if #query > MAX_SEARCH_QUERY_LEN then
            local title = _("Bad search query")
            local msg = format(_("Query too long (more than %d bytes)."),
                               MAX_SEARCH_QUERY_LEN)
            return search_error(i18n, main_menu, timeline, query, title, msg)
        end

        local res = model.get_search_results(lang, query)

        if #res == 0 then
            return search_error(i18n, main_menu, timeline, query,
                                _("No search results found"),
                                _("Please adjust your search query and try again."))
        end

        -- print("search result: ", cjson.encode(res))

        local result_html = view.process("search-result.tt2", { hits = res }, i18n)

        local html = view.process("page.tt2",
                                  { main_menu = main_menu,
                                    skip_meta = true,
                                    title = _("Search Result"),
                                    search_query = query,
                                    body = concat(result_html),
                                    timeline = timeline,
                                  },
                                  i18n)
        ngx.print(html)
        return
    end

    local id = posts[tag]
    if not id then
        return ngx.exit(404)
    end

    local main_menu = model.get_main_menu(lang)
    local timeline = model.get_timeline(lang)

    local rec = model.get_post(lang, id)

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
                               },
                               i18n)

    ngx.print(html)
end

return _M
