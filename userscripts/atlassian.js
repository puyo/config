// ==UserScript==
// @name         Atlassian JIRA CLOUD - disable smart links globally
// @namespace    puyo/atlassian
// @version      1.1
// @description  Turns of conversion of any text in the editor into a "smart" link. From https://jira.atlassian.com/browse/JRACLOUD-72429?focusedCommentId=2950243&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-2950243
// @author       Kyle W.
// @include      *://blakeelearning.atlassian.net/*
// @match        *://blakeelearning.atlassian.net/*
// @grant        GM_webRequest
// @webRequest   { "selector": "*://blakeelearning.atlassian.net/gateway/api/object-resolver/*", "action": "cancel" }
// @updateURL    https://raw.githubusercontent.com/puyo/config/master/userscripts/atlassian.js
// @downloadURL  https://raw.githubusercontent.com/puyo/config/master/userscripts/atlassian.js
// ==/UserScript==
