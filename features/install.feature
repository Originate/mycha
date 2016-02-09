Feature: Installation

  As a developer setting up the test framework for my project
  I want the infrastructure required by Mycha being added for me by an installer
  So that I can start testing without repetitive setup work.


  Scenario: install with a .js test helper
    Given I am working on a Node.js project
    When I run "mycha install" and enter "spec/spec_helper.js"
    Then my "package.json" devDependencies now includes
      | NPM MODULE |
      | chai       |
      | sinon      |
      | sinon-chai |
    And my project now has a file "spec/spec_helper.js" containing
      """
      process.env.NODE_ENV = 'test';

      var chai = require('chai');
      var sinon = require('sinon');
      chai.use(require('sinon-chai'));

      global.chai = chai;
      global.expect = chai.expect;
      global.sinon = sinon;
      """
    And my project now has a file "mycha.yml" containing
      """
      # Environment variables to add to process.env when running mocha
      mochaEnv: {}

      # Default options to pass to mocha (can be overriden by command line options)
      mochaOptions:
        colors: true
        reporter: dot

      # Path patten used for finding tests (see https://github.com/isaacs/minimatch)
      testFilePattern: '**/*{spec,test}.js'

      # Files to include before all tests
      testHelpers:
        - spec/spec_helper.js
      """

  Scenario: install with a .coffee test helper
    Given I am working on a Node.js project
    When I run "mycha install" and enter "spec/spec_helper.coffee"
    Then my "package.json" devDependencies now includes
      | NPM MODULE |
      | chai       |
      | sinon      |
      | sinon-chai |
    And my project now has a file "spec/spec_helper.coffee" containing
      """
      process.env.NODE_ENV = 'test'

      chai = require 'chai'
      sinon = require 'sinon'
      chai.use require('sinon-chai')

      global.chai = chai
      global.expect = chai.expect
      global.sinon = sinon
      """
    And my project now has a file "mycha.yml" containing
      """
      # Environment variables to add to process.env when running mocha
      mochaEnv: {}

      # Default options to pass to mocha (can be overriden by command line options)
      mochaOptions:
        colors: true
        compilers: coffee:coffee-script/register
        reporter: dot

      # Path patten used for finding tests (see https://github.com/isaacs/minimatch)
      testFilePattern: '**/*{spec,test}.coffee'

      # Files to include before all tests
      testHelpers:
        - spec/spec_helper.coffee
      """

  Scenario: install with a .ls test helper
    Given I am working on a Node.js project
    When I run "mycha install" and enter "spec/spec_helper.ls"
    Then my "package.json" devDependencies now includes
      | NPM MODULE |
      | chai       |
      | sinon      |
      | sinon-chai |
    And my project now has a file "spec/spec_helper.ls" containing
      """
      process.env.NODE_ENV = 'test'

      require! [chai, sinon]
      chai.use require('sinon-chai')

      global.chai = chai
      global.expect = chai.expect
      global.sinon = sinon
      """
    And my project now has a file "mycha.yml" containing
      """
      # Environment variables to add to process.env when running mocha
      mochaEnv: {}

      # Default options to pass to mocha (can be overriden by command line options)
      mochaOptions:
        colors: true
        compilers: ls:livescript
        reporter: dot

      # Path patten used for finding tests (see https://github.com/isaacs/minimatch)
      testFilePattern: '**/*{spec,test}.ls'

      # Files to include before all tests
      testHelpers:
        - spec/spec_helper.ls
      """
