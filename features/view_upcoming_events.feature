@javascript
Feature: View upcoming events at Home page
  I want to view a list of upcoming events ordered by started time

  Background:
    Given There are 3 events
    And I am at Home page

  Scenario: View upcoming events
    Then I can see "Discover upcoming events"
    And I can see list of upcoming events ordered by started time

  Scenario: View event details
    When I click "Event 1"
    Then I can see "Event 1"
