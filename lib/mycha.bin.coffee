Mycha = require __dirname + '/mycha'
options = mochaArgs: process.argv.slice 3
mycha = new Mycha options
mycha.run()
