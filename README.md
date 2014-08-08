# hubot-doorkeeper

A Hubot script that display the doorkeeper events

## Installation

    $ npm install git://github.com/bouzuya/hubot-doorkeeper.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-doorkeeper.git#TAG'

## Sample Interaction

    bouzuya> hubot help doorkeeper
    hubot> hubot doorkeeper <group> - display the doorkeeper events

    bouzuya> hubot doorkeeper hitoridokusho
    hubot>
    http://hitoridokusho.doorkeeper.jp/events/13976
    ひとり読書会 #13 プログラミングの基礎 (9)
    2014-08-10T10:00:00.000Z/2014-08-10T12:00:00.000Z
    ひとり読書会 Lingr


See [`src/scripts/doorkeeper.coffee`](src/scripts/doorkeeper.coffee) for full documentation.

## License

MIT

## Development

### Run test

    $ npm test

### Run robot

    $ npm run robot


## Badges

[![Build Status][travis-badge]][travis]
[![][david-dm-badge]][david-dm]

[travis]: https://travis-ci.org/bouzuya/hubot-doorkeeper
[travis-badge]: https://travis-ci.org/bouzuya/hubot-doorkeeper.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-doorkeeper
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-doorkeeper.png
