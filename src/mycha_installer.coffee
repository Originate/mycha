async = require 'async'
colors = require 'colors'
compilers = require './compilers'
fsExtra = require 'fs-extra'
path = require 'path'
spawn = require 'cross-spawn'


class MychaInstaller

  constructor: ({@cwd, @testHelperPath}) ->
    @extension = path.extname(@testHelperPath).slice 1
    @compiler = compilers[@extension]


  install: (done) ->
    async.series [
      @_installDependencies
      @_writeMychaConfig
      @_writeTestHelper
    ], done


  _getMychaConfigContent: ->
    '''
    # Environment variables to add to process.env when running mocha
    mochaEnv: {}

    # Default options to pass to mocha (can be overriden by command line options)
    mochaOptions:
      colors: true
    ''' + (if @compiler then "\n  compilers: #{@extension}:#{@compiler}\n" else '\n') +
    """
      reporter: dot

    # Path patten used for finding tests (see https://github.com/isaacs/minimatch)
    testFilePattern: '**/*{spec,test}.#{@extension}'

    # Files to include before all tests
    testHelpers:
      - #{@testHelperPath}
    """


  _installDependencies: (done) =>
    cmd = 'npm'
    args = ['install', '--save-dev', 'chai', 'sinon', 'sinon-chai']
    @_writeToStdout colors.bold([cmd, args...].join ' '), lineBefore: yes
    child = spawn cmd, args, {@cwd, stdio: 'inherit'}
    child.once 'error', done
    child.once 'close', done


  _writeMychaConfig: (done) =>
    fsExtra.outputFile(
      path.join(@cwd, 'mycha.yml')
      @_getMychaConfigContent()
      (err) =>
        if err then return done err
        @_writeToStdout "#{colors.green 'create'} mycha.yml", lineBefore: yes
        done())


  _writeTestHelper: (done) =>
    scaffoldExt = if @compiler then @extension else 'js'
    @scaffoldPath = path.join __dirname, '..', 'scaffold', "test_helper.#{scaffoldExt}"
    fsExtra.copy(
      @scaffoldPath
      path.join(@cwd, @testHelperPath)
      (err) =>
        if err then return done err
        @_writeToStdout "#{colors.green 'create'} #{@testHelperPath}", lineAfter: yes
        done())


  _writeToStdout: (message, {lineAfter, lineBefore}) ->
    str = ''
    str += '\n' if lineBefore
    str += "#{message}\n"
    str += '\n' if lineAfter
    process.stdout.write str, 'utf8'


module.exports = MychaInstaller
