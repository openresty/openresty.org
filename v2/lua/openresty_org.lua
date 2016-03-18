local _M = {}

local view = require "openresty_org.view"
local model = require "openresty_org.model"
local cjson = require "cjson"

local concat = table.concat
local re_find = ngx.re.find
local sub = string.sub
local byte = string.byte

function _M.go()
    local uri = ngx.var.uri
    if uri == "/" then
        return ngx.redirect("/en/", 302)
    end

    if uri == "/en" then
        return ngx.redirect("/en/", 301)
    end

    local main_menu = model.get_main_menu()

    local posts = model.get_post_list()

    if uri == "/en/" then
        local home = model.get_home(posts.openresty)
        -- print("home data: ", cjson.encode(home))
        -- print(cjson.encode(home_html))

        local html = view.process("index.tt2",
                                  { main_menu = main_menu,
                                    skip_meta = true,
                                    title = home.title,
                                    body = home.html_body,

                                  })
        ngx.print(html)
        return
    end

    local fr, to, err = re_find(uri, [[^/en/([-\w]+)\.html$]], "jo", nil, 1)
    if not fr then
        return ngx.exit(404)
    end

    local tag = sub(uri, fr, to)

    print("tag: ", tag, ", fr: ", fr, ", to: ", to)

    if tag == "openresty" then
        return ngx.redirect("/en/", 301)
    end

    local id = posts[tag]
    if not id then
        return ngx.exit(404)
    end

    local rec = model.get_post(id)

    local html = view.process("page.tt2",
                              { main_menu = main_menu,
                                modified = rec.modified,
                                modifier = rec.modifier,
                                modifier_link = rec.modifier_link,
                                created = rec.created,
                                title = rec.title,
                                body = rec.html_body,
                               })

    ngx.print(html)
end

return _M