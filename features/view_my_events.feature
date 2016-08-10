@javascript
Feature: View my created events
  I want to view a list of my created events

  Background:
    Given There is a registered user
    And I am at Home page

  Scenario: I haven't signed in yet and go to Event management page
    When I visit the Event management page
    Then I should be at the Home page
    And I can see "You are not authorized to access this page."

  Scenario: I have already signed in and go to the other one's Event management page
    When I sign in
    And I visit the the other one's Event management page
    Then I should be at the Home page
    And I can see "You are not authorized to access this page."

  Scenario: I have already signed in and go to Event management page but I haven't created any event yet
    When I sign in
    And I visit the Event management page
    Then I can see "Event Management"
    And I can see "You haven't created any event yet."

  Scenario: I have already signed in and go to Event management page
    When I have some events
    And I sign in
    And I visit the Event management page
    Then I can see "My Account"
    And I can see Event tab is highlighted
    And I can see the number of events
    And I can see a list of my events in descending event of created date
    And I can see the expired events are blurred

  Scenario: I have already signed in and go to Event management page from Home page
    When I sign in
    And I click my email at the top to view My account page
    Then I can see "My Account"
    And I can see Order tab is highlighted
    When I click "Event Management"
    Then I can see Event tab is highlighted
