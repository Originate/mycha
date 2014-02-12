chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
require '../test_helper'
OptimistParser = require '../../lib/helpers/optimist_parser'


describe 'OptimistParser', ->

  describe 'find_command', ->

    context 'command given', ->

      beforeEach ->
        @result = new OptimistParser(create_argv(commands: ['watch', 'two'])).command()

      it 'returns the given command', ->
        expect(@result).to.equal 'watch'


    context 'no command given', ->

      beforeEach ->
        @result = new OptimistParser(create_argv()).command()

      it 'returns "run" as the default value', ->
        expect(@result).to.equal 'run'


  describe 'find_files', ->

    context 'no command-line arguments given', ->

      beforeEach ->
        @result = new OptimistParser(create_argv()).files()

      it 'returns an empty array', ->
        expect(@result).to.be.empty


    context 'command given, but no files given', ->

      beforeEach ->
        @result = new OptimistParser(create_argv(commands: ['run'])).files()

      it 'returns an empty array', ->
        expect(@result).to.be.empty


    context 'command and files given', ->

      beforeEach ->
        @result = new OptimistParser(create_argv(commands: ['run', 'file 1', 'file 2'])).files()

      it 'returns the given files', ->
        expect(@result).to.eql ['file 1', 'file 2']


  describe 'find_options', ->

    context 'no options given', ->

      beforeEach ->
        @result = new OptimistParser(create_argv()).options()

      it 'returns an empty hash', ->
        expect(@result).to.eql {}


    context 'options given', ->

      beforeEach ->
        @result = new OptimistParser(create_argv(options: {reporter: 'spec', timeout: 20})).options()

      it 'returns the given options', ->
        expect(@result).to.have.property 'reporter', 'spec'
        expect(@result).to.have.property 'timeout', 20


      it 'does not contain the Optimist-specific elements', ->
        expect(@result).to.not.have.property '_'
        expect(@result).to.not.have.property '$0'
