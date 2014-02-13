chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require '../test_helper'
Mycha = require '../../lib/mycha'
FileConfiguration = require '../../lib/configuration/file_configuration'


describe 'FileConfiguration', ->

  describe 'constructor', ->

    context 'no user options given', ->

      beforeEach ->
        @file_configuration = new FileConfiguration
          test_dir: 'test_data/subdirectories'
          default_files: Mycha.default_files
          files: []

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)

      it 'includes all files in the "test" directory', ->
        expect(@result).to.include_test_file 'two_tests', 'one_test.coffee'
        expect(@result).to.include_test_file 'two_tests', 'two_test.coffee'


    context 'custom test directory given', ->

      beforeEach ->
        @file_configuration = new FileConfiguration
          test_dir: 'test_data/subdirectories'
          default_files: Mycha.default_files
          files: []

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)

      it 'includes all files in the "test" directory', ->
        expect(@result).to.include_test_file 'custom_test_directory', 'one_spec.coffee'
        expect(@result).to.include_test_file 'custom_test_directory', 'two_spec.coffee'


    context 'single test file name given by the user', ->

      beforeEach ->
        # @file_configuration = new FileConfiguration
        #   test_dir: 'test/test_data'
        #   default_files: Mycha.default_files
        #   files: ['run', '']

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)

      it 'only runs the given test file'


  describe 'to_args', ->

    beforeEach ->
      file_configuration = new FileConfiguration
        test_dir: 'test_data/subdirectories/'
        default_files: Mycha.default_files
        files: []
      @result = file_configuration.to_args()

    it 'loads the Mycha helper first', ->
      expect(@result[0]).to.equal "#{process.cwd()}/lib/test_helper.coffee"

    it 'provides all test files', ->
      expect(@result).to.include_test_file 'two_tests', 'one_test.coffee'
      expect(@result).to.include_test_file 'two_tests', 'two_test.coffee'

