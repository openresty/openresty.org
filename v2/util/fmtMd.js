#!/usr/bin/env node

var fs = require('fs');
var marked = require('marked');
var renderer = new marked.Renderer();

marked.setOptions({
    gfm: true,
});

renderer.link = function (href, title, text) {
    title = title || text;
    if (href === '#') {
        var slugger = new marked.Slugger();
        href = '#' + slugger.slug(text); // create internal links
    }
    return '<a href="' + href + '" title="' + title + '">' + text + '</a>';
}

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
