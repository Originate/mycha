Mocha = require 'mocha'
child = require 'child_process'
_ = require 'underscore'
TestsFinder = require './tests_finder'


class Mycha

  constructor: (projectDir, options={}) ->

    # The default options that are used if none are provided by the user.
    default_options =
      stdout: process.stdout
      stderr: process.stderr
      reporter: 'dot'
      testDir: 'test'
      mochaArgs: []

    # The actually used options user provided + defaults.
    @options = _(options).defaults default_options


  run: (callback) ->
    args = [
      # Set mocha options
      "--compilers", "coffee:coffee-script"
      "--reporter", @options.reporter
      "--colors"

      # Include mycha test helper
      "#{__dirname}/helper.coffee"
    ]

    # Include args passed mochaArgs
    args = args.concat @options.mochaArgs

    # Include files found in /test
    result.mochaArgs = result.mochaArgs.concat new TestsFinder(result.testDir).files()

    childProcess = child.spawn "#{__dirname}/../node_modules/mocha/bin/mocha", args
    childProcess.stdout.pipe @options.stdout
    childProcess.stderr.pipe @options.stderr
    childProcess.on 'exit', callback if callback



module.exports = Mycha
