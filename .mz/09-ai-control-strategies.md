# AI Control Strategies

## 🎯 Goal
Maintain complete control over AI during the interview while maximizing its benefits and minimizing risks.

## The Control Paradox

**The Challenge:**
- AI can generate code faster than you can review it
- Easy to accept suggestions without understanding
- Interviewer evaluates YOUR judgment, not AI's
- You're responsible for all code quality

**The Solution:**
- Use AI as a tool, not a crutch
- Review everything critically
- Maintain veto power
- Demonstrate engineering judgment

## The 3-Level Control System

### Level 1: STRATEGIC Control (What to Build)

**YOU decide:**
- ✅ Overall approach
- ✅ Architecture decisions
- ✅ Trade-offs to make
- ✅ When to stop/pivot

**AI helps:**
- 💡 Suggest options
- 💡 Explain trade-offs
- 💡 Provide context

**Example:**
```
You: "I need to add caching. Show me 3 approaches with pros/cons."
AI: [Suggests React Query, Redis, Jotai]
You: "I'll use React Query because [reasoning]" ← YOU DECIDE
AI: [Helps implement your choice]
```

### Level 2: TACTICAL Control (How to Build)

**YOU decide:**
- ✅ Which files to modify
- ✅ Code structure
- ✅ Validation rules
- ✅ Error handling approach

**AI helps:**
- 💡 Generate boilerplate
- 💡 Suggest patterns
- 💡 Find similar code

**Example:**
```
You: "Generate form validation, but use these specific rules: [rules]"
AI: [Generates code]
You: [Reviews] "Change rule 3, keep rest" ← YOU CONTROL
AI: [Makes specific change]
```

### Level 3: TECHNICAL Control (Code Quality)

**YOU decide:**
- ✅ Type safety acceptable
- ✅ Edge cases covered
- ✅ Conventions followed
- ✅ Whether to accept/reject code

**AI helps:**
- 💡 Generate code quickly
- 💡 Follow patterns
- 💡 Handle repetitive tasks

**Example:**
```
You: [Reviews generated code]
You: "This has 'any' types and missing null checks" ← YOU REVIEW
AI: [Fixes specific issues]
You: "Now it's acceptable" ← YOU APPROVE
```

## The Review Workflow

### Step 1: Generate (AI works)

**Good prompt:**
```
Generate [specific thing] following [pattern].

Show me only the code, no explanations yet.
I'll review first.
```

### Step 2: Review (YOU work)

**Your checklist:**
```
□ Read every line
□ Understand what it does
□ Check types are correct
□ Verify imports are right
□ Look for edge cases
□ Check error handling
□ Validate against conventions
□ Assess security implications

Time: 30-60 seconds per function
```

### Step 3: Critique (YOU decide)

**Decision matrix:**

```
Perfect → Accept → Move on
  ↓
Minor issues → Note them → Fix later if time
  ↓
Major issues → Ask AI to fix → Review again
  ↓
Wrong approach → Reject → Start over
```

### Step 4: Verify (YOU confirm)

**Actions:**
```
□ Apply code to your editor
□ Check TypeScript errors
□ Test in browser
□ Verify expected behavior
□ Check console for errors

Only then consider it "done"
```

## Risk Mitigation Strategies

### Risk 1: AI Generates Too Much Code

**Problem:**
- Hard to review 100+ lines
- Easy to miss issues
- Difficult to understand

**Solution: Constrain Output**

**Prompt:**
```
Generate ONLY [specific part].

Don't generate:
- [Part 1] - I'll do that separately
- [Part 2] - Already exists
- [Part 3] - Not needed yet

Show me just [specific part].
Max 30 lines of code.
```

**Example:**
```
❌ "Create a booking form"
   → AI generates 200 lines, hard to review

✅ "Create just the Zod validation schema for booking form"
   → AI generates 20 lines, easy to review
   
   Then: "Now add the form fields"
   Then: "Now add submit handler"
```

### Risk 2: AI Uses Wrong Patterns

**Problem:**
- Doesn't know project conventions
- Uses outdated patterns
- Imports from wrong locations

**Solution: Provide Examples**

**Prompt template:**
```
Follow the EXACT pattern from [file:lines].

Specifically copy:
- Import style
- Type definitions
- Error handling
- Function structure

Apply it to [new task].
```

**Example:**
```
In apps/web/modules/bookings/BookingForm.tsx lines 20-45,
there's the pattern for form fields.

Follow that EXACT pattern (same imports, same structure)
to add a "location" field.

Don't deviate from the pattern.
```

### Risk 3: AI Assumes Context

**Problem:**
- Makes incorrect assumptions
- Doesn't ask clarifying questions
- Generates incomplete solution

**Solution: Force Questions**

**Prompt:**
```
Before implementing, you MUST ask me:
1. [Question 1]
2. [Question 2]
3. [Question 3]
4. Any other clarifying questions

Don't generate code until I answer.
```

**Example:**
```
Task: Add filtering to booking list

Before implementing, ask me:
1. What fields should be filterable?
2. Should filters persist in URL?
3. Should filtering be client or server-side?
4. What's the expected data volume?
5. Any other questions you have?

Wait for my answers before generating code.
```

### Risk 4: AI Introduces Bugs

**Problem:**
- Generates code that looks good but has subtle bugs
- Off-by-one errors, race conditions, etc.
- Hard to spot in quick review

**Solution: Defensive Testing**

**Workflow:**
```
1. Generate code
2. Review carefully
3. Apply to editor
4. TEST IMMEDIATELY
5. If broken, analyze why
6. Ask AI to fix specific issue
7. Test again
8. Only then consider it working
```

**Test cases to always check:**
```
✅ Happy path (should work)
✅ Invalid input (should reject)
✅ Empty data (should handle)
✅ Null/undefined (should not crash)
✅ Edge values (0, -1, max, etc.)
```

### Risk 5: AI Modifies Wrong Things

**Problem:**
- Changes code you didn't want changed
- Breaks working functionality
- Hard to revert specific parts

**Solution: Explicit Boundaries**

**Prompt:**
```
Modify ONLY [specific function/section].

DO NOT TOUCH:
- [Function/file 1]
- [Function/file 2]
- [Lines X-Y]

If you need to modify something else, ask first.
```

**Example:**
```
Add error handling to submitBooking function (lines 45-60).

ONLY modify that function.

DO NOT modify:
- The validation logic
- The form component
- Any other functions
- Import statements

Show me just the updated function.
```

### Risk 6: Security Vulnerabilities

**Problem:**
- AI might expose sensitive data
- Skip authentication checks
- Introduce SQL injection risks

**Solution: Security Checklist**

**Before accepting code:**
```
Security Review:
□ No exposed credentials/keys?
□ No .env secrets in code?
□ Using 'select' not 'include' in Prisma?
□ Not exposing credential.key field?
□ Authentication check present?
□ Authorization check present?
□ Input validation/sanitization?
□ No SQL injection risk?
□ No XSS vulnerabilities?
```

**Prompt for AI:**
```
Review this code for security issues:
1. Is any sensitive data exposed?
2. Are there auth/permission checks?
3. Is input validated/sanitized?
4. Any injection risks?
5. Following AGENTS.md security rules?

List any security concerns before I apply this code.
```

## The Interrupt System

### When to Interrupt AI

**Interrupt immediately if:**
- ❌ Taking wrong approach
- ❌ Modifying wrong files
- ❌ Generating too much code
- ❌ Not following instructions
- ❌ Making unsafe changes

**How to interrupt:**
```
STOP

[Explain issue]

Instead, [new instruction]
```

### Interrupt Patterns

#### Pattern 1: Course Correction

```
STOP - You're modifying [wrong thing].

Don't change [X].
Only change [Y].

Start over with that constraint.
```

#### Pattern 2: Scope Reduction

```
STOP - That's too much at once.

Break it into smaller steps:
Step 1: [Small task 1]
Step 2: [Small task 2]
Step 3: [Small task 3]

Show me ONLY Step 1.
```

#### Pattern 3: Approach Change

```
STOP - This approach won't work because [reason].

Instead, let's try [different approach].

Explain how that approach would work first.
Don't generate code yet.
```

## The Validation Gates

### Gate 1: Pre-Generation (Before AI writes code)

**Questions to answer:**
```
✅ Do I understand what I'm asking for?
✅ Have I provided enough context?
✅ Did I specify constraints?
✅ Did I reference examples?
✅ Is my prompt specific enough?
```

**If any is "No"** → Improve prompt first

### Gate 2: Post-Generation (After AI writes code)

**Questions to answer:**
```
✅ Do I understand what this code does?
✅ Are the types correct?
✅ Are imports correct?
✅ Is error handling present?
✅ Are edge cases handled?
✅ Does it follow conventions?
✅ Is it secure?
```

**If any is "No"** → Don't apply, fix issues first

### Gate 3: Post-Application (After applying to editor)

**Questions to answer:**
```
✅ Does TypeScript compiler pass?
✅ Does it work in the browser?
✅ Are there console errors?
✅ Does it handle invalid input?
✅ Does it match requirements?
```

**If any is "No"** → Debug before moving on

## The Question-Driven Workflow

### Make AI Ask YOU Questions

**Why it's better:**
- Ensures AI understands requirements
- Catches assumptions early
- Demonstrates your thinking to interviewer
- Gives you control of direction

**How to do it:**

#### Method 1: Explicit Question Request

```
I need to [task].

Before implementing, ask me 5-7 clarifying questions about:
- Requirements
- Edge cases
- Constraints
- Approach

Wait for my answers.
```

#### Method 2: Socratic Method

```
I think I need to [task].

But first:
1. Ask me if this is the right approach
2. Ask what edge cases I've considered
3. Ask about constraints I might have missed
4. Suggest alternatives I should consider

Help me think through this before coding.
```

#### Method 3: Red Team Mode

```
I'm about to implement [solution].

Play devil's advocate:
1. What could go wrong with this approach?
2. What am I not considering?
3. What edge cases might I miss?
4. What would you do differently?

Challenge my assumptions.
```

### Your Response Template

When AI asks questions:

```
Answer format:

Q1: [AI's question]
A1: [Your answer] - narrate this out loud

Q2: [AI's question]
A2: [Your answer] - narrate this out loud

Q3: [AI's question]
A3: [Your answer] - narrate this out loud

Now proceed with implementation.
```

## The Incremental Control Pattern

### Step-by-Step Workflow

```
┌──────────────────────────────────────┐
│ 1. Define smallest useful unit      │
│    ↓                                │
│ 2. AI generates that unit only      │
│    ↓                                │
│ 3. YOU review (30-60 seconds)       │
│    ↓                                │
│ 4. YOU decide: Accept/Reject/Modify │
│    ↓                                │
│ 5. Apply and test                   │
│    ↓                                │
│ 6. If works, commit checkpoint      │
│    ↓                                │
│ 7. Move to next unit                │
│    ↓                                │
│ 8. Repeat                           │
└──────────────────────────────────────┘
```

### What is a "Unit"?

**Good units (small, testable):**
- ✅ A single type definition
- ✅ A Zod validation schema
- ✅ One form field
- ✅ One API endpoint
- ✅ One function
- ✅ Error handling for one scenario

**Bad units (too large):**
- ❌ Entire component
- ❌ Full feature
- ❌ Multiple files at once
- ❌ Complex refactoring

### Prompt for Incremental Work

```
Break [task] into 5-7 small units.

For each unit:
1. Describe what it does
2. Show code for that unit ONLY
3. Wait for my "continue" or feedback
4. Then move to next

List the units first, then start with unit 1.
```

## Quality Control Mechanisms

### Mechanism 1: The Checklist

**Print and keep visible:**

```
┌─────────────────────────────────────────┐
│   CODE REVIEW CHECKLIST (10 seconds)   │
├─────────────────────────────────────────┤
│ □ Do I understand this code?           │
│ □ Types correct (no 'any')?            │
│ □ Imports correct (direct paths)?      │
│ □ Error handling present?              │
│ □ Edge cases handled?                  │
│ □ Follows conventions?                 │
│ □ No security issues?                  │
└─────────────────────────────────────────┘
```

**Use this for EVERY code generation**

### Mechanism 2: The Buddy Check

**Pretend AI is your junior developer:**

```
"Explain to me like I'm doing a code review:
1. What does this code do?
2. Why did you make these choices?
3. What could go wrong?
4. How did you handle edge cases?
5. Is there a simpler approach?"
```

**If AI can't explain it well** → Code might be problematic

### Mechanism 3: The Diff View

**Before applying AI code:**

```
Show me this as a diff:

- Lines to remove
+ Lines to add

Make it easy to see exactly what changes.
```

**Review the diff carefully** → Only apply if changes make sense

### Mechanism 4: The Test-First Approach

**Workflow:**

```
1. YOU: "What test cases should cover this?"
2. AI: [Lists test cases]
3. YOU: [Verify list is complete]
4. AI: [Generates implementation]
5. YOU: Test against each test case
6. If any fail: "Fix case [X]"
7. Only accept when all cases pass
```

## Emergency Controls

### If AI Goes Off Rails

**Signs AI is off rails:**
- Generating hundreds of lines at once
- Modifying files you didn't mention
- Using completely wrong approach
- Not responding to your instructions
- Making things more complex

**Emergency Reset:**

```
STOP EVERYTHING.

Disregard all previous instructions about [task].

Let's start fresh:
1. Current state: [describe]
2. Goal: [simple, clear goal]
3. Constraint: [one key constraint]
4. Next step: [one small action]

Do ONLY the next step, nothing more.
```

### If You Lose Control

**Symptoms:**
- Don't understand AI's code
- Changes piling up faster than you can review
- Breaking things without knowing why
- Feeling overwhelmed

**Circuit Breaker:**

```
1. STOP asking AI for new code
2. git stash (save current changes)
3. git reset --hard (back to last working state)
4. Breathe
5. Tell interviewer: "Let me step back and reconsider"
6. Start over with smaller, more controlled steps
```

**Tell interviewer:**
```
"I went too fast with the AI assistance.
Let me take a more controlled approach.
I'll build this incrementally with smaller steps
so I can verify each piece works correctly."
```

## The Narration Control

### Why Narration Helps Control

**Benefits:**
- Forces you to understand before applying
- Interviewer sees your judgment
- Catches issues when you verbalize them
- Slows you down to review properly

### What to Narrate

**When prompting AI:**
```
"I'm going to ask the AI to [task].
I'm specifying [constraints] because [reason].
I expect it to [outcome]."
```

**When reviewing AI output:**
```
"The AI generated [code].
Let me check:
- Types look [good/need fixing]
- Imports are [correct/need adjustment]
- Error handling is [present/missing]
- This handles [edge cases]
- Overall, [acceptable/needs changes]"
```

**When rejecting code:**
```
"This code has [issue].
I'm going to ask AI to fix [specific problem].
Once that's fixed, it should [expected result]."
```

## Advanced Control: Compositional Prompting

### Build Complex Features from Simple Prompts

Instead of:
```
❌ "Create a complete booking dashboard with statistics, filters, and exports"
```

Do this:
```
✅ Step 1: "Create empty dashboard component structure"
✅ Step 2: "Add data fetching for booking statistics"
✅ Step 3: "Add display components for statistics"
✅ Step 4: "Add filter controls"
✅ Step 5: "Wire up filters to data"
✅ Step 6: "Add export button"
✅ Step 7: "Implement export logic"
```

**Review and test after EACH step**

## The Control Scorecard

### Measure Your Control Level

After each AI interaction:

```
Did I:
□ Provide specific instructions?
□ Review the code carefully?
□ Understand what it does?
□ Test it before moving on?
□ Maintain veto power?
□ Demonstrate judgment?

Score: [X/6]

5-6: Excellent control ✅
3-4: Adequate control ⚠️
0-2: Need more control ❌
```

**If score is low** → Slow down, increase control

---

## Quick Reference: Control Commands

**Keep these ready to use:**

```
STOP - [Explain why, give new direction]

WAIT - [Ask clarifying question]

EXPLAIN - [What does this code do?]

REVIEW - [Check this for issues]

SIMPLIFY - [Make this simpler]

TEST - [How do I test this?]

ALTERNATIVES - [Show me other approaches]

STEP-BY-STEP - [Break this down]
```

**Next:** Practice these control strategies in low-stakes coding before the interview!
