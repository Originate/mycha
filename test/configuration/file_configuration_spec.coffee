path = require 'path'
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
        file_configuration = new FileConfiguration
          root_dir: path.join(process.cwd(), 'test_data', 'two_tests')
          test_dir_name: 'test'
          default_files: Mycha.default_files
          run_files: []
        @result = file_configuration.files

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)

      it 'includes all files in the "test" directory', ->
        expect(@result).to.include_test_file 'two_tests', 'one_test.coffee'
        expect(@result).to.include_test_file 'two_tests', 'two_test.coffee'


    context 'custom test directory given', ->

      beforeEach ->
        file_configuration = new FileConfiguration
          root_dir: path.join(process.cwd(), 'test_data', 'custom_test_directory')
          test_dir_name: 'spec'
          default_files: Mycha.default_files
          run_files: []
        @result = file_configuration.files

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)

      it 'includes all files in the "test" directory', ->
        expect(@result).to.include_test_file 'custom_test_directory', 'one_spec.coffee'
        expect(@result).to.include_test_file 'custom_test_directory', 'two_spec.coffee'


    context 'single test file name given by the user', ->

      beforeEach ->
        file_configuration = new FileConfiguration
          root_dir: path.join(process.cwd(), 'test_data', 'two_tests')
          test_dir_name: 'test'
          default_files: Mycha.default_files
          run_files: ['test/two_test.coffee']
        @result = file_configuration.files

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)

      it 'only runs the given test file', ->
        expect(@result).to.include_test_file 'two_tests', 'two_test.coffee'


  describe 'to_args', ->

    beforeEach ->
      file_configuration = new FileConfiguration
        root_dir: path.join(process.cwd(), 'test_data', 'two_tests')
        test_dir_name: 'test'
        default_files: Mycha.default_files
        run_files: []
      @result = file_configuration.to_args()

    it 'loads the Mycha helper first', ->
      expect(@result[0]).to.equal "#{process.cwd()}/lib/test_helper.coffee"

    it 'provides all test files', ->
      expect(@result).to.include_test_file 'two_tests', 'one_test.coffee'
      expect(@result).to.include_test_file 'two_tests', 'two_test.coffee'

