chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require '../test_helper'



describe 'return code', ->

  context 'with failing tests', ->

    it 'returns status code 1', (done) ->
      verify_failure 'return_code_tests/failing_test', done


  context 'with passing tests', ->

    it 'returns status code 0', (done) ->
      verify_success 'return_code_tests/passing_test', done
