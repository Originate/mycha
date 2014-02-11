TestsFinder = require './tests_finder'


# Knows which test files Mycha should provide to Mocha.
class FileConfiguration

  constructor: ({test_dir, default_files, argv}) ->

    # The files that Mycha should provide to Mocha.
    @files = []
    @files = @files.concat default_files
    user_files = argv._[1..]
    if user_files.length > 0
      @files = @files.concat user_files
    else
      @files = @files.concat new TestsFinder(test_dir).files()



module.exports = FileConfiguration
