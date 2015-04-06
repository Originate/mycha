# Mycha [![Build Status](https://travis-ci.org/Originate/mycha.png?branch=master)](https://travis-ci.org/Originate/mycha) [![Dependency Status](https://david-dm.org/Originate/mycha.svg)](https://david-dm.org/Originate/mycha)

/'maɪ.kɑː/

A thin wrapper around [mocha](https://github.com/mochajs/mocha)
that finds tests anywhere in your project
and provides a utility that gets tests up and running quickly


## Install

* `npm install --save-dev mycha`
* add `./node_modules/.bin` to your PATH environment variable


## Usage

* `mycha install`
  * prompts you for where you would like to install your default test helper, `testHelperPath`

  * runs
    ```
    npm install --save-dev chai
    npm install --save-dev sinon
    npm install --save-dev sinon-chai
    ```

  * writes to `testHelperPath`
    ```coffee
    chai = require 'chai'
    sinon = require 'sinon'
    chai.use require 'sinon-chai'

    global.expect = chai.expect
    global.sinon = sinon

    process.env.NODE_ENV = 'test'
    ```

  * writes to `mycha.coffee`
    ```coffee
    module.exports =

      # Default options to pass to mocha (can be overriden by command line options)
      mochaOptions:
        colors: yes
        compilers: 'coffee:coffee-script/register'
        reporter: 'dot'

      # Regular expression used for finding tests
      testFileRegex: /_(spec|test)\.(coffee|js)$/

      # Files to include before all tests
      testHelpers: [
        '#{@testHelperPath}'
      ]
    ```

* `mycha [mochaOptions] [<folder>...] [<file>...]`
  * if no folders or files are specified runs all tests
  * if folders or files are specified, pass them through to mocha


## Development

* deploy a new patch version: `./release`
