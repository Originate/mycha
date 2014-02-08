chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require './test_helper'


describe 'NODE_ENV', ->

  it 'runs the test stack in the TEST development', (done) ->
    mycha_process = run_mycha test_dir: 'integration_tests/node_env_test', args: ['run']
    mycha_process.on 'close', (exit_code) ->
      expect(exit_code).to.equal 0
      done()


