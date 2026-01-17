# Cursor Prompting Mastery

## 🎯 Goal
Master Cursor-specific prompting techniques to maximize AI effectiveness while maintaining control during the interview.

## Understanding Cursor's Capabilities

### What Cursor Can Do
- ✅ Read multiple files simultaneously
- ✅ Search across codebase
- ✅ Understand project context
- ✅ Generate, edit, and refactor code
- ✅ Explain code and answer questions
- ✅ Debug issues
- ✅ Follow instructions incrementally

### What Cursor Needs from You
- 🎯 Clear, specific instructions
- 📂 Context about which files are relevant
- 🔍 Guidance on project conventions
- 🎨 Examples of desired patterns
- ✋ Feedback on generated code

## The Perfect Prompt Structure

### Template: The 5-Part Prompt

```
[1. CONTEXT]
In this Cal.com codebase, working on [area/feature]...

[2. CURRENT STATE]
Currently, [describe what exists now]...

[3. GOAL]
I need to [specific action/outcome]...

[4. CONSTRAINTS]
Must follow:
- [Convention 1]
- [Convention 2]
- [Constraint 3]

[5. SPECIFIC REQUEST]
[Action]: [Generate/Explain/Refactor/Debug] [what exactly]
```

### Example: Basic Prompt

❌ **Bad:**
```
Add a phone field
```

✅ **Good:**
```
[CONTEXT]
In Cal.com's booking form (apps/web/modules/bookings/BookingForm.tsx),
which uses React Hook Form + Zod for validation.

[CURRENT STATE]
The form currently has name and email fields.

[GOAL]
I need to add a phone number field that's optional but validates format if provided.

[CONSTRAINTS]
- Use PhoneInput component from @calcom/ui/components/phone-input
- Add Zod validation for international phone format
- Follow the pattern used for the email field
- Add translation key to common.json

[REQUEST]
Show me:
1. The Zod schema update
2. The form field addition
3. The translation string needed
```

## Advanced Prompting Techniques

### Technique 1: Reference Existing Code

**Pattern:**
```
"Follow the exact pattern from [file:line-line]"
```

**Example:**
```
In apps/web/modules/event-types/EventTypeForm.tsx (lines 45-68),
there's a pattern for adding a form field with validation.

Follow that exact pattern to add a "notes" field to the booking form,
including:
- useForm registration
- Zod validation
- Error message display
- Translation key
```

**Why it works:**
- Gives AI concrete example
- Ensures consistency
- Reduces hallucination
- Matches project style

### Technique 2: Constrain Output

**Pattern:**
```
"Only show me [specific part], don't change [other parts]"
```

**Example:**
```
I need to add error handling to this function.

ONLY show me the error handling code to add.
DON'T regenerate the entire function.
DON'T modify the existing logic.

Specifically, add:
- Try-catch block
- TRPCError for different error types
- Proper error messages
```

**Why it works:**
- Prevents unnecessary changes
- Easier to review small diffs
- Maintains context of rest of code
- Faster iteration

### Technique 3: Ask for Multiple Options

**Pattern:**
```
"Show me 2-3 approaches to [problem], with pros/cons"
```

**Example:**
```
I need to add caching for booking data.

Show me 3 different approaches:
1. React Query cache configuration
2. Server-side caching with Redis
3. Local state management with Jotai

For each approach, explain:
- Implementation steps
- Pros and cons
- Complexity level
- Best use case

Then recommend which is best for this context.
```

**Why it works:**
- Explores solution space
- Helps you make informed decisions
- Shows trade-offs
- Interviewer sees your thinking

### Technique 4: Incremental Building

**Pattern:**
```
"First [step 1], then I'll ask for [step 2]"
```

**Example:**
```
I'm building a statistics dashboard.

FIRST: Just create the basic component structure with:
- Empty component shell
- Props interface
- Loading state

DON'T add:
- Data fetching yet
- UI components yet
- Styling yet

I'll add those in the next steps after reviewing the structure.
```

**Why it works:**
- Easier to review small pieces
- Catch issues early
- Build confidence incrementally
- More control over direction

### Technique 5: Use the Codebase Context

**Pattern:**
```
"Given the files @[filename], how should I..."
```

**Example:**
```
Given these files:
@apps/web/modules/bookings/BookingsList.tsx
@packages/trpc/server/routers/viewer/bookings/list.handler.ts

How should I add filtering by status (pending/confirmed/cancelled)?

Show me:
1. Backend changes needed
2. Frontend changes needed
3. How they connect via tRPC
```

**Why it works:**
- AI sees actual code
- Better suggestions
- Maintains consistency
- Fewer errors

## Making AI Ask Questions (Interactive Mode)

### Strategy 1: Ask for Clarification

**Prompt:**
```
I need to add [feature].

Before implementing, ask me clarifying questions about:
- Requirements
- Edge cases
- UI/UX decisions
- Data structure

Then wait for my answers before generating code.
```

**Example:**
```
I need to add a "favorite bookings" feature.

Before implementing, ask me:
1. Where should the favorite button appear?
2. Should it persist to database or local storage?
3. Can users have unlimited favorites?
4. What happens when they click a favorite?
5. Any permissions needed?

Ask these questions one by one, and I'll answer before you proceed.
```

### Strategy 2: Request a Plan First

**Prompt:**
```
Don't write code yet.

Instead:
1. Ask me questions about requirements
2. Propose 2-3 approaches
3. Break down implementation steps
4. Wait for my approval

Only then generate code.
```

**Example:**
```
I need to improve the booking form's performance.

DON'T write code yet.

Instead:
1. Ask me what performance issues I'm seeing
2. Propose potential optimizations
3. Explain trade-offs for each
4. Get my approval on approach

Then we'll implement step by step.
```

### Strategy 3: Step-by-Step Confirmation

**Prompt:**
```
Let's work incrementally.

For each step:
1. Show me what you plan to do
2. Wait for my "yes" or feedback
3. Then implement that step only
4. Repeat

Steps needed: [list steps]
```

**Example:**
```
Let's add a phone field to the booking form incrementally.

Steps:
1. Update Prisma schema - WAIT for approval
2. Update Zod validation - WAIT for approval
3. Add form field - WAIT for approval
4. Add translations - WAIT for approval
5. Test - WAIT for approval

Start with step 1: show me the schema change only.
```

## Changing Direction Mid-Task

### Pattern 1: Stop and Pivot

**Prompt:**
```
STOP what you're doing.

I want to change direction because [reason].

Instead, let's [new approach].

Forget previous instructions about [X].
```

**Example:**
```
STOP - I realize this tRPC approach is too complex.

Instead, let's use a simpler API route.

Forget the tRPC router we were building.

Show me:
1. A Next.js API route approach
2. How to call it from the frontend
3. Pros/cons vs tRPC
```

### Pattern 2: Course Correction

**Prompt:**
```
The approach is right, but adjust:
- [Change 1]
- [Change 2]

Keep everything else the same.
```

**Example:**
```
The component structure is good, but adjust:
- Use Dialog instead of Modal
- Fetch data in parent, pass as props
- Remove internal state management

Keep:
- The form validation
- Error handling
- Button layout
```

### Pattern 3: Rollback

**Prompt:**
```
This isn't working. Let's go back to [previous state].

What we tried: [description]
Why it didn't work: [reason]
What to try instead: [new approach]
```

**Example:**
```
This client-side filtering isn't performant enough.

What we tried: Filtering 1000+ items in React
Why it failed: UI freezes, bad UX
What instead: Move filtering to tRPC backend with pagination

Show me how to implement server-side filtering.
```

## Risk Reduction Strategies

### Strategy 1: Review Before Applying

**Workflow:**
```
1. Ask AI to generate code
2. READ THE CODE COMPLETELY
3. Check:
   □ TypeScript types correct?
   □ Imports correct?
   □ Follows conventions?
   □ Edge cases handled?
   □ No security issues?
4. Only then apply
5. If issues, ask AI to fix specific problems
```

**Prompt for fixes:**
```
This code has issues:
1. [Specific issue 1]
2. [Specific issue 2]

Fix ONLY these issues, don't change anything else.
```

### Strategy 2: Small, Testable Changes

**Principle:**
Make one small change → Test → Next change

**Prompt pattern:**
```
Make the smallest possible change to [achieve X].

Only modify [specific file/function].
Don't touch [other parts].

I'll test it before asking for the next change.
```

**Example:**
```
Add a single console.log to debug the booking creation flow.

Only add it in the tRPC create handler.
Don't modify any logic.
Show me exactly where to add it.

I'll test and see what it logs, then ask for next debug step.
```

### Strategy 3: Defensive Prompting

**Pattern:**
```
Generate [code], but:
- ❌ DON'T use 'any' types
- ❌ DON'T skip error handling
- ❌ DON'T ignore null/undefined cases
- ✅ DO add TypeScript types for everything
- ✅ DO handle errors explicitly
- ✅ DO validate input
```

**Example:**
```
Create a function to fetch booking by ID.

Requirements:
✅ Use proper TypeScript types (no 'any')
✅ Handle case where booking doesn't exist
✅ Handle database errors
✅ Validate ID is a positive number
✅ Use select in Prisma query (not include)
❌ Don't expose sensitive user data
❌ Don't skip permission checks
```

### Strategy 4: Checkpoint Saves

**Workflow:**
```
1. After each working state, commit:
   git add .
   git commit -m "checkpoint: [what works]"

2. If AI breaks something:
   git diff  # See what changed
   git reset --hard  # Revert if needed

3. Continue from last working state
```

## Quality Control Techniques

### Technique 1: Explicit Quality Checks

**Prompt:**
```
After generating code, review it for:
1. Type safety (no 'any', proper types)
2. Error handling (all error cases covered)
3. Edge cases (null, undefined, empty, invalid)
4. Security (no exposed credentials/sensitive data)
5. Performance (no obvious bottlenecks)
6. Conventions (matches AGENTS.md rules)

List any issues found, then provide fixed version.
```

### Technique 2: Comparison with Existing Code

**Prompt:**
```
Compare the code you generated with [existing similar file].

Does it match:
- Import style?
- Component structure?
- Error handling patterns?
- Naming conventions?
- TypeScript usage?

If not, adjust to match.
```

### Technique 3: Explain Your Code

**Prompt:**
```
After generating code, explain:
1. What does each part do?
2. Why did you make these choices?
3. What edge cases does it handle?
4. What could go wrong?
5. What would you improve given more time?
```

**Why this works:**
- Helps you understand the code
- Catches AI misunderstandings
- Reveals gaps in logic
- Good practice for explaining to interviewer

## Custom Cursor Commands (Shortcuts)

### Create .cursorrules file

Create `.cursorrules` in project root:

```yaml
# Cal.com Interview Mode
interview_mode: true

rules:
  - Always use 'import type' for type imports
  - Use select, never include, in Prisma queries
  - Import from source paths, not barrel files
  - Add translations for all UI strings
  - Use TRPCError in tRPC, ErrorWithCode elsewhere
  - Handle loading and error states
  - Validate all inputs
  - Ask clarifying questions before implementing

workflows:
  plan_first:
    description: "Plan implementation before coding"
    steps:
      - Ask clarifying questions
      - Propose approach
      - Break into steps
      - Wait for approval
  
  incremental:
    description: "Build incrementally with checkpoints"
    steps:
      - Smallest possible change
      - Review
      - Test
      - Checkpoint commit
      - Next change
  
  review_code:
    description: "Review generated code"
    checks:
      - TypeScript types (no any)
      - Imports (direct paths)
      - Error handling
      - Edge cases
      - Conventions (AGENTS.md)
      - Security
```

### Quick Command Prompts

Save these as text snippets for quick use:

#### Command: Plan First
```
MODE: Plan First

Don't generate code yet.

1. Ask me clarifying questions about:
   - Requirements
   - Edge cases
   - Constraints
   - Approach preferences

2. Propose 2-3 approaches with pros/cons

3. Break down into steps

4. Wait for my approval

Then we'll implement step by step.

Current task: [DESCRIBE TASK HERE]
```

#### Command: Review Generated Code
```
MODE: Code Review

Review the code you just generated:

1. Type Safety:
   - Any 'any' types? → Fix
   - Missing type definitions? → Add
   - Unsafe type assertions? → Fix

2. Imports:
   - Using barrel imports? → Use direct paths
   - Missing 'import type'? → Add
   - Correct package paths? → Verify

3. Error Handling:
   - All error cases covered? → Check
   - Proper error types (TRPCError/ErrorWithCode)? → Verify
   - User-friendly error messages? → Check

4. Edge Cases:
   - Null/undefined handled? → Check
   - Empty arrays/objects? → Check
   - Invalid input? → Check

5. Conventions:
   - Matches AGENTS.md rules? → Verify
   - Follows existing patterns? → Check
   - Translations added? → Verify

List issues found, then provide corrected version.
```

#### Command: Incremental Build
```
MODE: Incremental Build

Build this feature in small, testable steps.

For each step:
1. Show me the code for ONLY that step
2. Explain what it does
3. Wait for my "continue" or feedback
4. Then move to next step

Steps for [FEATURE]:
1. [Step 1] - WAIT
2. [Step 2] - WAIT
3. [Step 3] - WAIT
4. [Step 4] - WAIT

Start with step 1 only.
```

#### Command: Explain and Implement
```
MODE: Explain and Implement

Before implementing [TASK]:

1. Explain what needs to happen:
   - Files to modify
   - Changes required
   - Potential issues

2. Show me pseudocode/outline

3. Ask if approach is correct

4. Only then generate actual code

Current task: [DESCRIBE TASK]
```

#### Command: Debug Help
```
MODE: Debug

I'm seeing [ERROR/ISSUE].

Help me debug by:
1. Asking clarifying questions about the error
2. Identifying likely causes
3. Suggesting debugging steps (console.log, breakpoints, etc)
4. Proposing fixes

Don't immediately rewrite code - help me understand the problem first.

Error: [PASTE ERROR HERE]
Code: [PASTE RELEVANT CODE]
```

## Interview-Specific Prompting

### Opening Prompt (Start of Interview)

```
Interview Context:
- I'm in a 60-minute live coding interview
- Building features in Cal.com codebase
- Need to narrate my thinking out loud
- Want high-quality, production-ready code
- Must follow project conventions strictly

Interview Mode Rules:
1. Ask clarifying questions before implementing
2. Explain your suggestions so I can narrate them
3. Generate small, reviewable code chunks
4. Follow AGENTS.md rules strictly
5. Point out if I'm missing edge cases
6. Help me avoid common pitfalls

My approach:
- I'll describe requirements
- You ask questions
- I approve approach
- You generate code incrementally
- I review and test
- We iterate

Ready? First task: [DESCRIBE TASK]
```

### Mid-Interview Checkpoint

```
Checkpoint - Let's pause and review:

What's working:
- [List completed features]

What's in progress:
- [Current task]

Remaining time: [X] minutes

Next priority:
- [What to focus on]

Quick review:
1. Any issues with current code?
2. Any edge cases I'm missing?
3. Anything I should refactor?
4. What's the best use of remaining time?
```

### Time Pressure Prompt

```
Time Check: [X] minutes remaining

Priority mode:
- Focus on core functionality
- Simplify where possible
- Skip nice-to-haves
- Ensure what works is solid

Current task: [TASK]

What's the fastest path to get this working?
What can I skip without compromising quality?
```

## Advanced Control Patterns

### Pattern: Guided Generation

```
Generate code following this exact structure:

```
// Step 1: Imports (show me these first)
// [AI generates imports]

// Step 2: Types (show me these second)
// [AI generates types]

// Step 3: Component/Function (show me this third)
// [AI generates main code]

// Step 4: Exports (show me these last)
// [AI generates exports]
```

Generate each step separately, waiting for my approval.
```

### Pattern: Diff-Style Changes

```
Show me only the code that needs to CHANGE, using diff format:

- (lines to remove)
+ (lines to add)

Don't show unchanged code.
Make it easy to see exactly what's different.
```

### Pattern: Multiple File Changes

```
I need changes across multiple files.

For each file:
1. State the filename
2. Explain what changes and why
3. Show the specific changes
4. Wait for confirmation
5. Move to next file

Files to modify:
- [File 1]
- [File 2]
- [File 3]

Start with File 1.
```

## Common Interview Prompts

### "Add a Field to Form"

```
Task: Add [field name] field to [form name]

Context:
- Form uses React Hook Form + Zod
- Located in: [file path]
- Follow pattern from [existing field]

Requirements:
1. Update Zod schema with validation
2. Add form field with proper component
3. Add translation key
4. Handle loading/error states
5. Update types if needed

Show me each change separately.
```

### "Create New Component"

```
Task: Create [component name] that [purpose]

Context:
- Lives in: [directory]
- Similar to: [existing component]
- Uses: [specific libraries/patterns]

Requirements:
1. TypeScript interface for props
2. Proper imports (direct paths)
3. Loading/error states
4. Responsive design (Tailwind)
5. Follows Cal.com component patterns

Start by showing me the component structure (no implementation yet).
```

### "Debug Issue"

```
Task: Fix [issue description]

Current behavior: [what's happening]
Expected behavior: [what should happen]
Error (if any): [error message]
Relevant code: [file/function]

Help me:
1. Understand why this is happening
2. Identify the root cause
3. Propose a fix
4. Consider if fix affects other parts

Walk me through the debugging process.
```

---

## Quick Reference Card

**Print this or keep it visible during interview:**

```
┌─────────────────────────────────────────────────┐
│         CURSOR INTERVIEW PROMPTING              │
├─────────────────────────────────────────────────┤
│ START: "Interview mode - ask questions first"  │
│                                                 │
│ BUILD: "Incremental - show step 1 only"        │
│                                                 │
│ REVIEW: "Check types, imports, errors, edges"  │
│                                                 │
│ CHANGE: "STOP - new direction: [approach]"     │
│                                                 │
│ DEBUG: "Help me understand error: [error]"     │
│                                                 │
│ EXPLAIN: "Walk me through what this does"      │
└─────────────────────────────────────────────────┘
```

**Next:** Practice these techniques with actual coding tasks before the interview!
