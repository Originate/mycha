chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
TestsFinder = require '../lib/helpers/tests_finder'
_ = require 'underscore'


describe 'TestsFinder', ->

  beforeEach ->
    @test_files = new TestsFinder('./test/test_data').files()

  it 'finds javascript tests', ->
    expect(@test_files).to.include_test_file 'javascript_test.js'
    expect(@test_files).to.include_test_file 'javascript_spec.js'

  it 'finds coffeescript tests', ->
    expect(@test_files).to.include_test_file 'root_level_test.coffee'
    expect(@test_files).to.include_test_file 'root_level_spec.coffee'

  it 'traverses subdirectories', ->
    expect(@test_files).to.include_test_file 'dir/test_in_directory_test.coffee'
    expect(@test_files).to.include_test_file 'dir/subdir/test_in_subdirectory_test.coffee'

  it 'ignores hidden files', ->
    expect(@test_files).to.not.include_test_file '.hidden_test.coffee'

  it "ignores files whose name doesn't end in _test", ->
    expect(@test_files).to.not.include_test_file 'test_helper.coffee'

  it 'ignores non-code files that end in _test.*', ->
    expect(@test_files).to.not.include_test_file 'image_test.png'

  it 'does not find tests outside of the given test directory', ->
    expect(@test_files).to.not.include_test_file 'mycha_test.coffee'
