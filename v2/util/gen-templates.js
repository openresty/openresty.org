#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const {writeFile, readdir, unlink} = fs.promises;
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
const pics = new Set();
let picsExists;

const youtubeApiKey = process.env.YOUTUBE_API_KEY;
const youtubeChannelId = process.env.YOUTUBE_CHANNEL_ID;

// Replace the extension of the original image path with .webp
function toWebpPath(picPath) {
  const ext = path.extname(picPath);
  if (!ext) {
    return `${picPath}.webp`;
  }
  return `${picPath.slice(0, -ext.length)}.webp`;
}

async function genSlideTemplate(lang) {
  const postInfos = [];
  const news = [];
  const base = lang === 'en' ? enBase : cnBase;
  const source = `${base}index.xml`;
  const rss = await http.get(source);
  const $ = cheerio.load(rss.data, {decodeEntities: false});
  const length = 20;

  if (!picsExists) {
    picsExists = await readdir('./images/header-images');
  }

  $('item').filter((index, entry) => {
    const tags = $(entry).children('tags').text();
    const priv = $(entry).children('private').text();
    return tags
      && (tags.includes('xray')
        || tags.includes('openresty-edge')
        || tags.includes('packages')
        || tags.includes('openresty-xray'))
      && priv !== 'true';
  }).slice(0, length).each((index, entry) => {
    const title = $(entry).children('title').text();
    const id = $(entry).children('guid').text();
    const originPic = $(entry).children('pic').text();

    // Convert to webp path for template rendering
    const webpPic = toWebpPath(originPic);
    const webpName = webpPic.split('/header-images/')[1];

    // Only download and process the image when the corresponding webp file does not exist locally
    if (!picsExists.includes(webpName)) {
      pics.add(originPic);
    }

    postInfos.push({href: id, pic: webpPic, title});

    if (index <= 5) {
      news.push({href: id, pic: webpPic, title});
    }
  });

  const compileFunction = pug.compileFile('./util/posts-slide.pug', {pretty: true});
  const swiperCss = lang === 'en'
    ? `${staticBaseUrl}/swiper/5.2.1/css/swiper.min.css`
    : `${staticBaseUrl}.cn/swiper/5.2.1/css/swiper.min.css`;
  const swiperJs = lang === 'en'
    ? `${staticBaseUrl}/swiper/5.2.1/js/swiper.min.js`
    : `${staticBaseUrl}.cn/swiper/5.2.1/js/swiper.min.js`;
  await writeFile(`./templates/posts-slide-${lang}.tt2`, compileFunction({postInfos, swiperCss, swiperJs}));

  const newsCompileFunction = pug.compileFile('./util/news.pug', {pretty: true});
  await writeFile(`./templates/news-${lang}.tt2`, newsCompileFunction({news}));
}

async function genEnVideos() {
  const playlists = [];
  const data = await http.get(`https://www.googleapis.com/youtube/v3/playlists?key=${youtubeApiKey}&channelId=${youtubeChannelId}&part=snippet`);
  const allLists = data.data.items;
  const shownList = allLists.filter((list) => list.snippet.title !== 'OpenResty Con 2018');
  const sortedList = ['OpenResty Tutorials', 'OpenResty Edge', 'OpenResty Showman'];

  let index = 0;
  shownList.forEach(async (item) => {
    const {snippet, id} = item;
    const {title} = snippet;
    const videos = [];
    const videosData = await axios.get(`https://www.googleapis.com/youtube/v3/playlistItems?key=${youtubeApiKey}&playlistId=${id}&maxResults=100&part=snippet`);

    videosData.data.items.forEach((video) => {
      const {title: videoTitle, resourceId, publishedAt} = video.snippet;
      if (videoTitle !== 'Private video') {
        videos.push({
          id: resourceId.videoId,
          publishedAt,
          title: videoTitle,
          src: `https://www.youtube.com/embed/${resourceId.videoId}`,
        });
      }
    });
    videos.sort((v1, v2) => {
      return (new Date(v2.publishedAt)).getTime() - (new Date(v1.publishedAt)).getTime();
    });
    playlists.push({id, title, videos});
    index += 1;
    if (index === shownList.length) {
      playlists.sort((list1, list2) => {
        return sortedList.indexOf(list1.title) - sortedList.indexOf(list2.title);
      });
      const videosCompileFunction = pug.compileFile('./util/videos.pug', {pretty: true});
      writeFile('./templates/videos-en.tt2', videosCompileFunction({playlists}));
    }
  });
}

async function genCnVideos() {
  const playlists = [];
  const data = await http.get('https://api.bilibili.com/x/space/channel/list?mid=457424101');
  const allLists = data.data.data.list;
  const shownList = allLists.filter((list) => list.name !== 'OpenResty 分享活动');
  const sortedList = ['OpenResty 教程', 'OpenResty Edge', 'OpenResty Showman'];

  let index = 0;
  shownList.forEach(async (item) => {
    const {name, cid} = item;
    const videos = [];
    const videosData = await axios.get(`https://api.bilibili.com/x/space/channel/video?mid=457424101&cid=${cid}`);
    videosData.data.data.list.archives.forEach((video) => {
      const {aid, bvid, cid: videoCid, title, pubdate} = video;
      videos.push({
        id: bvid,
        pubdate,
        title,
        src: `https://player.bilibili.com/player.html?aid=${aid}&bvid=${bvid}&cid=${videoCid}&page=1`,
      });
    });
    videos.sort((v1, v2) => v2.pubdate - v1.pubdate);
    playlists.push({id: cid, title: name, videos});
    index += 1;
    if (index === shownList.length) {
      playlists.sort((list1, list2) => {
        return sortedList.indexOf(list1.title) - sortedList.indexOf(list2.title);
      });
      const videosCompileFunction = pug.compileFile('./util/videos.pug', {pretty: true});
      writeFile('./templates/videos-cn.tt2', videosCompileFunction({playlists}));
    }
  });
}

Promise.all([
  genSlideTemplate('en'),
  genSlideTemplate('cn'),
  genEnVideos(),
  // genCnVideos(),
]).then(() => {
  for (const pic of pics) {
    optimizeImg(pic);
  }
});

async function optimizeImg(pic) {
  try {
    const response = await axios({
      url: `${picBase}${pic}`,
      method: 'GET',
      responseEncoding: 'binary',
      responseType: 'arraybuffer',
    });

    // Save the original image to a local temporary file, then compress and convert it to webp
    const originLocalPath = `./images${pic}`;
    await writeFile(originLocalPath, response.data, 'binary');

    const webpLocalPath = `./images${toWebpPath(pic)}`;
    await compressImg(originLocalPath, webpLocalPath);
  } catch (err) {
    console.error('optimizeImg failed:', pic, err);
  }
}

async function compressImg(srcPath, destPath) {
  try {
    const data = await sharp(srcPath)
      .resize({
        height,
        fit: 'contain',
        withoutEnlargement: true,
      })
      .webp({quality: 80})
      .toBuffer();

    return writeFile(destPath, data);
  } catch (err) {
    console.error(srcPath, err);
    return null;
  }
}
