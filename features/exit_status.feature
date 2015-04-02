Feature: running tests has the correct exit status

  Background:
    Given I have a installed mycha


  Scenario: passing test
    Given I have 1 passing test
    When I run "mycha"
    Then it has exit status 0


  Scenario: failing test
    Given I have 1 failing test
    When I run "mycha"
    Then it has exit status 1
