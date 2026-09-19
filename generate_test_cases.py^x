"""
GenAI-Powered Test Case Generator
Converts a plain-English user story / acceptance criteria into
structured Gherkin (Cucumber BDD) test scenarios using the OpenAI API.
"""

import os
from openai import OpenAI

client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))


def generate_gherkin_scenarios(user_story: str) -> str:
    """
    Sends a user story to the LLM and asks it to return
    Gherkin-formatted test scenarios covering positive,
    negative, and edge cases.
    """
    prompt = f"""You are a senior QA engineer. Convert the following user story
into Gherkin (Cucumber BDD) test scenarios.

Include:
- One happy-path scenario
- At least two negative/edge-case scenarios
- Use proper Given/When/Then syntax
- Use a Scenario Outline with Examples table if the story has multiple input variations

User Story:
{user_story}

Return ONLY the Gherkin feature file content, nothing else."""

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3,
    )

    return response.choices[0].message.content


if __name__ == "__main__":
    sample_user_story = """
    As a registered user, I want to log in with my email and password
    so that I can access my account dashboard.
    Acceptance Criteria:
    - Email and password fields are required
    - Show an error if credentials are invalid
    - Redirect to dashboard on successful login
    - Account locks after 5 failed attempts
    """

    print("Generating test scenarios...\n")
    scenarios = generate_gherkin_scenarios(sample_user_story)
    print(scenarios)

    # Save output to a .feature file — the standard Cucumber format
    with open("login.feature", "w") as f:
        f.write(scenarios)
    print("\n✅ Saved to login.feature")
