# Real Interview Scenarios - Complete Prompt & Response Examples

## 🎯 Goal
See exactly how to interact with Cursor AI through 5 realistic interview scenarios with full prompt/response dialogues.

---

## Scenario 1: Add a "Notes" Field to Booking Form

### Initial Requirement from Interviewer

> **Interviewer:** "Users want to add private notes when creating a booking. Add a notes field to the booking form. It should be optional and support up to 500 characters."

---

### Your Internal Planning (Think Out Loud)

**You say:**
```
"Okay, so I need to add a notes field to bookings. Let me think through what this requires:
1. Database - add notes column to Booking model
2. Backend - update the tRPC create booking schema
3. Frontend - add the field to the form
4. Validation - max 500 characters, optional

Let me start by checking the current database schema."
```

---

### Interaction 1: Understanding Current State

**Your Prompt:**
```
Show me the current Booking model in packages/prisma/schema.prisma

Focus on what fields already exist.
```

**Cursor Response:**
```typescript
model Booking {
  id          Int      @id @default(autoincrement())
  uid         String   @unique
  title       String
  description String?
  startTime   DateTime
  endTime     DateTime
  userId      Int
  user        User     @relation(fields: [userId], references: [id])
  // ... more fields
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

**You say:**
```
"Good, I can see the Booking model. There's already a 'description' field.
Let me check if notes should be different from description, or if we're adding
a separate field. I'll assume it's separate for private notes."
```

---

### Interaction 2: Update Database Schema

**Your Prompt:**
```
Add a 'notes' field to the Booking model in packages/prisma/schema.prisma

Requirements:
- Type: String
- Optional (nullable)
- This is for private user notes, separate from description

Show me only the field to add to the model.
```

**Cursor Response:**
```typescript
notes String? @db.Text
```

**You say:**
```
"Good. The @db.Text annotation allows for longer text than default String.
Let me add this to the schema."
```

**You apply the change, then say:**
```
"Now I need to generate the Prisma types."
```

**You run:**
```bash
yarn prisma generate
```

---

### Interaction 3: Update Backend Validation

**Your Prompt:**
```
Show me the Zod validation schema for creating a booking.

File should be in: packages/trpc/server/routers/viewer/bookings/create.schema.ts
```

**Cursor Response:**
```typescript
// packages/trpc/server/routers/viewer/bookings/create.schema.ts
import { z } from "zod";

export const ZCreateBookingSchema = z.object({
  title: z.string().min(1),
  description: z.string().optional(),
  startTime: z.date(),
  endTime: z.date(),
  // ... other fields
});
```

**You say:**
```
"I can see the validation schema. Now I need to add notes validation."
```

**Your Next Prompt:**
```
Add 'notes' field to this Zod schema.

Requirements:
- Optional field
- Max 500 characters
- Can be empty string or null

Show me just the line to add.
```

**Cursor Response:**
```typescript
notes: z.string().max(500, "Notes cannot exceed 500 characters").optional(),
```

**You say:**
```
"Perfect. This validates max length and makes it optional. Let me add this."
```

**You apply the change.**

---

### Interaction 4: Update Backend Handler

**Your Prompt:**
```
Now show me the booking creation handler.

File: packages/trpc/server/routers/viewer/bookings/create.handler.ts

I need to see where the Prisma create query is.
```

**Cursor Response:**
```typescript
export async function createBookingHandler({ ctx, input }: Options) {
  // ... validation logic
  
  const booking = await ctx.prisma.booking.create({
    data: {
      title: input.title,
      description: input.description,
      startTime: input.startTime,
      endTime: input.endTime,
      userId: ctx.user.id,
      // ... other fields
    },
    select: {
      id: true,
      title: true,
      // ... other fields
    },
  });
  
  return booking;
}
```

**You say:**
```
"I can see the create query. I need to add notes to the data object.
Also, I should include it in the select for the return value."
```

**Your Next Prompt:**
```
Update this Prisma query to include the notes field.

Changes needed:
1. Add notes to the data object
2. Add notes to the select object

Show me just the updated data and select objects.
```

**Cursor Response:**
```typescript
data: {
  title: input.title,
  description: input.description,
  notes: input.notes,  // Add this
  startTime: input.startTime,
  endTime: input.endTime,
  userId: ctx.user.id,
  // ... other fields
},
select: {
  id: true,
  title: true,
  notes: true,  // Add this
  // ... other fields
}
```

**You say:**
```
"Good. Let me apply these changes to the handler."
```

**You apply the changes.**

---

### Interaction 5: Update Frontend Form

**Your Prompt:**
```
Find the booking creation form component.

It should be in: apps/web/modules/bookings/

Show me which file contains the form.
```

**Cursor Response:**
```
The booking form is in: apps/web/modules/bookings/components/BookingForm.tsx
```

**Your Prompt:**
```
Show me the BookingForm.tsx file, specifically:
1. The useForm hook setup
2. Where form fields are rendered

I need to see the pattern for adding fields.
```

**Cursor Response:**
```typescript
// Simplified version
export function BookingForm() {
  const form = useForm<BookingFormValues>({
    resolver: zodResolver(bookingFormSchema),
  });
  
  return (
    <Form form={form} handleSubmit={onSubmit}>
      <TextField
        label={t("title")}
        {...form.register("title")}
      />
      
      <TextAreaField
        label={t("description")}
        {...form.register("description")}
        rows={3}
      />
      
      {/* ... other fields */}
    </Form>
  );
}
```

**You say:**
```
"I can see the pattern. TextAreaField is used for description.
I'll use the same for notes since it can be longer text."
```

**Your Next Prompt:**
```
Add a notes field to this form following the description field pattern.

Requirements:
- Use TextAreaField component
- Label should use translation key "notes"
- Register with form.register("notes")
- 4 rows for the textarea
- Add placeholder text using translation

Show me just the field component to add.
```

**Cursor Response:**
```typescript
<TextAreaField
  label={t("notes")}
  placeholder={t("add_private_notes")}
  {...form.register("notes")}
  rows={4}
/>
```

**You say:**
```
"Good. Now I need to add the translation keys."
```

**You apply the change.**

---

### Interaction 6: Add Translations

**Your Prompt:**
```
Add translation strings for the notes field.

File: apps/web/public/static/locales/en/common.json

Add these keys:
- "notes": translation for the label
- "add_private_notes": translation for placeholder

Show me the JSON entries to add.
```

**Cursor Response:**
```json
"notes": "Notes",
"add_private_notes": "Add private notes (optional)"
```

**You say:**
```
"Perfect. Let me add these to common.json."
```

**You apply the changes.**

---

### Testing & Validation

**You say:**
```
"Now let me test this in the browser. I'll:
1. Go to the booking form
2. Check that the notes field appears
3. Test creating a booking with notes
4. Test creating a booking without notes (should work since optional)
5. Test with 501 characters (should show validation error)"
```

**You test in browser and narrate:**
```
"Field appears... good.
Creating booking with notes... works, notes saved.
Creating without notes... works, optional field working correctly.
Testing with too many characters... validation error shows. Perfect."
```

---

### Final Review

**You say to interviewer:**
```
"I've successfully added the notes field. Let me walk through what I did:

1. Database: Added optional 'notes' field to Booking model as Text type
2. Backend: Added Zod validation with 500 char max to the create schema
3. Backend: Updated the handler to save and return notes
4. Frontend: Added TextAreaField to the form following existing patterns
5. Translations: Added label and placeholder text
6. Testing: Verified it works with and without notes, and validates max length

The field is optional as required, validates max length, and follows all
the Cal.com conventions - using select in Prisma, direct imports, etc."
```

---

## Scenario 2: Create a User Statistics Dashboard Widget

### Initial Requirement

> **Interviewer:** "Create a dashboard widget that shows user statistics: total bookings, upcoming bookings, and completion rate. Display it as cards."

---

### Your Planning

**You say:**
```
"I need to create a statistics widget. This will require:
1. Fetching booking data from tRPC
2. Calculating statistics
3. Creating a component to display as cards
4. Adding it to the dashboard

Let me first check if there's an existing tRPC endpoint for bookings."
```

---

### Interaction 1: Check Existing API

**Your Prompt:**
```
Show me what tRPC endpoints exist for bookings.

Looking for: packages/trpc/server/routers/viewer/bookings/

List the existing endpoints and what they do.
```

**Cursor Response:**
```
Existing endpoints in viewer.bookings:
- list: Gets all bookings for current user
- get: Gets a single booking by ID
- create: Creates a new booking
- update: Updates a booking
- delete: Deletes a booking
```

**You say:**
```
"There's a 'list' endpoint. Let me check what data it returns."
```

**Your Next Prompt:**
```
Show me the list endpoint handler.

File: packages/trpc/server/routers/viewer/bookings/list.handler.ts

I need to see what fields it returns.
```

**Cursor Response:**
```typescript
export async function listHandler({ ctx }: Options) {
  const bookings = await ctx.prisma.booking.findMany({
    where: { userId: ctx.user.id },
    select: {
      id: true,
      title: true,
      startTime: true,
      endTime: true,
      status: true, // "pending" | "confirmed" | "cancelled" | "completed"
    },
    orderBy: { startTime: "desc" },
  });
  
  return bookings;
}
```

**You say:**
```
"Perfect! The list endpoint returns status, which I can use to calculate stats.
It returns all bookings, so I can filter them on the frontend.
Now let me create the component."
```

---

### Interaction 2: Create Component Structure

**Your Prompt:**
```
Create a new component called BookingStats.

Location: apps/web/modules/bookings/components/BookingStats.tsx

Requirements:
- Fetch bookings using trpc.viewer.bookings.list
- Calculate: total bookings, upcoming (future startTime), completion rate
- Display as 3 cards in a grid
- Handle loading and error states
- Use TypeScript

Show me just the component structure first (no UI implementation yet).
Include:
- Imports
- Props interface (if needed)
- Data fetching
- Statistics calculation
- Loading/error handling
```

**Cursor Response:**
```typescript
import { trpc } from "@calcom/trpc/react";
import type { ReactNode } from "react";

export function BookingStats() {
  // Fetch bookings
  const { data: bookings, isLoading, error } = trpc.viewer.bookings.list.useQuery();
  
  // Handle loading
  if (isLoading) {
    return <div>Loading statistics...</div>;
  }
  
  // Handle error
  if (error) {
    return <div>Error loading statistics: {error.message}</div>;
  }
  
  // Handle no data
  if (!bookings) {
    return null;
  }
  
  // Calculate statistics
  const totalBookings = bookings.length;
  const now = new Date();
  const upcomingBookings = bookings.filter(b => new Date(b.startTime) > now).length;
  const completedBookings = bookings.filter(b => b.status === "completed").length;
  const completionRate = totalBookings > 0 
    ? Math.round((completedBookings / totalBookings) * 100) 
    : 0;
  
  // TODO: Render UI
  return <div>Stats widget</div>;
}
```

**You say:**
```
"Good structure. The data fetching and calculations look correct.
Now let me review the calculations more carefully..."
```

---

### Interaction 3: Review and Refine

**You say:**
```
"Wait, I should double-check the completion rate calculation.
Let me make sure the logic is sound."
```

**Your Prompt:**
```
Review the completion rate calculation in this code.

Is there any issue with how it's calculated?
Should we handle the case where totalBookings is 0 differently?
```

**Cursor Response:**
```
The calculation looks correct. It handles the zero division case by returning 0.

However, you might want to consider:
1. Only completed or cancelled bookings should count as "finished"
2. Pending/confirmed bookings shouldn't affect completion rate
3. You might want to show "N/A" instead of "0%" when there are no finished bookings

Suggested improvement:
```typescript
const finishedBookings = bookings.filter(
  b => b.status === "completed" || b.status === "cancelled"
);
const completionRate = finishedBookings.length > 0
  ? Math.round((completedBookings / finishedBookings.length) * 100)
  : null; // or 0, depending on UX preference
```
```

**You say:**
```
"Good catch. Let me adjust the logic to only consider finished bookings."
```

**You apply the refinement.**

---

### Interaction 4: Add UI Implementation

**Your Prompt:**
```
Now add the UI for the statistics cards.

Requirements:
- 3 cards in a responsive grid (1 col mobile, 3 cols desktop)
- Each card shows: number (large), label (small)
- Use components from @calcom/ui/components/
- Use Tailwind for styling
- Follow Cal.com's existing card patterns

Check similar components for reference if needed.
Show me the UI implementation.
```

**Cursor Response:**
```typescript
import { Card } from "@calcom/ui/components/card";
import { useTranslation } from "next-i18next";

// ... (previous code)

return (
  <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
    {/* Total Bookings Card */}
    <Card>
      <div className="p-6">
        <p className="text-3xl font-bold text-gray-900">{totalBookings}</p>
        <p className="text-sm text-gray-500">{t("total_bookings")}</p>
      </div>
    </Card>
    
    {/* Upcoming Bookings Card */}
    <Card>
      <div className="p-6">
        <p className="text-3xl font-bold text-gray-900">{upcomingBookings}</p>
        <p className="text-sm text-gray-500">{t("upcoming_bookings")}</p>
      </div>
    </Card>
    
    {/* Completion Rate Card */}
    <Card>
      <div className="p-6">
        <p className="text-3xl font-bold text-gray-900">
          {completionRate !== null ? `${completionRate}%` : "N/A"}
        </p>
        <p className="text-sm text-gray-500">{t("completion_rate")}</p>
      </div>
    </Card>
  </div>
);
```

**You say:**
```
"Good! The UI uses Cal.com's Card component and Tailwind classes.
It's responsive with the grid. I need to add the translation keys."
```

---

### Interaction 5: Add Translations and Loading State

**Your Prompt:**
```
Two quick tasks:

1. Add translation keys to common.json:
   - total_bookings
   - upcoming_bookings
   - completion_rate

2. Improve the loading state to show skeleton cards instead of plain text

Show me both updates.
```

**Cursor Response:**
```json
// Translations
"total_bookings": "Total Bookings",
"upcoming_bookings": "Upcoming",
"completion_rate": "Completion Rate"
```

```typescript
// Loading state
if (isLoading) {
  return (
    <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
      {[1, 2, 3].map((i) => (
        <Card key={i}>
          <div className="p-6">
            <div className="h-8 w-24 animate-pulse bg-gray-200 rounded" />
            <div className="mt-2 h-4 w-32 animate-pulse bg-gray-200 rounded" />
          </div>
        </Card>
      ))}
    </div>
  );
}
```

**You say:**
```
"Perfect! The skeleton loading state matches the card layout. Much better UX.
Let me apply these changes and test."
```

---

### Testing

**You say:**
```
"Testing in the browser:
- Component renders correctly
- Shows skeleton while loading
- Statistics calculate correctly
- Cards are responsive
- No console errors
- TypeScript compiles without errors

Everything looks good!"
```

---

### Explanation to Interviewer

**You say:**
```
"I've created the BookingStats widget. Here's what it does:

1. Data: Fetches bookings via existing tRPC list endpoint
2. Logic: Calculates three statistics with proper edge case handling
3. UI: Three responsive cards using Cal.com's Card component
4. UX: Skeleton loading state, error handling, proper formatting
5. i18n: Translation keys for all labels

Key decisions:
- Reused existing API instead of creating new endpoint (simpler)
- Completion rate only counts finished bookings (better metric)
- Skeleton cards for loading (better UX than plain text)
- Responsive grid for mobile/desktop

If I had more time, I'd add:
- Click-through to detailed views
- Date range filtering
- More statistics like average booking duration"
```

---

## Scenario 3: Add Filtering to Booking List

### Initial Requirement

> **Interviewer:** "Users want to filter the booking list by status. Add a filter dropdown above the list that filters by pending, confirmed, cancelled, or all."

---

### Your Planning

**You say:**
```
"I need to add filtering to the existing booking list. Let me:
1. Find the booking list component
2. Add a filter dropdown
3. Filter the displayed bookings based on selection
4. Maintain the filter state

This is purely frontend - no backend changes needed since we already
fetch all bookings."
```

---

### Interaction 1: Find the Component

**Your Prompt:**
```
Find the booking list component.

Should be in: apps/web/modules/bookings/

Show me the file that renders the list of bookings.
```

**Cursor Response:**
```
The booking list is in: apps/web/modules/bookings/components/BookingsList.tsx
```

**Your Next Prompt:**
```
Show me the BookingsList.tsx component.

I need to see:
1. How bookings are fetched
2. How they're currently displayed
3. The component structure
```

**Cursor Response:**
```typescript
export function BookingsList() {
  const { data: bookings, isLoading } = trpc.viewer.bookings.list.useQuery();
  
  if (isLoading) return <LoadingSpinner />;
  if (!bookings) return null;
  
  return (
    <div className="space-y-4">
      {bookings.map((booking) => (
        <BookingCard key={booking.id} booking={booking} />
      ))}
    </div>
  );
}
```

**You say:**
```
"Simple structure. I need to:
1. Add state for selected filter
2. Add dropdown component
3. Filter bookings before mapping
Let me do this incrementally."
```

---

### Interaction 2: Add Filter State

**Your Prompt:**
```
Add filter state to this component.

Requirements:
- Use useState for filter selection
- Filter options: "all", "pending", "confirmed", "cancelled"
- Default to "all"
- Create a filtered bookings array based on selection

Show me just the state and filtering logic to add.
DON'T show the full component yet.
```

**Cursor Response:**
```typescript
import { useState } from "react";

// Inside component
const [statusFilter, setStatusFilter] = useState<"all" | "pending" | "confirmed" | "cancelled">("all");

// Filter bookings
const filteredBookings = statusFilter === "all"
  ? bookings
  : bookings.filter(booking => booking.status === statusFilter);
```

**You say:**
```
"Good. Clean filtering logic. Now I need the dropdown UI."
```

---

### Interaction 3: Add Dropdown UI

**Your Prompt:**
```
Add a Select dropdown for the status filter.

Requirements:
- Use Select component from @calcom/ui/components/select
- Place above the bookings list
- Label: "Filter by status"
- Options: All, Pending, Confirmed, Cancelled
- onChange updates the statusFilter state
- Use translations for labels

Show me the Select component and where to place it.
```

**Cursor Response:**
```typescript
import { Select } from "@calcom/ui/components/select";
import { useTranslation } from "next-i18next";

// Inside component
const { t } = useTranslation("common");

// In JSX (above the bookings list)
<div className="mb-4">
  <Select
    label={t("filter_by_status")}
    value={statusFilter}
    onChange={(e) => setStatusFilter(e.target.value as typeof statusFilter)}
    options={[
      { label: t("all"), value: "all" },
      { label: t("pending"), value: "pending" },
      { label: t("confirmed"), value: "confirmed" },
      { label: t("cancelled"), value: "cancelled" },
    ]}
  />
</div>
```

**You say:**
```
"Perfect. Now I need to use filteredBookings in the map instead of bookings."
```

---

### Interaction 4: Complete Implementation

**Your Prompt:**
```
Show me the complete updated BookingsList component with:
1. Filter state
2. Filter dropdown
3. Filtered bookings being mapped

Make sure I use filteredBookings in the map, not bookings.
```

**Cursor Response:**
```typescript
import { useState } from "react";
import { Select } from "@calcom/ui/components/select";
import { useTranslation } from "next-i18next";
import { trpc } from "@calcom/trpc/react";
import { LoadingSpinner } from "@calcom/ui/components/loading";
import { BookingCard } from "./BookingCard";

export function BookingsList() {
  const { t } = useTranslation("common");
  const { data: bookings, isLoading } = trpc.viewer.bookings.list.useQuery();
  
  const [statusFilter, setStatusFilter] = useState<"all" | "pending" | "confirmed" | "cancelled">("all");
  
  if (isLoading) return <LoadingSpinner />;
  if (!bookings) return null;
  
  // Filter bookings
  const filteredBookings = statusFilter === "all"
    ? bookings
    : bookings.filter(booking => booking.status === statusFilter);
  
  return (
    <div>
      {/* Filter dropdown */}
      <div className="mb-4">
        <Select
          label={t("filter_by_status")}
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value as typeof statusFilter)}
          options={[
            { label: t("all"), value: "all" },
            { label: t("pending"), value: "pending" },
            { label: t("confirmed"), value: "confirmed" },
            { label: t("cancelled"), value: "cancelled" },
          ]}
        />
      </div>
      
      {/* Bookings list */}
      <div className="space-y-4">
        {filteredBookings.length === 0 ? (
          <p className="text-gray-500">{t("no_bookings_found")}</p>
        ) : (
          filteredBookings.map((booking) => (
            <BookingCard key={booking.id} booking={booking} />
          ))
        )}
      </div>
    </div>
  );
}
```

**You say:**
```
"Great! I notice it also added an empty state when no bookings match the filter.
That's a good UX touch. Let me add the translation keys."
```

---

### Interaction 5: Add Translations

**Your Prompt:**
```
Add translation keys for the filter feature to common.json:
- filter_by_status
- all (if not exists)
- pending (if not exists)
- confirmed (if not exists)
- cancelled (if not exists)
- no_bookings_found

Show me the JSON entries.
```

**Cursor Response:**
```json
"filter_by_status": "Filter by Status",
"all": "All",
"pending": "Pending",
"confirmed": "Confirmed",
"cancelled": "Cancelled",
"no_bookings_found": "No bookings found"
```

**You apply all changes.**

---

### Testing

**You say:**
```
"Testing the filter:
- Select 'All' - shows all bookings ✓
- Select 'Pending' - shows only pending ✓
- Select 'Confirmed' - shows only confirmed ✓
- Select 'Cancelled' - shows only cancelled ✓
- No bookings case - shows 'No bookings found' ✓

Working perfectly!"
```

---

### Explanation

**You say:**
```
"I've added the status filter. Implementation details:

1. State: Simple useState with union type for type safety
2. Filtering: Client-side filtering since we already have all data
3. UI: Cal.com's Select component with proper labels
4. UX: Empty state when no matches, maintains selection when new data loads
5. i18n: All labels translated

This is a client-side solution which works well for reasonable data volumes.
For thousands of bookings, we'd want to add server-side filtering with
pagination to the tRPC endpoint."
```

---

## Scenario 4: Fix a TypeScript Error

### Initial Situation

> **Interviewer:** "I'm seeing a TypeScript error. Can you fix it?"

**Error shown:**
```
Property 'attendeeName' does not exist on type 'Booking'
File: apps/web/modules/bookings/components/BookingCard.tsx
Line: 42
```

---

### Your Approach

**You say:**
```
"I see a TypeScript error about 'attendeeName' not existing on the Booking type.
Let me investigate:
1. First, check what properties Booking actually has
2. Check if this is a backend or frontend typing issue
3. Fix properly without using 'any'
"
```

---

### Interaction 1: Understand the Error

**Your Prompt:**
```
Show me the code causing the error.

File: apps/web/modules/bookings/components/BookingCard.tsx
Around line 42

I need to see how attendeeName is being used.
```

**Cursor Response:**
```typescript
export function BookingCard({ booking }: { booking: Booking }) {
  return (
    <div className="card">
      <h3>{booking.title}</h3>
      <p>{booking.attendeeName}</p>  {/* Line 42 - ERROR */}
      <p>{format(booking.startTime, "PPP")}</p>
    </div>
  );
}
```

**You say:**
```
"So we're trying to access attendeeName on the booking object,
but TypeScript says it doesn't exist. Let me check the type definition."
```

---

### Interaction 2: Check Type Definition

**Your Prompt:**
```
What is the type of 'booking' in this component?

Trace back:
1. The Booking type import
2. Where it's defined
3. What fields it actually has
```

**Cursor Response:**
```typescript
// At top of file
import type { Booking } from "@prisma/client";

// The Booking type from Prisma schema has these fields:
// id, uid, title, startTime, endTime, userId, ...
// But NO 'attendeeName' field
```

**You say:**
```
"Ah! The issue is that we're importing the Prisma Booking type,
but the actual data being passed might be from a tRPC query that
selects different fields. Let me check where this component is used."
```

---

### Interaction 3: Check Data Source

**Your Prompt:**
```
Show me where BookingCard is used and what data is passed to it.

Search for components that render <BookingCard
```

**Cursor Response:**
```typescript
// In BookingsList.tsx
const { data: bookings } = trpc.viewer.bookings.list.useQuery();

bookings.map((booking) => (
  <BookingCard key={booking.id} booking={booking} />
))
```

**You say:**
```
"Now I need to check what the tRPC endpoint actually returns."
```

**Your Next Prompt:**
```
Show me the return type of trpc.viewer.bookings.list

File: packages/trpc/server/routers/viewer/bookings/list.handler.ts

What fields does the Prisma query select?
```

**Cursor Response:**
```typescript
export async function listHandler({ ctx }: Options) {
  const bookings = await ctx.prisma.booking.findMany({
    where: { userId: ctx.user.id },
    select: {
      id: true,
      uid: true,
      title: true,
      startTime: true,
      endTime: true,
      status: true,
      // attendeeName is NOT in the select!
    },
  });
  
  return bookings;
}
```

**You say:**
```
"Found it! The problem is that attendeeName exists in the database schema,
but the tRPC endpoint isn't selecting it. I have two options:
1. Add attendeeName to the backend select
2. Remove the usage from the frontend

Let me check if attendeeName actually exists in the Prisma schema."
```

---

### Interaction 4: Check Schema

**Your Prompt:**
```
Show me the Booking model in packages/prisma/schema.prisma

Does it have an attendeeName field?
```

**Cursor Response:**
```prisma
model Booking {
  id            Int      @id @default(autoincrement())
  // ... other fields
  attendeeName  String
  attendeeEmail String
  // ... more fields
}
```

**You say:**
```
"Yes! attendeeName exists in the schema. The fix is to add it to
the select in the tRPC handler. That's the proper solution."
```

---

### Interaction 5: Implement Fix

**Your Prompt:**
```
Update the list.handler.ts to include attendeeName in the select.

File: packages/trpc/server/routers/viewer/bookings/list.handler.ts

Show me the updated select object.
```

**Cursor Response:**
```typescript
select: {
  id: true,
  uid: true,
  title: true,
  startTime: true,
  endTime: true,
  status: true,
  attendeeName: true,  // Add this
  attendeeEmail: true, // You might want this too
},
```

**You say:**
```
"Perfect. Now TypeScript will know that attendeeName is available.
Let me apply this fix."
```

**You apply the change.**

---

### Verify Fix

**You say:**
```
"Running type check to verify the error is gone:"
```

**You run:**
```bash
yarn type-check:ci --force
```

**You say:**
```
"Type check passes! No more errors. The fix is complete."
```

---

### Explanation

**You say:**
```
"I fixed the TypeScript error. The issue was:

Root cause: The tRPC endpoint wasn't selecting the attendeeName field from
the database, even though it exists in the schema.

Solution: Added attendeeName to the Prisma select in the list handler.

Why this is correct:
1. attendeeName exists in the database
2. The frontend component legitimately needs it
3. Adding it to select is the proper way (not using 'any')
4. TypeScript now correctly reflects the runtime data

Alternative I didn't choose:
- Remove attendeeName from the UI (but we need it for UX)
- Use 'any' type (bad practice, loses type safety)
- Use optional chaining like booking.attendeeName? (masks the real issue)

This demonstrates understanding of the data flow: Prisma schema → tRPC handler
→ Frontend types."
```

---

## Scenario 5: Improve Performance - Add Pagination

### Initial Requirement

> **Interviewer:** "The booking list is slow when users have many bookings. Add pagination to improve performance."

---

### Your Planning

**You say:**
```
"Performance issue with large lists. Pagination requires:
1. Backend: Modify tRPC endpoint to support pagination (limit, offset)
2. Backend: Return total count for UI
3. Frontend: Add pagination controls
4. Frontend: Manage current page state
5. Test with large dataset

This is more complex - requires both backend and frontend changes.
Let me plan the approach first."
```

---

### Interaction 1: Plan the Implementation

**Your Prompt:**
```
I need to add pagination to the bookings list.

Before implementing, help me plan:

1. What changes are needed in the tRPC endpoint?
2. What pagination pattern does Cal.com use elsewhere?
3. What should the API response look like?
4. What pagination controls should the UI have?

Don't generate code yet, just help me think through the approach.
```

**Cursor Response:**
```
Suggested Approach:

1. Backend Changes (tRPC):
   - Add input schema with 'page' and 'limit' parameters
   - Use Prisma's skip and take for pagination
   - Also return total count for page calculation
   - Return: { bookings: [...], totalCount: number }

2. Cal.com Patterns:
   - Check existing paginated lists in the codebase
   - Example: Event types list uses pagination
   - Look at: packages/trpc/server/routers/viewer/eventTypes/list.handler.ts

3. API Response Structure:
   ```typescript
   {
     bookings: Booking[],
     totalCount: number,
     pageSize: number,
     currentPage: number
   }
   ```

4. UI Components:
   - Page size selector (10, 25, 50, 100)
   - Previous/Next buttons
   - Page number display ("Showing X-Y of Z")
   - Consider using Cal.com's existing Pagination component
```

**You say:**
```
"Good plan. Let me first check the existing event types pagination
to follow that pattern."
```

---

### Interaction 2: Check Existing Pattern

**Your Prompt:**
```
Show me how event types list handles pagination.

File: packages/trpc/server/routers/viewer/eventTypes/list.handler.ts

I want to see the input schema and handler logic.
```

**Cursor Response:**
```typescript
// Input schema
export const ZListInput = z.object({
  limit: z.number().min(1).max(100).default(10),
  cursor: z.number().optional(), // or page-based: page: z.number()
});

// Handler
export async function listHandler({ ctx, input }: Options) {
  const { limit, cursor } = input;
  
  const eventTypes = await ctx.prisma.eventType.findMany({
    where: { userId: ctx.user.id },
    take: limit + 1, // Fetch one extra for hasMore
    skip: cursor ? 1 : 0,
    cursor: cursor ? { id: cursor } : undefined,
    // ...
  });
  
  let hasMore = false;
  if (eventTypes.length > limit) {
    hasMore = true;
    eventTypes.pop();
  }
  
  return {
    eventTypes,
    hasMore,
    nextCursor: hasMore ? eventTypes[eventTypes.length - 1].id : undefined,
  };
}
```

**You say:**
```
"I see they use cursor-based pagination. But for bookings, page-based
might be simpler since we want page numbers. Let me implement page-based
pagination instead."
```

---

### Interaction 3: Update Backend Schema

**Your Prompt:**
```
Create pagination input schema for bookings list.

File: packages/trpc/server/routers/viewer/bookings/list.schema.ts

Use page-based pagination:
- page: number (default 1)
- limit: number (default 10, max 100)

Show me the Zod schema.
```

**Cursor Response:**
```typescript
import { z } from "zod";

export const ZListBookingsInput = z.object({
  page: z.number().int().positive().default(1),
  limit: z.number().int().min(1).max(100).default(10),
  status: z.enum(["pending", "confirmed", "cancelled", "completed"]).optional(),
});

export type TListBookingsInput = z.infer<typeof ZListBookingsInput>;
```

**You say:**
```
"Good! It also included status filter which is a nice touch for
server-side filtering. Now let me update the handler."
```

---

### Interaction 4: Update Backend Handler

**Your Prompt:**
```
Update the bookings list handler to support pagination.

File: packages/trpc/server/routers/viewer/bookings/list.handler.ts

Requirements:
- Use skip and take for pagination
- Calculate skip from page and limit
- Get total count for pagination controls
- Return: { bookings, totalCount, page, limit }
- Filter by status if provided

Show me the updated handler.
```

**Cursor Response:**
```typescript
import type { TListBookingsInput } from "./list.schema";

interface ListHandlerOptions {
  ctx: {
    prisma: PrismaClient;
    user: { id: number };
  };
  input: TListBookingsInput;
}

export async function listHandler({ ctx, input }: ListHandlerOptions) {
  const { page, limit, status } = input;
  
  // Calculate skip
  const skip = (page - 1) * limit;
  
  // Build where clause
  const where = {
    userId: ctx.user.id,
    ...(status && { status }),
  };
  
  // Get bookings and total count in parallel
  const [bookings, totalCount] = await Promise.all([
    ctx.prisma.booking.findMany({
      where,
      select: {
        id: true,
        title: true,
        startTime: true,
        endTime: true,
        status: true,
        attendeeName: true,
        attendeeEmail: true,
      },
      orderBy: { startTime: "desc" },
      skip,
      take: limit,
    }),
    ctx.prisma.booking.count({ where }),
  ]);
  
  return {
    bookings,
    totalCount,
    page,
    limit,
    totalPages: Math.ceil(totalCount / limit),
  };
}
```

**You say:**
```
"Excellent! It uses Promise.all to fetch bookings and count in parallel
for better performance. The pagination math looks correct. Now the frontend."
```

---

### Interaction 5: Update Frontend

**Your Prompt:**
```
Update BookingsList component to use pagination.

Requirements:
- Add state for current page and limit
- Pass page and limit to tRPC query
- Show pagination controls (Previous, Next, page info)
- Show "Showing X-Y of Z bookings"
- Disable Previous on first page, Next on last page

Show me the updated component.
```

**Cursor Response:**
```typescript
import { useState } from "react";
import { Button } from "@calcom/ui/components/button";
import { Select } from "@calcom/ui/components/select";
import { useTranslation } from "next-i18next";
import { trpc } from "@calcom/trpc/react";

export function BookingsList() {
  const { t } = useTranslation("common");
  const [page, setPage] = useState(1);
  const [limit, setLimit] = useState(10);
  
  const { data, isLoading } = trpc.viewer.bookings.list.useQuery({
    page,
    limit,
  });
  
  if (isLoading) return <LoadingSpinner />;
  if (!data) return null;
  
  const { bookings, totalCount, totalPages } = data;
  const startItem = (page - 1) * limit + 1;
  const endItem = Math.min(page * limit, totalCount);
  
  return (
    <div>
      {/* Controls Bar */}
      <div className="mb-4 flex items-center justify-between">
        <div className="text-sm text-gray-600">
          {t("showing_x_to_y_of_z", { 
            start: startItem, 
            end: endItem, 
            total: totalCount 
          })}
        </div>
        
        <Select
          label={t("per_page")}
          value={limit}
          onChange={(e) => {
            setLimit(Number(e.target.value));
            setPage(1); // Reset to first page
          }}
          options={[
            { label: "10", value: 10 },
            { label: "25", value: 25 },
            { label: "50", value: 50 },
          ]}
        />
      </div>
      
      {/* Bookings List */}
      <div className="space-y-4">
        {bookings.map((booking) => (
          <BookingCard key={booking.id} booking={booking} />
        ))}
      </div>
      
      {/* Pagination Controls */}
      <div className="mt-6 flex items-center justify-between">
        <Button
          onClick={() => setPage(page - 1)}
          disabled={page === 1}
          variant="secondary"
        >
          {t("previous")}
        </Button>
        
        <span className="text-sm text-gray-600">
          {t("page_x_of_y", { current: page, total: totalPages })}
        </span>
        
        <Button
          onClick={() => setPage(page + 1)}
          disabled={page === totalPages}
          variant="secondary"
        >
          {t("next")}
        </Button>
      </div>
    </div>
  );
}
```

**You say:**
```
"Great! The component has all the pagination controls. I notice it resets
to page 1 when changing the limit - that's good UX. Let me add the
translation keys."
```

---

### Interaction 6: Add Translations

**Your Prompt:**
```
Add translation keys for pagination to common.json:
- showing_x_to_y_of_z (with variables)
- per_page
- page_x_of_y (with variables)
- previous
- next

Show me the JSON with proper interpolation syntax.
```

**Cursor Response:**
```json
"showing_x_to_y_of_z": "Showing {{start}}-{{end}} of {{total}} bookings",
"per_page": "Per page",
"page_x_of_y": "Page {{current}} of {{total}}",
"previous": "Previous",
"next": "Next"
```

**You apply all changes.**

---

### Testing & Validation

**You say:**
```
"Now let me test the pagination:
1. Check that it loads first page (10 items)
2. Click Next - should show next 10
3. Click Previous - should go back
4. Change to 25 per page - should reset to page 1 and show 25
5. Check that Previous is disabled on page 1
6. Check that Next is disabled on last page

Testing... all working correctly!

Let me also verify the backend is efficient:"
```

**Your Prompt:**
```
Review the pagination implementation for performance issues.

Are there any problems with:
1. The database queries
2. The parallel count query
3. The pagination math
```

**Cursor Response:**
```
The implementation looks good:

✅ Uses skip/take for efficient pagination
✅ Count query runs in parallel with data query
✅ Pagination math is correct
✅ Where clause properly filters

Potential optimization:
- For very large datasets, consider adding an index on (userId, startTime)
- The count query can be expensive; consider caching if needed

But for typical use cases (hundreds to thousands of bookings per user),
this implementation is solid.
```

**You say:**
```
"Good to know about the index suggestion. I'll mention that."
```

---

### Explanation to Interviewer

**You say:**
```
"I've implemented pagination for the bookings list. Here's the complete solution:

Backend Changes:
1. Added pagination input schema (page, limit, optional status filter)
2. Updated handler to use skip/take for pagination
3. Added parallel count query for efficiency
4. Returns pagination metadata (totalPages, etc.)

Frontend Changes:
1. Added page and limit state
2. Pass pagination params to query
3. Added pagination controls (Previous/Next buttons)
4. Added page size selector (10/25/50)
5. Shows "Showing X-Y of Z" info
6. Proper disabled states for buttons

Performance Improvements:
- Only loads one page at a time (vs. all bookings before)
- Parallel queries for data + count
- Server-side filtering and pagination

User Experience:
- Clear indication of current position
- Configurable page size
- Proper button states
- Resets to page 1 when changing filters

Future Optimizations:
- Could add database index on (userId, startTime) for even better performance
- Could cache count query result briefly
- Could add URL state to persist page across navigation

This scales well from 10 to 10,000+ bookings per user."
```

---

## Key Takeaways from These Scenarios

### Pattern Recognition
- Always plan before implementing
- Break complex tasks into steps
- Check existing patterns first
- Review AI output critically

### Communication
- Narrate your thinking process
- Explain why, not just what
- Discuss trade-offs
- Acknowledge alternatives

### Quality Control
- Test thoroughly (happy path + edge cases)
- Check TypeScript errors
- Verify in browser
- Consider performance

### AI Collaboration
- Specific, constrained prompts
- Incremental implementation
- Review before applying
- Ask for explanations

---

**Practice these scenarios before the interview to build muscle memory for the workflow!**
