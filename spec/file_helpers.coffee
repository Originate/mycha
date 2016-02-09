fsExtra = require 'fs-extra'


testContent = (passing) ->
  if passing
    '''
    it('passes', function() {});
    '''
  else
    '''
    it('fails', function() {
      throw new Error('fail');
    });
    '''


createTest = ({filePath, passing}, done) ->
  fsExtra.outputFile filePath, testContent(passing), done


module.exports = {createTest}
