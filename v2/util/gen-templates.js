#!/usr/bin/env node

const fs = require('fs');
const {writeFile, readdir} = fs.promises;
const sharp = require('sharp');
const cheerio = require('cheerio');
const axios = require('axios');
const pug = require('pug');

const http = axios.create();
const enBase = 'https://blog.openresty.com/en/';
const cnBase = 'https://blog.openresty.com.cn/cn/';
const staticBaseUrl = 'https://static.openresty.com';
const height = 260;
let pics = new Set();
let picsExists;

async function genSlideTemplate(lang) {
  let postInfos = [];
  let news = [];
  const base = lang === 'en' ? enBase : cnBase;
  const source = `${base}atom.xml`;
  let rss = await http.get(source);
  const $ = cheerio.load(rss.data, { decodeEntities: false });
  const length = 10;

  if (!picsExists) {
    picsExists = await readdir('./images/header-images');
  }

  $('entry').filter((index, entry) => {
    const tags = $(entry).children('tags').text();
    return tags && (tags.includes('xray') || tags.includes('openresty-edge') || tags.includes('openresty-showman') || tags.includes('packages'));
  }).slice(0, length).each((index, entry) => {
    const title = $(entry).children('title').text();
    const array = $(entry).children('id').text().split('/');
    const id = array[array.length - 2];
    const pic = $(entry).children('pic').text();

    // images will be downloaded and compressed only when they do not exist yet
    if (!picsExists.includes(pic.split('/header-images/')[1])) {
      pics.add(pic);
    }

    postInfos.push({href: `${base}${id}`, pic, title})

    if (index <= 2) {
      news.push({href: `${base}${id}`, pic, title})
    }
  });

  const compileFunction = pug.compileFile('./util/posts-slide.pug', {pretty: true});
  const swiperCss = lang == 'en' ? `${staticBaseUrl}/swiper/5.2.1/css/swiper.min.css` : `${staticBaseUrl}.cn/swiper/5.2.1/css/swiper.min.css`;
  const swiperJs = lang == 'en' ? `${staticBaseUrl}/swiper/5.2.1/js/swiper.min.js` : `${staticBaseUrl}.cn/swiper/5.2.1/js/swiper.min.js`;
  writeFile(`./templates/posts-slide-${lang}.tt2`, compileFunction({postInfos, swiperCss, swiperJs}));

  const newsCompileFunction = pug.compileFile('./util/news.pug', {pretty: true});
  writeFile(`./templates/news-${lang}.tt2`, newsCompileFunction({news}));
};

Promise.all([
  genSlideTemplate('en'),
  genSlideTemplate('cn'),
]).then(() => {
  for(pic of pics) {
    optimizeImg(pic);
  }
})

async function optimizeImg(pic) {
  const response = await axios({
    url: `${cnBase}${pic}`,
    method: "GET",
    responseEncoding: "binary",
  });

  await writeFile(`./images${pic}`, response.data, 'binary');
  compressImg(`./images${pic}`);
};

async function compressImg(filePath) {
  try {
    const data = await sharp(filePath).resize({
      height,
      fit: 'contain',
      withoutEnlargement: true,
    })
    .toBuffer();

    return writeFile(filePath, data);
  } catch (err) {
    console.error(filePath, err);
  }
}
