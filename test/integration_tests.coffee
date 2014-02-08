chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect


describe 'Integration tests', ->

  it 'sets NODE_ENV to test', (done) ->
    mycha_process = run_mycha test_dir: 'integration_tests/node_env_test', args: ['run']
    mycha_process.on 'close', (exit_code) ->
      expect(exit_code).to.equal 0
      done()

