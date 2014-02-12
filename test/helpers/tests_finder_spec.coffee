chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
TestsFinder = require '../../lib/helpers/tests_finder'
_ = require 'underscore'


# Domain-specifc matcher for checking if the result list
# has the entries with the given id marked as clicked.
chai.Assertion.addMethod 'include_test_file', (filename) ->

  # Convert the absolute paths in the result to relative paths,
  # to make them easier to compare.
  test_directory_path = "#{process.cwd()}/test_data/subdirectories/"
  shortened_actual_data = _(@_obj).map( (path) -> path.substr test_directory_path.length)

  assertion = new chai.Assertion(shortened_actual_data)
  if @__flags.negate
    # We are supposed to check that Mycha does NOT consider the given file as a test file.
    assertion.to.not.include filename
  else
    # We are supposed to check that Mycha does consider the given file as a test file.
    assertion.to.include filename


describe 'TestsFinder', ->

  beforeEach ->
    @test_files = new TestsFinder('./test_data/subdirectories').files()

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
