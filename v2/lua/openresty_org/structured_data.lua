-- Structured data (JSON-LD) generation for openresty.org pages.
--
-- Emits schema.org entities:
--   * Organization (site-wide)
--   * SoftwareApplication / SoftwareSourceCode for software pages
--   * HowTo / TechArticle for documentation & tutorial pages
--   * BreadcrumbList (site-wide)
--
-- The blocks are built here and injected into the rendered HTML by the
-- controller (see openresty_org.controller), before `</head>`.

local cjson = require "cjson"

local _M = {}

local BASE_URL = "https://openresty.org"

local ORGANIZATION = {
    ["@context"] = "https://schema.org",
    ["@type"] = "Organization",
    name = "OpenResty",
    url = BASE_URL .. "/",
    logo = BASE_URL .. "/images/logo.webp",
    sameAs = {
        "https://github.com/openresty/",
        "https://www.youtube.com/channel/UCXVmwF-UCScv2ftsGoMqxhw/",
        "https://forum.openresty.us/",
    },
}

-- Make an encoded JSON string safe to embed inside a <script> block:
-- escape < > & so a stray "</script>" (or similar) in the data can never
-- terminate the block early.
local function html_safe_json(json)
    return json:gsub("<", "\\u003c"):gsub(">", "\\u003e"):gsub("&", "\\u0026")
end

local function encode(t)
    return html_safe_json(cjson.encode(t))
end

local function script_block(t)
    return '<script type="application/ld+json">' .. encode(t) .. "</script>"
end

local function language_name(lang)
    if lang == "cn" then
        return "zh-CN"
    end
    return "en"
end

-- Classify a permlink into a schema.org @type.
local function classify(permlink)
    -- Source-code components: Nginx modules and Lua libraries.
    if permlink:match("%-nginx%-module$")
        or permlink:match("%-library$")
        or permlink == "nginx-devel-kit"
        or permlink == "libdrizzle"
        or permlink == "standard-lua-interpreter"
        or permlink == "resty-cli"
    then
        return "SoftwareSourceCode"
    end

    -- The software applications / runtimes themselves.
    if permlink == "nginx" or permlink == "luajit" then
        return "SoftwareApplication"
    end

    -- Step-by-step guides and tutorials.
    if permlink == "getting-started"
        or permlink == "installation"
        or permlink == "using-luarocks"
        or permlink == "build-systemtap"
        or permlink == "debugging"
        or permlink == "profiling"
        or permlink == "upgrading"
        or permlink == "dynamic-routing-based-on-redis"
        or permlink == "routing-mysql-queries-based-on-uri-args"
    then
        return "HowTo"
    end

    -- Reference documentation, release notes and change logs.
    if permlink == "faq"
        or permlink == "c-coding-style-guide"
        or permlink == "components"
        or permlink == "quality-assurance"
        or permlink == "benchmark"
        or permlink == "git-workflow"
        or permlink == "ec2-test-cluster"
        or permlink == "changes"
        or permlink:match("^ann%-")
        or permlink:match("^changelog%-")
    then
        return "TechArticle"
    end

    return "WebPage"
end

-- Organization block only (used on utility pages like search & videos).
function _M.organization()
    return script_block(ORGANIZATION)
end

-- Home page: Organization + WebSite.
function _M.home(lang)
    return script_block(ORGANIZATION) .. "\n" .. script_block({
        ["@context"] = "https://schema.org",
        ["@type"] = "WebSite",
        name = "OpenResty",
        url = BASE_URL .. "/" .. lang .. "/",
        inLanguage = language_name(lang),
    })
end

-- Content page: Organization + type-specific entity + BreadcrumbList.
function _M.page(opts)
    local lang = opts.lang or "en"
    local permlink = opts.permlink
    local title = opts.title or ""
    local description = opts.description

    local url = BASE_URL .. "/" .. lang .. "/"
    if permlink then
        url = url .. permlink .. ".html"
    end

    local blocks = { script_block(ORGANIZATION) }

    local stype = permlink and classify(permlink) or "WebPage"
    local entity = {
        ["@context"] = "https://schema.org",
        ["@type"] = stype,
        url = url,
        inLanguage = language_name(lang),
    }
    if stype == "TechArticle" then
        entity.headline = title
    else
        entity.name = title
    end
    if description and description ~= "" then
        entity.description = description
    end
    blocks[#blocks + 1] = script_block(entity)

    blocks[#blocks + 1] = script_block({
        ["@context"] = "https://schema.org",
        ["@type"] = "BreadcrumbList",
        itemListElement = {
            {
                ["@type"] = "ListItem",
                position = 1,
                name = "Home",
                item = BASE_URL .. "/" .. lang .. "/",
            },
            {
                ["@type"] = "ListItem",
                position = 2,
                name = title,
                item = url,
            },
        },
    })

    return table.concat(blocks, "\n")
end

-- Inject the JSON-LD blocks into rendered HTML, just before </head>
-- (falling back to </body>, then appending).
-- the template engine returns the rendered page as a (possibly nested)
-- array of string chunks, as accepted by ngx.print; flatten it to a string
local function flatten(chunks, out)
    for i = 1, #chunks do
        local c = chunks[i]
        if type(c) == "table" then
            flatten(c, out)
        else
            out[#out + 1] = c
        end
    end
    return out
end

function _M.inject(html, jsonld)
    if type(html) == "table" then
        html = table.concat(flatten(html, {}))
    end

    if not jsonld or jsonld == "" then
        return html
    end

    local pos = html:find("</head>", 1, true)
    if pos then
        return html:sub(1, pos - 1) .. jsonld .. "\n" .. html:sub(pos)
    end

    pos = html:find("</body>", 1, true)
    if pos then
        return html:sub(1, pos - 1) .. jsonld .. "\n" .. html:sub(pos)
    end

    return html .. jsonld
end

return _M
