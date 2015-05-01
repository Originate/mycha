fs = require 'fs'
path = require 'path'


load = (cwd, done) ->
  configPath = path.join cwd, 'mycha.coffee'
  fs.exists configPath, (exists) ->
    config = if exists then require configPath else {}
    done null, config


module.exports = {load}
