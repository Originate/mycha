tmp = require 'tmp'


module.exports = ->

  @Before (done) ->
    tmp.dir unsafeCleanup: yes, (err, @tmpDir) => done err


  @After (done) ->
    if @error and not @expectedError
      console.log "#{@stdout}\n#{@stderr}"
      return done Error 'command failed unexpectedly'
    done()
