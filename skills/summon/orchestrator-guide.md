# Orchestrator Generation Reference

This file contains guidance for generating multi-agent orchestrator files. Read this
when the user requests a team composition or when generating an orchestrator agent.

## When to Generate an Orchestrator

Generate an orchestrator when:
- The user explicitly asks for a "team" or "agent team"
- Two or more agents have been generated in the same session
- The user says "create agents for this project" (implies multiple)

Do NOT generate an orchestrator for a single agent.

## Orchestrator Structure

The orchestrator is NOT a manager that controls other agents. It's a routing guide
that helps Claude Code (or the user) decide which agent to activate for a given task.
Think of it as a team playbook, not a supervisor.

### Core Sections

**1. Team Roster**

List each agent with:
- File path relative to project root
- Primary responsibility (one sentence)
- Trigger phrases (what kind of requests should route to this agent)

Example:
```
| Agent | Path | Responsibility | Activate When |
|-------|------|---------------|---------------|
| Backend Engineer | `.claude/agents/engineering-backend-engineer.md` | API development, DB queries, server logic | "add an endpoint", "fix the query", "database migration" |
| Security Auditor | `.claude/agents/quality-security-auditor.md` | Threat analysis, auth review, vuln scanning | "security review", "is this safe", "audit this" |
```

**2. Workflow Sequences**

Define common multi-agent workflows as ordered sequences. These represent how work
typically flows through the team.

Common patterns:

- **New Feature Flow:**
  Architect (scope) → Engineer (implement) → Code Reviewer (review) → QA (test)

- **Bug Fix Flow:**
  QA (reproduce + isolate) → Engineer (fix) → Code Reviewer (verify fix) → QA (regression)

- **Security Response:**
  Security Auditor (assess) → Engineer (remediate) → Security Auditor (verify) → DevOps (deploy)

- **Performance Issue:**
  Performance Engineer (profile + identify) → Engineer (optimize) → Performance Engineer (validate)

- **New API Endpoint:**
  API Designer (contract) → Backend Engineer (implement) → Security Auditor (review) → QA (test)

Customize these based on which agents actually exist in the team. Don't reference
agents that weren't generated.

**3. Handoff Protocol**

When work passes from one agent to another, the handoff should include:

- What was done (summary of changes/decisions)
- What needs to happen next (specific next action)
- Context the next agent needs (file paths, requirements, constraints)
- Open questions or concerns

This ensures continuity across agent switches without losing context.

**4. Conflict Resolution**

When agents have competing priorities, define resolution order:

1. **Security > everything** — Security concerns block until resolved
2. **Correctness > performance** — Working code before fast code
3. **User requirements > conventions** — Conventions serve the user, not the reverse
4. **Simplicity > cleverness** — When in doubt, pick the boring solution

The user always has final say. The orchestrator's conflict resolution is advisory.

**5. Parallel Work Identification**

Help identify tasks that can proceed in parallel:

- Frontend + Backend can work simultaneously when API contracts are defined first
- Security audit can run in parallel with QA testing
- Documentation can proceed alongside implementation
- Performance testing runs after feature completion but parallel with code review

**6. Evolution Coordination**

The orchestrator has additional responsibilities for the team's shared knowledge base
at `.claude/evolution/`:

**Periodic Knowledge Review:**
When starting a new major task or at the user's request, the orchestrator should:
1. Read all four evolution files
2. Summarize the current state: "The team has accumulated N patterns, N anti-patterns,
   N decisions, and N learnings. Key themes: [top 3]."
3. Identify pending cross-agent feedback loops (e.g., "Sentinel has flagged missing
   input validation 4 times — this should become a rule for Atlas")
4. Propose any agent definition updates that have accumulated enough evidence

**Evolution File Maintenance:**
When evolution files grow beyond ~100 entries:
1. Propose consolidating old entries — merge similar learnings, archive resolved anti-patterns
2. Promote the most impactful patterns into the relevant agent's Technical Deliverables section
3. Mark decisions as superseded when new decisions replace them

**Conflict Resolution with Evolution Context:**
When resolving conflicts between agents, check `decisions.md` for prior decisions on
the same topic. If a prior decision exists, default to it unless circumstances have changed.
Document any decision reversals with explicit rationale.

**Handoff Enrichment:**
When handing off between agents, add evolution context to the handoff:
- "Check `.claude/evolution/anti-patterns.md` for known issues in this area."
- "There's a proven pattern in `.claude/evolution/patterns.md` for this type of task."

## Generation Guidelines

- Keep the orchestrator under 150 lines — it's a quick reference, not a manual
- Use tables for the roster — they're scannable
- Write workflow sequences as simple arrows, not complex diagrams
- The orchestrator should be useful even if the user never reads it explicitly —
  Claude Code will reference it when deciding which agent to activate
- Don't repeat content from individual agents — reference their files instead
- Focus on the relationships and handoffs, not the individual capabilities

## Example Orchestrator for a Typical Web App Team

```markdown
# Team Orchestrator

## Identity & Context

You are the **Team Orchestrator** for this project. Your job is to route tasks to the
right specialist and coordinate multi-agent workflows. You don't do the work yourself —
you ensure the right agent handles each task with the right context.

## Team Roster

| Agent | File | Specialty | Activate When |
|-------|------|-----------|---------------|
| Backend Engineer | `engineering-backend-engineer.md` | API, DB, server logic | API work, queries, migrations, server errors |
| Frontend Engineer | `engineering-frontend-engineer.md` | UI, components, UX | Component work, styling, client state, UX issues |
| Code Reviewer | `quality-code-reviewer.md` | Review, standards | PR review, refactoring, code quality questions |
| QA Engineer | `quality-qa-engineer.md` | Testing, coverage | Writing tests, debugging flaky tests, coverage gaps |

## Workflow Sequences

**New Feature:**
1. Backend Engineer → implement API endpoint + DB changes
2. Frontend Engineer → build UI components + integrate API
3. Code Reviewer → review both backend and frontend changes
4. QA Engineer → write integration + e2e tests

**Bug Fix:**
1. QA Engineer → reproduce and write failing test
2. Relevant Engineer → implement fix
3. Code Reviewer → review fix
4. QA Engineer → verify fix + add regression test

**Refactoring:**
1. Code Reviewer → identify scope and approach
2. Relevant Engineer → implement refactor
3. Code Reviewer → verify no behavior change
4. QA Engineer → run full test suite

## Handoff Protocol

When switching agents, include:
- **Done**: What was completed (with file paths)
- **Next**: Specific action for the next agent
- **Context**: Relevant requirements, constraints, or decisions made
- **Watch**: Any concerns or risks to be aware of

## Conflict Resolution

Security > Correctness > User Requirements > Performance > Code Style

## Evolution Status

The team maintains shared knowledge at `.claude/evolution/`. Before routing complex tasks:

1. Quick scan: `ls -la .claude/evolution/` — verify the directory exists
2. For complex tasks, remind the target agent to check evolution files first
3. When cross-agent feedback accumulates (same issue 3+ times), propose agent definition updates
4. Periodically summarize: "Team has N patterns, N anti-patterns, N decisions, N learnings"
```
