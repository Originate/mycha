chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require '../test_helper'
Mycha = require '../../lib/mycha'
MochaConfiguration = require '../../lib/configuration/mocha_configuration'


describe 'MochaConfiguration', ->

  describe 'constructor', ->

    context 'without user options', ->

      beforeEach ->
        @mocha_configuration = new MochaConfiguration
          run_options: {}
          default_mocha_options: Mycha.default_mocha_options,
          files: []

      it 'uses CoffeeScript as the default compiler', ->
        expect(@mocha_configuration.options.compilers).to.equal 'coffee:coffee-script'

      it 'uses the "dot" reporter', ->
        expect(@mocha_configuration.options.reporter).to.equal 'dot'

      it 'shows colors', ->
        expect(@mocha_configuration.options.colors).to.be.true


    context 'with user options', ->

      beforeEach ->
        user_options =
          stdout: 'custom stdout'
          stderr: 'custom stderr'
          reporter: 'custom reporter'
          testDir: 'test/test_data'
          compilers: 'foo:bar'
        @mocha_configuration = new MochaConfiguration
          run_options: user_options
          default_mocha_options: Mycha.default_mocha_options
          files: []

      it 'uses the given compiler', ->
        expect(@mocha_configuration.options.compilers).to.equal 'foo:bar'

      it 'uses the given reporter', ->
        expect(@mocha_configuration.options.reporter).to.equal 'custom reporter'


    context 'with user files given', ->

      beforeEach ->
        @mocha_configuration = new MochaConfiguration
          run_options: {}
          default_mocha_options: Mycha.default_mocha_options,
          files: ['one_spec.coffee']

      it 'uses CoffeeScript as the default compiler', ->
        expect(@mocha_configuration.options.compilers).to.equal 'coffee:coffee-script'

      it 'uses the "spec" reporter', ->
        expect(@mocha_configuration.options.reporter).to.equal 'spec'

      it 'shows colors', ->
        expect(@mocha_configuration.options.colors).to.be.true


    context 'with custom reporter and user files given', ->

      beforeEach ->
        @mocha_configuration = new MochaConfiguration
          run_options: {reporter: 'foo'}
          default_mocha_options: Mycha.default_mocha_options,
          files: ['one_spec.coffee']

      it 'uses CoffeeScript as the default compiler', ->
        expect(@mocha_configuration.options.compilers).to.equal 'coffee:coffee-script'

      it 'uses the given custom reporter', ->
        expect(@mocha_configuration.options.reporter).to.equal 'foo'

      it 'shows colors', ->
        expect(@mocha_configuration.options.colors).to.be.true


  describe 'merge_options', ->

    beforeEach ->
      user_options =
        stdout: 'custom stdout'
        stderr: 'custom stderr'
        reporter: 'custom reporter'
        testDir: 'test/test_data'
        compilers: 'foo:bar'
      mocha_configuration = new MochaConfiguration
        run_options: {}
        default_mocha_options: Mycha.default_mocha_options
        files: []
      @result = mocha_configuration.merge_options user_options,
                                                  Mycha.default_mocha_options

    it 'uses the user-provided compiler', ->
      expect(@result.compilers).to.equal 'foo:bar'

    it 'uses the user-provided reporter', ->
      expect(@result.reporter).to.equal 'custom reporter'


  describe 'to_args', ->

    context 'normal behavior', ->

      beforeEach ->
        mocha_configuration = new MochaConfiguration
          run_options: {}
          default_mocha_options: Mycha.default_mocha_options
          files: []
        @result = mocha_configuration.to_args()

      it 'returns an array of strings', ->
        expect(@result.length).to.equal 5
        expect(@result).to.include '--compilers'
        expect(@result).to.include 'coffee:coffee-script'
        expect(@result).to.include '--reporter'
        expect(@result).to.include 'dot'
        expect(@result).to.include '--colors'


    context 'an option is disabled', ->

      beforeEach ->
        mocha_configuration = new MochaConfiguration
          run_options: {colors: false}
          default_mocha_options: Mycha.default_mocha_options
          files: []
        @result = mocha_configuration.to_args()

      it 'does not provide the disabled option', ->
        expect(@result).to.not.include '--colors'
