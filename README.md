# Mycha [![Build Status](https://travis-ci.org/Originate/mycha.svg?branch=master)](https://travis-ci.org/Originate/mycha) [![Dependency Status](https://david-dm.org/Originate/mycha.svg)](https://david-dm.org/Originate/mycha)

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
    * If `testHelperPath` has an extension found [here](src/compilers.coffee) then
      it writes the test helper in that language and updates the configuration file accordingly

  * runs
    ```
    npm install --save-dev chai sinon sinon-chai
    ```

  * writes to `testHelperPath`
    ```js
    process.env.NODE_ENV = 'test';

    var chai = require('chai');
    var sinon = require('sinon');
    chai.use(require('sinon-chai'));

    global.chai = chai;
    global.expect = chai.expect;
    global.sinon = sinon;
    ```

  * writes to `mycha.yml`
    ```yml
    # Environment variables to add to process.env when running mocha
    mochaEnv: {}

    # Default options to pass to mocha (can be overridden by command line options)
    mochaOptions:
      colors: true
      reporter: dot

    # Path patten used for finding tests (see https://github.com/isaacs/minimatch)
    testFilePattern: '**/*{spec,test}.js'

    # Files to include before all tests
    testHelpers:
      - #{testHelperPath}
    ```

* `mycha [mochaOptions] [<folder>...] [<file>...]`
  * if no folders or files are specified runs all tests
  * if folders or files are specified, pass them through to mocha


## Compilers

To add a new compiler, add an entry [here](src/compilers.coffee) and add a
language specific version of the test helper [here](scaffold).

## Development

see our [developer documentation](CONTRIBUTING.md)
