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
          default_files: Mycha.default_files
          run_files: []
        @result = file_configuration.files()

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)

      it 'includes all files in the "test" directory', ->
        expect(@result).to.include_test_file 'two_tests', 'test', 'one_test.coffee'
        expect(@result).to.include_test_file 'two_tests', 'test', 'two_test.coffee'


    context 'tests located in folder other than test', ->

      beforeEach ->
        file_configuration = new FileConfiguration
          root_dir: path.join(process.cwd(), 'test_data', 'custom_test_directory')
          default_files: Mycha.default_files
          run_files: []
        @result = file_configuration.files()

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)


      it 'includes all test files', ->
        expect(@result).to.include_test_file 'custom_test_directory', 'spec', 'one_spec.coffee'
        expect(@result).to.include_test_file 'custom_test_directory', 'spec', 'two_spec.coffee'

      it 'does not include files in the "node_modules" directory', ->
        expect(@result).to.not.include_test_file 'custom_test_directory', 'node_modules', 'not_found_spec.coffee'


    context 'single test file name given by the user', ->

      beforeEach ->
        file_configuration = new FileConfiguration
          root_dir: path.join(process.cwd(), 'test_data', 'two_tests')
          default_files: Mycha.default_files
          run_files: ['test/two_test.coffee']
        @result = file_configuration.files()

      it 'includes the given default file', ->
        for default_file in Mycha.default_files
          expect(@result).to.include(default_file)

      it 'only runs the given test file', ->
        expect(@result).to.include_test_file 'two_tests', 'test', 'two_test.coffee'


  describe 'to_args', ->

    beforeEach ->
      file_configuration = new FileConfiguration
        root_dir: path.join(process.cwd(), 'test_data', 'two_tests')
        default_files: Mycha.default_files
        run_files: []
      @result = file_configuration.to_args()

    it 'loads the Mycha helper first', ->
      expect(@result[0]).to.equal path.resolve('lib', 'test_helper.coffee')

    it 'provides all test files', ->
      expect(@result).to.include_test_file 'two_tests', 'test', 'one_test.coffee'
      expect(@result).to.include_test_file 'two_tests', 'test', 'two_test.coffee'

