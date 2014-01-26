chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
Mycha = require '../lib/mycha'
require './test_helper'


describe 'Mycha', ->

  describe 'options', ->

    context 'no user options given', ->

      beforeEach ->
        @options = new Mycha().options

      it 'uses the default stdout', ->
        expect(@options.stdout).to.equal Mycha.default_options.stdout

      it 'uses the default stderr', ->
        expect(@options.stderr).to.equal Mycha.default_options.stderr

      it 'uses the default reporter', ->
        expect(@options.reporter).to.equal Mycha.default_options.reporter

      it 'uses the default testDir', ->
        expect(@options.testDir).to.equal Mycha.default_options.testDir

      it 'uses the default mochaArgs', ->
        for default_mocha_arg in Mycha.default_mocha_args
          expect(@options.mochaArgs).to.include default_mocha_arg


    context 'user options given', ->

      beforeEach ->
        user_options =
          stdout: 'custom stdout'
          stderr: 'custom stderr'
          reporter: 'custom reporter'
          testDir: 'test/test_data'
          mochaArgs: 'custom mochaArgs'
        @options = new Mycha(null, user_options).options


      it 'uses the custom stdout', ->
        expect(@options.stdout).to.equal 'custom stdout'

      it 'uses the custom stderr', ->
        expect(@options.stderr).to.equal 'custom stderr'

      it 'uses the custom reporter', ->
        expect(@options.reporter).to.equal 'custom reporter'

      it 'uses the custom testDir', ->
        expect(@options.testDir).to.equal 'test/test_data'

      it 'uses the default mochaArgs in union with custom mochaArgs', ->
        expect(@options.mochaArgs).to.include 'custom mochaArgs'
        expect(@options.mochaArgs).to.include '--colors'


    context 'user gives empty mochaArgs', ->

      beforeEach ->
        @options = new Mycha(mochaArgs: []).options

      it 'uses the default mochaArgs', ->
        for default_mocha_arg in Mycha.default_mocha_args
          expect(@options.mochaArgs).to.include default_mocha_arg


    it 'appends the test files to the mochaArgs', ->
      @options = new Mycha(null, testDir: 'test/test_data').options
      expect(@options.mochaArgs).to.include_test_file 'javascript_test.js'
      expect(@options.mochaArgs).to.include_test_file 'dir/test_in_directory_test.coffee'

