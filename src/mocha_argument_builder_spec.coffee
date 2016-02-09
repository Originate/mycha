MochaArgumentBuilder = require './mocha_argument_builder'
TestFinder = require './test_finder'


config =
  mochaOptions:
    booleanOpt: yes
    stringOpt: 'value'
  testFilePattern: '**/*_spec.js'
  testHelpers: ['path/to/test/helper']


describe 'MochaArgumentBuilder', ->

  describe 'build', ->
    beforeEach ->
      sinon.stub TestFinder::, 'find'

    afterEach ->
      TestFinder::find.restore()


    context 'with folders/files in argv', ->
      beforeEach (done) ->
        @argumentBuilder = new MochaArgumentBuilder
          argv: ['--opt=value', 'path/to/file']
          config: config
          cwd: 'path/to/project'
        @argumentBuilder.build (@err, @args) => done()

      it 'does not return an error', ->
        expect(@err).to.not.exist

      it 'returns the mocha options, the test helper paths, and argv', ->
        expect(@args).to.eql [
          '--boolean-opt', '--string-opt=value',
          'path/to/test/helper',
          '--opt=value', 'path/to/file'
        ]


    context 'without folders/files in argv', ->
      beforeEach ->
        @argumentBuilder = new MochaArgumentBuilder
          argv: ['--opt=value']
          config: config
          cwd: 'path/to/project'


      context 'test finder returns some files', ->
        beforeEach (done) ->
          TestFinder::find.callsArgWith 0, null, ['path/to/test1', 'path/to/test2']
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


      context 'test finder returns no files', ->
        beforeEach (done) ->
          TestFinder::find.callsArgWith 0, null, []
          @argumentBuilder.build (@err, @args) => done()

        it 'does not return an error', ->
          expect(@err).to.not.exist

        it 'returns the argv and the current directory', ->
          expect(@args).to.eql [
            '--boolean-opt', '--string-opt=value',
            'path/to/test/helper',
            '--opt=value',
            '.' # To avoid any chance that mocha errors if there is no ./test directory
          ]


      context 'test finder errors', ->
        beforeEach (done) ->
          TestFinder::find.callsArgWith 0, 'some error'
          @argumentBuilder.build (@err, @args) => done()

        it 'errors', ->
          expect(@err).to.eql 'some error'

        it 'does not return args the argv and the found tests', ->
          expect(@args).to.not.exist
