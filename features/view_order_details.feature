@javascript
Feature: View my orders
  I want to view order details

  Background:
    Given There are some events
    And There is a registered user
    And I have some orders
    And I am at Home page

  Scenario: I go to an unavailable order details
    When I visit an unavailable order details page
    Then I should be at the Home page
    And I can see "This order is not available."

  Scenario: I haven't signed in yet and go to order details
    When I visit an order details page
    Then I should be at the Home page
    And I can see "You are not authorized to access this page."

  Scenario: I have already signed in and go to the other one's order details
    When I sign in
    And I visit an order details page
    Then I should be at the Home page
    And I can see "You are not authorized to access this page."

  Scenario: I have already signed in and go to my order details
    When I sign in
    And I visit my order details page
    Then I can see event's information
    And I can see a list of ticket types in my order
