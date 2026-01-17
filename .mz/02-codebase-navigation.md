# Codebase Navigation Guide

## 🎯 Goal
Quickly locate and understand relevant code during the 60-minute interview.

## Project Structure Overview

```
cal.com/
├── apps/
│   ├── web/              # Main Next.js application (⭐ MOST IMPORTANT)
│   │   ├── app/          # App Router pages (newer)
│   │   ├── pages/        # Pages Router (legacy, still used)
│   │   ├── modules/      # Feature modules
│   │   └── public/       # Static assets, translations
│   ├── api/              # API v2 application
│   └── ...
├── packages/
│   ├── prisma/           # Database schema & migrations
│   ├── trpc/             # tRPC API layer (⭐ IMPORTANT)
│   ├── ui/               # Shared UI components (⭐ IMPORTANT)
│   ├── features/         # Feature-specific code
│   ├── lib/              # Shared utilities
│   └── app-store/        # Third-party integrations
├── AGENTS.md             # Development guide for AI agents
└── agents/               # Extended documentation
```

## Key Directories Explained

### 🌟 apps/web/ - Main Application

**What to know:**
- This is where you'll spend most of your time
- Mix of App Router (`app/`) and Pages Router (`pages/`)
- `modules/` contains feature-specific components

**Important subdirectories:**
```
apps/web/
├── app/                  # New App Router pages
│   ├── (main)/          # Main app layout
│   └── api/             # API routes
├── pages/               # Legacy Pages Router
│   ├── api/             # API endpoints
│   ├── event-types/     # Event type management
│   ├── bookings/        # Booking management
│   └── settings/        # User settings
├── modules/             # Modular features
│   ├── bookings/        # Booking-related components
│   ├── event-types/     # Event type components
│   └── shell/           # Layout, navigation
└── public/
    └── static/locales/en/common.json  # Translations
```

### 📦 packages/ui/ - Shared Components

**What to know:**
- Reusable UI components
- Based on Radix UI + Tailwind
- Import from source, not barrel: `@calcom/ui/components/button`

**Common components:**
```
packages/ui/components/
├── button/              # Button component
├── form/               # Form components (crucial!)
├── dialog/             # Modal dialogs
├── tooltip/            # Tooltips
└── ...
```

### 🔌 packages/trpc/ - API Layer

**What to know:**
- Type-safe API using tRPC
- All backend logic
- Uses React Query for data fetching

**Structure:**
```
packages/trpc/server/
├── routers/            # API endpoints
│   ├── viewer/         # Main router
│   │   ├── eventTypes/ # Event type operations
│   │   ├── bookings/   # Booking operations
│   │   └── ...
│   └── ...
└── trpc.ts            # tRPC setup
```

### 🗄️ packages/prisma/ - Database

**What to know:**
- PostgreSQL with Prisma ORM
- Schema in `schema.prisma`
- Migrations in `migrations/`

**Key files:**
```
packages/prisma/
├── schema.prisma       # Database schema (⭐ READ THIS)
├── migrations/         # Database migrations
└── seed.ts            # Seed data script
```

## Quick Navigation Strategies

### Strategy 1: Search by Feature

**Looking for booking-related code?**
```bash
# Find all booking files
rg -l "booking" --type ts --type tsx

# Or use IDE search (Cmd/Ctrl + Shift + F)
# Search: "booking" in *.ts, *.tsx files
```

**Looking for event types?**
```bash
rg -l "eventType" --type ts --type tsx
```

### Strategy 2: Follow Component Hierarchy

**Example: Finding booking form**
1. Start at page: `apps/web/pages/bookings/index.tsx`
2. Find component imports
3. Navigate to component: `apps/web/modules/bookings/BookingForm.tsx`
4. Check API calls (tRPC hooks)
5. Find backend: `packages/trpc/server/routers/viewer/bookings/`

### Strategy 3: Use AI for Navigation

**Effective prompts:**
```
"Where is the booking creation form in this codebase?"

"Show me where event types are defined in the database schema"

"Find the component that renders the availability picker"

"Where are booking validations performed?"
```

### Strategy 4: Start from Routes

**App Router (apps/web/app/):**
```
app/
├── (main)/
│   └── event-types/
│       └── page.tsx    # Event types list page
```

**Pages Router (apps/web/pages/):**
```
pages/
├── event-types/
│   ├── index.tsx       # Event types list
│   └── [type].tsx      # Edit event type
```

## Common Code Patterns

### 1. Forms (React Hook Form)

**Pattern:**
```typescript
import { useForm } from "react-hook-form";
import { Form } from "@calcom/ui/components/form";

const MyForm = () => {
  const form = useForm({
    defaultValues: { ... }
  });

  return (
    <Form form={form} handleSubmit={...}>
      {/* Form fields */}
    </Form>
  );
};
```

**Where to find:**
- Search for `useForm` or `react-hook-form`
- Look in `apps/web/modules/*/components/`

### 2. API Calls (tRPC)

**Pattern:**
```typescript
import { trpc } from "@calcom/trpc/react";

const MyComponent = () => {
  const { data, isLoading } = trpc.viewer.eventTypes.list.useQuery();
  const mutation = trpc.viewer.eventTypes.create.useMutation();

  // Use data and mutation
};
```

**Where to find:**
- Frontend: Search for `trpc.viewer`
- Backend: `packages/trpc/server/routers/viewer/`

### 3. Database Queries (Prisma)

**Pattern:**
```typescript
import { prisma } from "@calcom/prisma";

const booking = await prisma.booking.findFirst({
  select: {
    id: true,
    title: true,
    // Use select, not include!
  }
});
```

**Where to find:**
- `packages/trpc/server/routers/` (in tRPC procedures)
- `packages/features/` (in services)

## Quick File Finder Cheatsheet

### Need to find...

**A UI component:**
```bash
# Search in packages/ui
ls packages/ui/components/

# Or search by name
rg "export.*Button" packages/ui/
```

**A page/route:**
```bash
# Check both routers
ls apps/web/app/
ls apps/web/pages/
```

**An API endpoint:**
```bash
# tRPC routers
ls packages/trpc/server/routers/viewer/

# Or search by procedure name
rg "procedure.*create" packages/trpc/
```

**A database model:**
```bash
# Open schema
code packages/prisma/schema.prisma

# Search for model
rg "model Booking" packages/prisma/schema.prisma
```

**Translation strings:**
```bash
# Main translations file
code apps/web/public/static/locales/en/common.json

# Search for key
rg "event_types" apps/web/public/static/locales/en/common.json
```

**Form validation:**
```bash
# Search for zod schemas
rg "z.object" packages/trpc/server/routers/
```

## Understanding Data Flow

### Frontend → Backend → Database

**Example: Creating an Event Type**

1. **UI Component** (`apps/web/modules/event-types/`)
   ```typescript
   const form = useForm<EventTypeInput>();
   const mutation = trpc.viewer.eventTypes.create.useMutation();
   ```

2. **tRPC Router** (`packages/trpc/server/routers/viewer/eventTypes/create.handler.ts`)
   ```typescript
   export const createHandler = async ({ input, ctx }) => {
     // Validation, business logic
     return await prisma.eventType.create({ ... });
   };
   ```

3. **Database** (`packages/prisma/schema.prisma`)
   ```prisma
   model EventType {
     id    Int    @id @default(autoincrement())
     title String
     // ...
   }
   ```

## Interview Shortcuts

### Before Starting Code

**1. Understand the requirement:**
```
Ask AI: "Where in the codebase would I add [feature X]?"
```

**2. Find similar code:**
```
Ask AI: "Show me an example of [similar feature] in this codebase"
```

**3. Check database schema:**
```bash
# Always check what data is available
code packages/prisma/schema.prisma
# Search for relevant model (Cmd/Ctrl + F)
```

### During Implementation

**1. Find the right component:**
```
Ask AI: "Which component in apps/web handles [feature]?"
```

**2. Understand existing patterns:**
```
Ask AI: "How does this codebase handle form validation?"
Ask AI: "Show me the pattern for creating a new tRPC endpoint"
```

**3. Check imports:**
```typescript
// ⚠️ Common mistake - don't import from barrel files
// ❌ BAD
import { Button } from "@calcom/ui";

// ✅ GOOD
import { Button } from "@calcom/ui/components/button";
```

## Testing Your Understanding

### Quick Exercise (5 minutes)

Before the interview, practice finding:

1. **The booking list page** 
   - Answer: `apps/web/pages/bookings/index.tsx`

2. **Where booking validations happen**
   - Answer: `packages/trpc/server/routers/viewer/bookings/`

3. **The Button component**
   - Answer: `packages/ui/components/button/`

4. **Database schema for User model**
   - Answer: `packages/prisma/schema.prisma` (search "model User")

5. **Translation for "Event Types"**
   - Answer: `apps/web/public/static/locales/en/common.json`

### Practice with AI

Ask your AI assistant:
```
"Walk me through the file structure of apps/web/"
"Where would I add a new field to the booking form?"
"Show me how event types are fetched from the database"
```

## Key Files to Bookmark

Open these in separate tabs/bookmarks:

1. `AGENTS.md` - Development rules
2. `packages/prisma/schema.prisma` - Database schema
3. `apps/web/modules/shell/navigation/Navigation.tsx` - Main nav
4. `packages/trpc/server/routers/viewer/` - API endpoints
5. `apps/web/public/static/locales/en/common.json` - Translations

---

**Next**: Read [03-ai-collaboration.md](./03-ai-collaboration.md) to learn effective AI prompting strategies.
