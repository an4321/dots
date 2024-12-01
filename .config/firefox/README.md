
* user.js
    * BetterFox: `cp ./user.js ~/.mozilla/firefox/*.default-release`
* userChrome.css
    * `mkdir -p ~/.mozilla/firefox/*.default-release/chrome && cp ./minimal.css ~/.mozilla/firefox/*.default-release/chrome`
    * [OneBar](file:./onebar.css)
    * [Minimal](file:./minimal.css)
        * Based on [Qute](https://github.com/Dook97/firefox-qutebrowser-userchrome/blob/master/userChrome.css)
    * Alt [Lepton](https://github.com/black7375/Firefox-UI-Fix)
* about:config
    * ui.key.menuAccessKeyFocuses toggle alt menu
    * devPixelsPerPx to scale
