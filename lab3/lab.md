# Lab - Build Data Apps with Fabric

⏱️ **Total duration:** 60 minutes

## Overview

This lab takes agentic development beyond model authoring and into application creation. Starting from an existing semantic model, you will use **Fabric Data Apps** and natural-language prompts to generate, customize, and refine highly personalized analytical applications—including experiences inspired by screenshots and design concepts.

## What you will learn

- How to create a **Fabric Data App** from a semantic model
- How to generate application experiences using natural-language prompts
- How to turn visual inspiration into customized data applications
- How to refine an AI-generated application for a specific audience
- How Fabric Data Apps differ from traditional Power BI authoring workflows

## Lab structure

| Section | Learning goal |
| ------- | ------------- |
| [Prerequisites](#prerequisites) | Confirm tools, capacity, model access, and tenant settings |
| [0. Upload the Contoso Sales model](#0-upload-the-contoso-sales-model) | Import the workshop semantic model into Fabric |
| [1. Create a Fabric app](#1-create-a-fabric-app) | Open the Fabric App (preview) creation experience |
| [2. Open a local project and get set up in the GitHub Copilot app](#2-open-a-local-project-and-get-set-up-in-the-github-copilot-app) | Choose the local folder and configure GitHub Copilot |
| [3. Create the first iteration of the Fabric app](#3-create-the-first-iteration-of-the-fabric-app) | Connect, generate, and deploy the first app experience |
| [4. Iterate on the Fabric app](#4-iterate-on-the-fabric-app) | Add interactive analysis, coaching notes, and Contoso branding |
| [5. Explore and customize](#5-explore-and-customize) | Experiment with creative Fabric App scenarios |

## Prerequisites

Before beginning the lab, confirm that you have:

* Access to the workshop's Fabric tenant with permission to create a workspace
* Access to a Fabric capacity that can be assigned to your workspace
* The **Fabric Apps (preview)** workload enabled for your account by a Fabric tenant administrator
* A Power BI Pro license
* Permission to download the workshop-provided **Contoso Sales** PBIX file
* A modern web browser such as Microsoft Edge, Google Chrome, or Mozilla Firefox
* A GitHub account with an active GitHub Copilot license
* The [GitHub Copilot app](https://github.com/features/ai/github-app) installed on your computer
* [Node.js and npm](https://nodejs.org/en/download/) installed on your computer
* The Rayfin CLI package installed:

	```console
	npm install @microsoft/rayfin-cli
	```

Verify that the Rayfin CLI is available before continuing:

	```console
	npx rayfin --version
	```

All participants should use the workshop-provided **Contoso Sales** semantic model rather than selecting their own model. This ensures that the prompts, expected results, and validation steps remain consistent across the workshop.

## 0. Upload the Contoso Sales model

✅ **Goal**: Upload the workshop PBIX file to your Fabric workspace and confirm that the Contoso Sales semantic model is ready to use.

### Upload the workshop model

1. Download the workshop [Contoso Sales PBIX file](resources/Contoso%20Sales.pbix) and save it to your **Downloads** folder.
2. Go to [Microsoft Fabric](https://app.fabric.microsoft.com) and sign in.
3. Open the Fabric workspace you will use for this lab.
4. Confirm that the workspace is assigned to a Fabric capacity.
5. Select **Import** from the workspace toolbar.
6. Select **Report, Paginated Report or Workbook**.
7. Select **From this computer**.

	![Import a report from this computer](resources/img/fabric-import-menu.png)

8. In the file picker, open your **Downloads** folder and select `Contoso Sales.pbix`.
9. Select **Open** and wait for the import to finish.

### Verify the model

1. Confirm that a report and a semantic model appear in the workspace.
2. Confirm that the semantic model is named **Contoso Sales**.
3. Open the semantic model and confirm that it loads without errors.
4. Do not make any changes yet.

### Expected result

You should now have:

* The Contoso Sales report and semantic model in your Fabric workspace
* Confirmation that the semantic model opens without errors
* A workshop model ready for the remaining exercises

## 1. Create a Fabric app

✅ **Goal**: Start creating a Fabric App in the same workspace as the Contoso Sales semantic model.

### Steps

1. Return to the workspace containing the **Contoso Sales** semantic model.
2. Select **New item** in the upper-left corner of the workspace.

	![New item button in a Fabric workspace](resources/img/fabric-new-item-button.png)

3. In the pane that opens, select **All items**.
4. Enter `App` in the search box.
5. Select **App (preview)** from the search results.

	![Search for App in the New item pane](resources/img/fabric-app-search.png)

6. In the **New App** dialog, enter a name for your app, such as `Contoso Sales App`.
7. Confirm that **Location** is set to your current workspace.
8. Select **Create**.

	![Name and create the new Fabric App](resources/img/fabric-new-app-dialog.png)

9. On the template selection page, select **Data App**.

	![Select the Data App template](resources/img/fabric-data-app-template.png)

### Expected result

You should now have:

* A new Fabric App in the same workspace as the Contoso Sales semantic model
* The **Data App** template selected
* A **Getting started** guide with commands to run in a terminal

## 2. Open a local project and get set up in the GitHub Copilot app

✅ **Goal**: Open the local folder where you will develop the Fabric app with GitHub Copilot.

### Steps

1. Open the **GitHub Copilot app**.
2. In **Projects**, select the **+** button.
3. Select **Open folder**.
4. Browse to and select the folder on your computer that you want to use for this Fabric app.
5. Confirm the folder selection.
6. In the chat pane, open the model selector.
7. Set **Model** to **GPT-5.6 Sol**.
8. Set **Effort** to **Medium**.

	![Configure the GitHub Copilot model and effort](resources/img/copilot-model-settings.png)

### Expected result

You should now have:

* The selected local folder open as a project in the GitHub Copilot app
* **GPT-5.6 Sol** selected as the model
* **Effort** set to **Medium**

## 3. Create the first iteration of the Fabric app

✅ **Goal**: Scaffold the Fabric App, connect it to the Contoso Sales semantic model, and create the first sales analytics experience.

### Steps

1. Return to your Fabric App in the Fabric portal.
2. In **Getting started**, locate step 2 and copy the provided scaffolding command.
3. Return to the GitHub Copilot app and confirm that the local project folder selected in the previous section is open.
4. Paste the scaffolding command into the chat pane and ask Copilot to run it. For example:

	```powershell
	npm create @microsoft/rayfin@latest -- "Contoso Sales App" --template dataapp --workspace "FabCon EU 2026" --base-api-url https://msitapi.fabric.microsoft.com
	```

	> [!IMPORTANT]
	> Use the command generated for your Fabric App. The app name, workspace name, and base API URL may differ from the example.

5. After scaffolding finishes, GitHub Copilot should suggest the next PowerShell commands for opening the generated project directory and starting the app. Copy and paste the suggested commands into GitHub Copilot, then ask it to run them. For example:

	```powershell
	cd "Contoso Sales App"
	npx rayfin dev
	```

6. Open the **Contoso Sales** semantic model in the Fabric web portal and copy its full URL from the browser address bar. Paste the URL into GitHub Copilot as plain text, add the following instruction, and run the prompt:

	```text
	connect my data app to this semantic model : [insert URL to semantic model]
	```

	> [!IMPORTANT]
	> Confirm that the full URL is visible as text in the chat pane rather than appearing only as a generic **Power BI** link. The URL contains the semantic model ID and workspace ID that GitHub Copilot needs to connect the app to the correct model.

7. Once that process finishes, give GitHub Copilot the following prompt and ask it to run the required commands:

	```text
	Build and deploy a polished sales analytics app for a Global Sales Manager using the connected semantic model. Analyze store performance with KPIs for Total Sales, Gross Profit, Gross Margin %, Units Sold, and Sales per Unit. Create a responsive store-level scatter plot of Sales per Unit vs. Gross Margin %, with labeled performance quadrants. Highlight top performers, outliers, and improvement opportunities, then deploy the app to Fabric.
	```

8. When GitHub Copilot displays the option to open the app in the Fabric portal, select it.

### Expected result

You should now have:

* A scaffolded Fabric Data App project running locally
* A connection to the Contoso Sales semantic model
* A first sales analytics experience for global sales managers
* A deployed app that opens in the Fabric portal
* Store-performance insights that highlight top performers, outliers, and improvement opportunities

## 4. Iterate on the Fabric app

✅ **Goal**: Refine the first app iteration by adding interactive selection, store coaching notes, and flexible Contoso themes.

### Add interactive scatter-plot selection

1. Give GitHub Copilot the following prompt:

	```text
	Make the scatter plot fully interactive. Allow selecting individual stores or multiple stores using rectangle and lasso selection, and use those selections to cross-filter the entire app. Include a Clear Selection action alongside the selection actions so users can quickly return to the unfiltered view. Keep the look and feel of the scatter plot clean and not too busy.
	```

2. Wait for GitHub Copilot to finish running the prompt, then refresh the app in the Fabric portal.
3. Test selecting one store, selecting multiple stores with rectangle and lasso selection, and clearing the selection. Confirm that each selection cross-filters the entire app and that **Clear Selection** restores the unfiltered view.

	> [!TIP]
	> This exercise demonstrates how customizable the visuals and experiences in a Fabric Data App can be, all through simple natural-language prompts.

	> [!NOTE]
	> If you encounter errors, unexpected behavior, or anything you want to change, prompt GitHub Copilot with a clear description of the undesired behavior and the result you want instead. Copilot should be able to help diagnose the issue and implement the requested changes.

### Add store coaching notes

1. Give GitHub Copilot the following prompt:

	```text
	Add in-app coaching notes for stores. Allow the ability within this app to create, view, and track notes, action items, and next steps for individual stores, with a historical log of entries. Support adding notes to multiple selected stores at once.
	```

2. Wait for GitHub Copilot to finish running the prompt, then refresh the app in the Fabric portal.
3. Confirm that the app provides options to view and add coaching notes. Test creating a note for one store and for multiple selected stores, then verify that the notes, action items, and next steps appear in the historical log.

	> [!TIP]
	> This exercise shows how easily Fabric Data Apps can support write-back scenarios, allowing users not only to view and analyze data but also to take action directly within the app.

### Apply the Contoso brand guide

1. Download the existing [Contoso design standards board](resources/img/contoso-design-standards.png). You can upload an image or PDF to GitHub Copilot by dragging the file from File Explorer into the chat pane. Alternatively, select the **+** button in the chat pane, select **Files**, and then select the downloaded Contoso design standards file.
2. Give GitHub Copilot the following prompt:

	```text
	Restyle the sales dashboard to align with the attached Contoso brand guide while preserving all functionality. Allow users to switch the app background to any color from the brand palette, with each theme automatically adjusting colors, contrast, and visuals to remain readable, cohesive, and on-brand.
	```

4. After GitHub Copilot finishes running the prompt and all approved tool calls, refresh the app in the Fabric portal and test every available brand-palette background. Confirm that text, controls, and visuals remain readable and cohesive and that the scatter-plot interactions and coaching notes still work.

	> [!TIP]
	> This exercise showcases how easily you can adjust the theme and styling of a Fabric Data App. Adding images, PDFs, or other files to the chat gives GitHub Copilot valuable visual and business context, helping it produce changes that more closely match your design requirements.

### Expected result

The refreshed Fabric Data App should include:

* Individual, rectangle, and lasso store selection that cross-filters the entire experience
* A **Clear Selection** action that restores the unfiltered view
* Coaching notes, action items, next steps, and history for one or multiple stores that can be viewed and edited all within the app
* Styling that follows the attached Contoso brand guide
* Brand-palette background options that preserve readable contrast and cohesive visuals
* All functionality from the first app iteration

## 5. Explore and customize

✅ **Goal**: Experiment with a new scenario or design change and refine the app through natural-language prompts.

One of the benefits of Fabric Apps is their flexibility and customizability. Use the remaining session time to be creative and explore what works.

### Steps

1. Browse the [Fabric Apps Gallery](https://community.fabric.microsoft.com/category/pbi_comm_galleries/discussions/pbi_fabricappsgallery) for inspiration.
2. Choose another scenario or a unique change that interests you.
3. Ask GitHub Copilot to update and deploy your Fabric App.
4. Test the change and continue to iterate

### Expected result

Your deployed app should include:

* At least one personalized change beyond the guided app iterations
* The existing Contoso Sales experience working as expected
* The final version deployed to Fabric


## ✅ Wrap-up

You've now:

* Uploaded the Contoso Sales semantic model and created a Fabric Data App
* Used GitHub Copilot and Rayfin to scaffold, run, and deploy the app
* Connected the app to semantic model data and built an analytical experience through iterative prompting
* Applied company design standards using a visual reference and natural-language prompting
* Explored how quickly Fabric Apps can be refined for different users, scenarios, and creative ideas

## Key takeaways

* Fabric Data Apps combine governed Fabric data with flexible, code-based experiences.
* Semantic model context and specific prompts help Copilot generate relevant applications.
* Reviewing, testing, and refining generated changes remains essential.

## Useful links

* [Fabric Apps Gallery | Microsoft Fabric Community](https://community.fabric.microsoft.com/category/pbi_comm_galleries/discussions/pbi_fabricappsgallery)
* [Fabric Data Apps template | Microsoft Learn](https://learn.microsoft.com/fabric/apps/data-apps-template)
* [Fabric Apps overview | Microsoft Learn](https://learn.microsoft.com/fabric/apps/overview)
* [Create a Fabric app | Microsoft Learn](https://learn.microsoft.com/fabric/apps/create-app)