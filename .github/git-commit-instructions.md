## GIT COMMIT GUIDELINES

When asked to generate a commit message, follow these strict rules:

1.  **Structure:** Use the format `<Type>: <Description>`.
2.  **Type Keywords:**
    - `feat`: New feature or significant addition.
    - `fix`: Bug fix.
    - `ui`: Visual changes (colors, typography, spacing).
    - `refactor`: Code restructuring without behavior change.
    - `chore`: Maintenance, dependencies, config.
3.  **Description Rules:**
    - **Imperative Mood:** Start with a verb in present tense (e.g., "Add" not "Added", "Fix" not "Fixed").
    - **Concise:** Keep the first line under 70 characters.
    - **Specific:** Mention the specific Shadcn component or logic changed (e.g., "Add ShadButton to login form" instead of "Update UI").
4.  **No Fluff:** Do not use generic messages like "Update code" or "Minor changes".

### Examples of Good Commits:
- `feat: Implement login screen using ShadCard and ShadInput`
- `ui: Update primary color scheme in ShadTheme`
- `fix: Resolve null overflow in ShadTable widget`
- `refactor: Extract user validation logic to AuthService`