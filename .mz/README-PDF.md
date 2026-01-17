# PDF Generation Instructions

## 🎯 Quick Start

Generate the complete interview prep PDF with one command:

```bash
cd .mz
bash generate_pdf.sh
```

## 📦 What Gets Generated

**Output:** `Apollo-Interview-Prep-Complete.pdf`

**Contents (in order):**
1. Main README (Overview)
2. 01 - Environment Setup
3. 02 - Codebase Navigation  
4. 03 - AI Collaboration
5. 04 - Tech Stack Reference
6. 05 - Interview Day Checklist
7. 06 - Common Patterns
8. 07 - Problem Solving Framework
9. 08 - Cursor Prompting Mastery
10. 09 - AI Control Strategies
11. 10 - Prompt Templates
12. 11 - Practice Exercises
13. 12 - Real Scenarios with Prompts

**Features:**
- ✅ Professional formatting
- ✅ Table of contents with page numbers
- ✅ Syntax highlighting for code blocks
- ✅ Numbered sections
- ✅ Hyperlinked cross-references
- ✅ ~150-200 pages of comprehensive material

## 🔧 Requirements

**Already installed:**
- ✅ Pandoc 3.1.3

**May need (for PDF engine):**
- LaTeX distribution (texlive on Linux, MacTeX on macOS)

### Install LaTeX if needed:

**Ubuntu/Debian:**
```bash
sudo apt install texlive-latex-base texlive-latex-extra
```

**macOS:**
```bash
brew install basictex
# OR download MacTeX from https://www.tug.org/mactex/
```

## 🎨 Customization Options

### Change Output Filename

Edit `generate_pdf.sh` line 11:
```bash
OUTPUT_FILE="your-custom-name.pdf"
```

### Adjust Page Margins

Edit the `--variable geometry:margin=` parameter:
```bash
--variable geometry:margin=0.75in  # Smaller margins
--variable geometry:margin=1.5in   # Larger margins
```

### Change Font Size

Edit the `--variable fontsize=` parameter:
```bash
--variable fontsize=10pt  # Smaller font
--variable fontsize=12pt  # Larger font
```

### Different Code Highlighting Style

Available styles: tango, pygments, kate, monochrome, espresso, zenburn, haddock, breezedark

```bash
--highlight-style=pygments
--highlight-style=zenburn
```

## 🚨 Troubleshooting

### Error: "pdflatex not found"

**Solution:** Install LaTeX:
```bash
# Ubuntu
sudo apt install texlive-latex-base texlive-latex-extra

# macOS  
brew install basictex
```

### Error: "! LaTeX Error: File not found"

**Solution:** Install additional LaTeX packages:
```bash
sudo apt install texlive-fonts-recommended texlive-fonts-extra
```

### PDF looks broken or has missing characters

**Solution:** Install Unicode font support:
```bash
sudo apt install texlive-xetex
```

Then edit `generate_pdf.sh` to use xelatex:
```bash
--pdf-engine=xelatex
```

### PDF is too large (>50MB)

**Solution:** The PDF should be 5-15MB. If larger:
- Check if images were accidentally included
- Use pdflatex instead of xelatex

## 📝 Alternative: Generate Without Script

**Single command:**
```bash
cd .mz
pandoc README.md 01-*.md 02-*.md 03-*.md 04-*.md 05-*.md 06-*.md 07-*.md 08-*.md 09-*.md 10-*.md 11-*.md 12-*.md \
  -o Apollo-Interview-Prep.pdf \
  --toc \
  --highlight-style=tango \
  --number-sections
```

## 🎯 What to Do With the PDF

### Before Interview:
1. Generate PDF: `bash generate_pdf.sh`
2. Copy to tablet/iPad for easy reference
3. Print key sections (05-interview-day-checklist, 10-prompt-templates)

### During Interview:
- Have PDF open on second screen
- Quick reference for commands, patterns
- Prompt templates at your fingertips

### After Interview:
- Share with friends preparing for similar interviews
- Use as reference for your own AI-assisted development

## 📊 File Information

**Script:** `generate_pdf.sh`
- Checks all files exist
- Generates PDF with proper ordering
- Shows success message with file size

**Ignored in Git:** `*.pdf` files (see `.gitignore`)
- PDFs are generated, not committed
- Keeps repository clean

## ✨ Tips

1. **Test first:** Generate PDF before interview day to ensure it works
2. **Keep updated:** Regenerate if you modify any markdown files
3. **Backup:** Keep a copy on cloud storage (Google Drive, Dropbox)
4. **Print:** Print 05-interview-day-checklist for day-of reference

---

**Questions or issues?** Check troubleshooting section above or regenerate with default settings.
