_ = require 'underscore'
path = require 'path'


# Domain-specifc matcher for checking if the result list
# has the entries with the given id marked as clicked.
class IncludeTestFileAssertion

  constructor: ({ Assertion }) ->
    Assertion.addMethod 'include_test_file',
                        IncludeTestFileAssertion.matcher


  # The new matcher method provided by this assertion.
  # This is the method that gets included in tests.
  @matcher: (pathParts...) ->
    array = @_obj
    expectedFilePath = path.resolve 'test_data', pathParts...
    @assert _.any(array, (filePath) -> filePath is expectedFilePath),
            "expected #{array} to contain #{expectedFilePath}",
            "expected #{array} to not contain #{expectedFilePath}"


module.exports = IncludeTestFileAssertion
