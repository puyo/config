// ==UserScript==
// @name         Facey
// @namespace    puyo/facey
// @license      Creative Commons BY-NC-SA
// @encoding     utf-8
// @version      1.10
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

    const textForNode = (node) => {
        if (node.data) {
            return node.data // #text nodes
        }
        const style = getComputedStyle(node)
        if (style.display === "none" || style.top !== "0px") {
            return ''
        }
        return node.textContent
    }

    const textForChildren = (node) => {
        return Array.from(node.querySelectorAll('*')).map(textForNode).join('').replace(/-/g, '')
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
            const ariaLabelSponsoredNode = article.querySelector('[aria-label=Sponsored]')
            const node = (ariaLabelSponsoredNode && ariaLabelSponsoredNode.parentNode) ||
                  article.querySelector('a[href^="/ads"]') ||
                  article
            let ad
            const h4 = article.querySelector('h4')
            const title = h4 && h4.textContent
            ad = textForChildren(node).includes('ponsored')
            if (debug) {
                console.log('Ad?', {title, article, node, ad})
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

    window.textForChildren = textForChildren
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

