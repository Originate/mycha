module.exports =

  # Environment variables to add to process.env when running mocha
  mochaEnv:
    multi: 'dot=- html-cov=coverage.html'

  # Default options to pass to mocha (can be overriden by command line options)
  mochaOptions:
    colors: yes
    compilers: 'coffee:coffee-script/register'
    reporter: 'mocha-multi'

  # Path patten used for finding tests (see https://github.com/isaacs/minimatch)
  testFilePattern: '**/*_{spec,test}.{coffee,js}'

  # Files to include before all tests
  testHelpers: [
    'spec/spec_helper.coffee'
  ]
