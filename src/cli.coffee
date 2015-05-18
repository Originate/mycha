async = require 'async'
ConfigLoader = require './config_loader'
MychaInstaller = require './mycha_installer'
Mycha = require './mycha'
prompt = require 'prompt'


exitWithError = (err) ->
  console.error err
  process.exit 1


getTestHelperPath = (done) ->
  prompt.start()
  prompt.get [
    description: 'Default test helper path',
    name: 'testHelperPath'
    required: yes
  ], (err, {testHelperPath} = {}) ->
    if err then return done err
    done null, testHelperPath


installMycha = (testHelperPath, done) ->
  installer = new MychaInstaller {cwd: process.cwd(), testHelperPath}
  installer.install done


loadConfig = (done) ->
  ConfigLoader.load process.cwd(), done


runTests = (config, done) ->
  Mycha.run {argv: process.argv.slice(2), config, cwd: process.cwd()}, done


if process.argv.length is 3 and process.argv[2] is 'install'
  async.waterfall [getTestHelperPath, installMycha], (err) ->
    if err then exitWithError err
    process.exit 0
else
  async.waterfall [loadConfig, runTests], (err, exitCode) ->
    if err then exitWithError err
    process.exit exitCode
