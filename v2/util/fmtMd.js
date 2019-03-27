#!/usr/bin/env node

var fs = require('fs');
var marked = require('marked');
var renderer = new marked.Renderer();
var matchHtmlRegExp = /["'&<>]/;

function escapeHtml(string) {
    var str = '' + string;
    var match = matchHtmlRegExp.exec(str);

    if (!match) {
        return str;
    }

    var escape;
    var html = '';
    var index = 0;
    var lastIndex = 0;

    for (index = match.index; index < str.length; index++) {
        switch (str.charCodeAt(index)) {
            case 34: // "
                escape = '&quot;';
                break;
            case 38: // &
                escape = '&amp;';
                break;
            case 39: // '
                escape = '&#39;';
                break;
            case 60: // <
                escape = '&lt;';
                break;
            case 62: // >
                escape = '&gt;';
                break;
            default:
                continue;
        }

        if (lastIndex !== index) {
            html += str.substring(lastIndex, index);
        }

        lastIndex = index + 1;
        html += escape;
    }

    return lastIndex !== index ?
        html + str.substring(lastIndex, index) :
        html;
}

marked.setOptions({
    gfm: true,
});

// create internal links for ()[#]
renderer.link = function (href, title, text) {
    title = title || text;
    if (href === '#') {
        var slugger = new marked.Slugger();
        href = '#' + slugger.slug(text);
    }
    title = escapeHtml(title);
    return '<a href="' + href + '" title="' + title + '">' + text + '</a>';
}

// add link icon for each heading, just like github
renderer.heading = function (text, level, raw, slugger) {
    var anchorId = renderer.options.headerPrefix + slugger.slug(raw);
    return '<h' + level + '>'
        + '<a id="' + anchorId + '" class="header-anchor" href="#' + anchorId + '" title="copy permalink to clipboard">'
        + '<svg class="icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-link"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>'
        + '</a>' + text
        + '</h' + level + '>\n';
};

var args = process.argv.slice(2);
if (args.length === 0) {
    console.log('please provide input file');
    process.exit(0);
}

var infile = args[0];
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
        console.log(marked(data, {
            renderer: renderer
        }));
    });
});
