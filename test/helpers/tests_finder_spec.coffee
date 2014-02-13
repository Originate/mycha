chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
TestsFinder = require '../../lib/helpers/tests_finder'
_ = require 'underscore'


describe 'TestsFinder', ->

  beforeEach ->
    @test_files = new TestsFinder('./test_data/subdirectories').files()

  it 'finds javascript tests', ->
    expect(@test_files).to.include_test_file 'subdirectories', 'javascript_test.js'
    expect(@test_files).to.include_test_file 'subdirectories', 'javascript_spec.js'

  it 'finds coffeescript tests', ->
    expect(@test_files).to.include_test_file 'subdirectories', 'root_level_test.coffee'
    expect(@test_files).to.include_test_file 'subdirectories', 'root_level_spec.coffee'

  it 'traverses subdirectories', ->
    expect(@test_files).to.include_test_file 'subdirectories', 'dir/test_in_directory_test.coffee'
    expect(@test_files).to.include_test_file 'subdirectories', 'dir/subdir/test_in_subdirectory_test.coffee'

  it 'ignores hidden files', ->
    expect(@test_files).to.not.include_test_file 'subdirectories', '.hidden_test.coffee'

  it "ignores files whose name doesn't end in _test", ->
    expect(@test_files).to.not.include_test_file 'subdirectories', 'test_helper.coffee'

  it 'ignores non-code files that end in _test.*', ->
    expect(@test_files).to.not.include_test_file 'subdirectories', 'image_test.png'

  it 'does not find tests outside of the given test directory', ->
    expect(@test_files).to.not.include_test_file 'subdirectories', 'mycha_test.coffee'
