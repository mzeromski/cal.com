#!/bin/bash

# Test running script for changed files
# Runs tests only for files that have been modified

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source utility functions
source "$SCRIPT_DIR/utils.sh"

# Change to project root
cd "$PROJECT_ROOT"

# Parse arguments
RUN_ALL=false
for arg in "$@"; do
    case $arg in
        --all)
            RUN_ALL=true
            shift
            ;;
    esac
done

# Main function
main() {
    print_header "Running Tests"
    
    # Check if yarn is available
    check_yarn
    
    # Check if we're in a git repo
    if ! is_git_repo; then
        print_warning "Not a git repository. Running all tests..."
        RUN_ALL=true
    fi
    
    start_timer
    
    if [ "$RUN_ALL" = true ]; then
        print_step "Running all unit tests..."
        print_info "Command: TZ=UTC yarn test"
        echo ""
        
        if TZ=UTC yarn test; then
            echo ""
            ELAPSED=$(end_timer)
            print_success "All tests passed! (${ELAPSED})"
            exit 0
        else
            echo ""
            ELAPSED=$(end_timer)
            print_error "Some tests failed! (${ELAPSED})"
            exit 1
        fi
    else
        # Get changed test files
        changed_test_files=$(get_changed_test_files)
        
        if [ -z "$changed_test_files" ]; then
            # No test files changed, check if source files changed
            changed_source_files=$(get_files_for_tests)
            
            if [ -z "$changed_source_files" ]; then
                print_info "No changed files detected"
                print_success "Skipping tests (no changes detected)"
                exit 0
            else
                print_warning "Source files changed but no corresponding test files found"
                print_info "Consider running tests manually for:"
                echo "$changed_source_files" | while read -r file; do
                    echo "  - $file"
                done
                echo ""
                print_info "To run all tests, use: yarn check:tests --all"
                print_success "Test check completed (no test files to run)"
                exit 0
            fi
        fi
        
        print_step "Running tests for changed files..."
        echo ""
        print_info "Changed test files:"
        echo "$changed_test_files" | while read -r file; do
            echo "  - $file"
        done
        echo ""
        
        # Run tests for each changed test file
        test_failed=false
        while IFS= read -r test_file; do
            if [ -n "$test_file" ]; then
                print_step "Testing: $test_file"
                
                if TZ=UTC yarn vitest run "$test_file" 2>&1; then
                    print_success "Passed: $test_file"
                else
                    print_error "Failed: $test_file"
                    test_failed=true
                fi
                echo ""
            fi
        done <<< "$changed_test_files"
        
        ELAPSED=$(end_timer)
        
        if [ "$test_failed" = true ]; then
            print_error "Some tests failed! (${ELAPSED})"
            exit 1
        else
            print_success "All changed tests passed! (${ELAPSED})"
            exit 0
        fi
    fi
}

# Run main function
main "$@"
