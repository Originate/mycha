fs = require 'fs'
path = require 'path'


# Finds all test files in the given directory.
class TestsFinder

  constructor: (@directory) ->


  # Returns the name of all files within the given directory that contain tests.
  files: ->
    @_search_directory @directory, []


  # Adds all test files in the current directory and its subdirectories
  # to the given files array.
  _search_directory: (dir, files) ->
    for file in fs.readdirSync(dir)
      continue if @_is_hidden file
      filePath = path.resolve "#{dir}/#{file}"
      stat = fs.statSync filePath
      if stat.isFile()
        continue unless @_is_test_file file
        files.push filePath
      else if stat.isDirectory()
        @_search_directory filePath, files
    files.sort()


  # Returns whether the given filesystem object is hidden.
  _is_hidden: (file) ->
    file[0] == '.'


  # Returns whether the file with the given filename contains unit tests.
  _is_test_file: (file) ->

    # Ignore non-test code files.
    return false unless file.match /_(?:test|spec)\.[^.]+$/

    # Ignore non-code files.
    return false unless file.match /(js|coffee)$/

    true



module.exports = TestsFinder
