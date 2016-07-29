@javascript
Feature: Sign up
  I want to create account

  Background:
    Given I am at Register page
    And There is a registered user

  Scenario Outline: Sign up failed
    When I input <username> to username field to register
    And I input <email> to email field to register
    And I input <password> to password field to register
    And I input <confirmed_password> to confirmed_password field to register
    When I click "Create Account"
    Then I can see <message>

    Examples:
    | username | email           | password | confirmed_password | message                                        |
    | cheetah  | cheetah.zxc.com | 123123   | 123123             | "Email is invalid"                             |
    | cheetah  | cheetah@cs.com  | 123123   | 123456             | "Password confirmation doesn't match Password" |

  Scenario: Sign up successfully
    When I input username
    And I input valid email
    And I input password
    And I input correct password confirmation
    When I click "Create Account"
    Then I can see home page
    And I can see "Sign Out"
