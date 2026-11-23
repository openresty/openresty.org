#!/usr/bin/env node

const fs = require('fs');

(async () => {

// marked is ESM-only; dynamic import() keeps this script working on
// Node versions without require(esm) support.
const {marked} = await import('marked');
const {default: sanitizeHtml} = await import('sanitize-html');
const renderer = new marked.Renderer();
const defaultHtmlRenderer = renderer.html;
const defaultLinkRenderer = renderer.link;
const defaultImageRenderer = renderer.image;
const punctuation =
    /[\u2000-\u206F\u2E00-\u2E7F\\'!"#$%&()*+,./:;<=>?@[\]^`{|}~]/g;

function slugify(value) {
    return value
        .toLowerCase()
        .trim()
        .replace(/<[!\/a-z].*?>/ig, '')
        .replace(punctuation, '')
        .replace(/\s/g, '-');
}

class Slugger {
    constructor() {
        this.seen = Object.create(null);
    }

    slug(value) {
        const originalSlug = slugify(value);
        let slug = originalSlug;
        let occurrence = this.seen[originalSlug] || 0;

        while (Object.prototype.hasOwnProperty.call(this.seen, slug)) {
            occurrence++;
            slug = originalSlug + '-' + occurrence;
        }

        this.seen[originalSlug] = occurrence;
        this.seen[slug] = 0;
        return slug;
    }
}

const headingSlugger = new Slugger();

// Neutralize dangerous URL schemes (javascript:, data:, vbscript:, file:) in
// Markdown links and images. marked does not block these itself, so a
// malicious `[x](javascript:alert(1))` would otherwise survive rendering.
function sanitizeUrl(url) {
    if (url == null) {
        return '';
    }
    // Strip whitespace and control chars that could smuggle a scheme past a
    // naive prefix check (e.g. "java\nscript:").
    const s = String(url).trim().replace(/[\u0000-\u001f\u007f]/g, '');
    if (/^(javascript|data|vbscript|file):/i.test(s)) {
        return '';
    }
    return s;
}

// Whitelist for the rendered body HTML. Keeps the markup this site depends on
// (heading permalink anchors + their inline SVG, fenced code blocks with
// language classes, tables, GFM task lists, lazy-loaded images) while dropping
// everything else — notably raw <script>, <iframe>, <style>, event handlers,
// and inline style attributes an author could smuggle into a Markdown file.
const SANITIZE_OPTIONS = {
    allowedTags: [
        'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
        'p', 'br', 'hr',
        'a', 'img', 'input', 'form',
        'strong', 'em', 'b', 'i', 'u', 's', 'del', 'strike',
        'sup', 'sub', 'code', 'pre', 'kbd', 'mark', 'abbr', 'small',
        'blockquote', 'ul', 'ol', 'li', 'dl', 'dt', 'dd',
        'table', 'thead', 'tbody', 'tfoot', 'tr', 'th', 'td', 'caption',
        'div', 'span',
        'svg', 'path',
    ],
    allowedAttributes: {
        a: ['href', 'title', 'id', 'class', 'rel', 'target'],
        img: ['src', 'alt', 'title', 'width', 'height', 'loading'],
        input: ['type', 'name', 'value', 'checked', 'disabled', 'src', 'alt'],
        form: ['name', 'action', 'method', 'target'],
        th: ['colspan', 'rowspan', 'align'],
        td: ['colspan', 'rowspan', 'align'],
        // htmlparser2 lowercases attribute names, so use `viewbox` here and
        // restore the case-sensitive `viewBox` after sanitization (see below).
        svg: ['viewbox', 'width', 'height', 'fill', 'stroke',
              'stroke-width', 'stroke-linecap', 'stroke-linejoin',
              'class', 'aria-hidden', 'focusable', 'role'],
        path: ['d', 'fill', 'stroke', 'stroke-width',
               'stroke-linecap', 'stroke-linejoin'],
        '*': ['id', 'class'],
    },
    allowedSchemes: ['http', 'https', 'mailto'],
    // `action` is a URL attribute but is not in sanitize-html's default scheme
    // filter list; include it so <form action="javascript:..."> is also blocked.
    allowedSchemesAppliedToAttributes: ['href', 'src', 'cite', 'action'],
    allowProtocolRelative: true,
};

marked.setOptions({
    gfm: true,
});

// Keep block HTML separated from the following Markdown token. gen-data.pl
// relies on the metadata comment ending at a line boundary.
renderer.html = function (token) {
    const html = defaultHtmlRenderer.call(this, token);
    return token.block && !html.endsWith('\n') ? html + '\n' : html;
}

// create internal links for ()[#]
renderer.link = function (token) {
    const link = {...token};
    link.title = link.title || link.text;

    link.href = sanitizeUrl(link.href);

    if (link.href === '#') {
        link.href = '#' + slugify(link.text);
    }

    return defaultLinkRenderer.call(this, link);
}

// add link icon for each heading, just like github
renderer.heading = function ({tokens, depth, text}) {
    const anchorId = headingSlugger.slug(text);
    const heading = this.parser.parseInline(tokens);
    return '<h' + depth + '>'
        + '<a id="' + anchorId + '" class="header-anchor" href="#' + anchorId + '" title="copy permalink to clipboard">'
        + '<svg class="icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-link"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>'
        + '</a>' + heading
        + '</h' + depth + '>\n';
};

// add loading="lazy" to all markdown images (below-the-fold article images)
renderer.image = function (token) {
    const img = {...token};
    img.href = sanitizeUrl(img.href);
    const html = defaultImageRenderer.call(this, img);
    return html.replace(/>$/, ' loading="lazy">');
};

const args = process.argv.slice(2);
if (args.length === 0) {
    console.log('please provide input file');
    process.exit(0);
}

const infile = args[0];
fs.open(infile, 'r', function (err, fd) {
    if (err) {
        if (err.code === 'ENOENT') {
            console.error(infile + ' does not exist');
            return;
        }

        throw err;
    }

    fs.readFile(infile, 'utf8', function (err, data) {
        if (err) throw err;
        const rendered = marked(data, { renderer: renderer });

        // gen-data.pl strips the leading `<!--- ... --->` metadata comment and
        // stores it in separate columns; it must survive sanitization intact.
        // Sanitize only the body, then re-attach the comment verbatim.
        const match = rendered.match(/^(\s*<!---[\s\S]*?--->)/);
        const meta = match ? match[1] : '';
        const body = match ? rendered.slice(match[1].length) : rendered;

        // htmlparser2 lowercases `viewBox` to `viewbox`, which browsers ignore
        // (the SVG attribute is case-sensitive). Restore it so the heading
        // permalink icons keep their correct coordinate system.
        const clean = sanitizeHtml(body, SANITIZE_OPTIONS)
            .replace(/\bviewbox=/g, 'viewBox=');

        console.log(meta + clean);
    });
});

})();
