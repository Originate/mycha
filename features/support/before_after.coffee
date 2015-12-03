tmp = require 'tmp'


module.exports = ->

  @Before (scenario, done) ->
    tmp.dir unsafeCleanup: yes, (err, @tmpDir) => done err


  @After ->
    if @error and not @expectedError
      console.log "#{@stdout}\n#{@stderr}"
      throw Error 'command failed unexpectedly'
