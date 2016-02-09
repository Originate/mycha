Feature: Automatic test file discovery

  As a developer running tests
  I want Mycha to find all existing test files for me
  So that I don't have to manually provide them through complicated command-line arguments.


  Background:
    Given I have Mycha installed


  Scenario: without test files
    Given my project has no test files
    When I run "mycha"
    Then I see "0 passing"


  Scenario: tests in multiple locations
    Given my project has a file "foo_spec.js" containing a passing test
    And my project has a file "dir/bar_spec.js" containing a passing test
    When I run "mycha"
    Then I see "2 passing"
