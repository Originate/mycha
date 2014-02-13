_ = require 'underscore'


# Domain-specifc matcher for checking if the result list
# has the entries with the given id marked as clicked.
class IncludeTestFileAssertion

  constructor: ({ Assertion }) ->
    Assertion.addMethod 'include_test_file',
                        IncludeTestFileAssertion.matcher


  # The new matcher method provided by this assertion.
  # This is the method that gets included in tests.
  @matcher: (test_dir, filename) ->
    array = @_obj
    @assert IncludeTestFileAssertion.contains_test_file(array,
                                                        test_dir,
                                                        filename),
            "expected #{array} to contain test file #{test_dir}/test/#{filename}",
            "expected #{array} to not contain test file #{test_dir}/test/#{filename}"


  # Returns whether the given array of filenames contains the given file
  # in the given directory.
  @contains_test_file: (array, test_dir, filename) ->

    # Convert the absolute paths in the result to relative paths,
    # to make them easier to compare.
    test_directory_path = "#{process.cwd()}/test_data/#{test_dir}/test/"
    shortened_actual_data = _(array).map( (path) -> path.substr test_directory_path.length)
    shortened_actual_data.indexOf(filename) > -1



module.exports = IncludeTestFileAssertion
