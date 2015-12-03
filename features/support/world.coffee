path = require 'path'


class World

  mychaPath: path.join __dirname, '..', '..', 'bin', 'mycha'

# Cucumber expects a 'World' attribute on all testing objects
module.exports = ->
  @World = World
