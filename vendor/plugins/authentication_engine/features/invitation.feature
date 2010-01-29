Feature: Invitations
  As a site member
  I want to be able to invite my friends
  So that I interact with them online

  #Commenting until we release invitation funcionality
  #Scenario: I invites my friends
  #  Given I am a confirmed user "bob" with password "secret"
  #    And I am logged in as "bob" with password "secret"
  #   Then I should see "Enviar Invitación"
  #    And I should have 5 invitations left
  #   When I follow "Enviar Invitación"
  #   Then I should see invitation form
  #   When I fill in "El nombre de la persona" with "lina"
  #    And I fill in "El email de la persona" with "lina@example.com"
  #    And I press "¡Invita!"
  #   Then I should see "Gracias, invitacion enviada."
  #    And I should have 4 invitations left
  #   Then "lina@example.com" should receive 1 email
  #   When they open the email with subject "Invitación De Usuario"
  #   Then they should see "bob has invited you to register." in the email body
  
  #Scenario: Friends accept my invitation
  #  Given I am a user with email "lina@example.com" who was invited by "bob"
  #   When "lina@example.com" opens the email with subject "Invitación De Usuario"
  #   Then I should see "bob has invited you to register." in the email body
  #   When I click the first link in the email
  #   Then I should see "Active su cuenta"
  #   When I fill in "Usuario" with "lina"
  #    And I fill in "Escriba su contraseña" with "secret"
  #    And I fill in "Confirmación contraseña" with "secret"
  #    And I press "Activar"
  #   Then I should see "Su cuenta ha sido activada."
  #    And I should be logged in
  #   Then I should have 2 emails at all
  #   When I open the most recent email
  #   Then I should see "Activación Completa" in the email subject
    # TODO: implement when failing mailer template is fixed
    # Then "bob@example.com" should have 1 email
    # When "bob@example.com" opens the email
    # Then "bob@example.com" should see "Invitation Activated" in the email subject
  
