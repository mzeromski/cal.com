#!/bin/bash

# PDF Generation Script for Apollo.io Interview Prep Materials
# Uses Pandoc to convert all markdown files to a professional PDF

set -e  # Exit on error

echo "📚 Generating Apollo.io Interview Prep PDF..."
echo ""

# Output file
OUTPUT_FILE="Apollo-Interview-Prep-Complete.pdf"

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "❌ Error: pandoc is not installed"
    echo "Install with: sudo apt install pandoc (Ubuntu) or brew install pandoc (macOS)"
    exit 1
fi

# Change to .mz directory
cd "$(dirname "$0")"

echo "📁 Working directory: $(pwd)"
echo ""

# Create ordered list of markdown files
FILES=(
    "README.md"
    "01-environment-setup.md"
    "02-codebase-navigation.md"
    "03-ai-collaboration.md"
    "04-tech-stack-reference.md"
    "05-interview-day-checklist.md"
    "06-common-patterns.md"
    "07-problem-solving-framework.md"
    "08-cursor-prompting-mastery.md"
    "09-ai-control-strategies.md"
    "10-prompt-templates.md"
    "11-practice-exercises.md"
    "12-real-scenarios-with-prompts.md"
)

# Check if all files exist
echo "✅ Checking files..."
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Error: File not found: $file"
        exit 1
    fi
    echo "   ✓ $file"
done
echo ""

# Generate PDF with pandoc
echo "🔄 Generating PDF..."
echo ""

pandoc "${FILES[@]}" \
    -o "$OUTPUT_FILE" \
    --toc \
    --toc-depth=3 \
    --number-sections \
    --highlight-style=tango \
    --pdf-engine=xelatex \
    --variable geometry:margin=1in \
    --variable fontsize=11pt \
    --variable linkcolor:blue \
    --variable mainfont="DejaVu Sans" \
    --metadata title="Apollo.io Interview Preparation Guide" \
    --metadata author="Interview Prep Materials" \
    --metadata date="$(date '+%B %d, %Y')" \
    2>&1

# Check if PDF was created successfully
if [ -f "$OUTPUT_FILE" ]; then
    FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    echo ""
    echo "✅ SUCCESS! PDF generated successfully"
    echo ""
    echo "📄 File: $OUTPUT_FILE"
    echo "📊 Size: $FILE_SIZE"
    echo "📍 Location: $(pwd)/$OUTPUT_FILE"
    echo ""
    echo "🎯 Your interview prep materials are ready!"
else
    echo ""
    echo "❌ Error: PDF generation failed"
    exit 1
fi
