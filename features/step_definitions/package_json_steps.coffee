fsExtra = require 'fs-extra'
path = require 'path'


module.exports = ->

  @Given /^I am in a node project$/, (done) ->
    fsExtra.outputJson path.join(@tmpDir, 'package.json'), name: '123', done


  @Then /^I now have the following devDependencies in my "package.json"$/, (table, done) ->
    modules = (row[0] for row in table.rows())
    fsExtra.readJson path.join(@tmpDir, 'package.json'), (err, packageJson) ->
      if err then return done err
      expect(packageJson.devDependencies).to.have.keys modules
      done()
