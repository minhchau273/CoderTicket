@javascript
Feature: Book tickets
  I want to book tickets for upcoming events

  Background:
    Given There are 3 events
    And There is a registered user
    And I am at Home page

  Scenario: I havent't signed in yet and go to Booking page
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
