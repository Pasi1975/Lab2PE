# Lab - Agentic Web Modeling with Copilot

⏱️ **Total duration:** 75-90 minutes, including environment setup

## Overview

In this lab, you inherit a semantic model from another analyst. The model works, but it contains realistic modeling issues such as unclear object names, missing descriptions, and incomplete business measures.

Using **Copilot in Power BI web modeling**, you will explore the model, identify areas for improvement, clean up its metadata, create business measures, validate your changes, and recover from an intentional mistake using semantic model version history. The entire lab is completed in the browser with no local installation required.

> **Workshop model:** All participants will use the same semantic model with sample data. The model has been intentionally prepared with realistic modeling issues so that the exercises produce visible, meaningful improvements.

> **Workspace isolation:** Each participant works in a separate Fabric workspace to prevent concurrent editing conflicts. You will create the workspace and upload the workshop model at the start of this lab.

## What you will learn

- How to create and organize a Fabric workspace for model development
- How to explore and understand an inherited semantic model
- How to analyze model structure, naming, and metadata
- How to improve model names and descriptions
- How better metadata can make a semantic model easier for people and AI experiences to understand
- How to create related business measures with Copilot
- How to review and validate AI-assisted model changes
- How to save a clean version and recover from an unwanted change using version history

## Lab structure

| # | Section | Learning goal | Duration |
| - | ------- | ------------- | -------- |
| - | [Prerequisites](#️-prerequisites) | Confirm access and understand workspace isolation | 5 min |
| 0 | [0. Prepare the environment](#0-prepare-the-environment) | Create your workspace and upload the workshop model | 10 min |
| 1 | [1. Explore the model](#1-explore-the-model) | Understand the inherited model | 10 min |
| 2 | [2. Analyze the model](#2-analyze-the-model) | Identify naming and metadata issues | 10 min |
| 3 | [3. Apply model cleanup](#3-apply-model-cleanup) | Improve approved names and descriptions | 15 min |
| 4 | [4. Validate the improvements](#4-validate-the-improvements) | Confirm the intended changes | 10 min |
| 5 | [5. Create measures in a batch](#5-create-measures-in-a-batch) | Add business calculations | 15 min |
| 6 | [6. Save a clean checkpoint](#6-save-a-clean-checkpoint) | Preserve the completed model | 5 min |
| 7 | [7. Recover with version history](#7-recover-with-version-history) | Undo an unwanted change | 5 min |

## 🛠️ Prerequisites

Before beginning the lab, confirm that you have:

* Access to the workshop's Fabric tenant with permission to create a workspace
* Access to a Copilot-supported Fabric capacity
* A Power BI Pro license
* Access to Copilot in Power BI web modeling
* A modern web browser such as Microsoft Edge, Google Chrome, or Mozilla Firefox
* The workshop PBIX file downloaded to your computer

All participants should use the workshop-provided model rather than selecting their own model. This ensures that the prompts, expected results, and validation steps remain consistent across the workshop.

## 0. Prepare the environment

✅ **Goal**: Create an isolated Fabric workspace and upload the workshop model so that you have a private copy to edit.

### Create a workspace

1. Go to [Power BI](https://app.powerbi.com) and sign in.
2. Select **Workspaces** from the navigation pane.
3. Select **New workspace**.
4. Enter a workspace name using this convention:

	```text
	PBI-Modeling-Lab-[YourInitials]-[Date]
	```

	For example: `PBI-Modeling-Lab-SP-0926`.

5. Optionally, add this description:

	```text
	Personal workspace for FabCon 2026 Agentic Web Modeling lab
	```

6. Assign the workspace to the Copilot-supported Fabric capacity identified by your instructor.
7. Select **Save** and wait for the workspace to be created.

### Upload the workshop model

1. In your new workspace, select **Upload**.
2. Select **Browse** and locate the workshop PBIX file provided by your instructor.
3. Select **Upload** and wait for the semantic model and associated report to appear.

### Verify the model

1. Select the semantic model, not the report.
2. Select **Edit semantic model**.
3. Confirm that the model opens without errors and displays its tables, columns, measures, and relationships.
4. Do not make any changes yet.

### Expected result

You should now have:

* An isolated Fabric workspace assigned to the correct capacity
* The workshop model uploaded and accessible
* Confirmation that the model opens without errors
* A private model ready for the remaining exercises

## 1. Explore the model

✅ **Goal**: Understand the purpose and structure of the inherited semantic model before making changes.

### Steps

1. Open the workshop workspace in Power BI.
2. Locate the semantic model provided by your instructor.
3. Open the model in the web modeling experience.
4. Switch to **Editing** mode.
5. Select **Copilot** from the ribbon.
6. Review and accept the permission prompt for the Copilot session.
7. Enter the following prompt:

	```text
	Analyze this semantic model and help me understand its current structure.

	1. List the tables in the model.
	2. Identify which tables appear to be fact tables and dimension tables.
	3. Summarize the business purpose of the model.
	4. Identify the existing measures that support sales and order analysis.
	5. Call out any parts of the model that may be difficult for a new report author to understand.

	Do not make any changes yet.
	```

8. Review Copilot's response and compare it with the tables, relationships, columns, and measures shown in the model.

	> **Tip:** Note anything Copilot identifies as confusing. These objects are candidates for improvement in the next exercise.

9. Select an unfamiliar table, column, or measure.
10. Ask a follow-up question to clarify its purpose:

	```text
	Explain the business purpose of [OBJECT NAME] and how it relates to the other
	objects in this model.

	Do not make any changes.
	```

	Replace `[OBJECT NAME]` with the name of the object you selected.

### Expected result

You should have a basic understanding of:

* The model's business scenario
* Its fact and dimension tables
* Its existing measures
* The parts of the model that are currently difficult to understand

## 2. Analyze the model

✅ **Goal**: Identify naming and metadata issues that make the model harder for report authors and AI experiences to understand.

### Steps

1. Enter the following prompt:

	```text
	Review the tables, columns, and measures in this semantic model using these standards:

	- Use clear English names.
	- Use spaces instead of underscores.
	- Use business-friendly wording instead of technical abbreviations.
	- Use consistent Title Case.
	- Provide concise descriptions for important tables, columns, and measures.
	- Preserve the existing business meaning of each object.

	Identify the objects that do not follow these standards and propose an improved
	name or description for each one.

	Group the recommendations by table, column, and measure. Explain the reason for
	each recommendation.

	Do not apply any changes yet.
	```

2. Review the proposed recommendations.
3. Compare each recommendation with the visible model structure.
4. Confirm that the proposed names preserve the intended business meaning.
5. Identify any recommendation that should not be applied.
6. Record the recommendations you approve and any exceptions you want Copilot to preserve.

	> **Tip:** Keep descriptions concise and place the most important business information first.

### Expected result

Copilot should identify issues such as:

* Names containing underscores
* Technical abbreviations
* Inconsistent capitalization
* Ambiguous table or column names
* Tables, columns, or measures without descriptions

## 3. Apply model cleanup

✅ **Goal**: Improve naming consistency and add useful descriptions through a controlled set of model edits.

Copilot will summarize its intended edits before applying them, giving you an opportunity to review the changes.

### Steps

1. Review the recommendations from the previous exercise.
2. Identify which recommendations you want to apply.
3. Enter the following prompt:

	```text
	Apply the approved naming recommendations from the previous review.

	Also add concise, business-friendly descriptions where descriptions are missing
	for the relevant tables, columns, and measures.

	Follow these requirements:

	- Preserve the business meaning of every object.
	- Do not change DAX expressions.
	- Do not change data types.
	- Do not create or delete relationships.
	- Do not change relationship behavior.
	- Do not delete any model objects.
	- Respect the exceptions I identified in the previous review.

	Before applying the changes, summarize the edits you intend to make.
	```

4. Review the proposed edits before applying them.
5. Confirm that the proposed changes match the approved list.
6. Apply the changes.
7. Save the semantic model using **Ctrl+S** or **File** > **Save**.
8. Inspect three to five renamed objects and generated descriptions in the properties pane.

### Expected result

The model should have:

* Clearer object names
* More consistent naming
* Business-friendly descriptions
* No unintended changes to DAX, data types, relationships, or model behavior

## 4. Validate the improvements

✅ **Goal**: Confirm that the cleanup was applied as intended without changing model behavior.

### Steps

1. Enter the following prompt:

	```text
	Review the model changes made during this session.

	1. List the objects that were renamed.
	2. List the descriptions that were added or updated.
	3. Identify any remaining objects that do not follow the naming standards.
	4. Confirm whether any DAX expressions, data types, or relationships were changed.
	5. Call out anything that still needs a manual review.

	Do not make any additional changes.
	```

2. Compare Copilot's response with the changes you approved.
3. Confirm that renamed objects use clear, consistent, business-friendly wording.
4. Inspect the descriptions added to three to five objects.
5. Open at least one existing measure and confirm that its DAX expression is unchanged.
6. Review the model relationships and confirm that no unintended relationship changes were applied.
7. Save the semantic model.

### Reflection

Consider the following questions:

* Is the model easier for a new report author to understand?
* Do the updated names communicate business meaning more clearly?
* Are the descriptions useful without being overly long?
* Did Copilot suggest anything that still required human judgment?
* Which changes would you review more carefully in a production model?

## 5. Create measures in a batch

✅ **Goal**: Use Copilot to create a related set of business measures and review the generated DAX before applying it.

### Steps

1. Review the sales, order, and date fields in the workshop model.
2. Confirm that you understand which fields should support each calculation.
3. Enter the following prompt:

	```text
	Using the appropriate columns and existing base measures in this semantic model,
	propose the following business measures:

	- Total Sales
	- Average Order Value
	- Year-over-Year Revenue Growth

	For each measure:

	- Provide the proposed DAX expression.
	- Explain the calculation in plain language.
	- Add a concise business description.
	- Recommend an appropriate format string.
	- Identify the table where the measure should be stored.

	Do not create the measures yet.
	```

4. Review the proposed DAX:
	* Confirm that **Total Sales** sums the intended sales or revenue column.
	* Confirm that **Average Order Value** divides sales by distinct orders rather than line items.
	* Confirm that **Year-over-Year Revenue Growth** uses the correct date field and comparison period.
5. Confirm that Copilot selected the intended tables and columns.
6. Pay particular attention to the date field and time-intelligence logic used for the year-over-year calculation.
7. If a recommendation uses an incorrect or ambiguous field, refine the request:

	```text
	Revise the proposed Year-over-Year Revenue Growth measure to use
	[APPROVED DATE FIELD] from [APPROVED DATE TABLE].

	Show the revised DAX before applying it.
	```

	Replace the placeholders with the approved field and table names from the workshop model.

8. Once the proposed calculations are correct, enter:

	```text
	Create the approved measures using the DAX, descriptions, format strings, and
	destination table we reviewed.

	Do not modify any existing measures.
	```

9. Review and apply the changes.
10. Save the semantic model.
11. Inspect each created measure's name, description, format string, destination table, and DAX expression.

### Expected result

The model should contain a related set of documented business measures that:

* Use the intended fields from the workshop model
* Follow the naming and description standards from the cleanup exercise
* Use DAX expressions you reviewed before creation
* Include appropriate format strings
* Are stored in the approved destination table

## 6. Save a clean checkpoint

✅ **Goal**: Preserve a known-good version of the semantic model before intentionally introducing an error.

Version history provides a safety net for experimentation. This checkpoint captures the validated cleanup and approved measures.

### Steps

1. Confirm that the approved cleanup and measures are present.
2. Confirm that the semantic model is saved.
3. Open **File** and select **Save to version history**.
4. Add the following description:

	```text
	Lab checkpoint: Validated cleanup and approved measures
	```

5. Save the version.
6. Open **File** > **View version history** and confirm that the checkpoint appears with the expected description and timestamp.

> Do not continue until you can identify the clean checkpoint. You will restore this exact version in the next exercise.

### Expected result

Version history should contain an entry named `Lab checkpoint: Validated cleanup and approved measures`.

## 7. Recover with version history

✅ **Goal**: Use semantic model version history as a safety net after making an unwanted change.

In this scenario, you will intentionally introduce a mistake and restore the clean checkpoint.

### Steps

1. Select the table identified by your instructor.
2. Note its current approved name.
3. Rename the table to:

	```text
	TEMPORARY INCORRECT TABLE NAME
	```

4. Save the semantic model.
5. Confirm that the temporary name appears in the model.
6. Open the semantic model's version history.
7. Locate the version with this description:

	```text
	Lab checkpoint: Validated cleanup and approved measures
	```

8. Select that version, choose **Restore**, and confirm the operation.
9. Reopen or refresh the semantic model if needed.
10. Confirm that the temporary table name is gone.
11. Confirm that the valid cleanup from the earlier exercises is still present.
12. Confirm that the approved measures are still present.

### Expected result

The model should return to the clean checkpoint created after the approved cleanup and measures were completed.

The temporary table name should no longer appear, while the valid work performed earlier in the lab should remain.

### Reflection

Consider the following questions:

* When would you create a manual checkpoint in a production model?
* What other unwanted changes could version history help you recover from?
* How does version history support safe experimentation and collaboration?

## ✅ Wrap-up

You've now:

* Created and organized an isolated Fabric workspace
* Explored and summarized an inherited semantic model
* Identified realistic naming and metadata issues
* Reviewed recommendations before allowing Copilot to apply changes
* Improved model names and descriptions
* Validated that the cleanup did not unintentionally alter model behavior
* Created and reviewed multiple business measures
* Saved a known-good version of the semantic model
* Recovered from an unwanted change using version history

## Key takeaways

* Copilot can accelerate model exploration and common authoring tasks, but its recommendations still require review.
* Clear names and descriptions make a semantic model easier for both people and AI-powered experiences to understand.
* Specific prompts and clear constraints help produce more controlled results.
* A standardized workshop model makes the hands-on experience more predictable.
* Version history provides a recovery path when an AI-assisted or manual change produces an unwanted result.
* The quality of the experience depends on the combination of the selected model, its starting state, and the prompts used against it.

## What's next?

Apply the same review, cleanup, and validation principles to other semantic models in your organization. You can also explore additional Copilot capabilities in Power BI web modeling and share the cleaned model with colleagues for feedback.

## Useful links

* [Copilot in Power BI web modeling](https://learn.microsoft.com/power-bi/transform-model/copilot-web-modeling)
* [Edit data models in the Power BI service](https://learn.microsoft.com/power-bi/transform-model/service-edit-data-models)
* [Use Copilot with Power BI](https://learn.microsoft.com/power-bi/create-reports/copilot-introduction)
* [Semantic model version history](https://learn.microsoft.com/power-bi/transform-model/service-semantic-model-version-history)
* [Power BI naming conventions and best practices](https://learn.microsoft.com/power-bi/guidance/powerbi-implementation-planning-structure-tier-naming-conventions)