Feature: Authentication
  As a confirmed user
  I want to login to the application
  So that I can be productive

  # TODO: set a background task which sets registration settings to open

  Scenario: Display login form to anonymous users
    Given I am an anonymous user
     When I go to the homepage
     Then I should see "Estoy registrado, quiero Entrar"
     When I follow "Entrar"
     Then I should see the login form
      And I should not see "Estoy registrado, quiero Entrar"

  Scenario: Allow login of a user with valid credentials
    Given I am a confirmed user "bob" with password "secret"
    When I go to the login page
    And I fill in "usuario" with "bob"
    And I fill in "contraseña" with "secret"
    And I press "Entrar"
    Then I should be logged in
    When I follow "Cerrar Sesión"
    Then I should be logged out

  Scenario: Show account page when logged-in user tries to login
    Given I am a confirmed user "bob" with password "secret"
      And I am logged in as "bob" with password "secret"
    When I go to the login page
    Then I should be logged in

  Scenario: Allow a confirmed user to login and be remembered
    Given I am a confirmed user "bob" with password "secret"
    When I go to the login page
    And I fill in "usuario" with "bob"
    And I fill in "contraseña" with "secret"
    And I check "Recordarme"
    And I press "Entrar"
    Then I should be logged in
    When I open the homepage in a new window with cookies
    Then I should be logged in
    When I follow "Cerrar Sesión"
    Then I should be logged out
  

  Scenario Outline: Reject login of a user with bad credentials
    Given the following user records
      | login | password |
      | bob   | secret   |
    When I go to the login page
    And I fill in "usuario" with "<login>"
    And I fill in "contraseña" with "<password>"
    And I press "Entrar"
    Then I should not be logged in
    And I should have <count> errors
    And I should see "<error_message>"
  
    Examples:
      | login   | password   | count | error_message                             |
      |         |            | 1     | No rellenó los datos de autentificación.  |
      |         | secret     | 1     | Usuario no puede estar vacio.             |
      |         | bad secret | 1     | Usuario no puede estar vacio.             |
      | unknown |            | 1     | Contraseña no puede estar vacia.          |
      | unknown | secret     | 1     | Usuario no es válido.                     |
      | unknown | bad secret | 1     | Usuario no es válido.                     |
      | bob     |            | 1     | Contraseña no puede estar vacia.          |
      | bob     | bad secret | 1     | Contraseña no es válida.                  |

  # TODO: move to state based confirmation managegment and test that
  # Scenario: Not allow login of an unconfirmed user
  #   Given "sharon" a notified but unconfirmed user
  #   When I go to the login page
  #   And I fill in "usuario" with "sharon"
  #   And I fill in "password" with "secret"
  #   And I press "Login"
  #   Then I should not be logged in
  #   And I should see "Login does not exist"

