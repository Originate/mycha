require('blanket')
  pattern: ['']
  loader: './node-loaders/coffee-script'
  'data-cover-never': ['features', 'lib', 'node_modules', 'spec']

chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

global.chai = chai
global.expect = chai.expect
global.sinon = sinon

process.env.NODE_ENV = 'test'
