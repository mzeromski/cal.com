#!/bin/bash

# Utility functions for quality check scripts

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Symbols
CHECK_MARK="✓"
CROSS_MARK="✗"
ARROW="→"

# Print functions
print_header() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK_MARK} $1${NC}"
}

print_error() {
    echo -e "${RED}${CROSS_MARK} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}${ARROW} $1${NC}"
}

print_step() {
    echo -e "${CYAN}▸ $1${NC}"
}

# Timer functions
start_timer() {
    TIMER_START=$(date +%s)
}

end_timer() {
    TIMER_END=$(date +%s)
    ELAPSED=$((TIMER_END - TIMER_START))
    
    if [ $ELAPSED -lt 60 ]; then
        echo "${ELAPSED}s"
    else
        MINUTES=$((ELAPSED / 60))
        SECONDS=$((ELAPSED % 60))
        echo "${MINUTES}m ${SECONDS}s"
    fi
}

# Git helper functions
get_changed_files() {
    # Get all files that have been modified but not committed
    # Also includes staged files
    git diff --name-only HEAD
    git diff --name-only --cached
}

get_changed_ts_files() {
    get_changed_files | grep -E '\.(ts|tsx)$' | sort -u
}

get_changed_test_files() {
    get_changed_files | grep -E '\.(test|spec)\.(ts|tsx)$' | sort -u
}

get_files_for_tests() {
    # Get TypeScript files (excluding test files) that might need testing
    get_changed_files | grep -E '\.(ts|tsx)$' | grep -v -E '\.(test|spec)\.(ts|tsx)$' | sort -u
}

has_changed_files() {
    [ -n "$(get_changed_files)" ]
}

# Check if running in a git repository
is_git_repo() {
    git rev-parse --git-dir > /dev/null 2>&1
}

# Error handling
exit_with_error() {
    local message="$1"
    local exit_code="${2:-1}"
    print_error "$message"
    exit "$exit_code"
}

# Command existence check
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if yarn is available
check_yarn() {
    if ! command_exists yarn; then
        exit_with_error "Yarn is not installed. Please install it first."
    fi
}
