@javascript
Feature: View my orders
  I want to view a list of my orders and order details

  Background:
    Given There are some events
    And There is a registered user
    And I am at Home page

  Scenario: I haven't signed in yet and go to order details
    When I visit an order details page
    Then I can see "Access denied!"
    And I wait for 5 seconds
    Then I should be at the Home page

  Scenario: I have already signed in and go to the other one's order details
    When I sign in
    And I visit an order details page
    Then I can see "Access denied!"
    And I wait for 5 seconds
    Then I should be at the Home page

  Scenario: I have already signed in and go to my order details
    When I sign in
    And I visit my order details page
    Then I can see "Total"
