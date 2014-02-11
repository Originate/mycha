chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require './test_helper'
Mycha = require '../lib/mycha'
MochaConfiguration = require '../lib/mocha_configuration'


describe 'MochaConfiguration', ->

  context 'no user options given', ->

    beforeEach ->
      @mocha_configuration = new MochaConfiguration Mycha.default_mocha_options

    it 'uses CoffeeScript as the default compiler', ->
      expect(@mocha_configuration.options.compilers).to.equal 'coffee:coffee-script'

    it 'uses the "dot" reporter', ->
      expect(@mocha_configuration.options.reporter).to.equal 'dot'

    it 'shows colors', ->
      expect(@mocha_configuration.options.colors).to.be.true


  context 'user options given', ->

    beforeEach ->
      user_options =
        stdout: 'custom stdout'
        stderr: 'custom stderr'
        reporter: 'custom reporter'
        testDir: 'test/test_data'
        compilers: 'foo:bar'
      @mocha_configuration = new MochaConfiguration Mycha.default_mocha_options,
                                                    user_options

    it 'uses the given compiler', ->
      expect(@mocha_configuration.options.compilers).to.equal 'foo:bar'

    it 'uses the given reporter', ->
      expect(@mocha_configuration.options.reporter).to.equal 'custom reporter'

