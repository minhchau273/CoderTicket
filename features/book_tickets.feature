@javascript
Feature: Book tickets
  I want to book tickets for upcoming events

  Background:
    Given There is a registered user
    And There are some events
    And There is a sold out ticket type
    And I am at Home page

  Scenario: I go to an unavailable event's Booking page
    When I visit an unavailable event's booking page
    Then I should be at the Home page
    And I can see "This event is not available."

  Scenario: I haven't signed in yet and go to Booking page
    When I click on an event
    And I click Book Now button
    Then I should be redirected to the Sign in page
    And I can see "Please login first!"
    When I input valid email and password to sign in
    And I click "Sign In"
    Then I should be at the Booking page

  Scenario: I have already signed in and go to Booking page
    When I sign in
    And I click on an event
    And I click Book Now button
    Then I should be at the Booking page
    And I can see a list of ticket types in descending order of prices
    And I can see "Sold out"
    And I can see "0 VND"
    When I click "Buy"
    Then I can see "Please choose at least 1 ticket to continue!"
    When I select the quantity of tickets
    Then I can see the order's total
    When I click "Buy"
    Then I should be redirected to the order's details page
    And I can see "Order successfully!"
    And I can see the order's total

  Scenario: I cannot buy tickets to events that occur in the past
    When I visit an expired event page
    Then The Book Now button should be disabled
    When I visit an expired event's booking page
    Then I should be at the Home page
    And I can see "This event is no longer available."
