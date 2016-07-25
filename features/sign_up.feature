@javascript
Feature: Sign up
  I want to create account

  Background:
    Given I am at Register page
    And There is a registered user

  Scenario: Input invalid email
    When I input username
    And I input invalid email
    And I input password
    And I input correct password confirmation
    When I click "Create Account"
    Then I can see error message about invalid email

  Scenario: Input incorrect password confirmation
    When I input username
    And I input valid email
    And I input password
    And I input incorrect password confirmation
    When I click "Create Account"
    Then I can see error message about incorrect password confirmation

  Scenario: Input correct information
    When I input username
    And I input valid email
    And I input password
    And I input correct password confirmation
    When I click "Create Account"
    Then I can see home page
    And I can see "Sign Out"
