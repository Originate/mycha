chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require '../test_helper'


describe 'NODE_ENV', ->

  it 'runs the server in the TEST environment', (done) ->
    verify_success 'node_env_test', done
