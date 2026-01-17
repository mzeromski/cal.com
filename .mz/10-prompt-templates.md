# Ready-to-Use Prompt Templates

## 🎯 Goal
Copy-paste prompt templates for common interview scenarios. Customize the [BRACKETS] for your specific needs.

## Core Templates

### Template 1: Interview Mode Initialization

**Use at start of interview:**

```
INTERVIEW MODE ACTIVE - Cal.com Live Coding

Context:
- 60-minute technical interview at Apollo.io
- Working in Cal.com codebase
- Must narrate my thinking process out loud
- Need production-ready, maintainable code
- Strict adherence to project conventions

Your role:
1. Ask clarifying questions before implementing
2. Provide clear explanations I can narrate
3. Generate small, reviewable code chunks
4. Follow AGENTS.md rules strictly
5. Point out edge cases I might miss
6. Help me avoid common pitfalls

My workflow:
- I describe requirements
- You ask clarifying questions
- I answer and approve approach
- You generate code incrementally
- I review, test, and narrate
- We iterate

References:
- AGENTS.md for all conventions
- Existing code for patterns
- packages/prisma/schema.prisma for data models

First task: [DESCRIBE YOUR FIRST TASK]
```

---

## Feature Development Templates

### Template 2: Add Form Field

```
Task: Add [FIELD_NAME] field to [FORM_NAME]

Context:
- Form location: [FILE_PATH]
- Form uses: React Hook Form + Zod validation
- Database model: [MODEL_NAME] in packages/prisma/schema.prisma
- Similar field for reference: [EXISTING_FIELD]

Requirements:
□ Add field to Prisma schema if needed
□ Update Zod validation schema
□ Add form input component
□ Add translation key to common.json
□ Handle validation errors
□ [Optional: Mark as required/optional]

Validation rules:
- [RULE_1]
- [RULE_2]
- [RULE_3]

Before implementing:
1. Check if database field exists
2. Ask me about any unclear requirements
3. Confirm validation rules

Then show me each change separately:
1. Schema change (if needed)
2. Zod validation
3. Form field component
4. Translation string
```

### Template 3: Create New Component

```
Task: Create [COMPONENT_NAME] component

Purpose: [WHAT_IT_DOES]

Location: [DIRECTORY_PATH]

Similar component: [REFERENCE_COMPONENT] (follow this pattern)

Requirements:
□ TypeScript interface for props
□ Direct imports (no barrel imports)
□ Loading state handling
□ Error state handling
□ Empty state handling
□ Responsive design (Tailwind)
□ Accessibility considerations
□ Translation strings for all text

Props needed:
- [PROP_1]: [TYPE] - [DESCRIPTION]
- [PROP_2]: [TYPE] - [DESCRIPTION]

Data fetching (if applicable):
- tRPC endpoint: [ENDPOINT]
- Query/Mutation: [QUERY_OR_MUTATION]

UI requirements:
- [REQUIREMENT_1]
- [REQUIREMENT_2]

Before generating:
1. Ask about any unclear requirements
2. Confirm the component structure
3. Show me the props interface first

Then generate incrementally:
1. Props interface + imports
2. Component shell + states
3. Main render logic
4. Event handlers
```

### Template 4: Add API Endpoint (tRPC)

```
Task: Create [ENDPOINT_NAME] tRPC endpoint

Purpose: [WHAT_IT_DOES]

Router location: packages/trpc/server/routers/viewer/[ROUTER_NAME]/

Input:
- [FIELD_1]: [TYPE] - [VALIDATION]
- [FIELD_2]: [TYPE] - [VALIDATION]

Output:
- [FIELD_1]: [TYPE]
- [FIELD_2]: [TYPE]

Business logic:
1. [STEP_1]
2. [STEP_2]
3. [STEP_3]

Validation:
- [RULE_1]
- [RULE_2]

Error cases to handle:
- [ERROR_CASE_1]: return [ERROR_TYPE]
- [ERROR_CASE_2]: return [ERROR_TYPE]

Security:
- [ ] Authentication required? [YES/NO]
- [ ] Authorization check needed? [DESCRIBE]
- [ ] Sensitive data? [HOW_TO_HANDLE]

Reference similar endpoint: [EXISTING_ENDPOINT]

Generate in this order:
1. Input schema (Zod) - [ROUTER_NAME]/[ENDPOINT].schema.ts
2. Handler function - [ROUTER_NAME]/[ENDPOINT].handler.ts
3. Router wiring - [ROUTER_NAME]/_router.ts

Show me each file separately.
```

### Template 5: Add Database Field

```
Task: Add [FIELD_NAME] to [MODEL_NAME] model

Field details:
- Type: [POSTGRES_TYPE]
- Required: [YES/NO]
- Default: [DEFAULT_VALUE or NONE]
- Unique: [YES/NO]
- Indexed: [YES/NO]
- Relation: [RELATION_DETAILS or NONE]

Migration plan:
1. Update schema.prisma
2. Run: yarn prisma generate
3. Update relevant types
4. Update queries using this model
5. Test changes

Before implementing:
1. Show me the schema change
2. Confirm it doesn't break existing queries
3. List all files that need updates

After schema change:
1. Remind me to run prisma generate
2. Show me which queries need updating
3. Help me update each query
```

---

## Code Quality Templates

### Template 6: Code Review Request

```
Review the code you just generated against these criteria:

1. TYPE SAFETY
   □ No 'any' types used
   □ All function parameters typed
   □ All function returns typed
   □ Proper use of 'import type'
   □ No unsafe type assertions

2. IMPORTS
   □ Direct imports, not barrel imports
   □ Correct package paths
   □ Type imports use 'import type'
   □ No unused imports

3. ERROR HANDLING
   □ All error cases covered
   □ Proper error types (TRPCError in tRPC, ErrorWithCode elsewhere)
   □ User-friendly error messages
   □ No silent failures

4. EDGE CASES
   □ Null/undefined handled
   □ Empty arrays/objects handled
   □ Invalid input handled
   □ Boundary values handled

5. CONVENTIONS (AGENTS.md)
   □ Using 'select' not 'include' in Prisma
   □ Early returns instead of deep nesting
   □ No secrets or API keys
   □ Translation keys added for UI strings

6. SECURITY
   □ No exposed credentials
   □ No exposed credential.key field
   □ Authentication checks present
   □ Input validated/sanitized

List any issues found with specific line numbers.
Then provide corrected version.
```

### Template 7: Refactor Request

```
Refactor [FILE_PATH or FUNCTION_NAME]

Current issues:
- [ISSUE_1]
- [ISSUE_2]
- [ISSUE_3]

Goals:
- [GOAL_1]
- [GOAL_2]

Constraints:
- Don't change public API/interface
- Maintain current functionality
- Keep tests passing
- Follow project conventions

Before refactoring:
1. Explain current problems
2. Propose refactoring approach
3. Show what will change
4. Wait for my approval

Then refactor incrementally:
1. [STEP_1]
2. [STEP_2]
3. [STEP_3]

After each step, I'll test before continuing.
```

### Template 8: Add Error Handling

```
Add comprehensive error handling to [FUNCTION/COMPONENT]

Current code: [FILE_PATH:LINES]

Error scenarios to handle:
1. [SCENARIO_1] → [HOW_TO_HANDLE]
2. [SCENARIO_2] → [HOW_TO_HANDLE]
3. [SCENARIO_3] → [HOW_TO_HANDLE]

Error UI requirements:
- Show user-friendly messages
- Use translation keys
- Provide retry mechanism (if applicable)
- Log errors for debugging

Error types:
- Use TRPCError for tRPC procedures
- Use ErrorWithCode for other code
- Use proper error codes

Show me:
1. Try-catch blocks to add
2. Error state handling
3. User-facing error messages
4. Logging strategy
```

---

## Debugging Templates

### Template 9: Debug Error

```
DEBUG MODE

Error: [PASTE_ERROR_MESSAGE]

Context:
- File: [FILE_PATH]
- Function/Component: [NAME]
- What I was trying to do: [DESCRIPTION]
- What happened instead: [DESCRIPTION]

Relevant code:
[PASTE_CODE_SNIPPET]

Help me debug by:
1. Asking clarifying questions about the error
2. Explaining likely causes
3. Suggesting debugging steps (logs, breakpoints)
4. Proposing specific fixes

Don't immediately rewrite the code.
Help me understand the problem first.
```

### Template 10: Investigate Issue

```
INVESTIGATION MODE

Issue: [DESCRIBE_PROBLEM]

What I've tried:
- [ATTEMPT_1] - [RESULT]
- [ATTEMPT_2] - [RESULT]

What I know:
- [FACT_1]
- [FACT_2]

What I don't know:
- [QUESTION_1]
- [QUESTION_2]

Help me investigate by:
1. Suggesting what to check next
2. Explaining possible causes
3. Recommending debugging approach
4. Pointing me to relevant code/docs

Let's work through this systematically.
```

---

## Planning Templates

### Template 11: Feature Planning

```
PLANNING MODE - Don't generate code yet

Feature: [FEATURE_NAME]

Requirements:
- [REQUIREMENT_1]
- [REQUIREMENT_2]
- [REQUIREMENT_3]

Constraints:
- [CONSTRAINT_1]
- [CONSTRAINT_2]

Before implementing, help me plan by:

1. CLARIFYING QUESTIONS
   Ask me 5-7 questions about:
   - Unclear requirements
   - Edge cases
   - Technical decisions
   - Approach preferences

2. APPROACH OPTIONS
   Suggest 2-3 different approaches:
   - Approach A: [DESCRIPTION]
     Pros: [LIST]
     Cons: [LIST]
   - Approach B: [DESCRIPTION]
     Pros: [LIST]
     Cons: [LIST]

3. RECOMMENDED APPROACH
   Recommend one with reasoning

4. IMPLEMENTATION STEPS
   Break down into 7-10 small steps
   Estimate risk level for each (low/medium/high)

Wait for my approval before generating any code.
```

### Template 12: Technical Decision

```
DECISION POINT

I need to decide: [DECISION]

Options:
A. [OPTION_A]
B. [OPTION_B]
C. [OPTION_C]

For each option, provide:
1. How it would work
2. Implementation complexity
3. Pros
4. Cons
5. Impact on codebase
6. Performance implications
7. Maintainability

Then recommend which option and why.

I'll make the final decision and we'll proceed.
```

---

## Control Templates

### Template 13: Incremental Build

```
INCREMENTAL MODE

Feature: [FEATURE_NAME]

Break this into 5-8 small, testable units.

For each unit:
1. Name the unit
2. Describe what it does (1 sentence)
3. List files affected
4. Estimate lines of code (rough)

Then we'll build one unit at a time:
- You generate unit N
- I review (30-60 seconds)
- I test
- I approve or request changes
- Then move to unit N+1

List all units first.
Then start with Unit 1 only.
```

### Template 14: Stop and Pivot

```
STOP - DIRECTION CHANGE

What we were doing: [PREVIOUS_APPROACH]

Why it's not working: [REASON]

New direction: [NEW_APPROACH]

Forget previous instructions about [SPECIFIC_THING].

New plan:
1. [STEP_1]
2. [STEP_2]
3. [STEP_3]

Start fresh with step 1.
```

### Template 15: Checkpoint Review

```
CHECKPOINT - Let's review progress

Completed:
- [COMPLETED_1]
- [COMPLETED_2]

Current task:
- [CURRENT_TASK]
- Status: [IN_PROGRESS/BLOCKED/ALMOST_DONE]

Remaining time: [X] minutes

Before continuing:
1. Review current code for issues
2. List any edge cases not covered
3. Suggest what to prioritize with remaining time
4. Flag anything that needs refactoring

Then I'll decide next steps.
```

---

## Interview-Specific Templates

### Template 16: Time Pressure Mode

```
TIME CHECK: [X] minutes remaining

PRIORITY MODE ACTIVE

Current task: [TASK]

Simplification strategy:
- Focus on: [CORE_FEATURES]
- Simplify: [NICE_TO_HAVES]
- Skip: [NON_ESSENTIALS]

Questions:
1. What's the fastest path to get [TASK] working?
2. What can I skip without compromising quality?
3. What's the minimum viable implementation?
4. Any shortcuts I can take safely?

Generate implementation focused on core functionality only.
```

### Template 17: Demo Prep

```
DEMO PREPARATION

I've completed: [FEATURE]

Help me prepare to demonstrate it:

1. Test cases to show:
   - Happy path: [SCENARIO]
   - Edge case: [SCENARIO]
   - Error handling: [SCENARIO]

2. Talking points:
   - Key decisions made
   - Trade-offs considered
   - Conventions followed
   - Potential improvements

3. Questions interviewer might ask:
   - List 5-7 likely questions
   - Suggest how to answer each

4. Code highlights:
   - Best parts to walk through
   - Interesting technical details

Prepare me for a strong demo and discussion.
```

### Template 18: Explanation Helper

```
EXPLANATION MODE

I need to explain [CODE/FEATURE] to the interviewer.

Code: [FILE_PATH or CODE_SNIPPET]

Help me explain by providing:

1. High-level summary (2-3 sentences)
   What it does and why

2. Key components (bullet points)
   Main parts and their roles

3. Technical decisions (2-3 key ones)
   What I chose and why

4. Trade-offs (2-3)
   What I gave up to gain what

5. Potential improvements
   What I'd add with more time

Keep explanations clear and concise.
I need to sound confident and knowledgeable.
```

---

## Quick Action Templates

### Template 19: Fast Fix

```
QUICK FIX NEEDED

Problem: [ONE_SENTENCE]

Location: [FILE:LINE]

Expected behavior: [WHAT_SHOULD_HAPPEN]

Actual behavior: [WHAT_IS_HAPPENING]

Show me:
1. Exact line(s) to change
2. What to change them to
3. Why this fixes it (1 sentence)

Fast, focused fix only.
```

### Template 20: Pattern Application

```
APPLY PATTERN

Pattern to copy: [FILE:LINES]

Apply to: [NEW_LOCATION/FEATURE]

Changes needed:
- Replace [X] with [Y]
- Replace [A] with [B]
- Adjust [C] for context

Follow the pattern EXACTLY except for these changes.

Show me the applied code.
```

---

## Custom Templates for Common Cal.com Tasks

### Template 21: Add Booking Field

```
Add [FIELD_NAME] field to Booking model

Field type: [STRING/NUMBER/DATE/BOOLEAN/OTHER]
Required: [YES/NO]
Validation: [RULES]

Files to update:
1. packages/prisma/schema.prisma
2. packages/trpc/server/routers/viewer/bookings/create.schema.ts
3. packages/trpc/server/routers/viewer/bookings/create.handler.ts
4. apps/web/modules/bookings/BookingForm.tsx
5. apps/web/public/static/locales/en/common.json

Generate changes for each file separately.
After each, I'll review before continuing.

Start with the Prisma schema change.
```

### Template 22: Add Event Type Feature

```
Add [FEATURE] to Event Types

Context:
- Event type files: apps/web/modules/event-types/
- Event type model: packages/prisma/schema.prisma (EventType model)
- tRPC router: packages/trpc/server/routers/viewer/eventTypes/

Requirements:
- [REQUIREMENT_1]
- [REQUIREMENT_2]

Reference similar feature: [EXISTING_FEATURE]

Plan the implementation:
1. List all files that need changes
2. Break down into steps
3. Show me step 1 only

Then we'll implement step by step.
```

### Template 23: Add UI Component to Dashboard

```
Add [COMPONENT] to Cal.com dashboard

Location: apps/web/modules/[MODULE]/

Component purpose: [DESCRIPTION]

Data needed:
- Fetch from: [tRPC_ENDPOINT]
- Display: [DATA_POINTS]

UI requirements:
- Responsive (mobile, tablet, desktop)
- Loading state: [DESCRIPTION]
- Empty state: [DESCRIPTION]
- Error state: [DESCRIPTION]

Visual style:
- Follow existing dashboard cards pattern
- Use components from @calcom/ui/components/
- Tailwind classes for styling

Generate:
1. Component structure first
2. Then data fetching
3. Then UI implementation

Start with structure only.
```

---

## Meta Templates

### Template 24: Improve My Prompt

```
I'm about to ask you to [TASK].

Here's my draft prompt:
[PASTE_YOUR_PROMPT]

Before I use it, help me improve it by:
1. Pointing out what's unclear
2. Suggesting what context to add
3. Identifying missing constraints
4. Recommending better structure

Then show me an improved version.
```

### Template 25: Custom Template Creator

```
Help me create a reusable prompt template for [COMMON_TASK].

This task involves:
- [STEP_1]
- [STEP_2]
- [STEP_3]

Typical variations:
- [VARIATION_1]
- [VARIATION_2]

Create a template with:
- [PLACEHOLDERS] for customization
- Clear structure
- All necessary context
- Quality checkpoints

Format it so I can copy-paste and fill in the [BRACKETS].
```

---

## Usage Tips

### How to Use These Templates

1. **Copy the entire template**
2. **Replace [BRACKETS] with your specifics**
3. **Remove sections that don't apply**
4. **Add any additional context**
5. **Paste into Cursor chat**

### Customization Tips

- Keep templates in a text file for quick access
- Create your own variations
- Combine templates as needed
- Adjust verbosity to your preference

### Practice Before Interview

Try each template with sample tasks:
- Add a field to booking form
- Create a statistics widget
- Debug a TypeScript error
- Refactor a component

Get comfortable with the flow.

---

**Quick Template Index:**

- **#1-5**: Feature Development
- **#6-8**: Code Quality
- **#9-10**: Debugging
- **#11-12**: Planning
- **#13-15**: Control
- **#16-18**: Interview-Specific
- **#19-20**: Quick Actions
- **#21-23**: Cal.com-Specific
- **#24-25**: Meta Templates

**Save this file for quick reference during the interview!**
