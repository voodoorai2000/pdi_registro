Feature: Authentication
  As a confirmed user
  I want to login to the application
  So that I can be productive

  # TODO: set a background task which sets registration settings to open

  Scenario: Display login form to anonymous users
    Given I am an anonymous user
    When I go to the login page
    Then I should see a login form

  Scenario: Allow login of a user with valid credentials
    Given I am a confirmed user "bob" with password "secret"
    When I go to the login page
    And I fill in "login" with "bob"
    And I fill in "password" with "secret"
    And I press "Login"
    Then I should be logged in
    When I follow "Logout"
    Then I should be logged out

  Scenario: Show account page when logged-in user tries to login
    Given I am a confirmed user "bob" with password "secret"
      And I am logged in as "bob" with password "secret"
    When I go to the login page
    Then I should be logged in

  Scenario: Allow a confirmed user to login and be remembered
    Given I am a confirmed user "bob" with password "secret"
    When I go to the login page
    And I fill in "login" with "bob"
    And I fill in "password" with "secret"
    And I check "Remember me"
    And I press "Login"
    Then I should be logged in
    When I open the homepage in a new window with cookies
    Then I should be logged in
    When I follow "Logout"
    Then I should be logged out
  

  Scenario Outline: Reject login of a user with bad credentials
    Given the following user records
      | login | password |
      | bob   | secret   |
    When I go to the login page
    And I fill in "login" with "<login>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should not be logged in
    And I should have <count> errors
    And I should see "<error_message>"
  
    Examples:
      | login   | password   | count | error_message                                      |
      |         |            | 1     | You did not provide any details for authentication |
      |         | secret     | 1     | Login can not be blank                             |
      |         | bad secret | 1     | Login can not be blank                             |
      | unknown |            | 1     | Password can not be blank                          |
      | unknown | secret     | 1     | Login is not valid                                 |
      | unknown | bad secret | 1     | Login is not valid                                 |
      | bob     |            | 1     | Password can not be blank                          |
      | bob     | bad secret | 1     | Password is not valid                              |

  # TODO: move to state based confirmation managegment and test that
  # Scenario: Not allow login of an unconfirmed user
  #   Given "sharon" a notified but unconfirmed user
  #   When I go to the login page
  #   And I fill in "login" with "sharon"
  #   And I fill in "password" with "secret"
  #   And I press "Login"
  #   Then I should not be logged in
  #   And I should see "Login does not exist"

