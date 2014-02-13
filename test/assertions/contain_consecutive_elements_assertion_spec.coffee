chai = require 'chai'
path = require 'path'
chai = require 'chai'
expect = chai.expect


describe 'ContainConsecutiveElementsAssertion', ->

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


  context 'elements consecutivly in array', ->

    it 'passes', ->
      expect(@array).to.contain_consecutive_elements 'two', 'three', 'four'

    it 'fails if negated', ->
      expect ->
        expect(@array).to.not.contain_consecutive_elements 'two', 'three', 'four'
      .to.throw()

