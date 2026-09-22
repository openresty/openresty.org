-- Structured data (JSON-LD) generation for openresty.org pages.
--
-- Emits schema.org entities:
--   * SoftwareApplication + SoftwareSourceCode for the open-source OpenResty
--     project itself (site-wide, @id https://openresty.org/#software),
--     with OpenResty Inc. (https://openresty.com/#org) as its maintainer
--   * SoftwareApplication / SoftwareSourceCode for software pages
--   * HowTo / TechArticle for documentation & tutorial pages
--   * BreadcrumbList (site-wide)
--
-- The blocks are built here and injected into the rendered HTML by the
-- controller (see openresty_org.controller), before `</head>`.

local cjson = require "cjson"

local _M = {}

local BASE_URL = "https://openresty.org"

-- The open-source OpenResty project as a software entity. This deliberately
-- is NOT an Organization: the company behind the project is OpenResty Inc.,
-- whose entity (@id https://openresty.com/#org) is defined on openresty.com
-- and is referenced here as the maintainer. Keep this block in sync with the
-- copy in Appendix C of the entity checklist. Notes on the individual fields:
--
--   * @id "#software" is distinct from the company "#org" and from the
--     "#software" ids of the commercial products (XRay, Edge);
--   * the dual @type is required: codeRepository is only valid under
--     SoftwareSourceCode, yet the project is also an application/runtime;
--   * maintainer inlines @type/name/url (not a bare @id reference) so this
--     block alone states that the maintainer is OpenResty Inc., without
--     requiring a crawler to have seen openresty.com as well;
--   * description is the canonical OSS definition sentence, do not reword;
--   * sameAs lists only GitHub and the forum; the YouTube channel already
--     belongs to the company entity on openresty.com;
--   * license: the openresty/openresty COPYRIGHT file is BSD 2-Clause.
local SOFTWARE = {
    ["@context"] = "https://schema.org",
    ["@type"] = { "SoftwareApplication", "SoftwareSourceCode" },
    ["@id"] = BASE_URL .. "/#software",
    name = "OpenResty",
    url = BASE_URL .. "/",
    description = "OpenResty is an open-source web platform that integrates "
                  .. "an enhanced Nginx core with LuaJIT, maintained by "
                  .. "OpenResty Inc.",
    applicationCategory = "DeveloperApplication",
    operatingSystem = "Linux",
    codeRepository = "https://github.com/openresty/openresty",
    license = "https://opensource.org/licenses/BSD-2-Clause",
    sameAs = {
        "https://github.com/openresty/",
        "https://forum.openresty.us/",
    },
    maintainer = {
        ["@type"] = "Organization",
        ["@id"] = "https://openresty.com/#org",
        name = "OpenResty Inc.",
        url = "https://openresty.com",
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

-- Software block only (used on utility pages like search & videos).
function _M.software()
    return script_block(SOFTWARE)
end

-- Home page: Software + WebSite.
function _M.home(lang)
    return script_block(SOFTWARE) .. "\n" .. script_block({
        ["@context"] = "https://schema.org",
        ["@type"] = "WebSite",
        name = "OpenResty",
        url = BASE_URL .. "/" .. lang .. "/",
        inLanguage = language_name(lang),
    })
end

-- Content page: Software + type-specific entity + BreadcrumbList.
function _M.page(opts)
    local lang = opts.lang or "en"
    local permlink = opts.permlink
    local title = opts.title or ""
    local description = opts.description

    local url = BASE_URL .. "/" .. lang .. "/"
    if permlink then
        url = url .. permlink .. ".html"
    end

    local blocks = { script_block(SOFTWARE) }

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
