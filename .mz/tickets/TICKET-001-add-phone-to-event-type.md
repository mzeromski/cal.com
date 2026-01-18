# TICKET-001: Add Phone Number to Event Type

**Status:** 📝 Specifications Complete  
**Priority:** Medium  
**Estimated Complexity:** Medium (90-100 minutes)  
**Type:** Feature Request  
**Last Updated:** 2026-01-18

---

## 📋 SPECIFICATION SUMMARY

### Feature Description
Add an optional "Additional Phone Number" field to Event Types that serves as a backup/secondary contact number for the event organizer. This phone number will be:
- Displayed publicly on the booking page
- Included in booking confirmation emails to both organizers and attendees
- Validated using country-aware phone number validation
- Stored in the exact format the user enters

### Use Case
When the primary phone number is unavailable, bookers can use this backup contact number to reach the event organizer.

### Key Requirements
| Aspect | Specification |
|--------|--------------|
| **Purpose** | Backup contact number when primary phone is unavailable |
| **Field Type** | Optional (nullable) String field |
| **Validation** | Country-aware using `libphonenumber-js` |
| **Storage Format** | Raw user input (preserved formatting) |
| **Display Locations** | Event type settings, public booking page, email confirmations |
| **Visibility** | Event type owner, team members, and public bookers |
| **Access Control** | Owner can edit, team members can edit, bookers can view |
| **Component** | Phone input with country selector (if available) |

### Behavior
- **Optional Field:** Users can create/update event types without providing this
- **International Support:** Accept all valid international phone formats
- **No Normalization:** Store exactly as user types (e.g., "+1 (555) 123-4567")
- **Public Display:** Show on booking page if provided
- **Email Inclusion:** Include in organizer and attendee confirmation emails
- **Null Handling:** Existing event types without phone continue to work

### Technical Scope
- **Backend:** Database schema + validation in tRPC routers
- **Frontend:** Event type settings form + public booking page
- **Emails:** Organizer + attendee confirmation templates
- **i18n:** Translation keys for labels and help text

### Out of Scope (Future Enhancements)
- SMS/calling integration
- Phone number verification
- Multiple additional phone numbers
- Phone number as required field

---

## 🎯 Final Decisions

**All requirements confirmed. Implementation ready.**

| Decision | Choice |
|----------|---------|
| **Optional vs Required** | Optional field |
| **Validation Level** | Country-aware with `libphonenumber-js` |
| **Storage Format** | Raw user input (preserve formatting) |
| **Display Location** | Settings form + public booking page + emails |
| **Visibility** | Owner + team members + public bookers |
| **Data Migration** | Not needed (nullable field, defaults to null) |
| **Component Type** | PhoneInput with country selector (fallback to TextField) |

---

## 🔍 Pre-Implementation Investigation

### ✅ Confirmed - No Investigation Needed
- [x] `libphonenumber-js` is already a Cal.com dependency
- [x] Database schema location: `packages/prisma/schema.prisma`
- [x] tRPC router location: `packages/trpc/server/routers/viewer/eventTypes/`

### 📝 To Investigate During Implementation

**1. Event Type Form Component**
- Find exact file path for event type settings form
- Search: `apps/web/modules/event-types/` or `apps/web/app/*/event-types/`
- Action: Use `rg` to locate form component

**2. Public Booking Page Component**
- Find where event type details are displayed on booking page
- Search: `apps/web/app/[user]/[type]/` or booking components
- Action: Use `rg` to search for booking page components

**3. PhoneInput Component Availability**
- Check if Cal.com UI library has PhoneInput component
- Search: `packages/ui/` or `packages/coss-ui/`
- Fallback: Use TextField with validation if PhoneInput doesn't exist

**4. Email Template Files**
- Identify exact files for booking confirmation emails
- Search: `packages/emails/templates/`
- Action: Locate organizer and attendee confirmation templates

**5. Existing Phone Field**
- Check if EventType model already has a primary phone field
- Understand existing structure for consistency
- Action: Read `packages/prisma/schema.prisma` EventType model

**6. Form Validation Patterns**
- Check how other phone fields are validated in codebase
- Search for existing `libphonenumber-js` usage
- Action: Use `rg "libphonenumber"` to find existing patterns

### 🚨 Potential Blockers
- If PhoneInput component doesn't exist, use TextField
- If email template structure is complex, may need extra time
- If existing phone validation patterns are inconsistent, establish standard

---

## 🔍 Technical Analysis

### Files That Will Be Affected

**1. Database Layer (1 file + migration)**
```
packages/prisma/schema.prisma
└── Add: additionalPhone String? field to EventType model
```

**2. Backend Validation (4 files)**
```
packages/trpc/server/routers/viewer/eventTypes/
├── create.schema.ts       # Add Zod validation with libphonenumber-js
├── update.schema.ts       # Add Zod validation with libphonenumber-js
├── create.handler.ts      # Handle additionalPhone in creation
└── update.handler.ts      # Handle additionalPhone in updates
```

**3. Frontend - Event Type Settings (2-3 files)**
```
apps/web/modules/event-types/
└── components/             # Add phone input field with country-aware validation
```

**4. Frontend - Public Booking Page (2-3 files)**
```
apps/web/app/[user]/[type]/ or booking components
└── Display additionalPhone on public booking page (if provided)
```

**5. Email Templates (2-4 files)**
```
packages/emails/templates/
├── organizer-booking-confirmation.tsx   # Include additionalPhone
├── attendee-booking-confirmation.tsx    # Include additionalPhone
└── Other relevant email templates
```

**6. Translations (1 file)**
```
apps/web/public/static/locales/en/common.json
└── Add: "additional_phone", "additional_phone_description", 
        "additional_phone_help", "additional_phone_invalid" etc.
```

**7. Types (Auto-generated)**
```
Prisma types will regenerate after schema change
```

**Total Estimated Files:** 12-17 files

---

## ⚠️ Risks & Considerations

### 🔴 HIGH Risk
**1. Privacy/Security**
- Phone numbers are PII (Personally Identifiable Information)
- Must ensure proper access controls
- GDPR compliance considerations
- Public display must be intentional

**2. Data Migration**
- Existing event types need to handle null values
- No breaking changes to existing functionality

### 🟡 MEDIUM Risk
**3. Validation Complexity**
- International phone formats vary widely
- Balance between validation strictness and user convenience
- False positives/negatives in validation

**4. UI/UX Impact**
- Adding field increases form complexity
- Need clear help text explaining public visibility
- Mobile layout considerations

### 🟢 LOW Risk
**5. Performance**
- Simple string field, minimal impact
- No complex queries needed

---

## 📋 Implementation Plan

### Phase 1: Database Schema (10 min)
- [ ] Add `additionalPhone String?` field to EventType model in `packages/prisma/schema.prisma`
- [ ] Add comment: "Backup/secondary contact number shown on booking page and in confirmations"
- [ ] Run `yarn prisma generate` to update types
- [ ] Verify Prisma types updated correctly

### Phase 2: Backend Validation (15 min)
- [ ] Import `libphonenumber-js` in schema files
- [ ] Create Zod schema for country-aware phone validation
- [ ] Add validation to `create.schema.ts`
- [ ] Add validation to `update.schema.ts`
- [ ] Update handlers (`create.handler.ts`, `update.handler.ts`) to accept and store field
- [ ] Ensure validation accepts international formats

### Phase 3: Frontend - Event Type Settings Form (20 min)
- [ ] Locate event type settings form component
- [ ] Add phone input field with country selector (use existing PhoneInput component if available)
- [ ] Add label: "Additional Phone Number" (with translation key)
- [ ] Add help text: "Backup contact number shown to bookers"
- [ ] Wire up form registration and validation
- [ ] Test form submission with valid/invalid numbers

### Phase 4: Frontend - Public Booking Page (15 min)
- [ ] Locate booking page component that displays event type details
- [ ] Add conditional display: show additionalPhone if present
- [ ] Format phone number for display (clickable tel: link)
- [ ] Add label/icon to indicate it's a contact number
- [ ] Test on mobile and desktop layouts

### Phase 5: Email Templates (15 min)
- [ ] Update organizer booking confirmation email template
- [ ] Update attendee booking confirmation email template
- [ ] Add additionalPhone field to email context/props
- [ ] Display formatted phone number in emails
- [ ] Test email rendering with and without phone

### Phase 6: Translations (5 min)
- [ ] Add to `apps/web/public/static/locales/en/common.json`:
  - `additional_phone`: "Additional Phone Number"
  - `additional_phone_description`: "Backup contact number"
  - `additional_phone_help`: "This will be visible to people booking with you"
  - `additional_phone_invalid`: "Please enter a valid phone number"
- [ ] Verify translations display correctly

### Phase 7: Testing & Validation (15 min)
- [ ] Test creating new event type with phone
- [ ] Test creating new event type without phone (should work - optional)
- [ ] Test updating existing event type to add phone
- [ ] Test validation with various formats (+1 555 123 4567, +44 20 7123 4567, etc.)
- [ ] Test invalid inputs (letters, too short, etc.)
- [ ] Verify phone displays on public booking page
- [ ] Verify phone appears in booking confirmation emails
- [ ] Check existing event types still work (null phone)
- [ ] Test on mobile layout

### Phase 8: Type Check & Lint (5 min)
- [ ] Run `yarn type-check:ci --force` on changed files
- [ ] Run `yarn biome check --write .`
- [ ] Fix any TypeScript or linting errors

**Total Estimated Time:** 90-100 minutes

---

## ✅ Acceptance Criteria (Definition of Done)

### Must Have (Required)
- [ ] `additionalPhone String?` field exists in EventType model (nullable/optional)
- [ ] Phone field appears in event type settings form with proper label
- [ ] Form validates phone format using country-aware validation (`libphonenumber-js`)
- [ ] Can create event type with valid phone number
- [ ] Can create event type without phone number (field is optional)
- [ ] Can update existing event type to add/modify/remove phone
- [ ] Phone number displays on **public booking page** when present
- [ ] Phone number appears in **booking confirmation emails** (organizer + attendee)
- [ ] Phone number stored in exact format user entered (no normalization)
- [ ] Validation accepts international formats (+1, +44, +91, etc.)
- [ ] No TypeScript errors (`yarn type-check:ci --force` passes)
- [ ] No Biome linting errors (`yarn biome check --write .` passes)
- [ ] No console errors in browser
- [ ] Follows Cal.com conventions (AGENTS.md)
- [ ] Translations added to `en/common.json`

### Should Have (Important)
- [ ] Help text explains: "Backup contact number shown to bookers"
- [ ] Validation provides clear, user-friendly error messages
- [ ] Country selector UI for phone input (if PhoneInput component available)
- [ ] Works correctly on mobile and desktop layouts
- [ ] Phone displays as clickable `tel:` link on booking page (mobile-friendly)
- [ ] Accessible (keyboard navigation, screen readers, ARIA labels)
- [ ] Existing event types without phone continue to work (null handling)

### Nice to Have (Optional)
- [ ] Phone number auto-formatting as user types
- [ ] Example format shown in placeholder: "+1 (555) 123-4567"
- [ ] Visual indicator (icon) next to phone on booking page
- [ ] Graceful fallback if phone validation library fails

---

## 📊 Readiness Status

### ✅ Complete & Ready
- [x] **Business Requirements** - All questions answered
- [x] **Purpose & Context** - Clear use case defined
- [x] **Validation Strategy** - Country-aware validation specified
- [x] **Display Requirements** - All locations identified
- [x] **Access Control** - Visibility rules established
- [x] **Data Storage** - Format and schema decided
- [x] **Implementation Plan** - Detailed phase-by-phase plan
- [x] **Acceptance Criteria** - Clear definition of done
- [x] **Time Estimate** - 90-100 minutes
- [x] **Risk Assessment** - Security and privacy documented

### 🔍 To Discover During Implementation
- [ ] Exact file paths for event type form and booking page
- [ ] PhoneInput component availability in UI library
- [ ] Email template structure
- [ ] Existing phone field in EventType model
- [ ] Validation patterns already used in codebase

### ⚠️ Acceptable Gaps
- Error handling will follow Cal.com patterns
- UI/UX will match existing event type form styling
- Testing will use standard Cal.com approaches
- No migration script needed (nullable field)

---

## 🚀 Status: READY FOR IMPLEMENTATION

**Confidence Level:** HIGH (90%)
- ✅ Clear requirements
- ✅ Well-defined scope
- ✅ Realistic time estimate
- ✅ No major blockers identified

**Next Action:** Proceed with Phase 1 (Database Schema)
