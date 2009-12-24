Feature: Requested Invitation
  As a anonymous user
  I want to invite my friends to join this site
  So that we can have the same experience

  Background:
    Given "sharon" an admin user

  Scenario: Display invitation form to anonymous user
    Given "joanne" is an anonymous user
    When I go to the homepage
    Then I should see "Request Invitation"
    When I follow "Request Invitation"
    Then I should see the invitation request form
  
  Scenario: Allow an anonymous user to be invited
    Given "joanne" is an anonymous user
    When I go to the invitation request form
    And I fill in "Applicant's full name" with "joanne"
    And I fill in "Applicant's email address" with "joanne@example.com"
    And I press "Request"
    Then I should have a successful invitation
  
  Scenario Outline: Not allow an anonymous user to be invited with incomplete input
    Given "joanne" is an anonymous user
    When I go to the invitation request form
    And I fill in "Applicant's full name" with "<name>"
    And I fill in "Applicant's email address" with "<email>"
    And I press "Request"
    Then I should have an unsuccessful invitation
    And I should have <count> errors
    And I should see "<error_message>"

    Examples: incomplete invitation inputs
      | name   | email              | count | error_message                                                    |
      |        |                    |  4    | Applicant's email address can't be blank                         |
      | joanne |                    |  3    | Applicant's email address is too short (minimum is 6 characters) |
      |        | joanne@example.com |  1    | Applicant's full name can't be blank                             |
  
  Scenario: Send an invitation request mail at a successful account creation
    Given "joanne" an invitation requested user
    And admin should receive an email
    When admin open the email
    Then admin should see "joanne requests to be an invitee" in the email
  
  Scenario: Allow administrator to confirm the requested invitation
    Given "joanne" an invitation requested user
    And I logged in as an administrator
    When I go to the invitations list page
    Then I should see "joanne@example.com" can be invited
    When I invite "joanne@example.com"
    Then I should see "User invitation delivered"
    And "joanne@example.com" should receive 1 email
  
  Scenario: Want to confirm account using mail invitation token
    Given "joanne" an invitation notified but unconfirmed user
    And I follow "sign up by invitation" in the email
    Then I should see the invitation signup form
    And the "Name" field should contain "joanne"
    And the "Email" field should contain "joanne@example.com"
  
  Scenario: Do not confirm an account with invalid mail invitation token
    Given "joanne" an invitation notified but unconfirmed user
    When I go to the invitation accept form with bad token
    Then I should see the home page
  
  Scenario: Activate account using mail invitation token with password
    Given "joanne" an invitation notified but unconfirmed user
    When I follow "sign up by invitation" in the email
    And I should see the activation form
    When I fill in "Name" with "joanne"
    And I fill in "Email" with "joanne@example.com"
    And I fill in "Login" with "joanne"
    And I fill in "Set your password" with "secret"
    And I fill in "Password confirmation" with "secret"
    And I press "Activate"
    Then I should have a successful activation
    And I should be logged in
    When I follow "Logout"
    Then I should be logged out
  
  Scenario Outline: Activate account using mail activation token with bad inputs
    Given "joanne" an invitation notified but unconfirmed user
    When I follow "sign up by invitation" in the email
    And I should see the activation form
    When I fill in "Name" with "<name>"
    And I fill in "Email" with "<email>"
    And I fill in "Login" with "<login>"
    And I fill in "Set your password" with "<password>"
    And I fill in "Password confirmation" with "<confirmation>"
    And I press "Activate"
    Then I should have an unsuccessful activation
    And I should have <count> errors
    And I should see "<error_message>"

    Examples: Bad inputs
      | name   | email              | login  | password | confirmation | count | error_message                                                   |
      |        |                    |        |          | x            | 8     | Name can't be blank                                             |
      |        |                    |        |          | x            | 8     | Email is too short (minimum is 6 characters)                    |
      |        | oops               |        |          | x            | 8     | Email should look like an email address                         |
      | joanne | joanne@example.com |        |          | x            | 5     | Login is too short (minimum is 3 characters)                    |
      | joanne | joanne@example.com | joanne |          | x            | 3     | Password is too short (minimum is 4 characters)                 |
      | joanne | joanne@example.com |        | secret   |              | 4     | Password confirmation is too short (minimum is 4 characters)    |
      | joanne | joanne@example.com |        |          | secret       | 4     | Login should use only letters, numbers, spaces, and .-_@ please |
      | joanne | joanne@example.com | joanne | secret   |              | 2     | Password confirmation is too short (minimum is 4 characters)    |
      | joanne | joanne@example.com | joanne |          | secret       | 2     | Password is too short (minimum is 4 characters)                 |
      | joanne | joanne@example.com |        | secret   | secret       | 2     | Login is too short (minimum is 3 characters)                    |
      | joanne | joanne@example.com | joanne |          | not a secret | 2     | Password is too short (minimum is 4 characters)                 |
      | joanne | joanne@example.com | joanne | secret   | not a secret | 1     | Password doesn't match confirmation                             |
      | joanne | joanne@example.com |        | secret   | not a secret | 3     | Password doesn't match confirmation                             |
      | joanne | joanne@example.com | joanne | secret   | not a secret | 1     | Password doesn't match confirmation                             |
  
  Scenario: Send an activation confirmation mail when user confirms account
    Given "joanne" an invitation notified but unconfirmed user
    When I follow "sign up by invitation" in the email
    And I fill in "Login" with "joanne"
    And I fill in "Set your password" with "secret"
    And I fill in "Password confirmation" with "secret"
    And I press "Activate"
    Then I should be logged in
    And I should have 2 emails at all
    When I open the most recent email
    Then I should see "Activation Complete" in the email subject
    When I follow "Logout"
    Then I should be logged out
  
