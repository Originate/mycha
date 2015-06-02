_ = require 'lodash'
MochaArgumentBuilder = require './mocha_argument_builder'
MochaRunner = require './mocha_runner'


# argv - arguments to pass into mocha
# config - mycha config, if not present will load path.join(cwd, 'mycha.coffee')
# cwd - directory to look for mycha.coffee in
#       and to search for test files if none provided in argv
# silent - whether or not to silence the output
run = ({argv, config, cwd, silent}, done) ->
  env = _.assign {}, config.mochaEnv, process.env

  new MochaArgumentBuilder({argv, config, cwd}).build (err, args) ->
    if err then return done err
    new MochaRunner({args, env, silent}).run done


module.exports = {run}
