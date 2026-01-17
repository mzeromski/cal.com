# Practice Exercises

## 🎯 Goal
Practice AI collaboration and Cal.com coding patterns before the interview with realistic exercises.

## How to Use This Guide

### Practice Session Structure (30-45 min each)

```
1. Read exercise requirements (2 min)
2. Plan approach (3 min)
3. Work with AI to implement (20-30 min)
4. Review solution (5 min)
5. Compare with solution notes (5 min)
```

### Practice Goals

- ✅ Get comfortable with Cursor AI prompting
- ✅ Learn Cal.com patterns
- ✅ Practice narrating your thinking
- ✅ Build muscle memory for common tasks
- ✅ Identify your weak spots

---

## Exercise 1: Add a Form Field (Beginner)

### Requirements

Add a "phone number" field to the booking form that:
- Is optional (not required)
- Validates phone format if provided
- Uses international format
- Saves to database

### Files You'll Touch

- `packages/prisma/schema.prisma` - Database schema
- `packages/trpc/server/routers/viewer/bookings/create.schema.ts` - Validation
- `apps/web/modules/bookings/` - UI components
- `apps/web/public/static/locales/en/common.json` - Translations

### Steps to Practice

1. **Plan** (Practice narrating out loud)
   ```
   "I need to add a phone field. This will require:
   1. Database schema update
   2. Validation schema
   3. Form field
   4. Translation
   Let me start with the database..."
   ```

2. **Implement with AI**
   - Use Template #2 from prompt templates
   - Ask AI for each change separately
   - Review each change before applying

3. **Test**
   - Run `yarn dx`
   - Create a booking with phone number
   - Create a booking without phone number
   - Try invalid phone format

### Success Criteria

- [ ] Field appears in form
- [ ] Optional (can submit without it)
- [ ] Validates format when provided
- [ ] Saves to database correctly
- [ ] No TypeScript errors
- [ ] Translation string added

### Time Target

20-30 minutes total

### Common Pitfalls

- Forgetting to run `yarn prisma generate`
- Using barrel imports
- Skipping translations
- Not testing with invalid input

### Solution Notes

<details>
<summary>Click to see approach</summary>

1. **Schema**: Add `phone String?` to Booking model
2. **Validation**: `phone: z.string().regex(/^[\+]?[0-9]{10,}$/).optional()`
3. **Form**: Use `PhoneInput` component from `@calcom/ui/components/phone-input`
4. **Translation**: Add `"phone_number": "Phone Number"`

Key learning: Always test with both valid and invalid input.
</details>

---

## Exercise 2: Create a Simple Component (Beginner)

### Requirements

Create a "BookingStats" component that displays:
- Total bookings count
- Number of pending bookings
- Number of confirmed bookings
- Number of cancelled bookings

Display as cards in a grid.

### Files You'll Create/Touch

- `apps/web/modules/bookings/components/BookingStats.tsx` - New component
- Might use existing tRPC endpoint or create new one

### Steps to Practice

1. **Explore** (Find similar components)
   ```
   Ask AI: "Show me existing statistics/card components in Cal.com"
   ```

2. **Plan Structure**
   ```
   "I'll create a component that:
   - Fetches booking data via tRPC
   - Calculates statistics
   - Displays in cards
   - Handles loading/error states"
   ```

3. **Implement Incrementally**
   - Component shell first
   - Add data fetching
   - Add UI
   - Add error handling
   - Test each step

### Success Criteria

- [ ] Component renders correctly
- [ ] Shows loading state while fetching
- [ ] Shows error state if fetch fails
- [ ] Displays all 4 statistics
- [ ] Cards are responsive
- [ ] No TypeScript errors
- [ ] Uses proper imports

### Time Target

30-40 minutes

### Common Pitfalls

- Not handling loading state
- Forgetting error handling
- Using `any` types
- Not making it responsive
- Barrel imports

### Practice Points

- Practice explaining component structure
- Practice reviewing AI-generated code
- Practice incremental building

### Solution Notes

<details>
<summary>Click to see approach</summary>

1. **Data**: Use `trpc.viewer.bookings.list.useQuery()` and filter by status
2. **Layout**: Use `grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4`
3. **Cards**: Use existing Card component from `@calcom/ui/components/card`
4. **States**: Handle `isLoading`, `error`, and `!data` cases

Key learning: Always plan UI structure before implementing.
</details>

---

## Exercise 3: Add tRPC Endpoint (Intermediate)

### Requirements

Create a tRPC endpoint to get booking statistics:
- Endpoint: `viewer.bookings.getStats`
- Returns: `{ total, pending, confirmed, cancelled }`
- Only returns stats for current user's bookings
- Efficient database query

### Files You'll Touch/Create

- `packages/trpc/server/routers/viewer/bookings/getStats.handler.ts`
- `packages/trpc/server/routers/viewer/bookings/getStats.schema.ts`
- `packages/trpc/server/routers/viewer/bookings/_router.ts`

### Steps to Practice

1. **Explore Pattern**
   ```
   "Show me an existing tRPC endpoint in viewer.bookings
   to understand the pattern"
   ```

2. **Plan Approach**
   ```
   "I need to:
   1. Create input schema (might be empty)
   2. Create handler with Prisma query
   3. Wire up in router
   4. Test with frontend"
   ```

3. **Implement**
   - Schema first (might just be `z.object({})`)
   - Handler with efficient Prisma query
   - Add to router
   - Test from frontend

### Success Criteria

- [ ] Endpoint returns correct data
- [ ] Uses `select` not `include`
- [ ] Only shows current user's data
- [ ] Efficient query (uses aggregation)
- [ ] Proper TypeScript types
- [ ] Error handling present
- [ ] Can be called from frontend

### Time Target

25-35 minutes

### Common Pitfalls

- Using `include` instead of `select`
- Inefficient queries (fetching all then filtering)
- Missing authentication check
- Exposing data from other users
- Not using proper error types

### Practice Points

- Practice explaining backend logic
- Practice security considerations
- Practice database query optimization

### Solution Notes

<details>
<summary>Click to see approach</summary>

1. **Query Strategy**: Use Prisma `groupBy` or multiple `count` queries
2. **Security**: Use `ctx.user.id` to filter bookings
3. **Efficiency**: Don't fetch full records, just counts
4. **Types**: Return type should be `{ total: number; pending: number; confirmed: number; cancelled: number }`

Key learning: Always consider security and performance for backend code.
</details>

---

## Exercise 4: Add Form Validation (Intermediate)

### Requirements

Update the event type form to validate:
- Title must be 3-100 characters
- Duration must be 5-240 minutes
- Description is optional but max 500 characters
- URL slug must be lowercase alphanumeric with hyphens only

### Files You'll Touch

- `packages/trpc/server/routers/viewer/eventTypes/create.schema.ts`
- `packages/trpc/server/routers/viewer/eventTypes/update.schema.ts`
- Frontend form component

### Steps to Practice

1. **Find Existing Validation**
   ```
   "Show me the current validation schema for event types"
   ```

2. **Plan Validations**
   ```
   "I'll add Zod validations for:
   - min/max length
   - regex pattern for slug
   - optional field constraints"
   ```

3. **Implement and Test**
   - Update Zod schemas
   - Test each validation rule
   - Check error messages are clear

### Success Criteria

- [ ] All validation rules work
- [ ] Clear error messages
- [ ] Both frontend and backend validation
- [ ] Can't submit invalid data
- [ ] Valid data works fine

### Time Target

20-30 minutes

### Practice Points

- Practice explaining validation rules
- Practice testing edge cases
- Practice both happy and sad paths

---

## Exercise 5: Debug a Type Error (Intermediate)

### Setup

Intentionally introduce a type error:

```typescript
// In some component
const booking = await trpc.viewer.bookings.get.fetch({ id: bookingId });
const userName = booking.user.name; // Error: Property 'user' does not exist
```

### Requirements

1. Understand why the error occurs
2. Fix it properly (not with `any`)
3. Explain the fix

### Steps to Practice

1. **Analyze Error**
   ```
   "Help me understand this TypeScript error.
   What's the root cause?"
   ```

2. **Investigate**
   - Check the return type of the tRPC query
   - Look at the Prisma query in the handler
   - Understand what data is actually returned

3. **Fix Properly**
   - Update backend to include needed data
   - OR adjust frontend to work with available data
   - Ensure types are correct

### Success Criteria

- [ ] No type errors
- [ ] No use of `any`
- [ ] Proper type safety maintained
- [ ] Code actually works at runtime

### Time Target

15-25 minutes

### Practice Points

- Practice debugging TypeScript errors
- Practice tracing data flow
- Practice explaining technical issues

---

## Exercise 6: Refactor for Better Code Quality (Advanced)

### Requirements

Find a component in the codebase that could be improved and refactor it to:
- Better type safety
- Better error handling
- Better code organization
- Better readability

### Steps to Practice

1. **Find Target**
   ```
   "Show me a component that could benefit from refactoring"
   ```

2. **Identify Issues**
   ```
   "What are the code quality issues here?
   - Type safety problems?
   - Missing error handling?
   - Too complex/nested?
   - Hard to understand?"
   ```

3. **Plan Refactoring**
   ```
   "I'll refactor by:
   1. [Improvement 1]
   2. [Improvement 2]
   3. [Improvement 3]
   Without changing functionality"
   ```

4. **Refactor Incrementally**
   - One improvement at a time
   - Test after each change
   - Ensure no regressions

### Success Criteria

- [ ] Code quality improved
- [ ] Functionality unchanged
- [ ] All types correct
- [ ] Better error handling
- [ ] More readable

### Time Target

30-45 minutes

### Practice Points

- Practice code review skills
- Practice explaining technical debt
- Practice incremental refactoring
- Practice testing after changes

---

## Exercise 7: Handle Edge Cases (Advanced)

### Requirements

Take any feature you've built and add comprehensive edge case handling:
- Null/undefined values
- Empty arrays/objects
- Invalid input
- Race conditions
- Network errors
- Permission errors

### Steps to Practice

1. **List Edge Cases**
   ```
   "What edge cases should I handle for [feature]?"
   ```

2. **Prioritize**
   ```
   "Which are most critical?
   Which are most likely to occur?"
   ```

3. **Implement Handling**
   - Add checks for each case
   - Add appropriate error messages
   - Add user feedback
   - Test each scenario

### Success Criteria

- [ ] All identified edge cases handled
- [ ] Clear error messages
- [ ] Good user experience even when things go wrong
- [ ] No crashes or undefined behavior

### Time Target

30-40 minutes

### Practice Points

- Practice defensive programming
- Practice thinking through failure modes
- Practice user experience under errors

---

## Exercise 8: Full Feature (Advanced)

### Requirements

Build a complete feature: "Favorite Bookings"

Users can:
- Mark bookings as favorites
- See all favorite bookings in a list
- Un-favorite bookings
- Filter bookings by favorite status

This requires:
- Database changes
- Backend API
- Frontend UI
- State management

### Steps to Practice

1. **Full Planning**
   ```
   "Let's plan this complete feature:
   - Database schema
   - API endpoints needed
   - UI components needed
   - User workflows
   - Edge cases"
   ```

2. **Implement Bottom-Up**
   - Database schema
   - Backend API
   - UI components
   - Integration
   - Testing

3. **Polish**
   - Error handling
   - Loading states
   - Empty states
   - Translations

### Success Criteria

- [ ] Feature fully functional
- [ ] All CRUD operations work
- [ ] Good user experience
- [ ] Proper error handling
- [ ] Type-safe throughout
- [ ] Follows conventions

### Time Target

45-60 minutes

### Practice Points

- Practice full feature development
- Practice integrating frontend/backend
- Practice complete testing
- **This simulates the interview scenario**

---

## Practice Routines

### Daily Practice (15-20 minutes)

Day 1-2: Exercise 1, 2
Day 3-4: Exercise 3, 4
Day 5-6: Exercise 5, 6
Day 7: Exercise 7 or 8

### Weekend Deep Practice (2-3 hours)

- Complete Exercise 8 start to finish
- Focus on narrating throughout
- Time yourself
- Review and identify areas to improve

### Pre-Interview Practice (Day before)

- Exercise 1 (speed run: 15 min)
- Exercise 3 (speed run: 20 min)
- Exercise 8 (focused: 45 min)

Focus on:
- Clear communication
- Reviewing AI output
- Testing thoroughly
- Following conventions

---

## Self-Evaluation Checklist

After each practice exercise:

### Planning
- [ ] Did I understand requirements before coding?
- [ ] Did I ask clarifying questions?
- [ ] Did I plan the approach?
- [ ] Did I identify files to modify?

### AI Collaboration
- [ ] Did I write clear prompts?
- [ ] Did I review AI output critically?
- [ ] Did I catch issues before applying code?
- [ ] Did I maintain control?

### Code Quality
- [ ] No TypeScript errors?
- [ ] Proper imports (direct, not barrel)?
- [ ] Good error handling?
- [ ] Edge cases covered?
- [ ] Follows conventions?

### Testing
- [ ] Did I test happy path?
- [ ] Did I test error cases?
- [ ] Did I test edge cases?
- [ ] Did I verify in browser?

### Communication
- [ ] Did I narrate my thinking?
- [ ] Could I explain decisions?
- [ ] Did I explain trade-offs?

### Time Management
- [ ] Did I stay within time target?
- [ ] Did I prioritize correctly?
- [ ] Did I know when to move on?

## Progress Tracking

Keep a log:

```
Exercise: [Number]
Date: [Date]
Time: [Actual time taken]
Completed: [Yes/No]
Success Criteria Met: [X/Y]
What went well:
- [Point 1]
- [Point 2]
What to improve:
- [Point 1]
- [Point 2]
Key learning:
- [Learning]
```

---

## Mock Interview Simulation

### Final Practice (Before Interview)

Set up a 60-minute mock interview:

**Scenario:**
"Add a notes feature to bookings where users can add private notes to any booking. Notes should be editable and deletable. Show all notes for a booking in a timeline view."

**Your task:**
1. Plan the feature (5 min)
2. Implement it (45 min)
3. Demo and explain (10 min)

**Simulate interview conditions:**
- Work as if interviewer is watching
- Narrate out loud the entire time
- Use AI assistance
- Review code critically
- Test thoroughly

**Self-evaluate:**
- Would you hire yourself based on this performance?
- What went well?
- What needs improvement?

---

**Remember**: The goal isn't to memorize solutions, it's to build confidence and muscle memory for the workflow you'll use in the interview.

Practice with intent, review critically, and improve iteratively!
