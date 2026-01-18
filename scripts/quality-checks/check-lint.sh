#!/bin/bash

# Linting and formatting script using Biome
# Runs yarn biome check --write to fix and check code quality

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
    print_header "Linting & Formatting"
    
    # Check if yarn is available
    check_yarn
    
    start_timer
    
    print_step "Running Biome to check and fix code..."
    print_info "Command: yarn biome check --write ."
    echo ""
    
    # Run biome check with auto-fix
    if yarn biome check --write .; then
        echo ""
        ELAPSED=$(end_timer)
        print_success "Lint check passed! Code is formatted correctly. (${ELAPSED})"
        exit 0
    else
        echo ""
        ELAPSED=$(end_timer)
        print_error "Lint check failed! (${ELAPSED})"
        print_warning "Some issues could not be auto-fixed. Please review the errors above."
        exit 1
    fi
}

# Run main function
main "$@"
