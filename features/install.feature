Feature: Installation

  As a developer setting up the test framework for my project
  I want the infrastructure required by Mycha being added for me by an installer
  So that I can start testing without repetitive setup work.


  Scenario: fresh install
    Given I am working on a Node.js project
    When I run "mycha install" and enter "spec/spec_helper.coffee"
    Then my "package.json" now lists the devDependencies
      | NPM MODULE |
      | chai       |
      | sinon      |
      | sinon-chai |
    And my project now has a file "spec/spec_helper.coffee" containing
      """
      chai = require 'chai'
      sinon = require 'sinon'
      chai.use require 'sinon-chai'

      global.chai = chai
      global.expect = chai.expect
      global.sinon = sinon

      process.env.NODE_ENV = 'test'
      """
    And my project now has a file "mycha.coffee" containing
      """
      module.exports =

        # Default options to pass to mocha (can be overriden by command line options)
        mochaOptions:
          colors: yes
          compilers: 'coffee:coffee-script/register'
          reporter: 'dot'

        # Path patten used for finding tests (see https://github.com/isaacs/minimatch)
        testFilePattern: '**/*_{spec,test}.{coffee,js}'

        # Files to include before all tests
        testHelpers: [
          'spec/spec_helper.coffee'
        ]
      """
