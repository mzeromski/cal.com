#!/bin/bash

# Simple PDF Generation (no LaTeX required)
# Uses wkhtmltopdf or browser-based conversion

set -e

echo "📚 Generating Apollo.io Interview Prep PDF (Simple Mode)..."
echo ""

OUTPUT_FILE="Apollo-Interview-Prep-Complete.pdf"

cd "$(dirname "$0")"

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

# Method 1: Try wkhtmltopdf
if command -v wkhtmltopdf &> /dev/null; then
    echo "✅ Using wkhtmltopdf..."
    
    # Convert to HTML first
    pandoc "${FILES[@]}" -o temp.html --toc --standalone
    
    # Convert HTML to PDF
    wkhtmltopdf --enable-local-file-access temp.html "$OUTPUT_FILE"
    rm temp.html
    
    echo "✅ PDF generated successfully!"
    echo "📄 File: $OUTPUT_FILE"
    exit 0
fi

# Method 2: Try weasyprint
if command -v weasyprint &> /dev/null; then
    echo "✅ Using weasyprint..."
    
    pandoc "${FILES[@]}" -o temp.html --toc --standalone
    weasyprint temp.html "$OUTPUT_FILE"
    rm temp.html
    
    echo "✅ PDF generated successfully!"
    echo "📄 File: $OUTPUT_FILE"
    exit 0
fi

# Method 3: HTML output only
echo "⚠️  No PDF converter found. Generating HTML instead..."
pandoc "${FILES[@]}" \
    -o "Apollo-Interview-Prep-Complete.html" \
    --toc \
    --toc-depth=3 \
    --standalone \
    --highlight-style=tango \
    --metadata title="Apollo.io Interview Preparation Guide"

echo "✅ HTML generated successfully!"
echo "📄 File: Apollo-Interview-Prep-Complete.html"
echo ""
echo "💡 To convert to PDF:"
echo "   1. Open the HTML file in a browser"
echo "   2. Print to PDF (Ctrl+P or Cmd+P)"
echo "   3. Save as: $OUTPUT_FILE"
echo ""
echo "Or install a PDF converter:"
echo "   sudo apt install wkhtmltopdf"
