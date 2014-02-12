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
        expect(@file_configuration.files).to.include Mycha.default_files[0]

      it 'includes all files in the "test" directory', ->
        expect(@file_configuration.files).to.include "#{process.cwd()}/test_data/subdirectories/javascript_test.js"
        expect(@file_configuration.files).to.include "#{process.cwd()}/test_data/subdirectories/javascript_spec.js"


    context 'custom test directory given', ->

      beforeEach ->
        @file_configuration = new FileConfiguration
          test_dir: 'test_data/subdirectories'
          default_files: Mycha.default_files
          files: []

      it 'includes the given default file', ->
        expect(@file_configuration.files).to.include Mycha.default_files[0]

      it 'includes all files in the "test" directory', ->
        expect(@file_configuration.files).to.include "#{process.cwd()}/test_data/subdirectories/javascript_test.js"



    context 'single test file name given by the user', ->

      beforeEach ->
        # @file_configuration = new FileConfiguration
        #   test_dir: 'test/test_data'
        #   default_files: Mycha.default_files
        #   files: ['run', '']

      it 'includes the Mycha helper file'

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
      expect(@result).to.include "#{process.cwd()}/test_data/subdirectories/javascript_test.js"
      expect(@result).to.include "#{process.cwd()}/test_data/subdirectories/javascript_spec.js"
      expect(@result).to.include "#{process.cwd()}/test_data/subdirectories/root_level_test.coffee"
      expect(@result).to.include "#{process.cwd()}/test_data/subdirectories/root_level_spec.coffee"
      expect(@result).to.include "#{process.cwd()}/test_data/subdirectories/dir/test_in_directory_test.coffee"
      expect(@result).to.include "#{process.cwd()}/test_data/subdirectories/dir/subdir/test_in_subdirectory_test.coffee"

