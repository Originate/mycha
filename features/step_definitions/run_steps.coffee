{exec, fork} = require 'child_process'
path = require 'path'


module.exports = ->

  @Given /^I have Mycha installed$/, {timeout: 10000}, (done) ->
    @installMycha 'spec/spec_helper.js', done


  @When /^I run "([^"]*)"$/, (command, done) ->
    command = command.replace 'mycha', @mychaPath
    exec command,
         cwd: @tmpDir,
         (@error, @stdout, @stderr) => done()


  @When /^I run "mycha install" and enter "([^"]*)"$/, {timeout: 10000}, (testHelperPath, done) ->
    @installMycha testHelperPath, done


  @Then /^I see "([^"]*)"$/, (text) ->
    expect(@stdout).to.include text


  @Then /^it finishes with status (\d+)$/, (status) ->
    if status is '0'
      expect(@error).to.not.exist
    else
      @expectedError = yes
      expect(@error).to.be.instanceOf Error
      expect(@error.message).to.contain 'Command failed'
