fs = require 'fs'
path = require 'path'
yaml = require 'js-yaml'


parseConfig = (contents, done) ->
  try
    config = yaml.safeLoad contents
  catch err
    return done err
  done null, config


load = (cwd, done) ->
  configPath = path.join cwd, 'mycha.yml'
  fs.exists configPath, (exists) ->
    unless exists then return done null, {}
    fs.readFile configPath, 'utf8', (err, contents) ->
      if err then return done err
      parseConfig contents, done


module.exports = {load}
