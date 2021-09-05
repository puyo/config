// ==UserScript==
// @name         Facey
// @namespace    puyo/facey
// @license      Creative Commons BY-NC-SA
// @encoding     utf-8
// @version      1.6
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

    const removeAds = () => {
        const articles = document.querySelectorAll('[role=feed] [role=article]:not([data-checked])')
        articles.forEach(article => {
            const sponsored = article.querySelector('[aria-label=Sponsored]')
            let ad = false
            if (sponsored != null) {
                const h4 = article.querySelector('h4')
                const title = h4 && h4.textContent
                const textNodes = sponsored.parentNode.childNodes[1].childNodes
                const text = Array.from(textNodes).map(x => textForNode(x)).join('')
                ad = (text === 'Sponsored')
                console.log('Ad detector', {title, text, ad})
            }
            if (ad) {
                count += 1
                article.parentNode.removeChild(article)
            } else {
                article.setAttribute('data-checked', 'true')
            }
        })
    }

    const callback = (_mutList, _obs) => {
        observer.disconnect()
        removeAds()
        observer.observe(document, mutationObserverConfig)
    }
    removeAds()

    observer = new MutationObserver(callback)
    observer.observe(document, mutationObserverConfig)
})();

