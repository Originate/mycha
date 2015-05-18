fsExtra = require 'fs-extra'
path = require 'path'


module.exports = ->

  @Given /^I am working on a Node.js project$/, (done) ->
    fsExtra.outputJson path.join(@tmpDir, 'package.json'),
                       name: 'foo',
                       done


  @Then /^my "package.json" now lists the devDependencies$/, (table, done) ->
    modules = (row[0] for row in table.rows())
    fsExtra.readJson path.join(@tmpDir, 'package.json'), (err, packageJson) ->
      if err then return done err
      expect(packageJson.devDependencies).to.have.keys modules
      done()
