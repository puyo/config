// ==UserScript==
// @name         Facey
// @namespace    puyo/facey
// @license      Creative Commons BY-NC-SA
// @encoding     utf-8
// @version      1.8
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
    const mutationObserverConfig = { attributes: false, childList: true, subtree: true }
    let count = 0

    const textForNode = (x) => {
        if (x.data) {
            return x.data // #text nodes
        }
        if (x.attributes && x.attributes.style == null) {
            return x.textContent // <span> nodes
        }
        return '' // <span style=...> nodes
    }

    const removeAds = (debug = false) => {
        let articles
        if (debug) {
            console.log('-----')
            articles = document.querySelectorAll('[role=feed] [role=article]')
        } else {
            articles = document.querySelectorAll('[role=feed] [role=article]:not([data-checked])')
        }
        articles.forEach(article => {
            const sponsored = article.querySelector('[aria-label=Sponsored]') ||
                  article.querySelector('a[href^="/ads"]')
            let ad
            const h4 = article.querySelector('h4')
            const title = h4 && h4.textContent
            if (sponsored != null) {
                const textNodes = sponsored.parentNode.querySelectorAll('*')
                const text = Array.from(textNodes).map(x => textForNode(x)).join('').replace(/-/g, '')
                ad = text.includes('Sponsored')
            } else if (article.textContent.includes('Sponsored')) {
                ad = true
            } else {
                const textNodes = article.querySelectorAll('*')
                const text = Array.from(textNodes).map(x => textForNode(x)).join('').replace(/-/g, '')
                ad = text.includes('Sponsored')
            }
            if (debug) {
                console.log('Ad?', {title, article, sponsored, ad})
            } else {
                console.log('Ad?', {title, ad})
            }
            if (ad) {
                count += 1
                article.parentNode.removeChild(article)
            } else {
                article.setAttribute('data-checked', 'true')
            }
        })
    }

    window.removeAds = () => removeAds(true)

    removeAds()

    const callback = (_mutList, _obs) => {
        observer.disconnect()
        removeAds()
        observer.observe(document, mutationObserverConfig)
    }
    observer = new MutationObserver(callback)
    observer.observe(document, mutationObserverConfig)
})();
