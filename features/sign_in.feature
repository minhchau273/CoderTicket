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

  Scenario Outline: Sign in failed
    When I input <email> to email field
    And I input <password> to password field
    When I click "Sign In"
    Then I can see <message>

    Examples:
    | email           | password | message                   |
    | cheetah.zxc.com | 123123   | "Email is not found"      |
    | cheetah@cs.com  | 123456   | "Password does not match" |

  Scenario: Sign in successfully
    When I input valid email and password to sign in
    And I click "Sign In"
    Then I can see my email
    And I can see "Sign Out"
    And I cannot see "Log In"
