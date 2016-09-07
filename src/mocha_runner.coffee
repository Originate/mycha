mochaExecutablePath = require.resolve 'mocha/bin/mocha'
spawn = require 'cross-spawn'


class MochaRunner

  constructor: ({@args, @env, @silent}) ->


  run: (done) ->
    stdio = if @silent then 'ignore' else 'inherit'
    childProcess = spawn mochaExecutablePath, @args, {@env, stdio}
    childProcess.on 'exit', (exitCode) -> done null, exitCode


module.exports = MochaRunner
