# Adds contain_consecutive_elements assertion to chai
#
# Usage:
# chai.use ContainConsecutiveElementsAssertion
class ContainConsecutiveElementsAssertion
  constructor: ({ Assertion }) ->
    Assertion.addMethod 'contain_consecutive_elements',
                        ContainConsecutiveElementsAssertion.define_assertion

  @define_assertion: (consecutive_values...) ->
    array = @_obj
    @assert ContainConsecutiveElementsAssertion.test_consecutive(array, consecutive_values),
            "expected #{array} to contain #{consecutive_values} consecutively",
            "expected #{array} to not contain #{consecutive_values} consecutively"

  @test_consecutive: (array, consecutive_values) ->
    first_index = array.indexOf consecutive_values[0]
    return no if first_index is -1

    for value, value_index in consecutive_values
      return no if array[first_index + value_index] isnt value

    return yes


module.exports = ContainConsecutiveElementsAssertion
