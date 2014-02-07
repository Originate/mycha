commands =
  run: "Runs all tests found in /test"
  watch: "Runs all tests in /test and watches for changes"
  help: "Shows this help page"

usage_text = """
                Usage: mycha <command> [options]

                where <command> is one of:
                #{("  #{command_name} - #{command_desc}" for command_name, command_desc of commands).join("\n")}
              """

argv = require('optimist')
  .usage(usage_text)
  .options 'reporter',
    alias: 'R'
    default: 'spec'
    describe: 'specify the reporter to use'
  .options 'timeout',
    alias: 't'
    default: '2000'
    describe: 'set test-case timeout in milliseconds'
  .describe('mocha.[mocha option]', 'Pass in mocha options (ex. --mocha.grep <pattern>)')
  .check (argv) ->
    command = argv._[0]
    throw "Missing command." unless command?
    throw "\"#{command}\" is not a valid command." unless commands[command]?
    throw "" if command is 'help'
  .argv

command = argv._[0]
options = argv
options.watch = command is 'watch'

Mycha = require __dirname + '/mycha'
mycha = new Mycha options
mycha.run (exit_code) ->
  process.exit exit_code
