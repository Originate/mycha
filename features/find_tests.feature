Feature: running tests automatically find all test files

  Background:
    Given I have a installed mycha


  Scenario: no tests
    Given I have no test files
    When I run "mycha"
    Then I see "0 passing"


  Scenario: test in root directory
    Given I have the file "one_spec.coffee" with 1 passing test
    When I run "mycha"
    Then I see "1 passing"


  Scenario: test in subdirectory
    Given I have the file "dir/one_spec.coffee" with 1 passing test
    When I run "mycha"
    Then I see "1 passing"


  Scenario: multiple tests
    Given I have the file "one_spec.coffee" with 1 passing test
    And I have the file "dir/two_spec.coffee" with 1 passing test
    When I run "mycha"
    Then I see "2 passing"
