# Lab - Personalized Power BI Agents

⏱️ **Total duration:** 90 minutes

## Overview

In this lab you learn how to use a personalized agentic Power BI development using [GitHub Copilot](https://github.com/copilot) and Power BI agentic tools.

The lab covers the two scenarios you meet in real projects:

- **Brownfield development.** You inherit an existing Power BI report, convert it to a PBIP project, track it with Git, and use AI agents to help you with development tasks.
- **Greenfield development.** You start from a Fabric Lakehouse, and let the agent plan and build a new semantic model and reports with you steering the implementation.

## What you will learn

- How to install and use the `powerbi-authoring` plugin across multiple harnesses: GitHub Copilot CLI, Visual Studio Code, and the GitHub Copilot app
- How PBIP and Git let you track, review, and revert AI-generated changes
- How an `AGENTS.md` file constrains agent behavior and reduces hallucinations
- How to feed company context and team standards to an agent as versioned team shareable files
- How to generate and maintain documentation for a semantic model and a report
- How to modify an existing semantic model and report using AI and Power BI agentic skills and tools
- How to plan before implementing, and how to choose a model for each phase
- How to use the remote Power BI Authoring MCP server with no local setup
- How to run parallel subagents to scale with different implementation variations

## Lab structure

| Section | Learning goal |
| ------- | ------------- |
| [Prerequisites](#prerequisites) | Confirm tools, licenses, and access |
| [0. Prepare the environment](#0-prepare-the-environment) | Install the plugin and sign in to the required CLIs |
| [1. Save the report as a PBIP project and track it with Git](#1-save-the-report-as-a-pbip-project-and-track-it-with-git) | Create a reviewable baseline |
| [2. Set up Visual Studio Code and GitHub Copilot Chat](#2-set-up-visual-studio-code-and-github-copilot-chat) | Configure the model and add `AGENTS.md` |
| [3. Generate documentation for the model and report](#3-generate-documentation-for-the-model-and-report) | Automate a task nobody enjoys |
| [4. Add measure descriptions using company context](#4-add-measure-descriptions-using-company-context) | Ground the agent in business language |
| [5. Add currency conversion with a calculation group](#5-add-currency-conversion-with-a-calculation-group) | Extend the semantic model |
| [6. Restyle the report pages](#6-restyle-the-report-pages) | Apply report-wide layout changes |
| [7. Update the documentation](#7-update-the-documentation) | Reuse an earlier chat session |
| [8. Prepare the Fabric Lakehouse](#8-prepare-the-fabric-lakehouse) | Create the greenfield data source |
| [9. Connect the GitHub Copilot app to the remote MCP server](#9-connect-the-github-copilot-app-to-the-remote-mcp-server) | Work without local setup |
| [10. Plan and build a Direct Lake semantic model](#10-plan-and-build-a-direct-lake-semantic-model) | Plan first, then implement |
| [11. Create two reports with parallel subagents](#11-create-two-reports-with-parallel-subagents) | Compare design variations in parallel |

## Prerequisites

Before you begin, confirm that the following software is installed and available on your machine. For each item, either use the link to download and install it manually or run the provided `winget` command to install it for you.

* [**GitHub Copilot CLI**](https://github.com/features/copilot/cli/)
    ```console
    winget install -e --id GitHub.Copilot --accept-source-agreements --accept-package-agreements
    ```
* [**GitHub Copilot app**](https://github.com/features/ai/github-app)
    ```console
    winget install -e --id GitHub.CopilotApp --accept-source-agreements --accept-package-agreements
    ```
* [**Power BI Desktop**](https://pbi.onl/download)
    ```console
    winget install -e --id Microsoft.PowerBI --accept-source-agreements --accept-package-agreements
    ```
* [**Visual Studio Code**](https://code.visualstudio.com/download)
    ```console
    winget install -e --id Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements
    ```
* [**Git for Windows**](https://gitforwindows.org/)
    ```console
    winget install -e --id Git.Git --accept-source-agreements --accept-package-agreements
    ```
* [**Node.js and npm**](https://nodejs.org/en/download/)
    ```console
    winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
    ```
* [**Azure CLI**](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest&pivots=winget)
    ```console
    winget install -e --id Microsoft.AzureCLI --accept-source-agreements --accept-package-agreements
    ```

You also need:

* A GitHub personal account with an active GitHub Copilot license
* Access to a Fabric tenant with permission to create a workspace
* This workshop repository downloaded and unzipped to a local folder

> [!IMPORTANT]
> Your instructor provides the workshop Fabric account and the GitHub Copilot license.

## 0. Prepare the environment

✅ **Goal**: Install the Power BI authoring plugin once and make it available to every GitHub Copilot surface, then sign in to the accounts the agent needs.

### Install the Power BI authoring plugin

1. Open a terminal.
2. Run the following commands:

	```powershell
	copilot plugin marketplace add microsoft/skills-for-fabric	
	```
	```powershell	
	copilot plugin install powerbi-authoring@fabric-collection
	```

	> [!TIP]
	> There are several ways to install skills and plugins. You can install them in Visual Studio Code, using [NPX Skills](https://github.com/vercel-labs/skills), [Agent Package Manager](https://microsoft.github.io/apm/) or simply copy them into your workspace or Copilot folder. Installing the plugin through GitHub Copilot CLI is a simple way to make its skills and MCP server available across GitHub Copilot CLI, Visual Studio Code, and the GitHub Copilot app without installing duplicate copies.
    >
    > Learn more in [`powerbi-authoring-plugin`](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-agentic-overview#get-started) documentation page.

### Sign in to GitHub Copilot

1. Start GitHub Copilot CLI:

	```powershell
	copilot
	```

2. Sign in to your GitHub Copilot account:

	```text
	/login
	```

    If asked for account type, choose **GitHub.com**
    
3. Follow the browser prompts and return to the terminal when the sign-in completes.
   
   Your console should look like this:

   ![gh-copilot-signedin](/resources/img/gh-copilot-signedin.png)

### Confirm that the skills and MCP server are ready

1. In the GitHub Copilot CLI session, enter the following prompt:

	```text
	List the Power BI skills and MCP servers you have available.
	```

	**Expected outcome**

	- The response lists the Power BI authoring skills that came with the plugin, including `semantic-model-authoring` and `powerbi-report-authoring`.
	- The response lists the Power BI Authoring MCP server as available.
	- If either list is empty, the plugin installation did not complete. Re-run the plugin install commands before continuing.

### Sign in to Azure CLI

1. Open a terminal.
2. Sign in with your Fabric account:

	```powershell
	az login
	```
3. Follow the browser prompts and return to the terminal when the sign-in completes.
3. Confirm that the correct account is active

	```powershell
	az account show
	```
    ![az-account-show](/resources/img/az-account-show.png)

    > [!IMPORTANT]
	> The Power BI report authoring tools use the Azure CLI token to reach Fabric. If the wrong account is active, later exercises fail with authorization errors.

### Ensure Copilot Chat is enabled in Visual Studio Code

1. Open **Visual Studio Code**.
2. Select [Open the AI features setting](vscode://settings/chat.disableAIFeatures) and ensure that **Disable AI Features** is cleared.
   	
    > [!NOTE]
	> If the link does not open from your Markdown viewer, open **Settings** in Visual Studio Code and search for `chat.disableAIFeatures`.

4. Open **GitHub Copilot Chat** (`CTRL+ALT+I`) and confirm that the chat view is accessible.


5. You may need to sign-in with your GitHub Copilot account.

### Expected result

You should now have:

* The `powerbi-authoring` plugin installed and shared across GitHub Copilot surfaces
* A signed-in GitHub Copilot CLI session
* Confirmation that the Power BI skills and MCP server are available
* Azure CLI signed in with the workshop Fabric account

---

## Part 1: Brownfield development

In this part you work with an existing Power BI report. You convert it to PBIP, place it under Git, and use an AI Agent inside Visual Studio Code to document and make changes to it. Power BI Desktop stays open so you can reload and inspect the agent's changes.

## 1. Save the report as a PBIP project and track it with Git

✅ **Goal**: Convert a provided PBIX file into a PBIP project and create a Git baseline so that every agent change is reviewable and reversible.

### Steps

1. Open the workshop [`resources/sales.pbix`](resources/sales.pbix) file in **Power BI Desktop**.
2. Select **File** > **Save as** > **Browse this device**.
3. Choose a local folder for the lab, for example `C:\FabCon\Lab2`.
4. In the file type list, select **Power BI project files (*.pbip)** and save the project.
5. Keep Power BI Desktop open. You reload changes from it later in the lab.
6. Open the project folder in **Visual Studio Code** by clicking the title bar and choosing **Open in Visual Studio Code**
   
   ![pbid-open-vscode](/resources/img/pbid-open-vscode.png)

   Confirm that the folder contains the `sales.SemanticModel` and `sales.Report` folders.

   ![vscode-pbip](/resources/img/vscode-pbip.png)

8. Click the **Source Control** (`CTRL+SHIFT+G`) tab and select **Initialize Repository**
9. Type a initial commit message, for example "Initial PBIP baseline"

    ![vscode-init-git-pbip](/resources/img/vscode-init-git-pbip.png)

    > [!IMPORTANT]
	> PBIP stores the semantic model as TMDL files and the report as PBIR files. Both are plain text, so Git can show you exactly what the agent changed. This is your safety net: review the diff after every prompt, keep what you want, and discard the rest with **Discard changes** in the Source Control view.    	

### Expected result

* A PBIP project saved to a local folder
* `sales.SemanticModel` and `sales.Report` folders visible in Visual Studio Code
* An initialized Git repository with a clean working tree and one baseline commit

## 2. Set up GitHub Copilot in Visual Studio Code

✅ **Goal**: Configure the AI model, add the `AGENTS.md` file and skills that keeps the agent grounded on important development rules.

### Steps

1. In **Visual Studio Code**, open **GitHub Copilot Chat** (`CTRL+ALT+I`).
2. Set the chat mode to **Agent**.
3. In the model picker, select a reasoning model such as `GPT-5.6 Sol`.
   
   ![vscode-copilot-chat](/resources/img/vscode-copilot-chat.png)

4. Copy [resources/AGENTS.md](resources/AGENTS.md) from the workshop repository into the root of your PBIP project folder. 

    > [!IMPORTANT]
	> [`AGENTS.md`](https://agents.md/) is an important part of agentic development. It lets you define codebase-level rules, context, and constraints that agents need to understand and respect when working on the project. Because the file is stored with the codebase and read automatically, the same guidance applies consistently across chat sessions and team members.
	>
	> The `AGENTS.md` file in this workshop is a simple example. It ensures that the agent always loads the appropriate Power BI authoring skills and directs it to use the Power BI Authoring MCP server when editing the semantic model. The agent can work with TMDL files directly, but using the MCP tools provides a more reliable authoring path less likely to break things.

5. Copy the folder [`resources/.github`](resources/.github) into the root of your PBIP project folder

    > [!IMPORTANT]
	> This workshop uses Microsoft-provided agent skills installed through the `powerbi-authoring` plugin. Skills give the agent context about processes and preferred ways of working. Teams can keep project-specific skills in source control to capture business practices and help developers produce consistent results. The [`powerbi-documentation` skill](resources/.github/skills/powerbi-documentation/SKILL.md) is an example of a repository-local skill that lives alongside the codebase. Skills can also be shared through private or public repositories and marketplaces.

6. Your folder should look like this.

    ![vscode-pbip-folder](/resources/img/vscode-pbip-folder.png)

6. Open **Source Control** (`CTRL+SHIFT+G`) and commit.

### Expected result

* GitHub Copilot Chat running in agent mode
* `AGENTS.md` present in the project root and committed to Git

## 3. Generate documentation for the model and report

✅ **Goal**: Let the agent produce the documentation that usually never gets written, using the PBIP files as the source of truth.

Writing documentation from scratch and keeping it current both take time. AI can help you create a useful starting point, while the Power BI agentic tools, the MCP server, and the `powerbi-desktop` CLI can help keep it aligned with the model and report with minimal ongoing effort.

### Steps

1. Start a **new chat session** in GitHub Copilot Chat.
2. Enter the following prompt:

	```text
	Document this Power BI Project code base.
	```

	**Expected outcome**

	- The agent reads `AGENTS.md` and loads the local `powerbi-documentation` skill. LLMs load skills on demand, and the instruction in `AGENTS.md` makes this requirement explicit.
	- The agent follows the documentation structure and standards defined by the `powerbi-documentation` skill.
	- The agent uses the Power BI Authoring skill and MCP server to inspect the semantic model metadata.
	- The agent loads the Power BI report authoring skills to inspect the PBIR files and understand the report pages, visuals, filters, and bindings.
	- The agent uses the Power BI report CLI tools to capture screenshots from the report open in Power BI Desktop.
	- A `docs/` folder is created with a catalog and one Markdown file for each semantic model and report in the codebase.
	- The generated documentation includes the model structure, measures, report flow, filters, and a screenshot of every report page.

	> [!IMPORTANT]
	> The short prompt works because `AGENTS.md` requires the agent to load the local `powerbi-documentation` skill. The skill defines how the team expects project documentation to be created, while the Power BI MCP server and report tools provide the model and report information needed to create it.

3. Open the generated Markdown files and preview it with **Ctrl+Shift+V**.
4. Keep this chat session open. You return to it in exercise 7.

## 4. Add measure descriptions using company context

✅ **Goal**: Add business-friendly descriptions to every measure, written in the language of Northwind Retail Group rather than generic BI text.

### Steps

1. Copy [resources/company-context.md](resources/company-context.md) from the workshop repository into the root of your PBIP project folder.
2. Start a **new chat session**.
3. Enter the following prompt:

	```text
	Add a description to every measure in the semantic model `Sales.SemanticModel\definition`.
	Use `company-context.md` for tone and business context so descriptions sound like they come from someone at Northwind Retail Group, not generic BI text.
	Keep each description to 1-2 sentences: what the measure calculates, and any business nuance from the context (e.g. net vs. gross, fiscal year, seasonality) where relevant.
	```

	**Expected outcome**

	- The agent loads the `semantic-model-authoring` skill.
	- The agent connects to the semantic model through the Power BI Authoring MCP server instead of editing TMDL files by hand.
	- Every measure receives a concise description of one to two sentences.
	- The descriptions reflect the context file, for example revenue described as net sales, fiscal years labeled FY24 or FY25, and seasonal patterns called out where they are relevant.
	- The updated model is saved back to the PBIP folder.
	- No measure expressions, data types, or relationships are changed.

4. Open the **Source Control** view in Visual Studio Code and review the Git diff.
5. Confirm that the changed lines are description properties only, and that no DAX expression was modified.

	This is the main advantage of PBIP with Git. You see the exact change before you accept it. Context files such as `company-context.md` live in the repository, so the whole team gets the same tone and business rules from the agent.

6. Switch to **Power BI Desktop**.
7. Select **Apply external changes** to reload the updated model.
8. Select a measure in the model view and confirm that its description appears in the properties pane.

### Reflection

* Which descriptions would you keep as written, and which would you rewrite?
* What other team knowledge would be worth storing as a context file in the repository?

## 5. Add currency conversion with a calculation group

✅ **Goal**: Extend the semantic model with a new source table and a calculation group so sales can be analyzed in multiple currencies.

### Steps

1. Start a **new chat session**.
2. Enter the following prompt:

	```text
	Add RAW-CurrencyExchange.csv (https://raw.githubusercontent.com/pbi-tools/sales-sample/refs/heads/data/RAW-CurrencyExchange.csv) to the Sales semantic model, then create a calculation group to convert and analyze sales in EUR, USD, and GBP.
	```

	**Expected outcome**

	- The agent loads the `semantic-model-authoring` skill.
	- The agent inspects the CSV file to determine its schema before creating anything.
	- The agent uses the Power BI Authoring MCP server to create the currency exchange table and the calculation group.
	- The calculation group contains calculation items for EUR, USD, and GBP.
	- The updated model is saved back to the PBIP folder.
	- The Git diff shows new TMDL files for the table and the calculation group, and no unrelated model changes.

3. Review the Git diff in the **Source Control** view.
4. Switch to **Power BI Desktop** and select **Apply external changes**.
5. Create a temporary visual with a sales measure, then apply the calculation group items to confirm that the converted values change as expected.
6. Remove the temporary visual before continuing.
7. Open **Source Control** (`CTRL+SHIFT+G`) in Visual Studio Code.
8. Stage the measure description and currency conversion changes, enter `Add measure descriptions and currency conversion` as the commit message, and select **Commit**.

## 6. Restyle the report pages

✅ **Goal**: Apply a consistent layout across every page of the report through the report authoring tools.

### Steps

1. Start a **new chat session**.
2. Enter the following prompt:

	```text
	Remove visual titles on all visuals of all pages in report `Sales.Report`
	Also ensure the visuals have a consistent grid alignment and size.
	```

	**Expected outcome**

	- The agent loads the `powerbi-report-authoring` skill.
	- The agent uses both the `powerbi-report-author` and `powerbi-desktop` CLI tools to inspect and update the report.
	- The agent analyzes the PBIR files before making changes.
	- The `visual.json` files are updated to turn off the visual titles.
	- The `position` properties are updated so that the visuals follow a consistent grid alignment and size on every page.
	- The Git diff is limited to files under `Sales.Report`. The semantic model is unchanged.

3. Optionally turn on **Autopilot** in the chat session so the agent runs the sequence of tool calls without asking for approval at every step.

	> **Note:** Autopilot is useful for long, repetitive tool sequences, but use it with care. The agent acts without asking. Keep your Git working tree clean before you enable it so you can always revert.

4. Review the Git diff and confirm that only report files changed.
5. Switch to **Power BI Desktop** and select **Apply external changes**.
6. Review each page and confirm that titles are removed and the visuals are aligned.
7. If a page does not look right, either refine the prompt or discard the change in the **Source Control** view and try again.

## 7. Update the documentation

✅ **Goal**: Bring the documentation back in sync with the model and report changes by reusing the chat session that created it.

### Steps

1. Reopen the chat session you used in exercise 3.
2. Enter the following prompt:

	```text
	I made changes to my PBIP, update the docs with those changes.
	```

	**Expected outcome**

	- The agent identifies what changed, either by inspecting the PBIP files or by reading the Git diff.
	- The Markdown file in `docs/` is updated with the new currency exchange table, the calculation group, and the measure descriptions.
	- The report section and page screenshots are refreshed to match the new layout.
	- Only files under `docs/` change.

3. Preview the updated documentation and confirm that the new model objects and the restyled pages are reflected.
4. Open **Source Control** (`CTRL+SHIFT+G`) in Visual Studio Code.
5. Stage the report and documentation changes, enter `Restyle report and refresh docs` as the commit message, and select **Commit**.

	Returning to an earlier session matters. That session already holds the context of how the documentation was structured and why, so the follow-up prompt can be short. A new session would have to rediscover all of it.

### Reflection

* How much of this work would you have done by hand, and how long would it have taken?
* Which changes would you still review line by line before merging into a shared branch?
* Where did `AGENTS.md` visibly change what the agent did?

---

## Part 2: Greenfield development

In this part you start from nothing. You create a Fabric workspace, load a Lakehouse with a notebook, and then build a Direct Lake semantic model and two reports from the **GitHub Copilot app** using the remote Power BI Authoring MCP server.

There are no local files in this part. The GitHub Copilot app is a good fit for that: it is more approachable than Visual Studio Code or the CLI, and it needs no local setup. Underneath it is the same GitHub Copilot orchestrator, the same skills, and the same MCP capabilities, so the experience stays consistent. Which surface you use is a matter of preference.

## 8. Prepare the Fabric Lakehouse

✅ **Goal**: Create an isolated Fabric workspace and load it with a Lakehouse containing the sample sales tables.

### Steps

1. Go to [Power BI](https://app.powerbi.com) and sign in with the workshop account.
2. Select **Workspaces** > **New workspace**.
3. Name the workspace using this convention:

	```text
	FabCon-Agentic-Lab2-[YourInitials]
	```

4. Assign the workspace to the Fabric capacity identified by your instructor, then select **Apply**.
5. In the new workspace, select **New item** > **Notebook**.
6. Open [resources/notebook.py](resources/notebook.py) from the workshop repository and copy its contents.
7. Paste the code into the first cell of the notebook.
8. Run the notebook and wait for it to finish.
9. Refresh the workspace and confirm that a Lakehouse named `Lakehouse_01` was created.
10. Open the Lakehouse and confirm that it contains the following tables:

	* `dimension_city`
	* `dimension_customer`
	* `dimension_date`
	* `dimension_employee`
	* `dimension_stock_item`
	* `fact_sale`

### Expected result

* A dedicated Fabric workspace named `FabCon-Agentic-Lab2-[YourInitials]`
* A `Lakehouse_01` Lakehouse loaded with the six Delta tables above

## 9. Connect the GitHub Copilot app to the remote MCP server

✅ **Goal**: Register the remote Power BI Authoring MCP server so the agent can work against Fabric with no local installation.

### Steps

1. Open the **GitHub Copilot app** and sign in with your GitHub account.
2. Open the MCP server settings and add a new MCP server manually with this URL:

	```text
	https://api.fabric.microsoft.com/v1/mcp/powerbi/authoring
	```

3. Complete the authentication prompt with the workshop Fabric account.
4. Confirm that the `powerbi-authoring` plugin and the remote MCP server both appear as available in the app.

	The local MCP server installed with the plugin in exercise 0 can do the same work. The remote server has one advantage: it needs no local setup at all, which makes it the easier option for anyone who is not working from a code project.

	> **Instructor note:** The exact menu path for registering an MCP server depends on the GitHub Copilot app version installed on your machine. Your instructor will show the current path.

### Expected result

* The remote Power BI Authoring MCP server registered and authenticated in the GitHub Copilot app

## 10. Plan and build a Direct Lake semantic model

✅ **Goal**: Produce a reviewed implementation plan for a new Direct Lake semantic model, then implement the approved plan with a cheaper model.

Planning first gives you something to correct before anything is created. It also lets you split the work: an expensive reasoning model for the thinking, a cheaper model for the execution.

### Create the plan

1. In the **GitHub Copilot app**, start a new session.
2. Set the session mode to **Plan**.
3. Select a powerful model such as `GPT-5.6 Sol`.
4. Attach or paste the contents of [resources/team-rules.md](resources/team-rules.md) so the agent can read your development standards.
5. Enter the following prompt, replacing the workspace name with your own:

	```text
	I want to create a new Direct Lake semantic model with name 'SM - Sales' on top of the lakehouse 'Lakehouse_01' in workspace 'FabCon-Agentic-Lab2-[YourInitials]'
	Consider the development rules in team-rules.md
	```

	**Expected outcome**

	- The agent starts by inspecting the schema of `Lakehouse_01` through the remote MCP server.
	- The agent may ask follow-up questions, for example about the model name or which tables to include. Answer them.
	- The agent returns an implementation plan rather than creating anything.
	- The plan reflects the rules in `team-rules.md`: a star schema, explicit measures for aggregatable numeric columns with the base columns hidden, business-friendly table names without `Fact` or `Dim` prefixes, plural fact table names and singular dimension names, measure names in uppercase, and an `About` table.
	- No semantic model exists in the workspace yet.

6. Read the plan and check it against `team-rules.md`.
7. Adjust the plan where needed, for example table naming, which measures to create, or the contents of the `About` table.

### Implement the plan

1. Switch the model picker to a cheaper model such as `GPT-5.6 Terra`.

	The implementation phase mostly follows instructions that are already written down, so it does not need the strongest reasoning model.

2. Ask the agent to implement the approved plan:

	```text
	Implement the approved plan.
	```

	**Expected outcome**

	- The agent executes the plan step by step without re-planning from scratch.
	- The agent uses the `database_operations` `Create` operation, which creates a Direct Lake model over the Lakehouse tables and infers their schema in a single call.
	- A semantic model named `SM - Sales` appears in your workspace.
	- The model follows your team rules rather than only the skill defaults. The `semantic-model-authoring` skill carries its own naming conventions, and the context you supplied overrides them.
	- The `About` table is present with the `Key`, `Value`, and `Order` columns.

3. Open the workspace in the Fabric portal and open `SM - Sales`.
4. Confirm the table names, the hidden base columns, the explicit measures, and the `About` table.
5. Note which parts of the model came from your rules and which came from the skill defaults.

### Reflection

* What did the plan get wrong, and would you have caught it after implementation instead?
* Which of your own team standards would you write down as a rules file?

## 11. Create two reports with parallel subagents

✅ **Goal**: Use subagents to build two report variations at the same time and pick the better one.

Trying design variations used to be expensive, so most teams built one and lived with it. With subagents you can run both and compare.

### Steps

1. In the **GitHub Copilot app**, start a new session.
2. Turn on **Autopilot** so the subagents can run without stopping for approval on each step.
3. Select a powerful model such as `GPT-5.6 Sol`.
4. Enter the following prompt, replacing the workspace name with your own:

	```text
	Create a report on top of the semantic model 'SM - Sales' in workspace 'FabCon-Agentic-Lab2-[YourInitials]'.
	The report must have only one page and it should be focused for executive view of the company.
	I want to try two different styles:
		Style 1 - cards on top with key metrics trend and category breakdowns in the bottom
		Style 2 - cards on the left with key metrics and trend and category breakdown on the right
	Spin two subagents one for each style each one should create a separate report in the workspace for my review and I'll pick the best one.
	Do not change the semantic model. Use whatever is available in the model and use your best judgement to pick the best measures and fields.
	```

	**Expected outcome**

	- The agent loads both the `semantic-model-authoring` and the `powerbi-report-authoring` skills.
	- The agent first queries `SM - Sales` to understand its tables, measures, and data before designing anything.
	- The agent produces a plan and then starts two subagents, one per style.
	- You can see the two subagents running in parallel in the session view.
	- Two separate reports appear in your Fabric workspace, each with a single page.
	- Style 1 places the metric cards across the top, with the trend and category breakdowns below. Style 2 places the cards and trend on the left and the category breakdown on the right.
	- The semantic model `SM - Sales` is unchanged. No new measures, tables, or columns are added to it.

5. Open both reports in the Fabric portal.
6. Compare the layouts, the chosen measures, and the chosen fields.
7. Decide which one you would keep, and note what you would change in the other.

### Reflection

* Did the two subagents pick the same measures? If not, why?
* When is running variations in parallel worth the cost, and when is one attempt enough?

## ✅ Wrap-up

You've now:

* Installed the `powerbi-authoring` plugin once and used it from GitHub Copilot CLI, Visual Studio Code, and the GitHub Copilot app
* Converted a PBIX file to PBIP and placed it under Git to make AI changes reviewable
* Used `AGENTS.md` to constrain how the agent works on your project
* Generated documentation for a semantic model and a report, then kept it up to date
* Added business-grounded measure descriptions from a shared company context file
* Extended a semantic model with a new table and a currency conversion calculation group
* Restyled every page of a report through the report authoring tools
* Built a Lakehouse in Fabric and connected the GitHub Copilot app to the remote MCP server
* Planned a Direct Lake semantic model with one model and implemented it with another
* Created two report variations in parallel with subagents

## Key takeaways

* PBIP plus Git turns AI changes into diffs you can review, accept, or revert. Without it you are trusting the agent blindly.
* Context files such as `AGENTS.md`, `company-context.md`, and `team-rules.md` live in the repository, so the whole team gets consistent agent behavior.
* Instructions matter most with cheaper models. They are the difference between a supported authoring path and a hallucinated one.
* Separate chat sessions keep context focused, and returning to an earlier session keeps follow-up prompts short.
* Plan with a strong model, implement with a cheaper one. The two phases have different requirements.
* Skills carry sensible defaults, and your own context overrides them when you provide it.
* Autopilot removes approval friction but also removes a checkpoint. Keep a clean Git state before turning it on.
* The same skills and MCP capabilities work across the CLI, Visual Studio Code, and the GitHub Copilot app. Pick the surface that fits the task.

## What's next?

Apply the same pattern to one of your own projects. Start by saving a report as PBIP, committing it to Git, and writing an `AGENTS.md` plus a rules file that reflects how your team actually works.

## Useful links

* [Power BI Desktop projects (PBIP)](https://learn.microsoft.com/power-bi/developer/projects/projects-overview)
* [Power BI Desktop project semantic model folder (TMDL)](https://learn.microsoft.com/power-bi/developer/projects/projects-dataset)
* [Power BI Desktop project report folder (PBIR)](https://learn.microsoft.com/power-bi/developer/projects/projects-report)
* [Skills for Fabric](https://github.com/microsoft/skills-for-fabric)
* [GitHub Copilot CLI](https://github.com/features/copilot/cli)
* [GitHub Copilot app](https://github.com/features/ai/github-app)
* [Direct Lake overview](https://learn.microsoft.com/fabric/fundamentals/direct-lake-overview)
* [Lakehouse overview](https://learn.microsoft.com/fabric/data-engineering/lakehouse-overview)
* [Calculation groups](https://learn.microsoft.com/power-bi/transform-model/calculation-groups)
* [Model Context Protocol](https://modelcontextprotocol.io/)
* [Tabular Editor - Get Started with Agentic Development](https://tabulareditor.com/blog/how-to-get-started-with-agentic-development-for-business-intelligence)
* [Tabular Editor - Pick the right AI model](https://tabulareditor.com/blog/picking-the-ai-model-for-the-task)
* [Tabular Editor - LLMs for data professionals](https://tabulareditor.com/blog/practical-introduction-to-llms-for-data-professionals)
* [Agent Plugins spec](https://github.com/agentplugins/agent-plugins-spec)
* [Agent Skills spec](https://agentskills.io/specification)