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

    it 'provides an empty argv structure', ->
      expect(@result).to.eql
        _: []
        '$0': 'node ./bin/mycha'


  context 'options given', ->

    beforeEach ->
      @result = create_argv options: { reporter: 'spec', timeout: 20 }

    it 'adds the given options to the result', ->
      expect(@result).to.eql
        reporter: 'spec'
        timeout: 20
        _: []
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



describe 'contain_consecutive_elements', ->
  beforeEach ->
    @array = ['one', 'two', 'three', 'four', 'five', 'six']

  context 'any elements not in array', ->
    it 'fails', ->
      expect ->
        expect(@array).to.contain_consecutive_elements 'two', 'three', 'nine'
      .to.throw()

    it 'passes if negated', ->
      expect(@array).to.not.contain_consecutive_elements 'two', 'three', 'nine'


  context 'elements in array but not concecutive', ->
    it 'fails', ->
      expect ->
        expect(@array).to.contain_consecutive_elements 'two', 'four', 'six'
      .to.throw()

    it 'passes if negated', ->
        expect(@array).to.not.contain_consecutive_elements 'two', 'four', 'six'


  context 'elements concecutivly in array', ->
    it 'passes', ->
      expect(@array).to.contain_consecutive_elements 'two', 'three', 'four'

    it 'fails if negated', ->
      expect ->
        expect(@array).to.not.contain_consecutive_elements 'two', 'three', 'four'
      .to.throw()
