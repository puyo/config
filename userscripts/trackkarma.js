// ==UserScript==
// @name         Track Karma
// @namespace    http://tampermonkey.net/
// @license      Creative Commons BY-NC-SA
// @encoding     utf-8
// @version      2.1
// @description  Make it easier to mark attendance
// @author       puyo
// @include      https://app.trackkarma.com/trainings*
// @grant        GM_addStyle
// @downloadURL  https://raw.githubusercontent.com/puyo/config/master/userscripts/trackkarma.js
// @updateURL    https://raw.githubusercontent.com/puyo/config/master/userscripts/trackkarma.js
// ==/UserScript==

GM_addStyle(`
.training-card, .availability-card {
  position: relative;
}

.set-availability-buttons {
  position: absolute;
  top: -10px;
  right: -10px;
  white-space: nowrap;
}

.availability-absent .button.set-absent { display: none; }
.availability-absent_major .button.set-absent { display: none; }

.availability-present .button.set-present { display: none; }
.availability-present_major .button.set-present { display: none; }


/* avoid hover effect on this element which isn't a link that affects our buttons */
.training-availability:hover {
    -webkit-filter: initial !important;
    filter: initial !important;
}

@keyframes circle-loader {
    0% {
        transform: rotate(0deg);
    }
    100% {
        transform: rotate(360deg);
    }
}

.loader.simple-circle {
    display: none;
    vertical-align: top;
    transform-origin: center center;
    border: 3px solid #fff;
    border-right-color: #aaa;
    background-color: #5e5e5e;
    width: 2em;
    height: 2em;
    border-radius: 50%;
    animation: circle-loader 1s infinite ease-out;
}

.loading .loader { display: inline-block; }
.loading .button { display: none; }

`)

;(function () {
    'use strict'

    const csrfValue = () => document.querySelector('meta[name=csrf-token]').getAttribute('content')
    const csrfParam = () => document.querySelector('meta[name=csrf-param]').getAttribute('content')

    const setValue = (action, status, startLoad, stopLoad, success) => {
        const body = new URLSearchParams([
            ['utf8', '✓'],
            ['_method', 'patch'],
            [csrfParam(), csrfValue()],
            ['availability[status]', status],
        ])

        startLoad()

        fetch(action, {
            method: 'POST',
            body: body,
        })
            .then((res) => {
                if (res.ok) {
                    success()
                } else {
                    console.error(res)
                }
            })
            .catch((err) => console.error(err))
            .finally(() => stopLoad())
    }

    const success = (present, attendeesDelta, card) => {
        const avail = card.querySelector('.training-availability, .member-availability')
        const oldPresent = avail.classList.contains('availability-present')

        if (oldPresent === present) {
            return
        }

        avail.classList.toggle('availability-present', present)
        avail.classList.toggle('availability-absent', !present)

        const icon = avail.querySelector('.fa')
        icon.classList.toggle('fa-check', present)
        icon.classList.toggle('fa-close', !present)

        const attendances = card.querySelector('.attendances')
        if (attendances) {
            attendances.textContent = parseInt(attendances.textContent) + attendeesDelta
        }
    }

    const makeButton = (innerHTML, klass, onclick) => {
        const button = document.createElement('button')
        button.classList.add('button', 'small', 'secondary', klass)
        button.innerHTML = innerHTML
        button.addEventListener('click', (event) => {
            event.preventDefault()
            event.stopPropagation()
            onclick()
        })
        return button
    }

    document.querySelectorAll('.training-card, .availability-card').forEach((card) => {
        const link = card.querySelector('a[data-remote=true]')

        if (!link) {
            return
        }

        const href = link.getAttribute('href')
        const action = href.replace('/edit', '')

        const setPresent = makeButton('<i class="fa fa-check"></i>', 'set-present', () =>
            setValue(
                action,
                'present',
                () => card.classList.add('loading'),
                () => card.classList.remove('loading'),
                () => success(true, +1, card)
            )
        )

        const setAbsent = makeButton('<i class="fa fa-close"></i>', 'set-absent', () =>
            setValue(
                action,
                'absent',
                () => card.classList.add('loading'),
                () => card.classList.remove('loading'),
                () => success(false, -1, card)
            )
        )

        const loading = document.createElement('div')
        loading.classList.add('loader', 'simple-circle')

        const buttonContainer = document.createElement('div')
        buttonContainer.classList.add('set-availability-buttons')
        buttonContainer.appendChild(loading)
        buttonContainer.appendChild(setPresent)
        buttonContainer.appendChild(setAbsent)

        const avail = card.querySelector('.training-availability, .member-availability')
        avail.appendChild(buttonContainer)
    })
})()
