// ==UserScript==
// @name         Facey
// @namespace    puyo/facey
// @license      Creative Commons BY-NC-SA
// @encoding     utf-8
// @version      1.11
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
    window.count = 0

    let textForNode, textForChildren
    let removeAds, removeAd, sponsoredNodes, isSponsoredElem

    isSponsoredElem = (node) => {
        const style = getComputedStyle(node)
        if (node.data || style.display === "none" || style.top !== "0px" || style.display === "flex") {
            return false
        }
        return true
    }

    textForNode = (node) => {
        return node.data || node.textContent
    }

    textForChildren = (node) => {
        const elems =
          Array.from(node.querySelectorAll('*'))
          .filter(isSponsoredElem)
          .sort((a, b) => parseInt(a.style.order) - parseInt(b.style.order))
        return elems.slice(0, 9).map(textForNode).join('').replace(/-/g, '')
    }

    sponsoredNodes = (article, debug = false) => {
        let result = []
        const ariaLabelSponsoredNode = article.querySelector('[aria-label=Sponsored]')
        if (ariaLabelSponsoredNode) {
            result.push(ariaLabelSponsoredNode.parentNode)
        }
        result.push(article.querySelector('a[href^="/ads"]'))
        result = result.concat(Array.from(article.querySelectorAll('div')))
        return result
    }

    removeAd = (article, debug = false) => {
        const nodes = sponsoredNodes(article, debug).filter(x => x != null)
        let ad = false
        const h4 = article.querySelector('h4')
        const title = h4 && h4.textContent
        for (let i = 0; i < nodes.length; i++) {
            const node = nodes[i]
            const text = textForChildren(node)
            ad = text.includes('ponsored')
            if (debug) {
                console.log('Ad?', {title, node, text, ad})
            }
            if (ad) { break }
        }
        if (!debug) {
            console.log('Ad?', {title, ad})
        }
        if (ad) {
            if (window.count == null) {
                window.count = 0
            }
            window.count += 1
            article.parentNode.removeChild(article)
        } else {
            article.setAttribute('data-checked', 'true')
        }
    }

    removeAds = (debug = false) => {
        let articles
        if (debug) {
            console.log('-----')
            articles = document.querySelectorAll('[role=feed] [role=article]')
        } else {
            articles = document.querySelectorAll('[role=feed] [role=article]:not([data-checked])')
        }
        articles.forEach(article => {
            removeAd(article, debug)
        })
    }

    window.textForChildren = textForChildren
    window.removeAds = (debug = false) => removeAds(debug)

    removeAds()

    const callback = (_mutList, _obs) => {
        observer.disconnect()
        removeAds()
        observer.observe(document, mutationObserverConfig)
    }
    observer = new MutationObserver(callback)
    observer.observe(document, mutationObserverConfig)
})();

