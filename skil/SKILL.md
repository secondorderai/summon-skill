---
name: summon
description: >
  Generate bespoke, stack-aware Claude Code agent files for tech teams. Creates specialized
  AI agent personas (backend, frontend, fullstack, AI/ML, DevOps, QA, security, code reviewer,
  performance engineer, system architect, tech lead) that Claude Code autonomously picks up
  from `.claude/agents/`. Use this skill whenever the user says things like "create an agent",
  "I need a code reviewer agent", "generate a backend agent for this project", "set up agents
  for my team", "build me a QA specialist", "create a security auditor agent", "I want a tech
  lead agent", "set up an agent team", "create agents for this repo", or any request involving
  creating Claude Code agent definitions, AI specialist personas, or team compositions for
  agentic coding workflows. Also trigger when the user mentions "agency agents", "agent roster",
  "agent team", or wants to scaffold autonomous coding assistants into their project.
---

# Agency Skill Creator

A skill for generating bespoke, stack-aware Claude Code agent files through a progressive
interview process. Each generated agent is a specialized AI persona with identity, personality,
mission, critical rules, concrete code patterns, workflows, and success metrics — designed to
be autonomously picked up by Claude Code from the project-local `.claude/agents/` directory.

## Why This Skill Exists

Generic agent templates are too broad to be useful. A "backend architect" agent that speaks
Express.js is useless in a Hono + Drizzle + Cloudflare Workers codebase. This skill generates
agents from first principles: it understands your stack, your conventions, your pain points,
and produces agents that speak your language and enforce your standards.

## How It Works

The skill follows a progressive interview flow:

1. **Role Selection** — What kind of specialist does the user need?
2. **Stack Discovery** — What technologies, patterns, and conventions define this project?
3. **Domain Drilling** — Role-specific questions that shape the agent's expertise
4. **Generation** — Produce the agent `.md` file with full structure
5. **Composition** (optional) — Generate an orchestrator agent that coordinates a team

## Progressive Interview Flow

### Phase 1: Role Selection

Ask the user what role they need. Present the three categories:

**Engineering Roles:**
- Backend Engineer
- Frontend Engineer
- Fullstack Engineer
- AI/ML Engineer
- DevOps / Infrastructure Engineer
- Data Engineer

**Quality Roles:**
- QA Engineer / Test Specialist
- Security Auditor
- Code Reviewer
- Performance Engineer

**Product & Architecture Roles:**
- System Architect
- Tech Lead
- API Designer

If the user describes something that doesn't fit these categories, derive the closest match
and confirm. The categories are guidelines, not constraints — the user might want a
"Database Migration Specialist" or "Observability Engineer" and that's perfectly valid.

### Phase 2: Stack Discovery

After role selection, discover the project's technical context. You have two sources:

**A) Project Inference (preferred first step)**

Before asking questions, look at the project to infer as much as possible:

```bash
# Check for package.json, requirements.txt, go.mod, Cargo.toml, etc.
ls -la package.json pyproject.toml requirements.txt go.mod Cargo.toml 2>/dev/null

# Check framework indicators
cat package.json 2>/dev/null | grep -E '"(next|react|vue|angular|express|hono|fastify|nest)"'
cat pyproject.toml 2>/dev/null | grep -E '(fastapi|django|flask|pytorch|tensorflow)'

# Check for ORM/DB patterns
ls -la prisma/ drizzle/ alembic/ migrations/ 2>/dev/null
grep -r "DATABASE_URL" .env* 2>/dev/null | head -3

# Check cloud/infra indicators
ls -la Dockerfile docker-compose* cdk.json serverless.yml terraform/ pulumi/ 2>/dev/null
ls -la .github/workflows/ .gitlab-ci.yml 2>/dev/null

# Check for existing conventions
cat CLAUDE.md .cursorrules .windsurfrules 2>/dev/null | head -50
ls -la .claude/agents/ 2>/dev/null
```

Present your inferences to the user: "I can see this is a TypeScript/Node.js project using
Next.js with Prisma and PostgreSQL, deployed via Docker. Is that right? Anything I'm missing?"

**B) Direct Questions (fill gaps)**

For anything you couldn't infer, ask specifically. Focus on what's relevant to the chosen role:

- **For Backend roles**: Primary language, framework, ORM, database(s), message queues, caching
- **For Frontend roles**: Framework, styling approach (Tailwind/CSS modules/styled-components), state management, component patterns
- **For AI/ML roles**: ML frameworks, model serving approach, data pipeline tools, vector DBs
- **For DevOps roles**: Cloud provider(s), IaC tool, CI/CD platform, container orchestration
- **For Quality roles**: Test framework, coverage tools, CI integration, staging setup
- **For Architecture roles**: Service topology (monolith/microservices/modular monolith), communication patterns, deployment model

### Phase 3: Domain Drilling

Now ask role-specific questions that shape the agent's behavior. These determine the
agent's critical rules, workflows, and code patterns.

**For Engineering roles, ask about:**
- Code conventions and style (naming, file structure, import patterns)
- Error handling philosophy (Result types? Exceptions? Error boundaries?)
- Logging and observability patterns
- Testing expectations (unit? integration? e2e? coverage thresholds?)
- PR/commit conventions
- Key pain points ("what do juniors always get wrong in this codebase?")

**For Quality roles, ask about:**
- What kinds of bugs ship most often?
- Current test coverage and gaps
- Review bottlenecks (what takes longest in code review?)
- Security posture and compliance requirements
- Performance SLAs and budgets
- What does "production ready" mean for this project?

**For Product & Architecture roles, ask about:**
- System boundaries and ownership model
- Decision-making process for technical choices
- Scalability targets and current bottlenecks
- Technical debt priorities
- Cross-team integration patterns
- Documentation standards

Keep the interview focused — 3-5 questions per phase, not an interrogation. Infer what
you can, confirm what you must, and ask only what you genuinely need.

## Agent File Structure

Generate each agent as a single `.md` file placed in `.claude/agents/`. The file follows
this structure (derived from the agency-agents pattern but adapted for Claude Code):

```markdown
# {Role Title}

## Identity & Context

You are **{Agent Name}**, a {role description with personality and expertise}.

- **Role**: {specific role}
- **Personality**: {3-4 traits that shape communication style}
- **Expertise**: {concrete technical domains}

## Core Mission

{2-3 sentences defining what this agent exists to do. Be specific and actionable.}

## Critical Rules

{5-8 non-negotiable rules specific to this role and stack. These are the guardrails
that prevent the agent from doing harm. Written as imperative statements with the WHY
explained.}

## Stack Context

{The project's specific technology choices, baked in so the agent doesn't need to
rediscover them each session.}

## Technical Deliverables

{Concrete code patterns, templates, and examples specific to this stack. This is where
the agent's expertise becomes tangible. Include 2-4 real patterns the agent should
produce or enforce.}

## Workflow

{Step-by-step process the agent follows for its primary tasks. This is the agent's
methodology — how it approaches work, in what order, with what checkpoints.}

## Success Metrics

{How to know the agent is doing its job well. Measurable where possible.}

## Communication Style

{How the agent talks — terse? detailed? asks questions first? shows examples?
This shapes the interaction pattern.}
```

### Naming Convention

Agent files should be named: `{category}-{role-slug}.md`

Examples:
- `engineering-backend-engineer.md`
- `quality-security-auditor.md`
- `architecture-system-architect.md`
- `quality-code-reviewer.md`
- `engineering-devops-engineer.md`

## Generating the Agent

After the interview is complete, generate the agent file following these principles:

1. **Stack-specific, not generic.** If the project uses Drizzle ORM, the agent should
   reference Drizzle patterns, not generic SQL. If it's a Next.js app, server components
   and app router patterns should be baked in.

2. **Opinionated where the user was opinionated.** If the user said "we always use Result
   types for error handling", the agent enforces that. If they didn't mention error handling,
   use sensible defaults for the stack.

3. **Concrete code patterns > abstract guidance.** "Use proper error handling" is useless.
   "Wrap all database calls in try/catch and return `{ success: false, error }` shape" is
   useful. Include actual code snippets the agent should produce or enforce.

4. **Personality serves function.** A security auditor should be skeptical and thorough.
   A rapid prototyper should be pragmatic and velocity-focused. Personality isn't decoration —
   it shapes how the agent prioritizes and communicates.

5. **Rules need reasons.** "Never use `any` type" is weaker than "Never use `any` type —
   it defeats the purpose of TypeScript and creates silent runtime failures that are hard
   to trace." Explaining WHY makes the rule stick.

After generating, write the file:

```bash
mkdir -p .claude/agents
# Write the agent file
cat > .claude/agents/{filename}.md << 'AGENT_EOF'
{generated content}
AGENT_EOF
```

Then confirm to the user: "Created `.claude/agents/{filename}.md`. Claude Code will
automatically pick this up in new sessions. Want to generate another agent or create a team?"

## Multi-Agent Composition

When the user wants a team of agents, generate each specialist individually (following the
full interview for each, but reuse stack context), then generate an orchestrator agent.

### The Orchestrator Agent

The orchestrator is a special agent that coordinates the others. It lives at
`.claude/agents/orchestrator.md` and:

1. **Knows the roster** — Lists all available agents with their specialties
2. **Routes tasks** — Given a task, recommends which agent(s) to activate
3. **Defines handoffs** — How work flows between agents (e.g., "after the backend
   engineer creates an API endpoint, the security auditor reviews it, then the
   QA engineer writes tests for it")
4. **Manages conflicts** — When agents have competing priorities (speed vs security,
   DRY vs readability), the orchestrator has a resolution framework

Generate the orchestrator after all individual agents are created. Its structure:

```markdown
# Team Orchestrator

## Identity & Context

You are the **Team Orchestrator**, responsible for coordinating specialized agents
in this project. You understand each agent's strengths and route work accordingly.

## Available Agents

{List each generated agent with: name, file path, primary responsibility, when to invoke}

## Task Routing

{Decision tree or rules for which agent handles what kind of task}

## Workflow Sequences

{Common multi-agent workflows, e.g.:
- New Feature: Architect → Backend → Frontend → Code Reviewer → QA
- Bug Fix: QA (reproduce) → relevant Engineer → Code Reviewer
- Security Incident: Security Auditor → Backend → DevOps
}

## Handoff Protocol

{How agents pass work to each other — what context to include, what to verify}

## Conflict Resolution

{When agents disagree, how to resolve — e.g., "security concerns override velocity
unless explicitly time-boxed by the user"}
```

## Important Reminders

- Always write to `.claude/agents/` in the project root, never to `~/.claude/agents/`
- Each agent is a standalone `.md` file — no YAML frontmatter needed for Claude Code agents
- Keep agents under 300 lines — if they're getting longer, the scope is too broad
- The interview is a conversation, not a form. Adapt to what the user tells you.
- If the user says "just make me a code reviewer", don't ask 20 questions. Infer from
  the project, generate a sensible default, and ask "anything you'd change?"
- Generated agents should be immediately useful without manual editing
- Reference `references/role-templates.md` for role-specific interview guides and
  default patterns when you need deeper guidance on a particular role
