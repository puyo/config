// ==UserScript==
// @name         Facey
// @namespace    puyo/facey
// @license      Creative Commons BY-NC-SA
// @encoding     utf-8
// @version      0.1
// @description  Make Facey better
// @author       Gregory McIntyre
// @match        https://www.facebook.com/
// @grant        none
// @updateURL    https://raw.githubusercontent.com/puyo/config/master/userscripts/facey.js
// ==/UserScript==

(function() {
    'use strict';

    let observer
    const feed = document.querySelector('[role=feed]')
    const mutationObserverConfig = { attributes: false, childList: true, subtree: false };

    const callback = (mutList, obs) => {
        observer.disconnect();
        const articles = feed.querySelectorAll('[role=article]')
        articles.forEach(article => {
            const sponsored = article.querySelector('a[aria-label=Sponsored][role=link]');
            if (sponsored) {
                article.style.display = 'none';
            }
        })
        observer.observe(feed, mutationObserverConfig);
    }

    observer = new MutationObserver(callback);
    observer.observe(feed, mutationObserverConfig);
})();
