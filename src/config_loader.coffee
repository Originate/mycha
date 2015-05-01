fs = require 'fs'
path = require 'path'


load = (cwd, done) ->
  configPath = path.join cwd, 'mycha.coffee'
  fs.exists configPath, (exists) ->
    config = {}
    if exists
      require 'coffee-script/register'
      config = require configPath
    done null, config


module.exports = {load}
