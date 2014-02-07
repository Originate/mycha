chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
child = require 'child_process'
path = require 'path'
expect = chai.expect


run_mycha = ({ test_dir, args }) ->
  cwd = path.join __dirname, 'integration_tests', test_dir
  mycha_path = path.resolve __dirname, '../bin/mycha'
  child.spawn mycha_path, args, cwd: cwd



describe 'Integration tests', ->

  it 'sets NODE_ENV to test', (done) ->
    mycha_process = run_mycha test_dir: 'node_env_test', args: ['run']
    mycha_process.on 'close', (exit_code) ->
      expect(exit_code).to.equal 0
      done()

  context 'with failing tests', ->
    it 'returns status code 1', (done) ->
      mycha_process = run_mycha test_dir: 'failing_test', args: ['run']
      mycha_process.on 'close', (exit_code) ->
        expect(exit_code).to.equal 1
        done()

  context 'with passing tests', ->
    it 'returns status code 0', (done) ->
      mycha_process = run_mycha test_dir: 'passing_test', args: ['run']
      mycha_process.on 'close', (exit_code) ->
        expect(exit_code).to.equal 0
        done()
