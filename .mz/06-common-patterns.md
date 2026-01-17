# Common Cal.com Patterns

## 🎯 Goal
Quick reference for common coding patterns you'll encounter and need to follow in Cal.com.

## 1. Import Patterns

### ✅ Correct Imports

```typescript
// Type imports - always use 'import type'
import type { User, Booking } from "@prisma/client";
import type { ReactNode } from "react";

// Direct imports from packages (not barrel imports)
import { Button } from "@calcom/ui/components/button";
import { Dialog } from "@calcom/ui/components/dialog";
import { trpc } from "@calcom/trpc/react";

// Utilities
import { classNames } from "@calcom/lib";
```

### ❌ Incorrect Imports

```typescript
// Don't import types without 'import type'
import { User } from "@prisma/client";

// Don't use barrel imports
import { Button } from "@calcom/ui";

// Don't use relative paths for shared packages
import { Button } from "../../../packages/ui/components/button";
```

## 2. Component Patterns

### Basic Component Structure

```typescript
import type { ReactNode } from "react";

interface BookingCardProps {
  id: number;
  title: string;
  date: Date;
  onEdit?: () => void;
  children?: ReactNode;
}

export function BookingCard({ 
  id, 
  title, 
  date, 
  onEdit,
  children 
}: BookingCardProps) {
  return (
    <div className="rounded-md border border-gray-200 p-4">
      <h3 className="text-lg font-semibold">{title}</h3>
      <p className="text-sm text-gray-500">{date.toLocaleDateString()}</p>
      {children}
      {onEdit && (
        <button onClick={onEdit}>Edit</button>
      )}
    </div>
  );
}
```

### Component with Data Fetching (tRPC)

```typescript
import { trpc } from "@calcom/trpc/react";
import { LoadingSpinner } from "@calcom/ui/components/loading";

export function BookingsList() {
  const { data: bookings, isLoading, error } = trpc.viewer.bookings.list.useQuery();
  
  if (isLoading) {
    return <LoadingSpinner />;
  }
  
  if (error) {
    return <div>Error loading bookings: {error.message}</div>;
  }
  
  if (!bookings || bookings.length === 0) {
    return <div>No bookings found</div>;
  }
  
  return (
    <div className="space-y-4">
      {bookings.map((booking) => (
        <div key={booking.id}>
          {booking.title}
        </div>
      ))}
    </div>
  );
}
```

### Component with Mutation

```typescript
import { trpc } from "@calcom/trpc/react";
import { Button } from "@calcom/ui/components/button";
import { showToast } from "@calcom/ui/components/toast";

export function DeleteBookingButton({ bookingId }: { bookingId: number }) {
  const utils = trpc.useContext();
  
  const deleteMutation = trpc.viewer.bookings.delete.useMutation({
    onSuccess: () => {
      showToast("Booking deleted successfully", "success");
      // Invalidate to refetch bookings list
      utils.viewer.bookings.list.invalidate();
    },
    onError: (error) => {
      showToast(error.message, "error");
    },
  });
  
  const handleDelete = () => {
    if (confirm("Are you sure you want to delete this booking?")) {
      deleteMutation.mutate({ bookingId });
    }
  };
  
  return (
    <Button
      color="destructive"
      onClick={handleDelete}
      loading={deleteMutation.isLoading}
    >
      Delete
    </Button>
  );
}
```

## 3. Form Patterns

### Complete Form Example

```typescript
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { useTranslation } from "next-i18next";
import { Form, TextField, TextAreaField } from "@calcom/ui/components/form";
import { Button } from "@calcom/ui/components/button";
import { showToast } from "@calcom/ui/components/toast";
import { trpc } from "@calcom/trpc/react";

// Validation schema
const bookingFormSchema = z.object({
  title: z.string().min(1, "Title is required").max(100, "Title too long"),
  description: z.string().optional(),
  attendeeEmail: z.string().email("Invalid email"),
  attendeeName: z.string().min(1, "Name is required"),
});

type BookingFormValues = z.infer<typeof bookingFormSchema>;

export function BookingForm() {
  const { t } = useTranslation("common");
  const utils = trpc.useContext();
  
  const form = useForm<BookingFormValues>({
    resolver: zodResolver(bookingFormSchema),
    defaultValues: {
      title: "",
      description: "",
      attendeeEmail: "",
      attendeeName: "",
    },
  });
  
  const createMutation = trpc.viewer.bookings.create.useMutation({
    onSuccess: () => {
      showToast(t("booking_created_successfully"), "success");
      form.reset();
      utils.viewer.bookings.list.invalidate();
    },
    onError: (error) => {
      showToast(error.message, "error");
    },
  });
  
  const onSubmit = (data: BookingFormValues) => {
    createMutation.mutate(data);
  };
  
  return (
    <Form form={form} handleSubmit={onSubmit}>
      <div className="space-y-4">
        <TextField
          label={t("title")}
          required
          {...form.register("title")}
        />
        
        <TextAreaField
          label={t("description")}
          {...form.register("description")}
          rows={3}
        />
        
        <TextField
          label={t("attendee_name")}
          required
          {...form.register("attendeeName")}
        />
        
        <TextField
          type="email"
          label={t("attendee_email")}
          required
          {...form.register("attendeeEmail")}
        />
        
        <Button
          type="submit"
          loading={createMutation.isLoading}
        >
          {t("create_booking")}
        </Button>
      </div>
    </Form>
  );
}
```

### Form Field Patterns

```typescript
// Text input
<TextField
  label="Email"
  type="email"
  placeholder="user@example.com"
  required
  {...form.register("email")}
/>

// Textarea
<TextAreaField
  label="Description"
  rows={4}
  {...form.register("description")}
/>

// Select/Dropdown
<Select
  label="Status"
  options={[
    { label: "Pending", value: "pending" },
    { label: "Confirmed", value: "confirmed" },
  ]}
  {...form.register("status")}
/>

// Checkbox
<CheckboxField
  label="Send confirmation email"
  {...form.register("sendEmail")}
/>

// Date picker
<DatePicker
  label="Booking Date"
  value={form.watch("date")}
  onChange={(date) => form.setValue("date", date)}
/>
```

## 4. Prisma Patterns

### ✅ Correct Queries (Use `select`)

```typescript
// Fetch single record
const booking = await prisma.booking.findUnique({
  where: { id: bookingId },
  select: {
    id: true,
    title: true,
    startTime: true,
    endTime: true,
    user: {
      select: {
        id: true,
        name: true,
        email: true,
      },
    },
  },
});

// Fetch multiple records
const bookings = await prisma.booking.findMany({
  where: { 
    userId: userId,
    startTime: { gte: new Date() },
  },
  select: {
    id: true,
    title: true,
    startTime: true,
  },
  orderBy: {
    startTime: "asc",
  },
  take: 10,
});

// Create record
const booking = await prisma.booking.create({
  data: {
    title: "Meeting",
    startTime: new Date(),
    endTime: new Date(),
    userId: userId,
  },
  select: {
    id: true,
    title: true,
  },
});

// Update record
const updated = await prisma.booking.update({
  where: { id: bookingId },
  data: {
    title: "Updated Meeting",
  },
  select: {
    id: true,
    title: true,
  },
});

// Delete record
await prisma.booking.delete({
  where: { id: bookingId },
});
```

### ❌ Incorrect Queries (Don't use `include`)

```typescript
// Don't do this - fetches all fields including sensitive ones
const booking = await prisma.booking.findUnique({
  where: { id: bookingId },
  include: {
    user: true, // Fetches ALL user fields
  },
});
```

## 5. tRPC Router Patterns

### Backend Handler Structure

```typescript
// packages/trpc/server/routers/viewer/bookings/create.schema.ts
import { z } from "zod";

export const ZCreateBookingSchema = z.object({
  title: z.string().min(1).max(100),
  description: z.string().optional(),
  startTime: z.date(),
  endTime: z.date(),
  attendeeEmail: z.string().email(),
  attendeeName: z.string().min(1),
});

export type TCreateBookingSchema = z.infer<typeof ZCreateBookingSchema>;
```

```typescript
// packages/trpc/server/routers/viewer/bookings/create.handler.ts
import type { PrismaClient } from "@prisma/client";
import { TRPCError } from "@trpc/server";
import type { TCreateBookingSchema } from "./create.schema";

interface CreateBookingHandlerOptions {
  ctx: {
    prisma: PrismaClient;
    user: { id: number };
  };
  input: TCreateBookingSchema;
}

export async function createBookingHandler({
  ctx,
  input,
}: CreateBookingHandlerOptions) {
  // Validate business logic
  if (input.endTime <= input.startTime) {
    throw new TRPCError({
      code: "BAD_REQUEST",
      message: "End time must be after start time",
    });
  }
  
  // Create booking
  const booking = await ctx.prisma.booking.create({
    data: {
      title: input.title,
      description: input.description,
      startTime: input.startTime,
      endTime: input.endTime,
      userId: ctx.user.id,
      attendeeEmail: input.attendeeEmail,
      attendeeName: input.attendeeName,
    },
    select: {
      id: true,
      title: true,
      startTime: true,
      endTime: true,
    },
  });
  
  return booking;
}
```

```typescript
// packages/trpc/server/routers/viewer/bookings/_router.ts
import { router, authedProcedure } from "@calcom/trpc/server/trpc";
import { ZCreateBookingSchema } from "./create.schema";
import { createBookingHandler } from "./create.handler";

export const bookingsRouter = router({
  create: authedProcedure
    .input(ZCreateBookingSchema)
    .mutation(async ({ ctx, input }) => {
      return createBookingHandler({ ctx, input });
    }),
});
```

## 6. Error Handling Patterns

### Frontend Error Handling

```typescript
// In components with tRPC
const { data, error, isLoading } = trpc.viewer.bookings.get.useQuery(
  { bookingId },
  {
    onError: (error) => {
      showToast(error.message, "error");
    },
  }
);

// In mutations
const mutation = trpc.viewer.bookings.create.useMutation({
  onError: (error) => {
    if (error.data?.code === "UNAUTHORIZED") {
      // Handle unauthorized
      showToast("You must be logged in", "error");
    } else {
      showToast(error.message, "error");
    }
  },
});
```

### Backend Error Handling

```typescript
// In tRPC handlers
import { TRPCError } from "@trpc/server";

// Not found
throw new TRPCError({
  code: "NOT_FOUND",
  message: "Booking not found",
});

// Bad request
throw new TRPCError({
  code: "BAD_REQUEST",
  message: "Invalid booking ID",
});

// Unauthorized
throw new TRPCError({
  code: "UNAUTHORIZED",
  message: "You don't have permission to access this booking",
});

// Internal error
throw new TRPCError({
  code: "INTERNAL_SERVER_ERROR",
  message: "Failed to create booking",
});
```

```typescript
// In services/utilities (non-tRPC)
import { ErrorWithCode } from "@calcom/lib/ErrorWithCode";

throw new ErrorWithCode({
  statusCode: 400,
  message: "Invalid input",
});
```

## 7. Translation Patterns

### Using Translations

```typescript
import { useTranslation } from "next-i18next";

export function MyComponent() {
  const { t } = useTranslation("common");
  
  return (
    <div>
      <h1>{t("event_types")}</h1>
      <p>{t("create_new_event_type")}</p>
      
      {/* With interpolation */}
      <p>{t("booking_confirmed_for", { name: "John" })}</p>
    </div>
  );
}
```

### Adding Translations

```json
// apps/web/public/static/locales/en/common.json
{
  "event_types": "Event Types",
  "create_new_event_type": "Create New Event Type",
  "booking_confirmed_for": "Booking confirmed for {{name}}"
}
```

## 8. Styling Patterns

### Layout Patterns

```typescript
// Page container
<div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
  {/* Content */}
</div>

// Card layout
<div className="rounded-lg border border-gray-200 bg-white p-6 shadow-sm">
  {/* Card content */}
</div>

// Flex layouts
<div className="flex items-center justify-between">
  {/* Items */}
</div>

<div className="flex flex-col space-y-4">
  {/* Stacked items */}
</div>

// Grid layouts
<div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
  {/* Grid items */}
</div>
```

### Common Component Styles

```typescript
// Button variations
<Button color="primary">Primary</Button>
<Button color="secondary">Secondary</Button>
<Button color="destructive">Delete</Button>
<Button variant="icon"><Icon /></Button>

// Text styles
<h1 className="text-2xl font-bold text-gray-900">
<h2 className="text-xl font-semibold text-gray-800">
<p className="text-sm text-gray-600">

// Status badges
<span className="inline-flex items-center rounded-full bg-green-100 px-2.5 py-0.5 text-xs font-medium text-green-800">
  Confirmed
</span>
```

## 9. Conditional Rendering Patterns

### Loading States

```typescript
if (isLoading) {
  return <LoadingSpinner />;
}

if (error) {
  return <div>Error: {error.message}</div>;
}

if (!data) {
  return null;
}

return <div>{/* Render data */}</div>;
```

### Empty States

```typescript
if (!bookings || bookings.length === 0) {
  return (
    <div className="text-center">
      <p className="text-gray-500">No bookings found</p>
      <Button onClick={createNew}>Create your first booking</Button>
    </div>
  );
}
```

### Conditional UI Elements

```typescript
// With optional chaining
{user?.isAdmin && <AdminPanel />}

// With ternary
{isExpanded ? <FullDetails /> : <Summary />}

// With early return
if (!hasPermission) return null;
```

## 10. Common Code Review Checks

Before submitting/demoing code, verify:

```typescript
// ✅ Type imports
import type { User } from "@prisma/client";

// ✅ Direct imports (not barrel)
import { Button } from "@calcom/ui/components/button";

// ✅ Prisma using select
const user = await prisma.user.findUnique({
  where: { id },
  select: { id: true, name: true },
});

// ✅ Error handling
if (!booking) {
  throw new TRPCError({
    code: "NOT_FOUND",
    message: "Booking not found",
  });
}

// ✅ Early returns
if (!user) return null;

// ✅ Optional chaining for nullable fields
const userName = user?.name ?? "Unknown";

// ✅ Translation strings
const { t } = useTranslation("common");
<h1>{t("page_title")}</h1>

// ✅ Loading states
if (isLoading) return <LoadingSpinner />;
```

---

**Next**: Read [07-problem-solving-framework.md](./07-problem-solving-framework.md) for a systematic approach to tackling interview problems.
