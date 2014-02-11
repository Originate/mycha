chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require './test_helper'
Mycha = require '../lib/mycha'
MychaConfiguration = require '../lib/mycha_configuration'


describe 'MychaConfiguration', ->

  context 'no user options given', ->

    beforeEach ->
      @mycha_configuration = new MychaConfiguration Mycha.default_mycha_options,
                                                    create_argv()

    it 'uses the default stdout', ->
      expect(@mycha_configuration.options.stdout).to.equal Mycha.default_mycha_options.stdout

    it 'uses the default stderr', ->
      expect(@mycha_configuration.options.stderr).to.equal Mycha.default_mycha_options.stderr

    it 'uses the default test directory', ->
      expect(@mycha_configuration.options.testDir).to.equal Mycha.default_mycha_options.testDir

    it 'removes the used options', ->
      for own key, value of Mycha.default_mycha_options
        expect(@mycha_configuration.remaining_options).to.not.have.property key


  context 'user options given', ->

    beforeEach ->
      @user_options =
        stdout: 'custom stdout'
        stderr: 'custom stderr'
        reporter: 'custom reporter'
        testDir: 'test/test_data'
        foo: 'bar'
      @mycha_configuration = new MychaConfiguration Mycha.default_mycha_options,
                                                    create_argv(options: @user_options)


    it 'uses the custom stdout', ->
      expect(@mycha_configuration.options.stdout).to.equal 'custom stdout'

    it 'uses the custom stderr', ->
      expect(@mycha_configuration.options.stderr).to.equal 'custom stderr'

    it 'uses the custom test directory', ->
      expect(@mycha_configuration.options.testDir).to.equal 'test/test_data'

    it 'returns the remaining user options ', ->
      expect(@mycha_configuration.remaining_options).to.have.property 'reporter', 'custom reporter'
      expect(@mycha_configuration.remaining_options).to.have.property 'foo', 'bar'
      expect(@mycha_configuration.remaining_options).to.not.contain.keys ['stdout', 'stderr', 'testDir']


