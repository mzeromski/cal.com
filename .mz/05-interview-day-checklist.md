# Interview Day Checklist

## 🎯 Goal
Be fully prepared and confident when the interview starts.

## Timeline: Day Before Interview

### Evening Before (30 minutes)

#### ✅ Verify Environment
```bash
# Pull latest changes
cd ~/projects/cal.com
git pull origin main

# Reinstall dependencies if needed
yarn

# Test dev server
yarn dx

# Wait for it to start, then verify:
# - Visit http://127.0.0.1:3000
# - Login with pro@example.com / pro
# - Navigate around dashboard
# - Check console for errors

# Stop server (Ctrl+C)
```

#### ✅ Test AI Assistant
1. Open Cursor
2. Open any `.tsx` file
3. Test prompt: "Explain what this component does"
4. Verify AI responds appropriately
5. Test: "Where is the booking form in this codebase?"

#### ✅ Prep Your Workspace
- [ ] Close unnecessary applications
- [ ] Clear desktop clutter
- [ ] Test webcam and microphone
- [ ] Charge laptop fully
- [ ] Have charger nearby
- [ ] Prepare water/coffee

#### ✅ Mental Prep
- [ ] Review this prep guide's main README
- [ ] Skim through Cal.com dashboard to refresh memory
- [ ] Practice thinking out loud for 2 minutes
- [ ] Get good sleep!

## Timeline: Interview Day

### 2 Hours Before (Optional Refresh)

**Quick review:**
- [ ] Skim [03-ai-collaboration.md](./03-ai-collaboration.md) - prompting strategies
- [ ] Skim [06-common-patterns.md](./06-common-patterns.md) - coding patterns
- [ ] Review [07-problem-solving-framework.md](./07-problem-solving-framework.md) - approach

### 30 Minutes Before

#### ✅ Start Environment
```bash
# Open terminal
cd ~/projects/cal.com

# Start dev server
yarn dx

# Wait for "ready - started server on 0.0.0.0:3000"
```

#### ✅ Verify Everything Works
```bash
# In browser, open:
http://127.0.0.1:3000

# Login:
# Email: pro@example.com
# Password: pro

# Quick navigation test:
# 1. Click "Event Types" - should load
# 2. Click "Bookings" - should load
# 3. Open browser console - should see no errors
```

#### ✅ Prep Your IDE
```bash
# Open Cursor with project
cursor ~/projects/cal.com

# Open these files in tabs for quick reference:
# - AGENTS.md
# - packages/prisma/schema.prisma
# - apps/web/public/static/locales/en/common.json

# Split view:
# Left: Code editor
# Right: Terminal with yarn dx running
```

#### ✅ Arrange Windows

**Recommended layout:**

```
┌─────────────────────┬──────────────┐
│                     │              │
│    Browser          │   Zoom/Meet  │
│    (Cal.com)        │   (Small)    │
│                     │              │
├─────────────────────┴──────────────┤
│                                    │
│          IDE (Cursor)              │
│                                    │
│  [Editor]         [Terminal]       │
│                                    │
└────────────────────────────────────┘
```

Or use a second monitor if available.

#### ✅ Final Checks
- [ ] Dev server running (`yarn dx`)
- [ ] Can access http://127.0.0.1:3000
- [ ] IDE open with project loaded
- [ ] AI assistant enabled in IDE
- [ ] Browser console open (F12)
- [ ] Terminal visible
- [ ] No notifications enabled (Do Not Disturb mode)
- [ ] Phone on silent

### 5 Minutes Before

#### ✅ Mental Reset
1. Take 3 deep breaths
2. Remind yourself: "I'm prepared"
3. Review key principles:
   - Think out loud
   - Ask clarifying questions
   - Review AI output critically
   - Test in the browser
   - Handle edge cases

#### ✅ Have Ready
- [ ] Water nearby
- [ ] These prep notes (this directory)
- [ ] Notepad for jotting requirements
- [ ] Calm, focused mindset

## During the Interview

### Opening (0-5 minutes)

#### When Interviewer Introduces Task

**Do:**
```
1. Listen carefully to requirements
2. Take notes (key requirements, constraints)
3. Ask clarifying questions:
   - "Should this work for all users or specific roles?"
   - "Are there any constraints I should know about?"
   - "Should I follow any specific patterns from the codebase?"
4. Repeat back your understanding:
   - "So I need to [requirement], and it should [constraint]"
5. Propose your approach at a high level:
   - "I'm thinking I'll need to modify [X], add [Y], and test [Z]"
6. Get confirmation before coding
```

**Don't:**
- Jump straight into coding
- Assume requirements
- Skip clarifying questions

### Implementation Phase (5-45 minutes)

#### Your Workflow

```
┌──────────────────────────────────────┐
│ 1. UNDERSTAND THE PROBLEM            │
│    - What needs to be built?         │
│    - What are the constraints?       │
└──────────────────────────────────────┘
          ↓
┌──────────────────────────────────────┐
│ 2. LOCATE RELEVANT CODE              │
│    - Use AI: "Where is [feature]?"   │
│    - Navigate to files               │
│    - Review existing patterns        │
└──────────────────────────────────────┘
          ↓
┌──────────────────────────────────────┐
│ 3. PLAN YOUR CHANGES                 │
│    - Narrate: "I'll need to..."     │
│    - Check database schema           │
│    - Identify components to modify   │
└──────────────────────────────────────┘
          ↓
┌──────────────────────────────────────┐
│ 4. IMPLEMENT WITH AI                 │
│    - Craft clear, specific prompts   │
│    - Narrate what you're asking      │
│    - Review AI output critically     │
└──────────────────────────────────────┘
          ↓
┌──────────────────────────────────────┐
│ 5. TEST & REFINE                     │
│    - Test in running app             │
│    - Check edge cases                │
│    - Fix issues                      │
│    - Explain what you're testing     │
└──────────────────────────────────────┘
          ↓
┌──────────────────────────────────────┐
│ 6. VALIDATE & DISCUSS                │
│    - Demo working solution           │
│    - Explain key decisions           │
│    - Discuss trade-offs              │
│    - Suggest improvements            │
└──────────────────────────────────────┘
```

#### Narration Examples

**When searching:**
```
"Let me find where the booking form is defined.
I'll ask the AI to help me locate it."
```

**When prompting AI:**
```
"I'm going to ask the AI to generate a new form field
following the React Hook Form pattern I see in this file."
```

**When reviewing code:**
```
"The AI generated this. Let me check:
- Types look good
- This import needs to be fixed - should be direct path
- Missing validation for empty string, let me add that"
```

**When testing:**
```
"Let me test this in the browser.
I'll fill out the form with valid data... works.
Now let me try invalid data... good, validation shows."
```

**When stuck:**
```
"I'm seeing an error here. Let me read the error message...
It says module not found. I think the import path is wrong.
Let me check the AGENTS.md guide... ah, I need to use direct imports."
```

### Common Interview Scenarios

#### Scenario: Add a form field

**Steps to narrate:**
```
1. "First, I'll check the database schema to see if this field exists"
   → Open packages/prisma/schema.prisma

2. "I need to add it to the schema, then generate types"
   → Add field, run `yarn prisma generate`

3. "Now I'll find the form component"
   → Use AI or search to locate form

4. "I'll add the field using React Hook Form pattern"
   → Prompt AI or manually add

5. "Need to add validation"
   → Update Zod schema

6. "Add translation for the label"
   → Add to common.json

7. "Let me test this in the browser"
   → Test form submission
```

#### Scenario: Create a new component

**Steps to narrate:**
```
1. "I'll look at similar components for patterns"
   → Find example component

2. "I'll ask AI to scaffold the component"
   → Clear prompt with context

3. "Let me review the generated code"
   → Check types, imports, conventions

4. "Need to add this to the page"
   → Import and use component

5. "Test it loads correctly"
   → Verify in browser

6. "Add loading and error states"
   → Handle edge cases
```

#### Scenario: Fix a bug

**Steps to narrate:**
```
1. "Let me reproduce the bug"
   → Demonstrate the issue

2. "I'll check the console for errors"
   → Look at browser console

3. "Let me trace where this happens"
   → Navigate to relevant code

4. "I think the issue is [explanation]"
   → Explain hypothesis

5. "I'll fix it by [solution]"
   → Implement fix

6. "Test that it's resolved"
   → Verify bug is gone

7. "Let me check edge cases"
   → Test related scenarios
```

### Communication Tips

#### Things to Say

✅ **When clarifying:**
- "Just to confirm, should this..."
- "What should happen if..."
- "Are there any constraints on..."

✅ **When planning:**
- "I'm thinking I'll need to..."
- "The approach I have in mind is..."
- "This will require changes to..."

✅ **When implementing:**
- "I'm asking the AI to..."
- "Let me review what it generated..."
- "I'm going to manually adjust..."

✅ **When testing:**
- "Let me verify this works by..."
- "I want to test the edge case where..."
- "Let me check the error handling..."

✅ **When stuck:**
- "I'm seeing an issue here..."
- "Let me check the documentation..."
- "Could you clarify..."

✅ **When explaining:**
- "The reason I did it this way is..."
- "The trade-off here is..."
- "An alternative approach would be..."

#### Things to Avoid

❌ **Silent coding** - Always narrate
❌ **"I don't know"** - Say "Let me investigate" instead
❌ **Blaming AI** - Take ownership of the code
❌ **Getting defensive** - Stay open to feedback
❌ **Rushing** - Take time to think through problems

### Time Management

**If you have 60 minutes:**

- **0-5 min**: Clarify requirements, plan approach
- **5-40 min**: Implement solution, iterate
- **40-50 min**: Test thoroughly, handle edge cases
- **50-55 min**: Demo and explain
- **55-60 min**: Discuss trade-offs, improvements

**If running out of time:**

```
"I see we have about 10 minutes left.
I've implemented [X] and [Y].
Would you like me to continue with [Z] or
would you prefer I explain what I've done so far?"
```

**If you finish early:**

```
"The main feature is working. I could:
1. Add better error handling
2. Improve the UI/UX
3. Add test coverage
4. Optimize performance
What would be most valuable?"
```

## After the Interview

### Immediate Follow-up (Optional)

If you forgot to mention something important:

```
Email template:

Subject: Follow-up from interview

Hi [Interviewer],

Thanks for the interview today. I wanted to mention [important point
you forgot] that I realized after we spoke.

Also, I appreciate the feedback on [specific thing].

Looking forward to hearing from you.

Best,
[Your name]
```

### Self-Reflection

Rate yourself on:
- [ ] Problem clarification
- [ ] Code quality
- [ ] Communication
- [ ] AI collaboration
- [ ] Testing/validation
- [ ] Time management

**What went well:**
- ...

**What to improve:**
- ...

## Emergency Troubleshooting

### If dev server crashes during interview

```bash
# Quick restart
Ctrl+C  # Stop server
yarn dx # Restart

# If that doesn't work
docker-compose restart
yarn dx
```

### If you get a TypeScript error

```bash
# Regenerate types
yarn prisma generate

# Check types
yarn type-check:ci --force
```

### If you can't find a file

```bash
# Use search
rg "component name" --type tsx

# Or ask AI
"Where is the [X] component in this codebase?"
```

### If you're truly stuck (>5 minutes on same issue)

**Say:**
```
"I'm stuck on this specific issue. Let me step back and
explain what I'm trying to do and where I'm having trouble.
[Explain the issue]

Do you have any suggestions, or should I try a different approach?"
```

---

**Good luck! You're prepared and ready to succeed. Remember to breathe, think out loud, and show your engineering judgment.** 🚀
