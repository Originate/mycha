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



context 'Mycha integration tests:', ->

  describe 'failing test', ->
    it 'returns status code 1', (done) ->
      mycha = run_mycha test_dir: 'failing_test', args: ['run']
      mycha.on 'close', (exit_code) ->
        expect(exit_code).to.equal 1
        done()

  describe 'passing test', ->
    it 'returns status code 0', (done) ->
      mycha = run_mycha test_dir: 'passing_test', args: ['run']
      mycha.on 'close', (exit_code) ->
        expect(exit_code).to.equal 0
        done()
