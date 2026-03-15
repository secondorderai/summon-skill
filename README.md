# ⚡ Summon

> **Summon a personalized team of AI agents into your codebase from first principles.**

---

## What Is Summon?

Summon is a Claude Code skill that **generates stack-aware, project-specific AI agent files** through a progressive interview. Instead of shipping 100 generic agent templates, Summon understands your codebase — your framework, your ORM, your conventions — and creates agents that speak your language from day one.

Each generated agent is a `.md` file that Claude Code autonomously picks up from `.claude/agents/`.

Works with both existing codebases and brand-new projects — if your repo is empty, Summon switches to greenfield mode and helps you plan your stack before generating agents.

**Think of it as:** `npx create-agent` but it actually knows your stack.

---

## Why Not Just Use Generic Agent Templates?

A "Backend Architect" template that speaks Express.js is useless in a Hono + Drizzle + Cloudflare Workers codebase. Generic agents:

- ❌ Don't know your ORM, so they suggest raw SQL or the wrong query builder
- ❌ Don't know your error handling patterns, so they introduce inconsistencies
- ❌ Don't know your test framework, so they write tests you can't run
- ❌ Don't know your deployment model, so their infra advice doesn't apply

Summon agents:

- ✅ **Scan your project** — detect frameworks, ORMs, databases, infra, CI/CD, and conventions automatically
- ✅ **Interview you** — fill gaps with targeted questions about your specific workflow and pain points
- ✅ **Generate stack-native code patterns** — real examples in your stack, not generic pseudocode
- ✅ **Enforce your conventions** — rules derived from your codebase, not someone else's

---

## Quick Start

### 1. Install the Skill

#### Options 1 (Recommended)

Install with npx skills

```bash
npx skills add secondorderai/summon-skill
```

#### Option 2 (Manual)

Manually clone and copy the skill into your Coding Agent skills directory:

Claude Code

```bash
git clone https://github.com/secondorderai/summon-skill.git
cp -R summon-skill/skills .claude
```

### 2. Summon an Agent

In any project with Claude Code:

```
summon a backend engineer for this project
```

```
create a security auditor agent
```

```
set up an agent team for this repo
```

Summon will:

1. **Scan your project** — detect your stack automatically
2. **Confirm what it found** — "I see Next.js + Prisma + PostgreSQL on Vercel. Right?"
3. **Ask role-specific questions** — error handling patterns, testing philosophy, pain points
4. **Generate the agent** — write to `.claude/agents/` with full structure

### 3. Use Your Agent

Once generated, Claude Code picks it up automatically:

```
Use the backend engineer agent to implement the new API endpoint
```

---

## What Gets Generated

Each agent is a single `.md` file with this structure:

```
.claude/agents/
├── engineering-backend-engineer.md
├── quality-security-auditor.md
├── quality-code-reviewer.md
└── orchestrator.md              # If you summoned a team
```

Every agent includes:

| Section                    | Purpose                                                          |
| -------------------------- | ---------------------------------------------------------------- |
| **Identity & Context**     | Role, personality, expertise — shapes how the agent communicates |
| **Core Mission**           | What this agent exists to do, in concrete terms                  |
| **Critical Rules**         | Non-negotiable guardrails with explanations of WHY               |
| **Stack Context**          | Your specific technologies, baked in                             |
| **Technical Deliverables** | Real code patterns in your stack                                 |
| **Workflow**               | Step-by-step methodology for primary tasks                       |
| **Success Metrics**        | How to know the agent is doing its job well                      |
| **Communication Style**    | Interaction pattern — terse, detailed, question-first            |

---

## Supported Roles

### ⚙️ Engineering

| Role               | Best For                                         |
| ------------------ | ------------------------------------------------ |
| Backend Engineer   | API development, database queries, server logic  |
| Frontend Engineer  | Components, styling, state management, UX        |
| Fullstack Engineer | End-to-end features, type-safe API integration   |
| AI/ML Engineer     | Model serving, data pipelines, LLM integration   |
| DevOps Engineer    | CI/CD, infrastructure, deployment, monitoring    |
| Data Engineer      | Pipelines, transformations, warehouse management |

### 🔍 Quality

| Role                 | Best For                                             |
| -------------------- | ---------------------------------------------------- |
| QA Engineer          | Test strategy, coverage gaps, test automation        |
| Security Auditor     | Threat modeling, vuln assessment, secure code review |
| Code Reviewer        | PR reviews, standards enforcement, refactoring       |
| Performance Engineer | Profiling, optimization, load testing, budgets       |

### 🏗️ Product & Architecture

| Role             | Best For                                         |
| ---------------- | ------------------------------------------------ |
| System Architect | Service boundaries, scaling strategy, tech debt  |
| Tech Lead        | Team standards, decision docs, process design    |
| API Designer     | Contract-first design, versioning, documentation |

### 🤖 Custom

Describe any role and Summon will derive the agent from first principles.

---

## Multi-Agent Teams

Summon can generate a coordinated team of agents with an orchestrator:

```
summon a team: backend engineer, code reviewer, and QA engineer
```

The orchestrator agent:

- **Routes tasks** — decides which agent handles what
- **Defines workflows** — New Feature flow, Bug Fix flow, Security Response flow
- **Manages handoffs** — context that passes between agents
- **Resolves conflicts** — Security > Correctness > Performance > Style

---

## How the Interview Works

Summon uses a **progressive interview** — it doesn't dump 20 questions on you. Instead:

```
Phase 1: "What kind of agent do you need?"
         → Backend Engineer

Phase 2: "I scanned your project. I see TypeScript, Hono, Drizzle ORM,
          PostgreSQL, Docker, GitHub Actions. Anything I'm missing?"
         → "We also use Redis for caching"

Phase 3: "A few things that'll make this agent really useful:
          - How do you handle errors? (Result types, exceptions, custom?)
          - What's your testing philosophy? (Coverage target? Unit vs integration?)
          - What do juniors always get wrong in this codebase?"
         → User answers

Generate → .claude/agents/engineering-backend-engineer.md
```

If the user says "just make me a code reviewer" — Summon infers from the project, generates a sensible default, and asks "anything you'd change?" No interrogation.

### Greenfield Project

```
Phase 1: "What kind of agent do you need?"
         → Backend Engineer

Phase 2: "This looks like a fresh project. What are you planning to build?"
         → "A REST API for a SaaS product, probably in TypeScript"
         "Any framework preference? For TypeScript APIs, Hono and Fastify are
          both great lightweight options, or NestJS if you want batteries-included."
         → "Hono sounds good, with PostgreSQL"

Phase 3: "A few things to shape the agent:
          - Solo project or team?
          - What scale are you expecting? (hobby / MVP / production)
          - Any hard constraints? (hosting, budget, compliance)"
         → User answers

Generate → .claude/agents/engineering-backend-engineer.md
           (includes Recommended Setup + First Steps sections)
```

---

## Project Scanner

Summon ships a `project-scanner.sh` that auto-detects:

- **Languages** — TypeScript, Python, Go, Rust, Java, Ruby, Elixir
- **Frameworks** — Next.js, React, Vue, Hono, FastAPI, Django, PyTorch, etc.
- **Databases** — PostgreSQL, MySQL, MongoDB, SQLite + ORM detection (Prisma, Drizzle, SQLAlchemy)
- **Infrastructure** — Docker, AWS CDK, Terraform, Vercel, Cloudflare Workers, Fly.io
- **CI/CD** — GitHub Actions, GitLab CI, CircleCI
- **Testing** — Vitest, Jest, Playwright, Cypress, Pytest
- **Conventions** — CLAUDE.md, .cursorrules, ESLint, Prettier, existing agents
- **Project Status** — Detects whether the project is greenfield (empty/new) or existing, and adapts the interview flow accordingly

---

## Skill Structure

```
summon-skill/
├── skills/
│   └── summon/
│       ├── SKILL.md                  # Core skill — interview flow + generation logic
│       ├── role-templates.md         # Per-role interview guides + default patterns
│       ├── orchestrator-guide.md     # Multi-agent composition patterns
│       ├── project-scanner.sh        # Auto-detect project stack
│       └── agent-writer.sh          # Safe file writer with backup
├── samples/
│   └── tech-team/                    # Example generated agent team
│       ├── orchestrator.md
│       ├── engineering-backend-engineer.md
│       ├── engineering-frontend-engineer.md
│       ├── quality-code-reviewer.md
│       └── quality-qa-engineer.md
├── LICENSE
└── README.md
```

---

## Inspiration

Summon was inspired by [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) — an excellent collection of pre-built AI agent personas. Summon takes a different approach: instead of shipping agents, it **generates them from first principles** based on your actual project context.

---

## Contributing

Contributions welcome! Some ideas:

- **New role templates** — Add interview guides for roles not yet covered
- **Stack detection** — Improve `project-scanner.sh` for more frameworks/tools
- **Agent quality** — Share examples of generated agents that work well (or don't)
- **Multi-tool support** — Adapt generation for Cursor, Windsurf, Copilot agents

---

## License

[MIT](https://opensource.org/licenses/MIT) — Use freely, fork freely, summon freely.  
[PRs Welcome](https://makeapullrequest.com)
