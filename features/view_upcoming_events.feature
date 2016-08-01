@javascript
Feature: View upcoming events at Home page
  I want to view a list of upcoming events ordered by started time

  Background:
    Given There are some events
    And I am at Home page

  Scenario: View upcoming events
    Then I can see "Discover upcoming events"
    And I can see list of upcoming events ordered by started time

  Scenario: View event details
    When I click on an event
    Then I can see the event's name

  Scenario: Search events and get no results
    When I input a dummy keyword
    Then I press enter to search
    And I can see that keyword in the search box
    And I can see "No events found"

  Scenario: Search events and get results
    When I input a keyword
    Then I press enter to search
    And I can see that keyword in the search box
    And I can see the results
    And I cannot see the unexpected events
