#!/usr/bin/env node

const fs = require('fs');
const cheerio = require('cheerio');
const axios = require('axios');

const http = axios.create();

async function genSlideTemplate(lang) {
  const base = lang === 'en' ? 'https://blog.openresty.com/en/' : 'https://blog.openresty.com.cn/cn/';
  const source = `${base}atom.xml`;
  let rss = await http.get(source);
  const $ = cheerio.load(rss.data, { decodeEntities: false });
  const html = fs.readFileSync('./util/posts-slide.html', 'utf-8');
  const $Template = cheerio.load(html, { decodeEntities: false });

  $('entry').slice(0, 10).each((index, entry) => {
    const title = $(entry).children('title').text();
    const array = $(entry).children('id').text().split('/');
    const id = array[array.length - 2];
    const pic = $(entry).children('pic').text();
    const picName = pic.split('.')[0];
    const webp = `${picName}.webp`;

    const text = $Template(`<p class="blog-title">${title}</p>`);
    const textContainer = $Template('<div class="article-text"></div>');
    textContainer.append(text);

    const source = $Template(`<source srcset="${base}${webp}" type="image/webp" />`);
    const img = $Template(`<img class="article-img" src="${base}${pic}" />`);
    const picture = $Template(`<picture></picture>`);
    picture.append(source).append(img);

    const imgContainer = $Template(`<div class="blog-img" data-pic="${pic}"></div>`);
    imgContainer.append(picture);

    const link = $Template(`<a class="article-item swiper-slide" href="${base}${id}" target="_blank">`);
    link.append(imgContainer);
    link.append(textContainer);

    $Template('.swiper-wrapper').append(link);

    fs.writeFileSync(`./templates/posts-slide-${lang}.tt2`, $Template.html());
  });
};

genSlideTemplate('en');
genSlideTemplate('cn');
