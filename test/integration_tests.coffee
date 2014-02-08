chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect


describe 'Integration tests', ->

  it 'sets NODE_ENV to test', (done) ->
    mycha_process = run_mycha test_dir: 'node_env_test', args: ['run']
    mycha_process.on 'close', (exit_code) ->
      expect(exit_code).to.equal 0
      done()

  context 'with failing tests', ->

    beforeEach (done) ->
      mycha_process = run_mycha test_dir: 'failing_test', args: ['run']
      mycha_process.on 'close', (@exit_code) =>
        done()

    it 'returns status code 1', ->
      expect(@exit_code).to.equal 1

  context 'with passing tests', ->

    beforeEach (done) ->
      mycha_process = run_mycha test_dir: 'passing_test', args: ['run']
      mycha_process.on 'close', (@exit_code) =>
        done()

    it 'returns status code 0', ->
      expect(@exit_code).to.equal 0

