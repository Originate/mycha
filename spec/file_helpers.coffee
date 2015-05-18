fsExtra = require 'fs-extra'


testContent = (passing) ->
  if passing
    '''
    it 'passes', ->
    '''
  else
    '''
    it 'fails', ->
      expect(false).to.be.true
    '''


createTest = ({filePath, passing}, done) ->
  fsExtra.outputFile filePath, testContent(passing), done


module.exports = {createTest}
