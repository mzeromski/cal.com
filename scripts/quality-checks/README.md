# Quality Check Scripts

Automated quality check scripts for Cal.com development. Run these after coding sessions to ensure code quality, type safety, and test coverage.

## Quick Start

```bash
# Run all checks (recommended after coding session)
yarn check:all

# Quick check (lint + types only, fastest)
yarn check:quick

# Individual checks
yarn check:lint    # Linting and formatting
yarn check:types   # Type checking
yarn check:tests   # Run tests for changed files
```

## Scripts Overview

### `yarn check:all` - Run All Checks

Runs all quality checks sequentially:
1. Linting & Formatting (Biome)
2. Type Checking (TypeScript)
3. Tests (Vitest)

**Features:**
- Stops on first failure by default
- Shows summary at the end
- Reports total execution time
- Color-coded output

**Options:**
```bash
# Continue running even if a check fails
yarn check:all --continue
```

**Example output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Quality Checks - Running All Checks
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

▸ Step 1/3: Linting & Formatting
✓ Lint check passed! (5s)

▸ Step 2/3: Type Checking
✓ Type check passed! (12s)

▸ Step 3/3: Running Tests
✓ All changed tests passed! (8s)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Linting: PASSED
✓ Type Checking: PASSED
✓ Tests: PASSED

Total time: 25s

✓ All quality checks passed! ✨
```

### `yarn check:quick` - Quick Check

Fast quality check that runs linting and type checking only. Skips tests for speed.

**Use when:**
- You want quick feedback before committing
- You only changed types or formatting
- You're in the middle of development

**Execution time:** ~15-30 seconds

### `yarn check:lint` - Linting & Formatting

Runs Biome to check and automatically fix code style issues.

**What it does:**
- Checks code formatting
- Checks for lint errors
- Automatically fixes issues when possible
- Reports unfixable issues

**Command:** `yarn biome check --write .`

**Execution time:** ~5-10 seconds

### `yarn check:types` - Type Checking

Runs TypeScript compiler to check for type errors.

**What it does:**
- Type checks all TypeScript files
- Uses `--force` flag for fresh results (no cache)
- Reports all type errors

**Command:** `yarn type-check:ci --force`

**Execution time:** ~10-20 seconds

**Note:** Always use `--force` to bypass cache and get accurate results, especially after:
- Making import changes
- Adding new components
- Modifying types
- Pulling changes from git

### `yarn check:tests` - Run Tests

Runs tests for changed files automatically.

**What it does:**
- Detects changed files using git
- Runs tests only for modified test files
- Uses `TZ=UTC` for consistency
- Reports results for each test file

**Options:**
```bash
# Run all tests (not just changed files)
yarn check:tests --all
```

**Behavior:**
- If test files changed → runs those test files
- If only source files changed → suggests running tests manually
- If no changes detected → skips tests

**Execution time:** 
- Changed files: ~5-30 seconds
- All tests: several minutes

## Integration with Development Workflow

### After Coding Session

```bash
# Recommended workflow
yarn check:all
```

This ensures all quality standards are met before committing.

### Before Committing

```bash
# Quick validation
yarn check:quick

# Or full check if you have time
yarn check:all
```

### Continuous Development

```bash
# Run individual checks as needed
yarn check:lint   # After formatting changes
yarn check:types  # After type modifications
yarn check:tests  # After adding/modifying tests
```

### In CI/CD

The scripts work well in CI/CD pipelines:

```bash
# In your CI script
./scripts/quality-checks/run-all-checks.sh
```

Exit codes:
- `0` = All checks passed
- `1` = One or more checks failed

## File Structure

```
scripts/quality-checks/
├── README.md              # This file
├── utils.sh               # Shared utility functions
├── check-lint.sh          # Linting script
├── check-types.sh         # Type checking script
├── check-tests.sh         # Testing script
└── run-all-checks.sh      # Master script
```

## Utility Functions

The `utils.sh` file provides shared functions:

**Colors:**
- `print_success()` - Green success message
- `print_error()` - Red error message
- `print_warning()` - Yellow warning message
- `print_info()` - Blue info message
- `print_header()` - Cyan header with borders
- `print_step()` - Cyan step indicator

**Timing:**
- `start_timer()` - Start timing a command
- `end_timer()` - End timing and get duration

**Git helpers:**
- `get_changed_files()` - Get all changed files
- `get_changed_ts_files()` - Get changed TypeScript files
- `get_changed_test_files()` - Get changed test files
- `has_changed_files()` - Check if any files changed
- `is_git_repo()` - Check if in a git repository

## Troubleshooting

### "Permission denied" when running scripts

Make the scripts executable:
```bash
chmod +x scripts/quality-checks/*.sh
```

Or use the npm scripts which work without execute permissions:
```bash
yarn check:all
```

### Scripts fail to find yarn

Ensure yarn is installed and in your PATH:
```bash
which yarn
yarn --version
```

### Type check shows stale errors

The scripts use `--force` flag automatically, but if you still see stale errors:
```bash
# Clean and regenerate
yarn clean
yarn install
yarn prisma generate
yarn check:types
```

### Tests not detecting changed files

Ensure you're in a git repository and have committed some files:
```bash
git status  # Check git status
```

If you're not tracking files with git yet:
```bash
yarn check:tests --all  # Run all tests
```

## Tips

1. **Run `check:all` frequently** - Catch issues early
2. **Use `check:quick` for rapid iteration** - Fast feedback loop
3. **Fix lint errors first** - They're usually quickest to fix
4. **Then fix type errors** - Often root cause of other issues
5. **Run tests last** - They usually take the longest

## Related Commands

Standard Cal.com commands that the quality scripts use:

```bash
yarn biome check --write .     # Direct Biome command
yarn type-check:ci --force     # Direct type check
TZ=UTC yarn test               # Run all unit tests
yarn vitest run <file>         # Run specific test file
```

See the main [AGENTS.md](../../AGENTS.md) for more development commands.
