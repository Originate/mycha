OptimistParser = require './optimist_parser'


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
  .check (argv) ->
    command = argv._[0]
    throw "Missing command." unless command?
    throw "\"#{command}\" is not a valid command." unless commands[command]?
    throw "" if command is 'help'
  .argv


Mycha = require __dirname + '/mycha'
mycha = new Mycha process.cwd()
optimist_parser = new OptimistParser argv
if optimist_parser.command() is 'run'
  mycha.run optimist_parser.options(),
            optimist_parser.files(),
            (exit_code) -> process.exit exit_code
