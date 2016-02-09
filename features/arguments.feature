Feature: Command-line arguments


  Background:
    Given I have Mycha installed
    And my project has a file "foo_spec.js" containing a passing test
    And my project has a file "dir/bar_spec.js" containing a passing test
    And my project has a file "dir/baz_spec.js" containing a passing test


  Scenario: running the specified test file
    When I run "mycha foo_spec.js"
    Then I see "1 passing"


  Scenario: running all tests in the specified folder
    When I run "mycha dir/"
    Then I see "2 passing"
