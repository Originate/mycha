chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require '../test_helper'
Mycha = require '../../lib/mycha'


describe 'Integration: "mycha run"', ->

  context 'mycha run', ->

    it 'runs all the tests with the dot reporter', ->
      # mycha = new Mycha create_argv commands: ['run', 'foo']
      # sinon.stub mycha, 'call_mocha'
      # mycha.run()
      # expect(child_process.spawn).to.have.been.calledOnce


  context 'mycha run --reporter spec', ->

    it 'runs all the tests with the spec reporter'


  context 'mycha run [filename]', ->

    it 'runs only the given test with the spec reporter'
