OptimistParser = require './helpers/optimist_parser'


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
    return unless command  # No command is fine, OptimistParser will default to "run" later.
    throw "'#{command}' is not a valid command." unless commands[command]?
    throw "" if command is 'help'
  .argv


Mycha = require __dirname + '/mycha'
mycha = new Mycha process.cwd()
optimist_parser = new OptimistParser argv
if optimist_parser.command() is 'run'
  mycha.run
    run_options: optimist_parser.options()
    run_files: optimist_parser.files(),
    done: (exit_code) -> process.exit exit_code
