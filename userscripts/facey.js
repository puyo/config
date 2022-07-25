// ==UserScript==
// @name         Facey
// @namespace    puyo/facey
// @license      Creative Commons BY-NC-SA
// @version      1.12
// @description  Make Facey better
// @author       puyo
// @match        https://www.facebook.com/
// @grant        none
// @updateURL    https://raw.githubusercontent.com/puyo/config/master/userscripts/facey.js
// @downloadURL  https://raw.githubusercontent.com/puyo/config/master/userscripts/facey.js
// ==/UserScript==

(function () {
  "use strict";

  let observer;
  const mutationObserverConfig = {
    attributes: false,
    childList: true,
    subtree: true,
  };
  window.count = 0;

  let textForNode, textForChildren;
  let removeAds, removeAd, hasAriaLabelSponsored;

  const consoleStyle = "background-color: darkblue; color: white;";
  const adStyle = "background-color: darkred; color: white;";

  hasAriaLabelSponsored = window.hasAriaLabelSponsored = (article, debug) => {
    let found = false;
    if (article.querySelector("[aria-label=Sponsored]")) {
      return true;
    }
    const descTextSponsored = (id) => {
      if (id == null || id === "") {
        return false;
      }
      const descNode = document.querySelector(`#${id}`);
      const text = descNode && descNode.textContent;
      return text && text.includes("Sponsored");
    };
    (article.getAttribute("aria-describedby") || "")
      .split(" ")
      .forEach((id) => {
        found = descTextSponsored(id);
        if (found) {
          return found;
        }
      });
    article.querySelectorAll("[aria-labelledby]").forEach((n) => {
      const id = n.getAttribute("aria-labelledby");
      found = descTextSponsored(id);
      if (found) {
        return found;
      }
    });
    return found;
  };

  removeAd = window.removeAd = (article, debug = false) => {
    let ad = false;
    const h4 = article.querySelector("h4");
    const title = h4 && h4.textContent;
    if (hasAriaLabelSponsored(article, debug)) {
      ad = true;
    }
    console.log("%cFacebook Ad?", ad ? adStyle : consoleStyle, {
      title,
      article,
      ad,
    });
    if (ad) {
      if (window.count == null) {
        window.count = 0;
      }
      window.count += 1;
      if (debug) {
        article.style.outline = "5px solid red";
      } else {
        article.parentNode.removeChild(article);
      }
    } else {
      article.setAttribute("data-checked", "true");
    }
  };

  removeAds = window.removeAds = (debug = false) => {
    let articles;
    if (debug) {
      console.log("%c-----", consoleStyle);
      articles = document.querySelectorAll("[role=feed] [role=article]");
    } else {
      articles = document.querySelectorAll(
        "[role=feed] [role=article]:not([data-checked])"
      );
    }
    articles.forEach((article) => {
      removeAd(article, debug);
    });
  };

  removeAds();

  const callback = (_mutList, _obs) => {
    observer.disconnect();
    removeAds();
    observer.observe(document, mutationObserverConfig);
  };
  observer = new MutationObserver(callback);
  observer.observe(document, mutationObserverConfig);
})();
