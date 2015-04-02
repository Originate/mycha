path = require 'path'


class World

  mychaPath: path.join __dirname, '..', '..', 'bin', 'mycha'

  # Cucumber needs the World constructor to take a callback
  constructor: (done) -> done()


  testContent: (status)  ->
    if status is 'passing'
      '''
      it 'passes', ->
      '''
    else
      '''
      it 'fails', ->
        expect(false).to.be.true
      '''

# Cucumber expects a 'World' attribute on all testing objects
module.exports = ->
  @World = World
