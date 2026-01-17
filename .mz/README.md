# Apollo.io Interview Prep - Cal.com AI-Assisted Live Coding

## 🎯 Interview Overview

- **Duration**: 60 minutes
- **Format**: Live coding in AI-enabled IDE (Cursor/Zed/Claude Code)
- **Product**: Cal.com - open-source scheduling platform
- **Login**: `pro@example.com` / `pro`
- **Local URL**: http://127.0.0.1:3000

## 📚 Prep Materials in This Directory

### Core Guides
1. **[01-environment-setup.md](./01-environment-setup.md)** - Complete setup checklist
2. **[02-codebase-navigation.md](./02-codebase-navigation.md)** - How to navigate Cal.com
3. **[03-ai-collaboration.md](./03-ai-collaboration.md)** - Effective AI prompting strategies
4. **[04-tech-stack-reference.md](./04-tech-stack-reference.md)** - Quick tech stack guide
5. **[05-interview-day-checklist.md](./05-interview-day-checklist.md)** - Day-of checklist
6. **[06-common-patterns.md](./06-common-patterns.md)** - Cal.com coding patterns
7. **[07-problem-solving-framework.md](./07-problem-solving-framework.md)** - Approach framework

### Advanced AI Mastery
8. **[08-cursor-prompting-mastery.md](./08-cursor-prompting-mastery.md)** - Master Cursor AI prompting
9. **[09-ai-control-strategies.md](./09-ai-control-strategies.md)** - Maintain control over AI
10. **[10-prompt-templates.md](./10-prompt-templates.md)** - Ready-to-use prompt templates
11. **[11-practice-exercises.md](./11-practice-exercises.md)** - Hands-on practice exercises
12. **[12-real-scenarios-with-prompts.md](./12-real-scenarios-with-prompts.md)** - 5 complete scenarios with full dialogues

## ✅ Quick Pre-Interview Checklist

### Environment (Complete 1+ day before)
- [ ] Node 18.x, Yarn 3.4.1, Docker installed
- [ ] `yarn` dependencies installed
- [ ] `.env` configured with secrets
- [ ] `yarn dx` runs successfully
- [ ] Can login and navigate dashboard
- [ ] Hot reload works for code changes

### Knowledge
- [ ] Understand Cal.com's main workflows (booking, availability, event types)
- [ ] Know project structure (apps/web, packages/*)
- [ ] Familiar with tRPC API patterns
- [ ] Can find and read components quickly
- [ ] Understand form validation with React Hook Form

### AI Tools
- [ ] AI assistant ready in IDE
- [ ] Practiced narrating prompts out loud
- [ ] Know how to ask for clarification
- [ ] Comfortable reviewing AI-generated code

### Communication
- [ ] Practice thinking out loud
- [ ] Prepare questions about requirements
- [ ] Know how to explain trade-offs
- [ ] Can describe code review process

## 🎯 What They're Evaluating

1. **Problem-Solving** (25%)
   - Clarifying ambiguous requirements
   - Breaking down tasks
   - Navigating unfamiliar codebase

2. **AI Collaboration** (30%)
   - Effective prompting
   - Critical review of AI output
   - Iterative refinement
   - Knowing when to manually intervene

3. **Code Quality** (25%)
   - TypeScript type safety
   - Following project conventions
   - Handling edge cases
   - Writing maintainable code

4. **Communication** (20%)
   - Explaining thought process
   - Asking clarifying questions
   - Describing trade-offs
   - Narrating AI interactions

## 🚀 Interview Day Strategy

### Phase 1: Understand (5-10 min)
1. Listen to requirements carefully
2. Ask clarifying questions
3. Identify constraints and edge cases
4. Propose high-level approach
5. Get alignment before coding

### Phase 2: Implement (30-40 min)
1. Navigate to relevant code
2. Craft clear, specific AI prompts
3. Review generated code critically
4. Test in running application
5. Handle edge cases
6. Refine and iterate

### Phase 3: Validate (10-15 min)
1. Demonstrate working solution
2. Explain key decisions
3. Discuss trade-offs
4. Address edge cases
5. Suggest improvements

## ⚠️ Common Pitfalls to Avoid

- ❌ Not setting up environment ahead of time
- ❌ Blindly accepting AI output without review
- ❌ Poor explanation of reasoning
- ❌ Ignoring product constraints
- ❌ Focusing only on "making it work"
- ❌ Not testing in the actual running app
- ❌ Forgetting TypeScript types
- ❌ Not asking questions when requirements are unclear

## 💡 Key Success Factors

✅ **Narrate your thinking** - Explain what you're doing and why
✅ **Use the running app** - Validate behavior, don't just trust code
✅ **Review AI output** - Check types, edge cases, conventions
✅ **Ask questions** - Clarify requirements early
✅ **Balance speed and quality** - Use AI for scaffolding, review for correctness
✅ **Handle edge cases** - Think about error states and validation
✅ **Follow conventions** - Use existing patterns in the codebase

## 🔧 Quick Commands Reference

```bash
# Start dev server
yarn dx

# Type check
yarn type-check:ci --force

# Lint and format
yarn biome check --write path/to/file.tsx

# Run specific test
yarn vitest run path/to/file.test.ts

# Database commands
yarn prisma generate
yarn workspace @calcom/prisma db-migrate
```

## 📖 Reading Order

### First Time (2-3 hours before interview)
1. Read this README
2. Read 01-environment-setup (ensure setup works)
3. Skim 02-codebase-navigation
4. Read 03-ai-collaboration
5. Bookmark 04-tech-stack-reference
6. Read 05-interview-day-checklist
7. Skim 06-common-patterns

### Day Before Interview (1-2 hours)
1. Re-read 05-interview-day-checklist
2. Study 08-cursor-prompting-mastery
3. Study 09-ai-control-strategies
4. Practice with 10-prompt-templates
5. Do 2-3 exercises from 11-practice-exercises

### Morning of Interview (30 minutes)
1. Quick review of 05-interview-day-checklist
2. Have 10-prompt-templates open for reference
3. Review "Quick Reference Card" sections

## 🎯 Quick Start Path

**Minimum viable prep (2 hours):**
1. Environment setup (01) - 30 min
2. AI collaboration (03) - 20 min  
3. Interview checklist (05) - 20 min
4. Cursor prompting (08) - 30 min
5. Practice one exercise (11) - 20 min

**Comprehensive prep (6-8 hours):**
- Read all guides sequentially
- Complete 4-5 practice exercises
- Do a mock interview simulation
- Review and refine weak areas

## 📖 Additional Resources

- [Cal.com GitHub](https://github.com/calcom/cal.com)
- [Cal.com Documentation](https://cal.com/docs)
- Main codebase rules: `/AGENTS.md`
- Extended guides: `/agents/` directory

---

**Remember**: This interview is about demonstrating engineering judgment, not just getting code to work. Show how you think, collaborate with AI, and make decisions.

Good luck! 🚀
