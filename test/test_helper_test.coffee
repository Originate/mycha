chai = require 'chai'
path = require 'path'
child = require 'child_process'
_ = require 'underscore'
chai = require 'chai'
expect = chai.expect


describe 'create_argv', ->

  context 'no options given', ->

    beforeEach ->
      @result = create_argv()

    it 'provides the "run" command by default', ->
      expect(@result).to.eql
        _: ['run']
        '$0': 'node ./bin/mycha'


  context 'options given', ->

    beforeEach ->
      @result = create_argv options: { reporter: 'spec', timeout: 20 }

    it 'adds the given options to the result', ->
      expect(@result).to.eql
        reporter: 'spec'
        timeout: 20
        _: ['run']
        '$0': 'node ./bin/mycha'


  context 'commands given', ->

    beforeEach ->
      @result = create_argv commands: ['one', 'two', 'three']

    it 'uses the given commands directly', ->
      expect(@result).to.eql
        _: ['one', 'two', 'three']
        '$0': 'node ./bin/mycha'


  context 'all options given at the same time', ->

    beforeEach ->
      @result = create_argv options: { reporter: 'spec' }, commands: ['one', 'two', 'three']

    it 'uses all given options', ->
      expect(@result).to.eql
        reporter: 'spec'
        _: ['one', 'two', 'three']
        '$0': 'node ./bin/mycha'

