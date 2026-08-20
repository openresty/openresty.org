-- Multilingual hreflang annotations for openresty.org pages.
--
-- Every page declares its language alternates so search engines can map the
-- /en/ and /cn/ versions of the same page to each other:
--
--   <link rel="alternate" hreflang="en" href="https://openresty.org/en/...">
--   <link rel="alternate" hreflang="zh" href="https://openresty.org/cn/...">
--   <link rel="alternate" hreflang="x-default" href="https://openresty.org/en/...">
--
-- The links are built here and injected into the rendered HTML by the
-- controller (see openresty_org.controller), before `</head>`.

local _M = {}

local BASE_URL = "https://openresty.org"

local function link(hreflang, url)
    return '<link rel="alternate" hreflang="' .. hreflang .. '" href="'
        .. url .. '">'
end

-- Build the hreflang <link> tags for a page.
--
-- opts.permlink   (optional) page permlink; omit for the home page.
-- opts.en_exists  (optional, default true) whether the English version exists.
-- opts.cn_exists  (optional, default true) whether the Chinese version exists.
function _M.links(opts)
    opts = opts or {}
    local path = opts.permlink and (opts.permlink .. ".html") or ""

    local out = {}
    if opts.en_exists ~= false then
        out[#out + 1] = link("en", BASE_URL .. "/en/" .. path)
    end
    if opts.cn_exists ~= false then
        out[#out + 1] = link("zh", BASE_URL .. "/cn/" .. path)
    end
    out[#out + 1] = link("x-default", BASE_URL .. "/en/" .. path)

    return table.concat(out, "\n")
end

return _M
