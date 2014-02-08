chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
child = require 'child_process'
path = require 'path'
expect = chai.expect


describe 'return code', ->

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


