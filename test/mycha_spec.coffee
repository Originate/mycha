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
        mycha.run
          run_options: {}
          run_files: []
          done: =>
            @mocha_argument = @mycha_call_stub.args[0][0]
            done()

      it 'calls mocha once', ->
        expect(@mycha_call_stub).to.have.been.calledOnce

      it 'enables the CoffeeScript compiler', ->
        expect(@mocha_argument).to.contain_consecutive_elements '--compilers', 'coffee:coffee-script'

      it 'uses the dot reporter', ->
        expect(@mocha_argument).to.contain_consecutive_elements '--reporter', 'dot'

      it 'activates colors', ->
        expect(@mocha_argument).to.contain '--colors',

      it 'loads Mychas test helper', ->
        expect(@mocha_argument).to.contain path.resolve 'lib/test_helper.coffee'

      it 'loads Mychas test helper before the test files', ->
        helper_index = @mocha_argument.indexOf path.resolve 'lib/test_helper.coffee'
        first_test_index = @mocha_argument.indexOf path.resolve 'test_data/two_tests/test/one_test.coffee'
        second_test_index = @mocha_argument.indexOf path.resolve 'test_data/two_tests/test/two_test.coffee'
        expect(helper_index).to.be.lessThan first_test_index
        expect(helper_index).to.be.lessThan second_test_index

      it 'runs all the tests', ->
        expect(@mocha_argument).to.include_test_file 'two_tests', 'one_test.coffee'
        expect(@mocha_argument).to.include_test_file 'two_tests', 'two_test.coffee'

      it 'does not provide any other arguments than listed above plus the done callback', ->
        expect(@mocha_argument.length).to.equal 8


    context 'mycha run --reporter spec', ->

      beforeEach (done) ->
        mycha = new Mycha 'test_data/two_tests'
        @mycha_call_stub = sinon.stub(mycha, 'call_mocha').yields()
        mycha.run
          run_options: {reporter: 'spec'},
          run_files: [],
          done: =>
            @mocha_argument = @mycha_call_stub.args[0][0]
            done()

      it 'calls mocha once', ->
        expect(@mycha_call_stub).to.have.been.calledOnce

      it 'uses the spec reporter', ->
        expect(@mocha_argument).to.contain_consecutive_elements '--reporter', 'spec'

      it 'enables the CoffeeScript compiler', ->
        expect(@mocha_argument).to.contain_consecutive_elements '--compilers', 'coffee:coffee-script'

      it 'activates colors', ->
        expect(@mocha_argument).to.contain '--colors',

      it 'loads Mychas test helper before the test files', ->
        helper_index = @mocha_argument.indexOf path.resolve 'lib/test_helper.coffee'
        first_test_index = @mocha_argument.indexOf path.resolve 'test_data/two_tests/test/one_test.coffee'
        second_test_index = @mocha_argument.indexOf path.resolve 'test_data/two_tests/test/two_test.coffee'
        expect(helper_index).to.be.lessThan first_test_index
        expect(helper_index).to.be.lessThan second_test_index

      it 'runs all the tests', ->
        expect(@mocha_argument).to.include_test_file 'two_tests', 'one_test.coffee'
        expect(@mocha_argument).to.include_test_file 'two_tests', 'two_test.coffee'

      it 'does not provide any other arguments than listed above plus the done callback', ->
        expect(@mocha_argument.length).to.equal 8


    context 'mycha run [filename]', ->

      beforeEach (done) ->
        mycha = new Mycha 'test_data/two_tests'
        @mocha_call_stub = sinon.stub(mycha, 'call_mocha').yields()
        mycha.run
          run_options: {},
          run_files: ['test/two_test.coffee'],
          done: =>
            @mocha_argument = @mocha_call_stub.args[0][0]
            done()

      it 'calls mocha once', ->
        expect(@mycha_call_stub).to.have.been.calledOnce

      it 'uses the spec reporter', ->
        expect(@mocha_argument).to.contain_consecutive_elements '--reporter', 'spec'

      it 'enables the CoffeeScript compiler', ->
        expect(@mocha_argument).to.contain_consecutive_elements '--compilers', 'coffee:coffee-script'

      it 'activates colors', ->
        expect(@mocha_argument).to.contain '--colors',

      it 'loads Mychas test helper before the test files', ->
        helper_index = @mocha_argument.indexOf path.resolve 'lib/test_helper.coffee'
        second_test_index = @mocha_argument.indexOf path.resolve 'test_data/two_tests/test/two_test.coffee'
        expect(helper_index).to.be.lessThan second_test_index

      it 'runs only the given test', ->
        expect(@mocha_argument).to.include_test_file 'two_tests', 'two_test.coffee'

      it 'does not provide any other arguments than listed above plus the done callback', ->
        expect(@mocha_argument.length).to.equal 7

