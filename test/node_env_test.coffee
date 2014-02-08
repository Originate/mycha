chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require './test_helper'


describe 'NODE_ENV', ->

  it 'runs the server in the TEST environment', (done) ->
    mycha_process = run_mycha test_dir: 'node_env_test', args: ['run']
    mycha_process.on 'close', (exit_code) ->
      expect(exit_code).to.equal 0
      done()
