# Adds contain_consecutive_elements assertion to chai
#
# Usage:
# chai.use ContainConsecutiveElementsAssertion
class ContainConsecutiveElementsAssertion

  constructor: ({ Assertion }) ->
    Assertion.addMethod 'contain_consecutive_elements',
                        ContainConsecutiveElementsAssertion.matcher


  # The new matcher method provided by this assertion.
  # This is the method that gets called in tests.
  @matcher: (consecutive_values...) ->
    array = @_obj
    @assert ContainConsecutiveElementsAssertion.has_consecutive_values(array,
                                                                       consecutive_values),
            "expected #{array.join ' '} to contain #{consecutive_values.join ' '} consecutively",
            "expected #{array.join ' '} to not contain #{consecutive_values.join ' '} consecutively"


  # Returns whether the given array contains the given values consecutively.
  @has_consecutive_values: (array, consecutive_values) ->
    first_index = array.indexOf consecutive_values[0]
    return no if first_index is -1

    for value, value_index in consecutive_values
      return no if array[first_index + value_index] isnt value

    return yes



module.exports = ContainConsecutiveElementsAssertion
