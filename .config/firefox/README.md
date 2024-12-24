
```sh
# BetterFox
cp ~/.config/firefox/user.js ~/.mozilla/firefox/*.default
# userChrome
cd ~/.mozilla/firefox/*.default-{release,esr} && mkdir -p chrome && cp ~/.config/firefox/onebar.css ./chrome/userChrome.css
```
* about:config
    * ui.key.menuAccessKeyFocuses toggle alt menu
    * devPixelsPerPx to scale
* [OneBar](file:./onebar.css)
* [Minimal](file:./minimal.css)
    * Based on [Qute](https://github.com/Dook97/firefox-qutebrowser-userchrome/blob/master/userChrome.css)
* Alt [Lepton](https://github.com/black7375/Firefox-UI-Fix)

