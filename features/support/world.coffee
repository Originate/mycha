{fork} = require 'child_process'
path = require 'path'


class World

  mychaPath: path.join __dirname, '..', '..', 'bin', 'mycha'


  installMycha: (testHelperPath, done) ->
    childProcess = fork @mychaPath, ['install'], silent: yes, cwd: @tmpDir
    childProcess.stdin.write "#{testHelperPath}\n", 'utf-8'
    childProcess.on 'exit', -> done()


# Cucumber expects a 'World' attribute on all testing objects
module.exports = ->
  @World = World
