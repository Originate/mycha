process.env.NODE_ENV = 'test';

var chai = require('chai');
var sinon = require('sinon');
chai.use(require('sinon-chai'));

global.chai = chai;
global.expect = chai.expect;
global.sinon = sinon;
