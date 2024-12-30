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
const picBase = 'https://blog.openresty.com/';
const staticBaseUrl = 'https://static.openresty.com';
const height = 260;
let pics = new Set();
let picsExists;

async function genSlideTemplate(lang) {
  let postInfos = [];
  let news = [];
  const base = lang === 'en' ? enBase : cnBase;
  const source = `${base}index.xml`;
  let rss = await http.get(source);
  const $ = cheerio.load(rss.data, { decodeEntities: false });
  const length = 20;

  if (!picsExists) {
    picsExists = await readdir('./images/header-images');
  }

  $('item').filter((index, entry) => {
    const tags = $(entry).children('tags').text();
    const priv = $(entry).children('private').text();
    return tags && (tags.includes('xray') || tags.includes('openresty-edge') || tags.includes('openresty-showman') || tags.includes('packages') || tags.includes('openresty-xray')) && priv !== 'true';
  }).slice(0, length).each((index, entry) => {
    const title = $(entry).children('title').text();
    const id = $(entry).children('guid').text();
    const pic = $(entry).children('pic').text();

    // images will be downloaded and compressed only when they do not exist yet
    if (!picsExists.includes(pic.split('/header-images/')[1])) {
      pics.add(pic);
    }

    postInfos.push({href: id, pic, title})

    if (index <= 5) {
      news.push({href: id, pic, title})
    }
  });

  const compileFunction = pug.compileFile('./util/posts-slide.pug', {pretty: true});
  const swiperCss = lang == 'en' ? `${staticBaseUrl}/swiper/5.2.1/css/swiper.min.css` : `${staticBaseUrl}.cn/swiper/5.2.1/css/swiper.min.css`;
  const swiperJs = lang == 'en' ? `${staticBaseUrl}/swiper/5.2.1/js/swiper.min.js` : `${staticBaseUrl}.cn/swiper/5.2.1/js/swiper.min.js`;
  writeFile(`./templates/posts-slide-${lang}.tt2`, compileFunction({postInfos, swiperCss, swiperJs}));

  const newsCompileFunction = pug.compileFile('./util/news.pug', {pretty: true});
  writeFile(`./templates/news-${lang}.tt2`, newsCompileFunction({news}));
};

async function genEnVideos() {
  const playlists = [];
  const data = await http.get('https://www.googleapis.com/youtube/v3/playlists?key=AIzaSyANu5r1u3Zt6RKS9j9NiYsJEXvo-UBFiww&channelId=UCXVmwF-UCScv2ftsGoMqxhw&part=snippet');
  const allLists = data.data.items;
  const shownList = allLists.filter(list => list.snippet.title !== 'OpenResty Con 2018');
  const sortedList = ['OpenResty Tutorials', 'OpenResty Edge', 'OpenResty Showman']

  let index = 0;
  shownList.forEach(async function(item) {
    const {snippet, id} = item;
    const {title} = snippet;
    const videos = [];
    const videosData = await axios.get(`https://www.googleapis.com/youtube/v3/playlistItems?key=AIzaSyANu5r1u3Zt6RKS9j9NiYsJEXvo-UBFiww&playlistId=${id}&maxResults=100&part=snippet`);

    videosData.data.items.forEach(video => {
      const {title, resourceId, publishedAt} = video.snippet;
      if (title !== 'Private video') {
        videos.push({id: resourceId.videoId, publishedAt, title, src: `https://www.youtube.com/embed/${resourceId.videoId}`})
      }
    })
    videos.sort((v1, v2) => {
      return (new Date(v2.publishedAt)).getTime() - (new Date(v1.publishedAt)).getTime();
    })
    playlists.push({id, title, videos});
    index++;
    if (index === shownList.length) {
      playlists.sort((list1, list2) => {
        return sortedList.indexOf(list1.title) - sortedList.indexOf(list2.title);
      })
      const videosCompileFunction = pug.compileFile('./util/videos.pug', {pretty: true});
      writeFile(`./templates/videos-en.tt2`, videosCompileFunction({playlists}));
    }
  })
}

async function genCnVideos() {
  const playlists = [];
  const data = await http.get('https://api.bilibili.com/x/space/channel/list?mid=457424101');
  const allLists = data.data.data.list;
  const shownList = allLists.filter(list => list.name !== 'OpenResty 分享活动');
  const sortedList = ['OpenResty 教程', 'OpenResty Edge', 'OpenResty Showman']

  let index = 0;
  shownList.forEach(async function(item) {
    const {name, cid} = item;
    const videos = [];
    const videosData = await axios.get(`https://api.bilibili.com/x/space/channel/video?mid=457424101&cid=${cid}`);
    videosData.data.data.list.archives.forEach(video => {
      const {aid, bvid, cid, title, pubdate} = video;
      videos.push({id: bvid, pubdate, title, src: `https://player.bilibili.com/player.html?aid=${aid}&bvid=${bvid}&cid=${cid}&page=1`})
    })
    videos.sort((v1, v2) => {
      return v2.pubdate - v1.pubdate;
    })
    playlists.push({id: cid, title: name, videos});
    index++;
    if (index === shownList.length) {
      playlists.sort((list1, list2) => {
        return sortedList.indexOf(list1.title) - sortedList.indexOf(list2.title);
      })
      const videosCompileFunction = pug.compileFile('./util/videos.pug', {pretty: true});
      writeFile(`./templates/videos-cn.tt2`, videosCompileFunction({playlists}));
    }
  })
}

Promise.all([
  genSlideTemplate('en'),
  genSlideTemplate('cn'),
  genEnVideos(),
  // genCnVideos(),
]).then(() => {
  for(pic of pics) {
    optimizeImg(pic);
  }
})

async function optimizeImg(pic) {
  const response = await axios({
    url: `${picBase}${pic}`,
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
