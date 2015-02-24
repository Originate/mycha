chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
path = require 'path'
TestsFinder = require '../../lib/helpers/tests_finder'
_ = require 'underscore'


describe 'TestsFinder', ->

  beforeEach ->
    @test_files = new TestsFinder(path.resolve './test_data/subdirectories').files()

  it 'finds javascript tests', ->
    expect(@test_files).to.include_test_file 'subdirectories', 'test', 'javascript_test.js'
    expect(@test_files).to.include_test_file 'subdirectories', 'test', 'javascript_spec.js'

  it 'finds coffeescript tests', ->
    expect(@test_files).to.include_test_file 'subdirectories', 'test', 'root_level_test.coffee'
    expect(@test_files).to.include_test_file 'subdirectories', 'test', 'root_level_spec.coffee'

  it 'traverses subdirectories', ->
    expect(@test_files).to.include_test_file 'subdirectories', 'test', 'dir', 'test_in_directory_test.coffee'
    expect(@test_files).to.include_test_file 'subdirectories', 'test', 'dir', 'subdir', 'test_in_subdirectory_test.coffee'

  it 'ignores hidden files', ->
    expect(@test_files).to.not.include_test_file 'subdirectories', '.hidden_test.coffee'

  it "ignores files whose name doesn't end in _test", ->
    expect(@test_files).to.not.include_test_file 'subdirectories', 'test', 'test_helper.coffee'

  it 'ignores non-code files that end in _test.*', ->
    expect(@test_files).to.not.include_test_file 'subdirectories', 'test', 'image_test.png'

  it 'does not find tests outside of the given test directory', ->
    expect(@test_files).to.not.include_test_file 'simple', 'test', 'simple_test.coffee'
