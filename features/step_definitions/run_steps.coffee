{exec, fork} = require 'child_process'
MychaInstaller = require '../../lib/mycha_installer'
path = require 'path'
StdOutFixture = require 'fixture-stdout'
fixtures = (new StdOutFixture {stream} for stream in [process.stdout, process.stderr])


module.exports = ->

  @Given /^I have Mycha installed$/, (done) ->
    fixture.capture(-> false) for fixture in fixtures
    new MychaInstaller(cwd: @tmpDir, testHelperPath: 'spec/spec_helper.coffee').install ->
      fixture.release() for fixture in fixtures
      done()


  @When /^I run "([^"]*)"$/, (command, done) ->
    command = command.replace 'mycha', @mychaPath
    exec command,
         cwd: @tmpDir,
         (@error, @stdout, @stderr) => done()


  @When /^I run "mycha ([^"]*)" and enter "([^"]*)"$/, (args, input, done) ->
    childProcess = fork @mychaPath,
                        args.split(' '),
                        silent: yes, cwd: @tmpDir
    childProcess.stdin.write "#{input}\n", 'utf-8'
    childProcess.on 'exit', -> done()


  @Then /^I see "([^"]*)"$/, (text, done) ->
    expect(@stdout).to.include text
    done()


  @Then /^it finishes with status (\d+)$/, (status, done) ->
    if status is '0'
      expect(@error).to.not.exist
    else
      @expectedError = yes
      expect(@error).to.be.instanceOf Error
      expect(@error.message).to.contain 'Command failed'
    done()
