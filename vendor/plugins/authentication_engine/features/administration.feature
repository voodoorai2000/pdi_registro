Feature: Administration
  In order to administrate the system
  As an administrator
  I want to have all privileges to control the whole system

  Scenario: should have a complete invitation list
    Given "sharon" an admin user
    When I logged in as an administrator
    And I go to the admin root page
    Then I should see the admin root page
    When I follow "Invitación"
    Then I should see "Lista de Invitaciones"
    
    
  Scenario: should have a complete user list
    Given "sharon" an admin user
    When I logged in as an administrator
    And I go to the admin root page
    Then I should see the admin root page
    When I follow "Usuario"
    Then I should see "Usuarios"


