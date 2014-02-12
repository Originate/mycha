path = require 'path'
chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
Mycha = require '../lib/mycha'
require './test_helper'


describe 'Mycha', ->

  describe 'run', ->

    context 'without arguments', ->

      beforeEach (done) ->
        mycha = new Mycha 'test_data/two_tests'
        @mycha_call_stub = sinon.stub(mycha, 'call_mocha').yields(0)
        mycha.run {}, [], =>
          @mocha_argument = @mycha_call_stub.args[0][0]
          done()

      it 'calls mocha once', ->
        expect(@mycha_call_stub).to.have.been.calledOnce

      it 'enables the CoffeeScript compiler', ->
        expect(@mocha_argument[0]).to.equal '--compilers'
        expect(@mocha_argument[1]).to.equal 'coffee:coffee-script'

      it 'uses the dot reporter', ->
        expect(@mocha_argument[2]).to.equal '--reporter'
        expect(@mocha_argument[3]).to.equal 'dot'

      it 'activates colors', ->
        expect(@mocha_argument[4]).to.equal '--colors',

      it 'loads Mychas test helper before the test files', ->
        expect(@mocha_argument[5]).to.equal path.resolve 'lib/helper.coffee'

      it 'runs all the tests', ->
        expect(@mocha_argument[6]).to.equal path.resolve 'test_data/two_tests/test/one_test.coffee'
        expect(@mocha_argument[7]).to.equal path.resolve 'test_data/two_tests/test/two_test.coffee'

      it 'does not provide any other arguments than listed above plus the done callback', ->
        expect(@mocha_argument.length).to.equal 8


    context 'mycha run --reporter spec', ->

      beforeEach (done) ->
        mycha = new Mycha 'test_data/two_tests'
        @mycha_call_stub = sinon.stub(mycha, 'call_mocha').yields()
        mycha.run {reporter: 'spec'}, [], =>
          @mocha_argument = @mycha_call_stub.args[0][0]
          done()

      it 'calls mocha once', ->
        expect(@mycha_call_stub).to.have.been.calledOnce

      it 'uses the spec reporter', ->
        expect(@mocha_argument[0]).to.equal '--reporter'
        expect(@mocha_argument[1]).to.equal 'spec'

      it 'enables the CoffeeScript compiler', ->
        expect(@mocha_argument[2]).to.equal '--compilers'
        expect(@mocha_argument[3]).to.equal 'coffee:coffee-script'

      it 'activates colors', ->
        expect(@mocha_argument[4]).to.equal '--colors',

      it 'loads Mychas test helper before the test files', ->
        expect(@mocha_argument[5]).to.equal path.resolve 'lib/helper.coffee'

      it 'runs all the tests', ->
        expect(@mocha_argument[6]).to.equal path.resolve 'test_data/two_tests/test/one_test.coffee'
        expect(@mocha_argument[7]).to.equal path.resolve 'test_data/two_tests/test/two_test.coffee'

      it 'does not provide any other arguments than listed above plus the done callback', ->
        expect(@mocha_argument.length).to.equal 8


    context 'mycha run [filename]', ->

      beforeEach (done) ->
        mycha = new Mycha 'test_data/two_tests'
        @mycha_call_stub = sinon.stub(mycha, 'call_mocha').yields()
        mycha.run {}, ['test/test_two.coffee'], =>
          @mocha_argument = @mycha_call_stub.args[0][0]
          done()

      it 'calls mocha once', ->
        expect(@mycha_call_stub).to.have.been.calledOnce

      it 'enables the CoffeeScript compiler', ->
        expect(@mocha_argument[0]).to.equal '--compilers'
        expect(@mocha_argument[1]).to.equal 'coffee:coffee-script'

      it 'uses the dot reporter', ->
        expect(@mocha_argument[2]).to.equal '--reporter'
        expect(@mocha_argument[3]).to.equal 'dot'

      it 'activates colors', ->
        expect(@mocha_argument[4]).to.equal '--colors',

      it 'loads Mychas test helper before the test files', ->
        expect(@mocha_argument[5]).to.equal path.resolve 'lib/helper.coffee'

      it 'runs only the given test', ->
        expect(@mocha_argument[6]).to.equal path.resolve 'test_data/two_tests/test/one_test.coffee'

      it 'does not provide any other arguments than listed above plus the done callback', ->
        expect(@mocha_argument.length).to.equal 7

