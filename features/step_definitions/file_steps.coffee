{createTest} = require '../../spec/file_helpers'
fs = require 'fs'
path = require 'path'


isPassing = (status) -> status is 'passing'



module.exports = ->

  @Given /^my project has no test files$/, ->


  @Given /^my project has a (passing|failing) test$/, (status, done) ->
    createTest
      filePath: path.join(@tmpDir, 'example_spec.coffee')
      passing: isPassing(status)
      done


  @Given /^my project has a file "([^"]*)" containing a (passing|failing) test$/, (filePath, status, done) ->
    createTest
      filePath: path.join(@tmpDir, filePath)
      passing: isPassing(status)
      done


  @Then /^my project now has a file "([^"]*)" containing$/, (fileName, fileContent, done) ->
    fs.readFile path.join(@tmpDir, fileName), 'utf8', (err, content) ->
      if err then return done err
      expect(content).to.eql fileContent
      done()
