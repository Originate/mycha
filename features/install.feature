Feature: install

  Scenario:
    Given I am in a node project
    When I run "mycha install" and respond to the prompt with "spec/spec_helper.coffee"

    Then I now have the following devDependencies in my "package.json"
      | NPM MODULE |
      | chai       |
      | sinon      |
      | sinon-chai |
    And I now have the file "spec/spec_helper.coffee" with the contents
      """
      chai = require 'chai'
      sinon = require 'sinon'
      chai.use require 'sinon-chai'

      global.chai = chai
      global.expect = chai.expect
      global.sinon = sinon

      process.env.NODE_ENV = 'test'
      """
    And I now have the file "mycha.coffee" with the contents
      """
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
          'spec/spec_helper.coffee'
        ]
      """
