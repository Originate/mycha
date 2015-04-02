fsExtra = require 'fs-extra'
tmp = require 'tmp'
path = require 'path'
TestFinder = require './test_finder'


describe 'TestFinder', ->

  beforeEach (done) ->
    tmp.dir unsafeCleanup: yes, (err, @tmpDir) => done err


  describe 'find', ->
    beforeEach ->
      @testFinder = new TestFinder cwd: @tmpDir, testFileRegex: /_spec.coffee$/


    context 'with non-test file', ->
      beforeEach (done) ->
        fsExtra.outputFile path.join(@tmpDir, 'server.coffee'), '', (err) =>
          if err then return done err
          @testFinder.find (@err, @files) => done()

      it 'does not error', ->
        expect(@err).to.not.exist

      it 'returns the current directory', ->
        expect(@files).to.eql []


    context 'with test file', ->
      beforeEach (done) ->
        fsExtra.outputFile path.join(@tmpDir, 'server_spec.coffee'), '', (err) =>
          if err then return done err
          @testFinder.find (@err, @files) => done()

      it 'does not error', ->
        expect(@err).to.not.exist

      it 'returns the found test', ->
        expect(@files).to.eql [path.join(@tmpDir, 'server_spec.coffee')]


    context 'with test file in subdirectory', ->
      beforeEach (done) ->
        fsExtra.outputFile path.join(@tmpDir, 'lib', 'server_spec.coffee'), '', (err) =>
          if err then return done err
          @testFinder.find (@err, @files) => done()

      it 'does not error', ->
        expect(@err).to.not.exist

      it 'returns the found test', ->
        expect(@files).to.eql [path.join(@tmpDir, 'lib', 'server_spec.coffee')]


    context 'with test file in node_modules', ->
      beforeEach (done) ->
        fsExtra.outputFile path.join(@tmpDir, 'node_modules', 'server_spec.coffee'), '', (err) =>
          if err then return done err
          @testFinder.find (@err, @files) => done()

      it 'does not error', ->
        expect(@err).to.not.exist

      it 'returns an empty array', ->
        expect(@files).to.eql []
