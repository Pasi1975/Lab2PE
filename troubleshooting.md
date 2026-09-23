# Troubleshooting

### Scenario: Authentication uses the wrong GitHub or Fabric account

Your browser might automatically reuse an existing work account or Enterprise Managed User session. This can authenticate workshop tools with the wrong account without displaying an account selection prompt.

#### Solution

1. Open an incognito or private browser window. Alternatively, create a separate browser profile for the workshop.
2. Keep this window or profile open for the entire workshop.
3. Use this window for every authentication link:
   - For GitHub, sign in with the personal GitHub account that has the workshop license. Enterprise Managed User accounts won't work.
   - For Fabric, sign in with the workshop-provided Fabric account.
   - For AZ CLI, sign in with the workshop-provided Fabric account.
4. When a command-line tool opens an authentication page in your default browser, copy the authentication URL and open it in the incognito window or workshop browser profile instead.
5. For example, after you run `az login`, copy the URL from the browser that opens and complete the sign-in in the isolated window with the workshop Fabric account.
   
### Scenario: Cannot authenticate the Remote Power BI Authoring MCP with the workshop Fabric account

The current version of the GitHub App might use single sign-on to authenticate the Power BI MCP with a different account, without providing an option to force the authentication prompt.

Known public issue:
- https://github.com/github/copilot-cli/issues/4660

#### Solution

1. Set the `COPILOT_ENTRA_DISABLE_ONEAUTH` environment variable to `1`.
    
    ![env-var-copilot-entra](resources/img/env-var-copilot-entra.png)
    
2. Open a new terminal.
3. Open the GitHub Copilot CLI.
4. Enter `/mcp`.
5. Select the Power BI Remote MCP server.
6. Copy the authentication URL.
7. Open the URL in the incognito window or workshop browser profile.
8. Sign in with the workshop Fabric account and complete the authentication.