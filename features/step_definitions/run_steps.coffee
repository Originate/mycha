{exec, fork} = require 'child_process'
MychaInstaller = require '../../lib/mycha_installer'
path = require 'path'
StdOutFixture = require 'fixture-stdout'
fixtures = (new StdOutFixture {stream} for stream in [process.stdout, process.stderr])


module.exports = ->

  @Given /^I have a installed mycha$/, (done) ->
    fixture.capture(-> false) for fixture in fixtures
    new MychaInstaller(cwd: @tmpDir, testHelperPath: 'spec/spec_helper.coffee').install ->
      fixture.release() for fixture in fixtures
      done()


  @When /^I run "([^"]*)"$/, (command, done) ->
    command = command.replace 'mycha', @mychaPath
    exec command, cwd: @tmpDir, (@error, @stdout, @stderr) => done()


  @When /^I run "mycha ([^"]*)" and respond to the prompt with "([^"]*)"$/, (args, input, done) ->
    childProcess = fork @mychaPath, args.split(' '), silent: true, cwd: @tmpDir
    childProcess.stdin.write "#{input}\n", 'utf-8'
    childProcess.on 'exit', -> done()


  @Then /^I see "([^"]*)"$/, (text, done) ->
    expect(@stdout).to.include text
    done()


  @Then /^it has exit status (\d+)$/, (status, done) ->
    if status is '0'
      expect(@error).to.not.exist
    else
      @expectedError = true
      expect(@error).to.be.instanceOf Error
      expect(@error.message).to.contain 'Command failed'
    done()
