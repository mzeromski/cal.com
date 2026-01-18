#!/bin/bash

# Type checking script using TypeScript compiler
# Runs yarn type-check:ci --force for fresh results without cache

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source utility functions
source "$SCRIPT_DIR/utils.sh"

# Change to project root
cd "$PROJECT_ROOT"

# Main function
main() {
    print_header "Type Checking"
    
    # Check if yarn is available
    check_yarn
    
    start_timer
    
    print_step "Running TypeScript type checker..."
    print_info "Command: yarn type-check:ci --force"
    echo ""
    
    # Run type check
    if yarn type-check:ci --force; then
        echo ""
        ELAPSED=$(end_timer)
        print_success "Type check passed! (${ELAPSED})"
        exit 0
    else
        echo ""
        ELAPSED=$(end_timer)
        print_error "Type check failed! (${ELAPSED})"
        print_warning "Fix the type errors above and run again"
        exit 1
    fi
}

# Run main function
main "$@"
