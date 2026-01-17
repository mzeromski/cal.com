# Tech Stack Quick Reference

## 🎯 Goal
Quick reference for the key technologies you'll use during the interview.

## Core Stack Overview

```
Frontend:  Next.js 13+ + React 18 + TypeScript
API:       tRPC + React Query
Database:  PostgreSQL + Prisma ORM
Forms:     React Hook Form + Zod
Styling:   Tailwind CSS + Radix UI
State:     Jotai + React Context
Auth:      NextAuth.js
i18n:      next-i18next
```

## 1. Next.js 13+

### App Router vs Pages Router

Cal.com uses **both** routers:

**App Router** (newer, preferred):
```
apps/web/app/
├── (main)/
│   └── event-types/
│       └── page.tsx       # Page component
│       └── layout.tsx     # Layout component
```

**Pages Router** (legacy, still common):
```
apps/web/pages/
├── event-types/
│   └── index.tsx          # Page component
```

### Key Concepts

**Page Component:**
```typescript
// app/event-types/page.tsx
export default function EventTypesPage() {
  return <div>Event Types</div>;
}
```

**Layout Component:**
```typescript
// app/layout.tsx
export default function RootLayout({ children }) {
  return <html><body>{children}</body></html>;
}
```

**API Route:**
```typescript
// app/api/webhooks/route.ts
export async function POST(request: Request) {
  const body = await request.json();
  return Response.json({ success: true });
}
```

### Common Patterns

**Data Fetching (Server Components):**
```typescript
async function getData() {
  const data = await fetch('...');
  return data;
}

export default async function Page() {
  const data = await getData();
  return <div>{data}</div>;
}
```

## 2. React + TypeScript

### Component Patterns

**Functional Component with Props:**
```typescript
import type { ReactNode } from "react";

interface Props {
  title: string;
  children: ReactNode;
  onClose?: () => void;
}

export function Modal({ title, children, onClose }: Props) {
  return (
    <div>
      <h2>{title}</h2>
      {children}
      <button onClick={onClose}>Close</button>
    </div>
  );
}
```

**Using Hooks:**
```typescript
import { useState, useEffect } from "react";

export function Counter() {
  const [count, setCount] = useState(0);
  
  useEffect(() => {
    document.title = `Count: ${count}`;
  }, [count]);
  
  return (
    <button onClick={() => setCount(count + 1)}>
      Count: {count}
    </button>
  );
}
```

### TypeScript Essentials

**Type Imports:**
```typescript
// ✅ Use 'import type' for types
import type { User } from "@prisma/client";
import type { ReactNode } from "react";

// ✅ Regular import for functions/components
import { Button } from "@calcom/ui/components/button";
```

**Type Definitions:**
```typescript
// Interface for component props
interface ButtonProps {
  variant?: "primary" | "secondary";
  size?: "sm" | "md" | "lg";
  children: ReactNode;
  onClick?: () => void;
}

// Type alias for data shapes
type BookingStatus = "pending" | "confirmed" | "cancelled";

// Pick/Omit for derived types
type UserPublic = Pick<User, "id" | "name" | "email">;
type UserWithoutPassword = Omit<User, "password">;
```

## 3. tRPC + React Query

### What is tRPC?

Type-safe API layer - no need to write API routes manually!

### Frontend Usage

**Query (GET data):**
```typescript
import { trpc } from "@calcom/trpc/react";

function BookingsList() {
  const { data, isLoading, error } = trpc.viewer.bookings.list.useQuery();
  
  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  
  return (
    <ul>
      {data?.map((booking) => (
        <li key={booking.id}>{booking.title}</li>
      ))}
    </ul>
  );
}
```

**Mutation (POST/PUT/DELETE data):**
```typescript
function CreateBooking() {
  const utils = trpc.useContext();
  
  const createMutation = trpc.viewer.bookings.create.useMutation({
    onSuccess: () => {
      // Refetch bookings list after creation
      utils.viewer.bookings.list.invalidate();
    },
  });
  
  const handleCreate = () => {
    createMutation.mutate({
      title: "New Booking",
      startTime: new Date(),
    });
  };
  
  return (
    <button onClick={handleCreate} disabled={createMutation.isLoading}>
      Create Booking
    </button>
  );
}
```

### Backend Usage

**Create a tRPC Router:**
```typescript
// packages/trpc/server/routers/viewer/bookings/create.handler.ts
import type { PrismaClient } from "@prisma/client";
import { TRPCError } from "@trpc/server";

interface CreateBookingOptions {
  ctx: { prisma: PrismaClient; user: { id: number } };
  input: { title: string; startTime: Date };
}

export async function createHandler({ ctx, input }: CreateBookingOptions) {
  const booking = await ctx.prisma.booking.create({
    data: {
      title: input.title,
      startTime: input.startTime,
      userId: ctx.user.id,
    },
    select: {
      id: true,
      title: true,
      startTime: true,
    },
  });
  
  return booking;
}
```

**Define Input Schema:**
```typescript
// packages/trpc/server/routers/viewer/bookings/create.schema.ts
import { z } from "zod";

export const ZCreateBookingSchema = z.object({
  title: z.string().min(1),
  startTime: z.date(),
});
```

## 4. Prisma ORM

### Schema Definition

```prisma
// packages/prisma/schema.prisma
model Booking {
  id        Int      @id @default(autoincrement())
  title     String
  startTime DateTime
  endTime   DateTime
  userId    Int
  user      User     @relation(fields: [userId], references: [id])
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```

### Query Patterns

**✅ GOOD - Use `select`:**
```typescript
const booking = await prisma.booking.findFirst({
  where: { id: bookingId },
  select: {
    id: true,
    title: true,
    user: {
      select: {
        id: true,
        name: true,
        email: true,
      },
    },
  },
});
```

**❌ BAD - Don't use `include`:**
```typescript
// Fetches ALL fields, including sensitive ones
const booking = await prisma.booking.findFirst({
  where: { id: bookingId },
  include: { user: true },
});
```

**Common Query Methods:**
```typescript
// Find one
const booking = await prisma.booking.findUnique({
  where: { id: 1 },
  select: { id: true, title: true },
});

// Find many
const bookings = await prisma.booking.findMany({
  where: { userId: 1 },
  select: { id: true, title: true },
  orderBy: { createdAt: "desc" },
  take: 10,
});

// Create
const booking = await prisma.booking.create({
  data: {
    title: "Meeting",
    startTime: new Date(),
    userId: 1,
  },
  select: { id: true },
});

// Update
const booking = await prisma.booking.update({
  where: { id: 1 },
  data: { title: "Updated Meeting" },
  select: { id: true, title: true },
});

// Delete
await prisma.booking.delete({
  where: { id: 1 },
});
```

## 5. React Hook Form + Zod

### Form Pattern

```typescript
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { Form, TextField } from "@calcom/ui/components/form";

// Define validation schema
const formSchema = z.object({
  email: z.string().email("Invalid email"),
  name: z.string().min(2, "Name too short"),
  age: z.number().min(18, "Must be 18+").optional(),
});

type FormValues = z.infer<typeof formSchema>;

export function MyForm() {
  const form = useForm<FormValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      email: "",
      name: "",
    },
  });
  
  const onSubmit = (data: FormValues) => {
    console.log("Valid data:", data);
  };
  
  return (
    <Form form={form} handleSubmit={onSubmit}>
      <TextField
        label="Email"
        {...form.register("email")}
      />
      <TextField
        label="Name"
        {...form.register("name")}
      />
      <button type="submit">Submit</button>
    </Form>
  );
}
```

### Validation Patterns

```typescript
import { z } from "zod";

// String validations
z.string()
z.string().min(3).max(50)
z.string().email()
z.string().url()
z.string().regex(/^\d{3}-\d{3}-\d{4}$/) // Phone pattern

// Number validations
z.number()
z.number().int()
z.number().min(0).max(100)

// Optional fields
z.string().optional()
z.string().nullable()

// Arrays
z.array(z.string())

// Objects
z.object({
  name: z.string(),
  age: z.number(),
})

// Enums
z.enum(["pending", "confirmed", "cancelled"])

// Union types
z.union([z.string(), z.number()])

// Custom validation
z.string().refine((val) => val.length > 0, {
  message: "Field is required",
})
```

## 6. Tailwind CSS

### Common Utility Classes

```typescript
// Layout
<div className="flex flex-col items-center justify-between">
<div className="grid grid-cols-3 gap-4">

// Spacing
<div className="p-4 m-2">        // Padding 1rem, Margin 0.5rem
<div className="px-6 py-3">      // Padding x-axis 1.5rem, y-axis 0.75rem
<div className="space-y-4">      // Gap between children

// Typography
<p className="text-lg font-bold text-gray-900">
<p className="text-sm text-gray-500">

// Colors
<div className="bg-blue-500 text-white">
<div className="bg-gray-100 text-gray-900">

// Borders & Radius
<div className="border border-gray-200 rounded-lg">
<div className="border-t border-b">

// Responsive
<div className="w-full md:w-1/2 lg:w-1/3">

// Hover/Focus states
<button className="hover:bg-blue-600 focus:ring-2">
```

### Cal.com Specific Classes

```typescript
// Common patterns in codebase
<div className="rounded-md border border-default">
<div className="bg-default text-default">
<div className="space-y-4 sm:space-y-6">
```

## 7. Radix UI Components

### Using Radix in Cal.com

```typescript
// Import from Cal.com's UI package
import { Dialog, DialogContent, DialogHeader } from "@calcom/ui/components/dialog";
import { Button } from "@calcom/ui/components/button";
import { Tooltip } from "@calcom/ui/components/tooltip";

// Dialog example
<Dialog open={isOpen} onOpenChange={setIsOpen}>
  <DialogContent>
    <DialogHeader>
      <h2>Dialog Title</h2>
    </DialogHeader>
    <p>Dialog content</p>
  </DialogContent>
</Dialog>

// Tooltip example
<Tooltip content="Click to edit">
  <Button>Edit</Button>
</Tooltip>
```

## 8. Common Patterns Cheatsheet

### Error Handling

```typescript
// In tRPC routers
import { TRPCError } from "@trpc/server";

throw new TRPCError({
  code: "BAD_REQUEST",
  message: "Invalid booking ID",
});

// In services/utilities
import { ErrorWithCode } from "@calcom/lib/ErrorWithCode";

throw new ErrorWithCode({
  statusCode: 400,
  message: "Invalid input",
});
```

### Loading States

```typescript
function MyComponent() {
  const { data, isLoading, error } = trpc.viewer.bookings.list.useQuery();
  
  if (isLoading) return <LoadingSpinner />;
  if (error) return <ErrorMessage error={error} />;
  if (!data) return null;
  
  return <div>{/* Render data */}</div>;
}
```

### Translations

```typescript
import { useTranslation } from "next-i18next";

function MyComponent() {
  const { t } = useTranslation("common");
  
  return <h1>{t("event_types")}</h1>;
}

// Add to apps/web/public/static/locales/en/common.json:
// { "event_types": "Event Types" }
```

## Quick Command Reference

```bash
# Type check
yarn type-check:ci --force

# Lint/format specific file
yarn biome check --write path/to/file.tsx

# Generate Prisma types after schema change
yarn prisma generate

# Run migrations
yarn workspace @calcom/prisma db-migrate

# Start dev server
yarn dx
```

## Interview Scenarios

### Scenario: Add a new form field

**What you need:**
1. React Hook Form - for form state
2. Zod - for validation
3. Prisma - to update schema
4. tRPC - to handle API submission
5. Translations - for field label

**Quick implementation checklist:**
- [ ] Update Prisma schema
- [ ] Run `yarn prisma generate`
- [ ] Update Zod validation schema
- [ ] Add form field in component
- [ ] Add translation string
- [ ] Test in browser

### Scenario: Create a new page

**What you need:**
1. Next.js - to create page file
2. TypeScript - for type safety
3. tRPC - to fetch data
4. Tailwind - for styling
5. Cal.com UI components

**Quick implementation checklist:**
- [ ] Create page file in `apps/web/app/` or `apps/web/pages/`
- [ ] Set up data fetching with tRPC
- [ ] Build UI with Cal.com components
- [ ] Add loading/error states
- [ ] Test navigation

---

**Next**: Read [05-interview-day-checklist.md](./05-interview-day-checklist.md) for your day-of preparation steps.
