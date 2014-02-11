chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require './test_helper'
Mycha = require '../lib/mycha'
MochaConfiguration = require '../lib/mocha_configuration'


describe 'MochaConfiguration', ->

  describe 'constructor', ->

    context 'with no user options given', ->

      beforeEach ->
        @argv = create_argv()
        @mocha_configuration = new MochaConfiguration Mycha.default_mocha_options,
                                                      @argv

      it 'uses CoffeeScript as the default compiler', ->
        expect(@mocha_configuration.options.compilers).to.equal 'coffee:coffee-script'

      it 'uses the "dot" reporter', ->
        expect(@mocha_configuration.options.reporter).to.equal 'dot'

      it 'shows colors', ->
        expect(@mocha_configuration.options.colors).to.be.true

      it 'does not contain the Optimist-specific elements', ->
        expect(@mocha_configuration.options).to.not.have.property '_'
        expect(@mocha_configuration.options).to.not.have.property '$0'

      it 'does not change the given argv parameter', ->
        expect(@argv).to.have.property '_'
        expect(@argv).to.have.property '$0'


    context 'with user options given', ->

      beforeEach ->
        user_options =
          stdout: 'custom stdout'
          stderr: 'custom stderr'
          reporter: 'custom reporter'
          testDir: 'test/test_data'
          compilers: 'foo:bar'
        @mocha_configuration = new MochaConfiguration Mycha.default_mocha_options,
                                                      create_argv(options: user_options)

      it 'uses the given compiler', ->
        expect(@mocha_configuration.options.compilers).to.equal 'foo:bar'

      it 'uses the given reporter', ->
        expect(@mocha_configuration.options.reporter).to.equal 'custom reporter'

      it 'does not contain the Optimist-specific elements', ->
        expect(@mocha_configuration.options).to.not.have.property '_'
        expect(@mocha_configuration.options).to.not.have.property '$0'


