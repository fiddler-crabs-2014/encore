Encore
==================

Created by:
-------------------
- [Jared Rader (Team Lead)](https://github.com/raderj89)
- [Timmy Haung](https://github.com/tihuan)
- [Howard "Buck" O'Leary](https://github.com/buck3000)
- [Brendan Scarano (Product Manager)](https://github.com/Onaracs)

Heroku: 
Outward-facing url: Bit.ly/EncoreBeta
http://encore-staging.herokuapp.com/

Trello: 
https://trello.com/b/dnoGtQbs/encore

[![Build Status](https://travis-ci.org/fiddler-crabs-2014/encore.svg?branch=master)](https://travis-ci.org/fiddler-crabs-2014/encore)

git workflow
============
1. fork the repo (https://github.com/fiddler-crabs-2014/encore)
2. git clone your fork
3. git checkout -b branch_name (prepended by chore/, feature/, bug/)
4. when finished with changes in branch
    1. git add .
    2. git commit -m "commit message"
    3. git push origin branch_name
5. go back to github and send a new pull request from your branch

css workflow / truncated style-guide
============
1. base styles are in main.css.scss
2. remember: grid-settings are in corresponding _grid-settings.css.scss file
3. use EMs instead of pixels when possible (unless dealing with text...)
4. keep color variables, fonts and page styles in seperate pages
5. prepend styles for a new page with a one line css comment (e.g. /* styles for user page */)
6. before making a pull request set the visual-grid variable to false in your branch.
7. before pushing to production sit with someone and remove css comments

