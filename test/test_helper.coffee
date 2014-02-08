chai = require 'chai'
path = require 'path'
child = require 'child_process'
_ = require 'underscore'


# Domain-specifc matcher for checking if the result list
# has the entries with the given id marked as clicked.
chai.Assertion.addMethod 'include_test_file', (filename) ->

  # Convert the absolute paths in the result to relative paths,
  # to make them easier to compare.
  test_directory_path = "#{process.cwd()}/test/test_data/"
  shortened_actual_data = _(@_obj).map( (path) -> path.substr test_directory_path.length)

  assertion = new chai.Assertion(shortened_actual_data)
  if @__flags.negate
    # We are supposed to check that Mycha does NOT consider the given file as a test file.
    assertion.to.not.include filename
  else
    # We are supposed to check that Mycha does consider the given file as a test file.
    assertion.to.include filename


# Runs the Mycha command-line tool
# with tests in the given directory and
# with the given arguments.
global.run_mycha = ({ test_dir, args }) ->
  cwd = path.join __dirname, test_dir
  mycha_path = path.resolve __dirname, '../bin/mycha'
  child.spawn mycha_path, args, cwd: cwd
