chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require './test_helper'
Mycha = require '../lib/mycha'
MochaConfiguration = require '../lib/mocha_configuration'


describe 'MochaConfiguration', ->

  describe 'constructor', ->

    context 'without user options', ->

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


    context 'with user options', ->

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


  describe 'merge_options', ->

    beforeEach ->
      user_options =
        stdout: 'custom stdout'
        stderr: 'custom stderr'
        reporter: 'custom reporter'
        testDir: 'test/test_data'
        compilers: 'foo:bar'
      mocha_configuration = new MochaConfiguration Mycha.default_mocha_options,
                                                   create_argv()
      @argv = create_argv options: user_options
      @result = mocha_configuration.merge_options @argv,
                                                  Mycha.default_mocha_options

    it 'uses the user-provided compiler', ->
      expect(@result.compilers).to.equal 'foo:bar'

    it 'uses the user-provided reporter', ->
      expect(@result.reporter).to.equal 'custom reporter'


  describe 'remove_optimist_elements', ->

    beforeEach ->
      mocha_configuration = new MochaConfiguration Mycha.default_mocha_options,
                                                   create_argv()
      @result = mocha_configuration.remove_optimist_elements create_argv()

    it 'removes the command-line arguments', ->
      expect(@result).to.not.have.property '_'

    it 'removes the application name element', ->
      expect(@result).to.not.have.property '$0'



  describe 'to_args', ->

    it 'returns an array of strings', ->
      mocha_configuration = new MochaConfiguration Mycha.default_mocha_options,
                                                   create_argv()
      result = mocha_configuration.to_args()
      expect(result.length).to.equal 5
      expect(result).to.include '--compilers'
      expect(result).to.include 'coffee:coffee-script'
      expect(result).to.include '--reporter'
      expect(result).to.include 'dot'
      expect(result).to.include '--colors'
