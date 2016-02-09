async = require 'async'
Mycha = require './mycha'
{createTest} = require '../spec/file_helpers'
path = require 'path'
tmp = require 'tmp'


config =
  mochaEnv: {}
  mochaOptions: {}
  testFilePattern: '**/*_spec.js'
  testHelpers: []


describe 'Mycha', ->

  describe 'run', ->
    beforeEach (done) ->
      tmp.dir unsafeCleanup: yes, (err, @tmpDir) => done err


    context 'without tests', ->
      beforeEach (done) ->
        Mycha.run {argv: [], config, cwd: @tmpDir, silent: yes}, (@err, @exitCode) => done()

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'returns exit code 0', ->
        expect(@exitCode).to.eql 0


    context 'with passing test', ->
      beforeEach (done) ->
        async.series [
          (next) =>
            createTest
              filePath: path.join(@tmpDir, 'one_spec.js')
              passing: yes
              next
          (next) =>
            Mycha.run {argv: [], config, cwd: @tmpDir, silent: yes}, (@err, @exitCode) => next()
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'returns exit code 0', ->
        expect(@exitCode).to.eql 0


    context 'with failing test', ->
      beforeEach (done) ->
        async.series [
          (next) =>
            createTest
              filePath: path.join(@tmpDir, 'one_spec.js'),
              passing: no,
              next
          (next) =>
            Mycha.run {argv: [], config, cwd: @tmpDir, silent: yes}, (@err, @exitCode) => next()
        ], done

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'returns exit code 1', ->
        expect(@exitCode).to.eql 1
