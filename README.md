# GenAI-Powered Test Case Generator

Converts a plain-English user story and acceptance criteria into structured
Gherkin (Cucumber BDD) test scenarios using the OpenAI API — automating the
first draft of test design so QA engineers can review and refine instead of
writing every scenario from scratch.

## The Problem

Turning acceptance criteria into well-structured Gherkin scenarios (happy
path, negative cases, edge cases, Scenario Outlines with Examples tables) is
repetitive and easy to under-cover when done manually under time pressure.

## The Solution

This script sends a user story to an LLM with a structured prompt asking for:

- One happy-path scenario
- At least two negative/edge-case scenarios
- Proper `Given/When/Then` Gherkin syntax
- A `Scenario Outline` with an `Examples` table when the story has multiple
  input variations

The output is saved directly as a `.feature` file — the standard format
consumed by Cucumber — ready to drop into an existing automation framework.

## Example

Input (a typical login user story with acceptance criteria) produces output
like:

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
      | email                 | password      |
      | user@example.com      | wrongpassword |
      | wronguser@example.com | password123   |

  Scenario: Account lock after 5 failed login attempts
    Given I am a registered user
    And I have made 5 failed login attempts
    When I attempt to log in with my email "user@example.com" and password "wrongpassword"
    Then my account should be locked
    And I should see an error message "Your account is locked due to multiple failed login attempts"
```

## Tech Stack

- Python 3
- OpenAI API (`gpt-4o-mini`)

## Running It

```bash
python3 -m venv venv
source venv/bin/activate
pip install openai
export OPENAI_API_KEY="your-key-here"
python3 generate_test_cases.py
```

Edit the `sample_user_story` variable in `generate_test_cases.py` to generate
scenarios for a different feature.

## Possible Extensions

- Accept a user story from a file or command-line argument instead of a
  hardcoded sample
- Generate corresponding Java/Cucumber step-definition stubs alongside the
  `.feature` file
- Batch-process multiple user stories from a backlog export (Jira CSV, etc.)
