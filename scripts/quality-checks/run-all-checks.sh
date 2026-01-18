#!/bin/bash

# Master quality check script
# Runs all quality checks sequentially: lint, type check, and tests

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source utility functions
source "$SCRIPT_DIR/utils.sh"

# Change to project root
cd "$PROJECT_ROOT"

# Parse arguments
CONTINUE_ON_ERROR=false
for arg in "$@"; do
    case $arg in
        --continue|--continue-on-error)
            CONTINUE_ON_ERROR=true
            shift
            ;;
    esac
done

# Track results
declare -A RESULTS
CHECKS=("Linting" "Type Checking" "Tests")

# Main function
main() {
    print_header "Quality Checks - Running All Checks"
    echo ""
    
    start_timer
    
    # Track overall success
    all_passed=true
    
    # Run lint check
    print_step "Step 1/3: Linting & Formatting"
    echo ""
    if "$SCRIPT_DIR/check-lint.sh"; then
        RESULTS["Linting"]="passed"
    else
        RESULTS["Linting"]="failed"
        all_passed=false
        if [ "$CONTINUE_ON_ERROR" = false ]; then
            print_error "Stopping due to lint failure. Use --continue to run all checks anyway."
            exit 1
        fi
    fi
    echo ""
    
    # Run type check
    print_step "Step 2/3: Type Checking"
    echo ""
    if "$SCRIPT_DIR/check-types.sh"; then
        RESULTS["Type Checking"]="passed"
    else
        RESULTS["Type Checking"]="failed"
        all_passed=false
        if [ "$CONTINUE_ON_ERROR" = false ]; then
            print_error "Stopping due to type check failure. Use --continue to run all checks anyway."
            exit 1
        fi
    fi
    echo ""
    
    # Run tests
    print_step "Step 3/3: Running Tests"
    echo ""
    if "$SCRIPT_DIR/check-tests.sh"; then
        RESULTS["Tests"]="passed"
    else
        RESULTS["Tests"]="failed"
        all_passed=false
    fi
    echo ""
    
    # Print summary
    ELAPSED=$(end_timer)
    print_header "Summary"
    echo ""
    
    for check in "${CHECKS[@]}"; do
        if [ "${RESULTS[$check]}" = "passed" ]; then
            print_success "$check: PASSED"
        else
            print_error "$check: FAILED"
        fi
    done
    
    echo ""
    echo -e "${CYAN}Total time: ${ELAPSED}${NC}"
    echo ""
    
    if [ "$all_passed" = true ]; then
        print_success "All quality checks passed! ✨"
        exit 0
    else
        print_error "Some quality checks failed. Please fix the issues above."
        exit 1
    fi
}

# Run main function
main "$@"
