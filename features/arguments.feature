Feature: running tests with arguments

  Background:
    Given I have a installed mycha


  Scenario: file provided as argument
    Given I have the file "one_spec.coffee" with 1 passing test
    And I have the file "dir/two_spec.coffee" with 1 passing test
    When I run "mycha one_spec.coffee"
    Then I see "1 passing"


  Scenario: folder provided as argument
    Given I have the file "one_spec.coffee" with 1 passing test
    And I have the file "dir/two_spec.coffee" with 1 passing test
    When I run "mycha dir/"
    Then I see "1 passing"
