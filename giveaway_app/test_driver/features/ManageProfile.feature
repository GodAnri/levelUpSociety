Feature: Manage User Profile
  Scenario: Attendees can access the Manage Profile page while searching for conferences
    Given I am at the 'home_page'
    When I tap the 'manage_profile_btn' button
    Then I will be redirected to the 'manage_profile_page'
    And I will be presented with the fields 'profile_district' and 'profile_interests'
    And I will be able to save my profile by clicking the 'save_profile_btn'