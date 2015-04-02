async = require 'async'
MychaInstaller = require './mycha_installer'
MochaRunner = require './mocha_runner'
prompt = require 'prompt'


exitWithError = (err) ->
  console.error err
  process.exit 1


getTestHelperPath = (done) ->
  prompt.start()
  prompt.get [
    description: 'Default test helper path',
    name: 'testHelperPath'
    required: true
  ], (err, {testHelperPath} = {}) ->
    if err then return done err
    done null, testHelperPath


installMycha = (testHelperPath, done) ->
  installer = new MychaInstaller {cwd: process.cwd(), testHelperPath}
  installer.install done


if process.argv.length is 3 and process.argv[2] is 'install'
  async.waterfall [getTestHelperPath, installMycha], (err) ->
    if err then exitWithError err
    process.exit 0
else
  mochaRunner = new MochaRunner {argv: process.argv.slice(2), cwd: process.cwd()}
  mochaRunner.run (err, exitCode) ->
    if err then exitWithError err
    process.exit exitCode
