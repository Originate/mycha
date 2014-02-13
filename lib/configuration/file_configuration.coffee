path = require 'path'
TestsFinder = require '../helpers/tests_finder'


# Parses the file-related options out of the given argv,
# augments them with default values,
# represents them in a user-friendly way,
# and provides all the resulting test files to Mycha.
class FileConfiguration

  # Params:
  # - root_dir: the root directory of the code base
  # - test_dir_name: the name of the test directory
  # - default_files: any files that should always be loaded (i.e. mycha test_helper)
  # - files: any files provided on the command line
  constructor: ({@root_dir, @test_dir_name, @default_files, @run_files}) ->


  files: ->
    # The files that Mycha should provide to Mocha.
    result = []
    result = result.concat @default_files
    if @run_files.length > 0
      result.push path.resolve(@root_dir, run_file) for run_file in @run_files
    else
      result = result.concat new TestsFinder(path.resolve(@root_dir, @test_dir_name)).files()
    result


  # Serializes this data into a format so that it can be given to
  # childProcess.spawn.
  to_args: ->
    @files()



module.exports = FileConfiguration
