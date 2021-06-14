// ==UserScript==
// @name         Facey
// @namespace    puyo/facey
// @license      Creative Commons BY-NC-SA
// @encoding     utf-8
// @version      1.3
// @description  Make Facey better
// @author       puyo
// @match        https://www.facebook.com/
// @grant        none
// @updateURL    https://raw.githubusercontent.com/puyo/config/master/userscripts/facey.js
// @downloadURL  https://raw.githubusercontent.com/puyo/config/master/userscripts/facey.js
// ==/UserScript==

(function() {
    'use strict';

    let observer
    const feed = document.querySelector('[role=feed]')
    const mutationObserverConfig = { attributes: false, childList: true, subtree: true }
    let count = 0

    const removeAds = () => {
        const articles = feed.querySelectorAll('[role=article]:not([data-checked])')
        //console.log(`removing ads from ${articles.length} articles, ${count} removed so far`)
        articles.forEach(article => {
            const sponsored = article.querySelector('a[aria-label=Sponsored][role=link]')
            if (sponsored) {
                count += 1
                article.parentNode.removeChild(article)
                //article.style.display = 'none'
            }
            article.setAttribute('data-checked', 'true')
        })
    }

    const callback = (mutList, obs) => {
        observer.disconnect()
        removeAds()
        observer.observe(feed, mutationObserverConfig)
    }
    removeAds()

    observer = new MutationObserver(callback)
    observer.observe(feed, mutationObserverConfig)
})();

