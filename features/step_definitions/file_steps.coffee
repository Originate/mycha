fsExtra = require 'fs-extra'
path = require 'path'


module.exports = ->

  @Given /^I have no test files$/, (done) ->
    done() # No op for readability


  @Given /^I have 1 (passing|failing) test$/, (status, done) ->
    fsExtra.outputFile path.join(@tmpDir, 'example_spec.coffee'), @testContent(status), done


  @Given /^I have the file "([^"]*)" with 1 (passing|failing) test$/, (filePath, status, done) ->
    fsExtra.outputFile path.join(@tmpDir, filePath), @testContent(status), done


  @Then /^I now have the file "([^"]*)" with the contents$/, (fileName, fileContent, done) ->
    expect(path.join @tmpDir, fileName).to.have.content fileContent
    done()
