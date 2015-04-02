MochaArgumentBuilder = require './mocha_argument_builder'
fsExtra = require 'fs-extra'
tmp = require 'tmp'
path = require 'path'
TestFinder = require './test_finder'


configContent = """
  module.exports =
    mochaOptions:
      booleanOpt: yes
      stringOpt: 'value'
    testFileRegex: /testRegex/
    testHelpers: ['path/to/test/helper']
  """


describe 'MochaArgumentBuilder', ->

  describe 'build', ->
    beforeEach (done) ->
      sinon.stub TestFinder::, 'find'
      tmp.dir unsafeCleanup: yes, (err, @tmpDir) => done err

    afterEach ->
      TestFinder::find.restore()


    context 'with folders/files in argv', ->
      beforeEach ->
        @argumentBuilder = new MochaArgumentBuilder
          argv: ['--opt=value', 'path/to/file']
          cwd: @tmpDir


      context 'with config file', ->
        beforeEach (done) ->
          fsExtra.outputFile path.join(@tmpDir, 'mycha.coffee'), configContent, (err) =>
            if err then return done err
            @argumentBuilder.build (@err, @args) => done()

        it 'does not return an error', ->
          expect(@err).to.not.exist

        it 'returns the mocha options, the test helper paths, and argv', ->
          expect(@args).to.eql [
            '--boolean-opt', '--string-opt=value',
            'path/to/test/helper',
            '--opt=value', 'path/to/file'
          ]


      context 'without config file', ->
        beforeEach (done) ->
          @argumentBuilder.build (@err, @args) => done()

        it 'does not return an error', ->
          expect(@err).to.not.exist

        it 'returns just the argv', ->
          expect(@args).to.eql ['--opt=value', 'path/to/file']


    context 'without folders/files in argv', ->
      beforeEach ->
        @argumentBuilder = new MochaArgumentBuilder
          argv: ['--opt=value']
          cwd: @tmpDir


      context 'test finder returns test files', ->
        beforeEach ->
          TestFinder::find.callsArgWith 0, null, ['path/to/test1', 'path/to/test2']

        context 'with config file', ->
          beforeEach (done) ->
            fsExtra.outputFile path.join(@tmpDir, 'mycha.coffee'), configContent, (err) =>
              if err then return done err
              @argumentBuilder.build (@err, @args) => done()

          it 'does not return an error', ->
            expect(@err).to.not.exist

          it 'returns the mocha options, the test helper paths, argv and the found tests', ->
            expect(@args).to.eql [
              '--boolean-opt', '--string-opt=value',
              'path/to/test/helper',
              '--opt=value',
              'path/to/test1', 'path/to/test2'
            ]


        context 'without config file', ->
          beforeEach (done) ->
            @argumentBuilder.build (@err, @args) => done()

          it 'does not return an error', ->
            expect(@err).to.not.exist

          it 'returns the argv and the found tests', ->
            expect(@args).to.eql ['--opt=value', 'path/to/test1', 'path/to/test2']


      context 'test finder returns no test files', ->
        beforeEach (done)->
          TestFinder::find.callsArgWith 0, null, []
          @argumentBuilder.build (@err, @args) => done()

        it 'does not return an error', ->
          expect(@err).to.not.exist

        # To avoid any chance that mocha errors if there is no ./test directory
        it 'returns the argv and the current directory', ->
          expect(@args).to.eql ['--opt=value', '.']


      context 'test finder errors', ->
        beforeEach (done) ->
          TestFinder::find.callsArgWith 0, 'some error'
          @argumentBuilder.build (@err, @args) => done()

        it 'errors', ->
          expect(@err).to.eql 'some error'

        it 'does not return args the argv and the found tests', ->
          expect(@args).to.not.exist
