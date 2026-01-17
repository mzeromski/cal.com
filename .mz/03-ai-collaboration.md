# AI Collaboration Strategies

## 🎯 Goal
Use AI effectively during the interview - leveraging its strengths while applying critical engineering judgment.

## The AI Collaboration Philosophy

**Remember:**
- AI is your **pair programmer**, not your replacement
- You're being evaluated on **how you work with AI**, not just the final code
- **Narrate your prompts and review process** - the interviewer needs to understand your thinking

## Effective Prompting Framework

### The 4-Part Prompt Structure

```
1. CONTEXT: "In this Cal.com codebase..."
2. GOAL: "I need to add a feature that..."
3. CONSTRAINTS: "It should follow the existing pattern of... and use..."
4. SPECIFIC ASK: "Generate/Show me/Explain..."
```

### Example: Bad vs Good Prompts

#### ❌ Bad Prompt (Too vague)
```
"Add a new field to the booking form"
```

**Problems:**
- No context about which form
- No constraints about validation
- No mention of database schema
- AI might not follow project conventions

#### ✅ Good Prompt
```
"In the Cal.com codebase, I need to add a 'phone number' field to the booking form.

Context:
- The booking form is in apps/web/modules/bookings/
- Forms use React Hook Form with zod validation
- Database schema is in packages/prisma/schema.prisma

Requirements:
- Add field to the Booking model in schema
- Add validation (must be valid phone format)
- Follow existing pattern for how 'email' field is handled
- Use the existing PhoneInput component from @calcom/ui

Show me:
1. The schema change needed
2. The form field addition with validation
3. Where to add the translation string
"
```

**Why it's better:**
- Provides codebase context
- References existing patterns
- Specifies tech stack (React Hook Form, zod)
- Mentions specific files/locations
- Asks for complete solution

## Prompting Strategies for Different Tasks

### 1. Understanding Code

**Goal:** Understand what existing code does

**Prompt Template:**
```
"Explain what this [component/function/file] does:

[paste code or mention file path]

Focus on:
- Main responsibility
- Key dependencies
- Data flow
- Edge cases handled
"
```

**Example:**
```
"Explain what apps/web/modules/bookings/BookingForm.tsx does:
- What data does it fetch?
- How does it handle validation?
- What API calls does it make?
- What are the key edge cases?"
```

### 2. Finding Code

**Goal:** Locate relevant code quickly

**Prompt Template:**
```
"Where in this codebase would I find [feature/pattern]?
Specifically looking for: [details]
"
```

**Example:**
```
"Where in this codebase is the event type availability logic?
I need to understand how users set their available time slots."
```

### 3. Generating Code

**Goal:** Create new functionality

**Prompt Template:**
```
"Generate [component/function/feature] that:
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

Follow these patterns from the codebase:
- [Pattern 1 with example]
- [Pattern 2 with example]

Use these tools/libraries:
- [Library 1]
- [Library 2]
"
```

**Example:**
```
"Generate a React component for displaying booking statistics.

Requirements:
- Show total bookings count
- Show bookings by status (confirmed, pending, cancelled)
- Display as cards with icons
- Use loading state while fetching

Follow these Cal.com patterns:
- Use tRPC for data fetching (see apps/web/modules/bookings/BookingsList.tsx)
- Use Card component from @calcom/ui/components/card
- Follow TypeScript strict mode
- Add translations to common.json

Tech stack:
- React with TypeScript
- tRPC + React Query
- Tailwind CSS
"
```

### 4. Debugging Code

**Goal:** Fix issues or errors

**Prompt Template:**
```
"I'm getting this error: [error message]

Context:
- File: [file path]
- What I'm trying to do: [goal]
- What I changed: [changes]

The relevant code is:
[paste code]

Help me:
1. Understand why this error occurs
2. Fix it following project conventions
3. Prevent similar issues
"
```

**Example:**
```
"I'm getting: 'Cannot find module @calcom/ui'

Context:
- File: apps/web/modules/events/EventCard.tsx
- Trying to import Button component
- I wrote: import { Button } from '@calcom/ui'

From AGENTS.md, I see I should import from source paths.
Show me the correct import statement for Button component."
```

### 5. Refactoring Code

**Goal:** Improve existing code

**Prompt Template:**
```
"Review this code and suggest improvements:

[paste code]

Focus on:
- Type safety
- Edge cases
- Cal.com conventions (reference: AGENTS.md)
- Performance
- Readability

Current issues I see:
- [Issue 1]
- [Issue 2]
"
```

## Critical Review Checklist

### After AI Generates Code, ALWAYS Check:

#### ✅ TypeScript Types
```typescript
// ❌ AI might generate
const data = response.data as any;

// ✅ You should ensure
import type { Booking } from "@prisma/client";
const data: Booking = response.data;
```

**Review prompt:**
```
"Review the types in this code. Are there any 'any' types?
Can we make this more type-safe?"
```

#### ✅ Imports
```typescript
// ❌ AI might use barrel imports
import { Button } from "@calcom/ui";

// ✅ Should be direct imports
import { Button } from "@calcom/ui/components/button";
```

**Review prompt:**
```
"Check these imports against the AGENTS.md rule about
avoiding barrel imports. Fix any that need direct paths."
```

#### ✅ Error Handling
```typescript
// ❌ AI might skip error handling
const booking = await trpc.bookings.get.fetch();

// ✅ Should handle errors
const booking = await trpc.bookings.get.fetch().catch((error) => {
  console.error("Failed to fetch booking:", error);
  return null;
});
```

**Review prompt:**
```
"What error cases does this code handle?
Add proper error handling following React Query patterns."
```

#### ✅ Edge Cases
```typescript
// ❌ AI might assume data exists
const userName = user.name.toUpperCase();

// ✅ Should handle null/undefined
const userName = user?.name?.toUpperCase() ?? "Unknown";
```

**Review prompt:**
```
"What edge cases could break this code?
- null/undefined values
- empty arrays
- invalid input
Add safeguards for these cases."
```

#### ✅ Project Conventions

**Review prompt:**
```
"Review this code against AGENTS.md:
- Using select instead of include in Prisma?
- Early returns instead of deep nesting?
- Type imports using 'import type'?
- Proper error classes (ErrorWithCode vs TRPCError)?
"
```

## Narration Techniques

### What to Say Out Loud During the Interview

#### When Writing Prompts
```
"I'm going to ask the AI to generate a booking form component.
I'll specify that it should use React Hook Form and follow
the pattern from the existing event type form."
```

#### When Reviewing AI Output
```
"The AI generated this component. Let me review:
- Types look good, using proper Booking type from Prisma
- Imports... wait, this is using a barrel import from @calcom/ui
  I need to change that to import from the specific component path
- Error handling... this could fail if the booking ID is invalid,
  let me add a check for that
- Looking good otherwise"
```

#### When Iterating
```
"This is close, but I notice it's not handling the loading state.
Let me ask the AI to add that following the React Query pattern
I saw in BookingsList.tsx"
```

#### When Making Manual Edits
```
"The AI got this mostly right, but I'm going to manually adjust
the TypeScript types here because I know from the schema that
this field can be null. Adding optional chaining..."
```

## Common AI Pitfalls and How to Avoid Them

### Pitfall 1: Outdated Patterns

**Problem:** AI might use old Next.js or React patterns

**Prevention prompt:**
```
"Use Next.js 13+ App Router patterns with React Server Components.
Reference existing files in apps/web/app/ for patterns."
```

### Pitfall 2: Generic Solutions

**Problem:** AI might not follow Cal.com-specific conventions

**Prevention prompt:**
```
"Follow the conventions in AGENTS.md and existing code:
- Use select in Prisma queries
- Import from source paths, not barrel files
- Use ErrorWithCode for non-tRPC errors
- Add translations to common.json
"
```

### Pitfall 3: Incomplete Error Handling

**Problem:** AI often skips edge cases

**Prevention prompt:**
```
"Include comprehensive error handling:
- Null/undefined checks
- Invalid input validation
- API error states
- Loading states
Show me the error scenarios this code handles."
```

### Pitfall 4: Missing TypeScript Types

**Problem:** AI might use 'any' or skip type definitions

**Prevention prompt:**
```
"Ensure strict TypeScript:
- No 'any' types
- Proper type imports using 'import type'
- Explicit return types for functions
- Type safety for all props
"
```

## Effective AI Workflows

### Workflow 1: Scaffold → Review → Refine

```
1. SCAFFOLD (AI does most work)
   Prompt: "Generate a [feature] following [pattern]"
   
2. REVIEW (You critically examine)
   - Check types
   - Verify imports
   - Test edge cases
   - Validate against conventions
   
3. REFINE (AI + You collaborate)
   Prompt: "Fix these issues: [list issues]"
   + Manual edits for small fixes
```

### Workflow 2: Understand → Plan → Implement

```
1. UNDERSTAND (AI helps explore)
   Prompt: "Explain how [existing feature] works"
   
2. PLAN (You design approach)
   You: "Based on that, I'll add [new feature] by..."
   Interviewer: "Sounds good / What about...?"
   
3. IMPLEMENT (AI generates, you review)
   Prompt: "Generate [feature] following [plan]"
   Then: Review and refine
```

### Workflow 3: Incremental Building

```
1. Start small
   Prompt: "Create a simple [component] with just [basic feature]"
   
2. Verify it works
   Test in browser
   
3. Add complexity
   Prompt: "Add [next feature] to this component"
   
4. Repeat
   Build up feature iteratively
```

## Practice Exercises

### Before the Interview

#### Exercise 1: Prompt Writing (10 min)
Write prompts for these tasks:
1. Add a new field to event type form
2. Create a dashboard statistics widget
3. Debug a TypeScript error
4. Refactor a component to use React Hook Form

#### Exercise 2: Code Review (15 min)
Ask AI to generate a form component, then practice reviewing:
1. Check all imports
2. Verify TypeScript types
3. Identify missing error handling
4. Find edge cases
5. Narrate your findings out loud

#### Exercise 3: Iteration (10 min)
1. Ask AI for a simple component
2. Identify 3 improvements needed
3. Prompt AI to make those improvements
4. Practice explaining why each improvement matters

---

**Next**: Read [04-tech-stack-reference.md](./04-tech-stack-reference.md) for a quick reference of the technologies you'll use.
