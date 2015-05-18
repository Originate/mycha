Feature: Command-line exit status

  As an administrator setting up continuous integration
  I want Mycha to follow the CLI exit status standards
  So that my builds only pass when all my tests pass


  Background:
    Given I have Mycha installed


  Scenario: passing test suite
    Given my project has a passing test
    When I run "mycha"
    Then it finishes with status 0


  Scenario: failing test suite
    Given my project has a failing test
    When I run "mycha"
    Then it finishes with status 1
