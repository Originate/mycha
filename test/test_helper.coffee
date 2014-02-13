chai = require 'chai'
path = require 'path'
child = require 'child_process'
_ = require 'underscore'
chai = require 'chai'
expect = chai.expect


# Runs the Mycha command-line tool
# with tests in the given directory and
# with the given arguments.
global.run_mycha = ({ test_dir, args, done }) ->
  cwd = path.join process.cwd(), 'test_data', test_dir
  mycha_path = path.resolve process.cwd(), 'bin/mycha'
  mycha_process = child.spawn mycha_path, args, cwd: cwd
  mycha_process.on 'close', done



# Verifies that the tests in the given test directory pass.
global.verify_success = (test_dir, done) ->
  run_mycha test_dir: test_dir, args: ['run'], done: (exit_code) ->
    expect(exit_code).to.equal 0
    done()


# Verifies that the tests in the given test directory fail.
global.verify_failure = (test_dir, done) ->
  run_mycha test_dir: test_dir, args: ['run'], done: (exit_code) ->
    expect(exit_code).to.equal 1
    done()


# Creates an Optimist argv object for testing.
#
# Parameters:
# * options: hash with command-line options (the stuff that begins with '--')
# * commands: array of command-line arguments given after the options
global.create_argv = (options = {}) ->
  {options, commands} = options
  options ?= {}
  commands ?= []
  result = {}
  result._ = commands
  result['$0'] = 'node ./bin/mycha'
  _(result).extend options


# Adds contain_consecutive_elements assertion to chai
#
# Usage:
# chai.use ContainConsecutiveElementsAssertion
class ContainConsecutiveElementsAssertion
  constructor: ({ Assertion }) ->
    Assertion.addMethod 'contain_consecutive_elements',
                        ContainConsecutiveElementsAssertion.define_assertion

  @define_assertion: (consecutive_values...) ->
    array = @_obj
    @assert ContainConsecutiveElementsAssertion.test_consecutive(array, consecutive_values),
            "expected #{array} to contain #{consecutive_values} consecutively",
            "expected #{array} to not contain #{consecutive_values} consecutively"

  @test_consecutive: (array, consecutive_values) ->
    first_index = array.indexOf consecutive_values[0]
    return no if first_index is -1

    for value, value_index in consecutive_values
      return no if array[first_index + value_index] isnt value

    return yes


chai.use ContainConsecutiveElementsAssertion
