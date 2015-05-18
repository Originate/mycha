fsExtra = require 'fs-extra'
tmp = require 'tmp'
path = require 'path'
TestFinder = require './test_finder'


describe 'TestFinder', ->

  beforeEach (done) ->
    tmp.dir unsafeCleanup: yes, (err, @tmpDir) => done err


  describe 'find', ->
    beforeEach ->
      @testFinder = new TestFinder cwd: @tmpDir, testFilePattern: "**/*_spec.coffee"


    context 'with non-test file', ->
      beforeEach (done) ->
        filePath = path.join @tmpDir, 'server.coffee'
        fsExtra.outputFile filePath, '', (err) =>
          if err then return done err
          @testFinder.find (@err, @files) => done()

      it 'does not error', ->
        expect(@err).to.not.exist

      it 'returns the current directory', ->
        expect(@files).to.eql []


    context 'with test file', ->
      beforeEach (done) ->
        @filePath = path.join @tmpDir, 'server_spec.coffee'
        fsExtra.outputFile @filePath, '', (err) =>
          if err then return done err
          @testFinder.find (@err, @files) => done()

      it 'does not error', ->
        expect(@err).to.not.exist

      it 'returns the found test', ->
        expect(@files).to.eql [@filePath]


    context 'with test file in subdirectory', ->
      beforeEach (done) ->
        @filePath = path.join @tmpDir, 'lib', 'server_spec.coffee'
        fsExtra.outputFile @filePath, '', (err) =>
          if err then return done err
          @testFinder.find (@err, @files) => done()

      it 'does not error', ->
        expect(@err).to.not.exist

      it 'returns the found test', ->
        expect(@files).to.eql [@filePath]


    context 'with test file in node_modules', ->
      beforeEach (done) ->
        filePath = path.join @tmpDir, 'node_modules', 'server_spec.coffee'
        fsExtra.outputFile filePath, '', (err) =>
          if err then return done err
          @testFinder.find (@err, @files) => done()

      it 'does not error', ->
        expect(@err).to.not.exist

      it 'returns an empty array', ->
        expect(@files).to.eql []
