@javascript
Feature: Sign in
  I want to sign in

  Background:
    Given I am at Login page
    And There is a registered user

  Scenario: Return to Home page
    When I click "Back to Home page"
    Then I can see home page
    And I can see "Sign In"
    And I cannot see "Sign Out"

  Scenario: Input invalid email
    When I input invalid email to sign in
    And I input correct password to sign in
    When I click "Sign In"
    Then I can see email not found error message

  Scenario: Input valid email and incorrect password
    When I input valid email to sign in
    And I input incorrect password to sign in
    When I click "Sign In"
    Then I can see incorrect password error message

  Scenario: Input valid email and correct password
    When I input valid email to sign in
    And I input correct password to sign in
    When I click "Sign In"
    Then I can see my email
    And I can see "Sign Out"
    And I cannot see "Log In"
