{outputTestFile} = require '../../spec/file_helpers'
path = require 'path'


module.exports = ->

  @Given /^I have no test files$/, (done) ->
    done() # No op for readability


  @Given /^I have 1 (passing|failing) test$/, (status, done) ->
    outputTestFile path.join(@tmpDir, 'example_spec.coffee'), passing: status is 'passing', done


  @Given /^I have the file "([^"]*)" with 1 (passing|failing) test$/, (filePath, status, done) ->
    outputTestFile path.join(@tmpDir, filePath), passing: status is 'passing', done


  @Then /^I now have the file "([^"]*)" with the contents$/, (fileName, fileContent, done) ->
    expect(path.join @tmpDir, fileName).to.have.content fileContent
    done()
