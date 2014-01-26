fs = require 'fs'
path = require 'path'


# Finds all test files in the given directory.
class TestsFinder

  constructor: (@directory) ->


  # Returns the name of all files within the given directory that contain tests.
  files: ->
    files = []
    @_search_directory @directory, files
    files


  _search_directory: (dir, files) ->
    # TODO: make this return files, instead of using a param for that.
    for file in fs.readdirSync(dir)

      # Ignore hidden stuff.
      continue if file[0] == '.'

      filePath = path.resolve "#{dir}/#{file}"
      stat = fs.statSync filePath
      if stat.isFile()

        # Ignore non-test code files.
        continue unless file.match /^.*_test\.[^\.]+$/

        # Ignore non-code files.
        continue unless file.match /(js|coffee)$/

        files.push filePath
      else if stat.isDirectory()
        @_search_directory filePath, files



module.exports = TestsFinder
