chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require './test_helper'
Mycha = require '../lib/mycha'
FileConfiguration = require '../lib/file_configuration'


describe 'FileConfiguration', ->

  describe 'constructor', ->

    context 'no user options given', ->

      beforeEach ->
        @file_configuration = new FileConfiguration
          test_dir: 'test/test_data'
          default_files: Mycha.default_files
          argv: create_argv()

      it 'includes the given default file', ->
        expect(@file_configuration.files).to.include Mycha.default_files[0]

      it 'includes all files in the "test" directory', ->
        expect(@file_configuration.files).to.include "#{__dirname}/test_data/javascript_test.js"
        expect(@file_configuration.files).to.include "#{__dirname}/test_data/javascript_spec.js"


    context 'custom test directory given', ->

      beforeEach ->
        @file_configuration = new FileConfiguration
          test_dir: 'test/test_data'
          default_files: Mycha.default_files
          argv: create_argv()

      it 'includes the given default file', ->
        expect(@file_configuration.files).to.include Mycha.default_files[0]

      it 'includes all files in the "test" directory', ->
        expect(@file_configuration.files).to.include "#{__dirname}/test_data/javascript_test.js"



    context 'single test file name given by the user', ->

      beforeEach ->
        # @file_configuration = new FileConfiguration
        #   test_dir: 'test/test_data'
        #   default_files: Mycha.default_files
        #   argv: create_argv(commands: ['run', ''])

      it 'includes the Mycha helper file'

      it 'only runs the given test file'


