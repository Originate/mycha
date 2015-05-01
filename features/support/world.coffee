path = require 'path'


class World

  mychaPath: path.join __dirname, '..', '..', 'bin', 'mycha'

  # Cucumber needs the World constructor to take a callback
  constructor: (done) -> done()

# Cucumber expects a 'World' attribute on all testing objects
module.exports = ->
  @World = World
