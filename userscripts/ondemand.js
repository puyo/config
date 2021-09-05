// ==UserScript==
// @name         Demand
// @namespace    puyo/ondemand
// @license      Creative Commons BY-NC-SA
// @encoding     utf-8
// @version      1.2
// @description  Make it better for myself
// @author       puyo
// @include      https://www.sbs.com.au/ondemand/*
// @require      https://jpillora.com/xhook/dist/xhook.js
// @grant        none
// @run-at       document-start
// @downloadURL  https://raw.githubusercontent.com/puyo/config/master/userscripts/ondemand.js
// @updateURL    https://raw.githubusercontent.com/puyo/config/master/userscripts/ondemand.js
// ==/UserScript==

// You may need these uBlock Origin "allow" rules, too:
//
// @@||imasdk.googleapis.com^$script,domain=www.sbs.com.au
// @@||licensing.bitmovin.com^$xhr,domain=www.sbs.com.au
// @@||pubads.g.doubleclick.net^$xhr,domain=www.sbs.com.au

(function() {
  'use strict';

  var skip = [
    '(?:',
    '^#EXTINF:[^\\n]+,\\nhttps://redirector\\.googlevideo\\.com[^\\n]+$\\n',
    '|',
    '^#EXT-X-DISCONTINUITY$\\n',
    ')',
  ];

  var skipRe = new RegExp(skip.join(''), 'gm');

  function filterPlaylist(text) {
    return text.replace(skipRe, '');
  }

  xhook.after(function(request, response) {
    if (request.url.match(/\.m3u8$/)) {
      // remove ad videos
      response.data = response.text = filterPlaylist(response.text);
    } else if (request.url.match(/time-events\.json$/)) {
      // remove ad marks on progress meter
      var data = JSON.parse(response.data);
      data.ads = {};
      data.breaks = {};
      data.cuepoints = [];
      data.times = {};
      response.data = response.text = JSON.stringify(data);
    }
  });
})();


