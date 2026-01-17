# Problem-Solving Framework

## 🎯 Goal
A systematic approach to tackle any interview problem efficiently and confidently.

## The Framework: UNDERSTAND → PLAN → IMPLEMENT → VALIDATE

```
┌─────────────────────────────────────────────────┐
│                                                 │
│  1. UNDERSTAND (10-15% of time)                │
│     ↓                                          │
│  2. PLAN (10-15% of time)                      │
│     ↓                                          │
│  3. IMPLEMENT (50-60% of time)                 │
│     ↓                                          │
│  4. VALIDATE (15-20% of time)                  │
│                                                 │
└─────────────────────────────────────────────────┘
```

## Phase 1: UNDERSTAND (5-10 minutes)

### Goal
Ensure you fully understand the problem before writing any code.

### Questions to Ask

#### About Requirements
- "What exactly needs to be built?"
- "Who will use this feature?"
- "What problem does this solve?"
- "Are there any existing similar features I should reference?"

#### About Constraints
- "Should this work for all users or specific roles?"
- "Are there any performance considerations?"
- "What browsers/devices need to be supported?"
- "Are there any security considerations?"

#### About Data
- "What data do I have access to?"
- "Where does this data come from?"
- "What's the data structure?"
- "Are there any nullable/optional fields I need to handle?"

#### About UI/UX
- "Where should this appear in the UI?"
- "What should the user experience be?"
- "What happens on error?"
- "What loading states are needed?"

### Techniques

**Repeat Back Your Understanding:**
```
"So, to confirm, I need to:
1. Add a [feature] to [location]
2. It should [behavior]
3. And handle [edge cases]
Is that correct?"
```

**Identify Edge Cases Early:**
```
"What should happen if:
- The user inputs invalid data?
- The API call fails?
- The data is empty?
- The user doesn't have permission?"
```

**Check Database Schema:**
```bash
# Open schema to understand data structure
code packages/prisma/schema.prisma

# Search for relevant models
# Example: Cmd+F "model Booking"
```

### Red Flags (Signs You Don't Understand Yet)

❌ You're not sure which files to modify
❌ You don't know where the data comes from
❌ You can't explain the feature in your own words
❌ You haven't thought about error cases

✅ When you're ready to proceed:
- You can explain the feature clearly
- You know which files need changes
- You've identified potential edge cases
- You have a mental model of the data flow

## Phase 2: PLAN (5-10 minutes)

### Goal
Create a clear implementation strategy before coding.

### Step-by-Step Planning

#### 1. Identify Components Affected
```
"I'll need to modify:
- [File 1] - to add the UI component
- [File 2] - to add the API endpoint
- [File 3] - to update the database schema
"
```

#### 2. Determine the Approach
```
"My approach will be:
1. First, update the database schema
2. Then, create the tRPC endpoint
3. Finally, add the UI component
"
```

#### 3. Consider Alternatives
```
"I could also:
- Approach A: [pros/cons]
- Approach B: [pros/cons]

I'll go with Approach A because [reason]"
```

#### 4. Break Down into Subtasks
```
TODO:
□ Update Prisma schema
□ Generate Prisma types
□ Create tRPC input schema (Zod)
□ Create tRPC handler
□ Create React component
□ Add form validation
□ Add translations
□ Test happy path
□ Test error cases
```

### Planning Template

Use this template out loud:

```
"Here's my plan:

1. BACKEND:
   - Modify [schema/model]
   - Add [API endpoint] that does [X]
   - Validate [inputs]

2. FRONTEND:
   - Create/modify [component]
   - Fetch data using [tRPC query/mutation]
   - Handle [loading/error states]

3. TESTING:
   - Test [scenario 1]
   - Test [scenario 2]
   - Test [edge case]

Does this approach sound good?"
```

### Get Alignment

**Before coding, confirm:**
```
Interviewer: "Sounds good, go ahead"
→ Proceed with confidence

Interviewer: "What about [X]?"
→ Adjust plan, then proceed

Interviewer: "Have you considered [Y]?"
→ Discuss, update plan
```

## Phase 3: IMPLEMENT (30-40 minutes)

### Goal
Write clean, working code efficiently using AI assistance.

### Implementation Strategy

#### Step 1: Start with Schema/Data Layer
```
Reason: Changes here affect everything else

1. Update packages/prisma/schema.prisma
2. Run: yarn prisma generate
3. Verify types are available in IDE
```

#### Step 2: Build Backend (tRPC)
```
Reason: Frontend needs working API

1. Create input schema (Zod validation)
2. Create handler function
3. Wire up in router
4. Test with Postman/curl if needed
```

#### Step 3: Build Frontend
```
Reason: User-facing functionality

1. Create/modify component
2. Add tRPC hooks
3. Add form validation
4. Add loading/error states
5. Add translations
```

#### Step 4: Iterate and Refine
```
Reason: Make it production-ready

1. Test in browser
2. Fix bugs
3. Handle edge cases
4. Improve UX
```

### AI Collaboration During Implementation

**For Each Task:**

```
1. PROMPT (Be specific)
   "Generate [X] that does [Y], following [pattern Z]"

2. REVIEW (Check critically)
   - Types correct?
   - Imports correct?
   - Edge cases handled?
   - Follows conventions?

3. REFINE (Fix issues)
   "Fix [specific issue]"
   OR manually edit small things

4. TEST (Verify it works)
   Test in browser, check console
```

### Narration During Implementation

**When starting a task:**
```
"Now I'm going to add the form field.
Let me ask the AI to generate it following
the React Hook Form pattern."
```

**When reviewing AI output:**
```
"The AI generated this component.
Let me check the imports... these look good.
Type definitions... using proper types.
Validation... hmm, missing null check, let me add that."
```

**When testing:**
```
"Let me test this in the browser.
I'll try the happy path first... works.
Now let me try invalid input... good, shows error.
What about empty field... should add validation for that."
```

### Dealing with Obstacles

**If stuck for 2-3 minutes:**
```
1. Explain the issue out loud
2. Ask AI for help with specific problem
3. Check AGENTS.md or existing code for patterns
```

**If stuck for 5+ minutes:**
```
"I'm having trouble with [specific issue].
Let me try a different approach..."

OR

"I'm stuck on [issue]. Could you provide
guidance on [specific question]?"
```

**If making no progress:**
```
"Let me step back and reconsider my approach.
Maybe I should [alternative strategy]."
```

## Phase 4: VALIDATE (10-15 minutes)

### Goal
Ensure the solution works correctly and handles edge cases.

### Testing Checklist

#### ✅ Happy Path
```
Test the main functionality:
□ Feature works as intended
□ Data displays correctly
□ Form submits successfully
□ Success message shows
```

#### ✅ Error Cases
```
Test error scenarios:
□ Invalid input (form validation)
□ Empty/null values
□ API errors (simulate if possible)
□ Network errors
□ Unauthorized access
```

#### ✅ Edge Cases
```
Test unusual scenarios:
□ Very long input
□ Special characters
□ Boundary values (0, negative, max)
□ Concurrent operations
□ Missing optional data
```

#### ✅ UX/UI
```
Verify user experience:
□ Loading states work
□ Error messages are clear
□ UI is responsive
□ No console errors
□ Translations display correctly
```

#### ✅ Code Quality
```
Review your code:
□ No TypeScript errors
□ Proper error handling
□ Follows project conventions
□ No hardcoded values
□ Clean, readable code
```

### Demo Strategy

**Structure your demo:**

```
1. EXPLAIN THE FEATURE
   "I've implemented [feature] that allows users to [action]"

2. SHOW HAPPY PATH
   "Let me demonstrate: I'll [action]... and it [result]"

3. SHOW ERROR HANDLING
   "Now if I enter invalid data... it shows proper validation"

4. EXPLAIN KEY DECISIONS
   "I chose to [decision] because [reasoning]"

5. DISCUSS TRADE-OFFS
   "One trade-off is [X], an alternative would be [Y]"

6. SUGGEST IMPROVEMENTS
   "Given more time, I would add [enhancement]"
```

### Discussion Points

**Be ready to discuss:**

#### Architecture Decisions
```
"I structured it this way because..."
"I chose [library/pattern] because..."
```

#### Trade-offs
```
"This approach is simpler but [limitation]"
"Alternative approach would be [X], which [pro/con]"
```

#### Future Improvements
```
"This could be enhanced by..."
"For production, I'd also add..."
"Performance could be improved by..."
```

#### Edge Cases Considered
```
"I handled [edge case] by..."
"If [scenario] happens, it will..."
```

## Common Interview Scenarios

### Scenario 1: Add a New Feature

**Example: "Add a notes field to bookings"**

**UNDERSTAND:**
- Where should notes appear? (booking form, details page, list?)
- Who can add notes? (booker, attendee, both?)
- Any character limits?
- Required or optional?

**PLAN:**
- Update Booking model in Prisma schema
- Add field to booking form component
- Update tRPC create/update endpoints
- Add validation (Zod)
- Add translation
- Test

**IMPLEMENT:**
- Schema → Generate → Backend → Frontend → Refine

**VALIDATE:**
- Test adding notes
- Test empty notes (if optional)
- Test very long notes
- Verify saves to database

### Scenario 2: Fix a Bug

**Example: "Form validation not working"**

**UNDERSTAND:**
- What's the expected behavior?
- What's actually happening?
- Can you reproduce it?
- Any console errors?

**PLAN:**
- Reproduce the bug
- Locate the validation code
- Identify the root cause
- Plan the fix
- Consider if this affects other places

**IMPLEMENT:**
- Fix the issue
- Verify it doesn't break anything else

**VALIDATE:**
- Test the fix works
- Test related functionality
- Check for similar bugs elsewhere

### Scenario 3: Improve Existing Code

**Example: "Refactor this component"**

**UNDERSTAND:**
- What's wrong with current code?
- What should be improved?
- Any specific goals? (performance, readability, type safety)

**PLAN:**
- Identify improvements needed
- Plan refactoring approach
- Consider if tests need updating

**IMPLEMENT:**
- Make changes incrementally
- Test after each change
- Ensure functionality unchanged

**VALIDATE:**
- Verify all functionality still works
- Check no new bugs introduced
- Confirm improvements achieved

## Mental Models

### Think in Layers

```
┌──────────────────────────────┐
│     UI Layer (React)         │  ← User sees/interacts
├──────────────────────────────┤
│   API Layer (tRPC)           │  ← Data flow
├──────────────────────────────┤
│   Business Logic (Handlers)  │  ← Validation, rules
├──────────────────────────────┤
│   Data Layer (Prisma)        │  ← Database
└──────────────────────────────┘
```

Work top-down or bottom-up depending on the task.

### Think in Data Flow

```
User Input → Validation → API Call → Database → Response → UI Update
```

Trace the data flow for any feature.

### Think in Error Paths

```
Happy Path: User → Input → Success → Display
Error Path: User → Invalid → Validation Error → Show Message
Error Path: User → Input → API Error → Show Error
Error Path: User → Input → Not Found → Show Empty State
```

Consider all possible paths.

## Time Management

### If Running Short on Time

**30 minutes left, feature not complete:**
```
Focus on:
1. Core functionality working
2. Basic error handling
3. Clean code

Skip:
- Advanced features
- Perfect UI polish
- Edge case #5
```

**15 minutes left:**
```
Focus on:
1. Demo what works
2. Explain what's missing
3. Show your thinking process

Say:
"I have the main functionality working.
Given more time, I would add [X, Y, Z].
Let me show you what I've completed..."
```

**5 minutes left:**
```
Focus on:
- Quick demo
- Key decisions made
- Clean stopping point

Say:
"Let me show you what I've built so far
and explain my approach..."
```

### If Finishing Early

**Completed with 15+ minutes left:**
```
Options:
1. Add error handling
2. Improve UX
3. Add tests
4. Optimize performance
5. Add accessibility

Ask:
"The core feature is working. I could:
- [Option 1]
- [Option 2]
- [Option 3]
What would be most valuable?"
```

## Key Principles

### 1. Communicate First, Code Second
Always explain what you're doing and why.

### 2. Plan Before Implementing
5 minutes of planning saves 15 minutes of confusion.

### 3. Test Continuously
Don't wait until the end to test.

### 4. Ask When Unclear
Better to clarify than assume wrong.

### 5. Show Your Thinking
The process matters as much as the result.

### 6. Stay Calm
Getting stuck is normal. Work through it systematically.

### 7. Review Critically
AI helps, but you're responsible for the code quality.

### 8. Focus on Fundamentals
Type safety, error handling, edge cases matter.

## Final Checklist

Before saying "I'm done":

- [ ] Feature works as intended
- [ ] Error cases handled
- [ ] No TypeScript errors
- [ ] No console errors in browser
- [ ] Code follows project conventions
- [ ] Can explain all decisions made
- [ ] Ready to demo and discuss

---

**You're now ready for the interview! Trust your preparation, think systematically, and communicate clearly. Good luck!** 🚀
