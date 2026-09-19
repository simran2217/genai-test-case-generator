```gherkin
Feature: User Login

  Scenario: Successful login with valid credentials
    Given I am a registered user
    And I have a valid email "user@example.com" and password "password123"
    When I enter my email and password
    Then I should be redirected to my account dashboard

  Scenario Outline: Unsuccessful login with invalid credentials
    Given I am a registered user
    When I enter my email "<email>" and password "<password>"
    Then I should see an error message "Invalid credentials"

    Examples:
      | email              | password      |
      | user@example.com   | wrongpassword |
      | wronguser@example.com | password123  |

  Scenario: Account lock after 5 failed login attempts
    Given I am a registered user
    And I have made 5 failed login attempts
    When I attempt to log in with my email "user@example.com" and password "wrongpassword"
    Then my account should be locked
    And I should see an error message "Your account is locked due to multiple failed login attempts"
```