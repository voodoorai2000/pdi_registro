Feature: Registration
  In order to get my personal account
  As a anonymous user
  I want be able to register
  So that I can be a member of the community

  Scenario: Display registration form to anonymous user
    Given I am an anonymous user
    When I go to the homepage
    Then I should see "Registrarse"
    When I follow "Registrarse"
    Then I should see the registration form

  Scenario: Allow an anonymous user to create account
    Given I am an anonymous user
    When I go to the registration form
    And I fill in "nombre" with "bob"
    And I fill in "email" with "bob@example.com"
    And I press "Entrar"
    Then I should have a successful registration

  Scenario Outline: Not allow an anonymous user to create account with incomplete input
    Given I am an anonymous user
    When I go to the registration form
    And I fill in "nombre" with "<name>"
    And I fill in "email" with "<email>"
    And I press "Entrar"
    Then I should have an unsuccessful registration
    And I should have <count> errors
    And I should see "<error_message>"
  
    Examples: incomplete registration inputs
      | name | email           | count | error_message                                   |
      |      |                 | 3     | Email es demasiado corto (6 caracteres mínimo)  |
      | bob  |                 | 2     | debería ser una dirección de email.             |
      |      | bob@example.com | 1     | Nombre no puede estar vacio.                    |

  Scenario: Send an activation instruction mail at a successful account creation 
    Given I have registered successfully
    Then I have received an activation email
  
  Scenario: Want to confirm account using mail activation token
    Given I have registered successfully
      And I have received an activation email
    When I follow "activa tu cuenta" in the email
    Then I should see the activation form
  
  Scenario: Want to confirm account using mail activation token
    Given I have registered successfully
      And I have received an activation email
    When I follow "activa tu cuenta" in the email
    Then I should see the activation form
  
  # TODO: find a better way of testing invalid email activation tokens 
  # Scenario: Do not confirm an account with invalid mail activation token
  #   Given "sharon" an unconfirmed user
  #   When I go to the confirm page with bad token
  #   Then I should see the home page
  
  Scenario: Activate account using mail activation token with password
    Given I have registered successfully
      And I have received an activation email
      And I follow "activa tu cuenta" in the email
    Then I should see the activation form
    And I fill in "usuario" with "bob"
    And I fill in "escriba su contraseña" with "secret"
    And I fill in "confirmación contraseña" with "secret"
    And I press "Activar"
    Then I should have a successful activation
    And I should be logged in
    When I follow "Cerrar Sesión"
    Then I should be logged out
  
  Scenario Outline: Activate account using mail activation token with bad password
    Given I have registered successfully
      And I have received an activation email
    When I follow "activa tu cuenta" in the email
    And I fill in "usuario" with "<login>"
    And I fill in "escriba su contraseña" with "<password>"
    And I fill in "confirmación contraseña" with "<confirmation>"
    And I press "Activar"
    Then I should have an unsuccessful activation
    And I should have <count> errors
    And I should see "<error_message>"
  
    Examples: Bad password and confirmation combinations
      | login | password | confirmation | count | error_message                                                    |
      |       |          |              |       | Usuario es demasiado corto (3 caracteres mínimo)                 |
      | bob   |          |              |       | Contraseña es demasiado corta (4 caracteres mínimo)              |
      |       | secret   |              | 4     | Confirmación contraseña es demasiado corta (4 caracteres mínimo) |
      |       |          | secret       | 4     | Usuario por favor utilizar solo letras, números, espacios y .-_@ |
      | bob   | secret   |              | 2     | Contraseña no coincide con la confirmación                       |
      | bob   |          | secret       | 2     | Contraseña es demasiado corta (4 caracteres mínimo)              |
      |       | secret   | secret       | 2     | Usuario es demasiado corto (3 caracteres mínimo)                 |
      | bob   |          | not a secret | 2     | Contraseña es demasiado corta (4 caracteres mínimo)              |
      | bob   | secret   | not a secret | 1     | Contraseña no coincide con la confirmación                       |
      |       | secret   | not a secret | 3     | Contraseña no coincide con la confirmación                       |

  Scenario: Send an activation confirmation mail when user confirms account
    Given I have successfully activated my account
    Then I should have 2 emails at all
    When I open the most recent email
    Then I should see "Activación Completa" in the email subject
  
