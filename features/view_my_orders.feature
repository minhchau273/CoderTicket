@javascript
Feature: View my orders
  I want to view a list of my orders

  Background:
    Given There is a registered user
    And I have some events
    And I am at Home page

  Scenario: I haven't signed in yet and go to Order management page
    When I visit the Order management page
    Then I should be redirected to the Sign in page
    And I can see "Please login first!"
    When I input valid email and password to sign in
    And I click "Sign In"
    Then I should be at the Order management page

  Scenario: I have already signed in and go to Order management page but I don't have any order
    When I sign in
    And I visit the Order management page
    Then I can see "Order Management"
    And I can see "You don't have any order."

  Scenario: I have already signed in and go to Order management page
    When I have some orders
    And I sign in
    And I visit the Order management page
    Then I can see "My Account"
    And I can see Order tab is highlighted
    And I can see the number of orders and the total amount of my orders
    And I can see a list of my orders in descending order of booking date
    When I click to an order
    Then I can see this order details

  Scenario: I have already signed in and go to Order management page from Home page
    When I sign in
    And I click my email at the top to view My account page
    Then I can see "My Account"
    And I can see Order tab is highlighted
