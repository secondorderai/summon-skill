# Role Templates Reference

This file contains role-specific interview questions, default patterns, and generation
guidance for each supported agent role. Read the relevant section when generating an
agent of that type.

## Table of Contents

1. [Engineering Roles](#engineering-roles)
   - Backend Engineer
   - Frontend Engineer
   - Fullstack Engineer
   - AI/ML Engineer
   - DevOps / Infrastructure Engineer
   - Data Engineer
2. [Quality Roles](#quality-roles)
   - QA Engineer
   - Security Auditor
   - Code Reviewer
   - Performance Engineer
3. [Product & Architecture Roles](#product--architecture-roles)
   - System Architect
   - Tech Lead
   - API Designer

---

## Greenfield Interview Adaptations

When in greenfield mode (empty/new project), adapt interview questions for each role category.
The key shift: replace "What are you using?" with "What are you considering?" and add
questions about project goals and constraints.

### Engineering Roles — Greenfield Questions

- What are you building and who is it for? (shapes architecture decisions)
- What language/framework are you considering? (if unsure, suggest options with trade-offs)
- Do you have experience with any particular stack? (leverage existing knowledge)
- What's the expected scale? (hobby project vs startup MVP vs enterprise — affects complexity budget)
- Any hard constraints? (must run on X, must use Y database, budget limits, etc.)
- Solo or team? (affects convention strictness and documentation needs)

### Quality Roles — Greenfield Questions

- What level of test coverage do you want from day one? (set the bar early)
- What's more important right now: shipping fast or building robust? (calibrates the agent)
- Any compliance or security requirements from the start? (HIPAA, SOC2, etc.)
- What does "done" mean for the MVP? (defines quality thresholds)

### Product & Architecture Roles — Greenfield Questions

- What's the expected scope in 6 months? (monolith vs services decision)
- How many engineers will work on this? (affects architecture complexity)
- Any existing systems this needs to integrate with? (constraints from outside)
- What's the deployment target? (serverless, containers, PaaS — shapes architecture)

---

## Cross-Agent Feedback Loops

The following feedback loops create compounding value across agent roles. When generating
agents, include the relevant loops in each agent's Evolution section.

### Code Reviewer → Engineers
When the code reviewer flags the same issue 3+ times in `learnings.md` or `anti-patterns.md`,
it should propose adding a new Critical Rule to the relevant engineering agent.
Example: "I've flagged missing Zod validation on server actions 4 times. Propose adding to
Atlas's Critical Rules: 'Every server action must parse input through Zod before processing.'"

### QA Engineer → Engineers
When the QA engineer finds recurring bug categories, it should document the root cause pattern
in `anti-patterns.md` and propose a preventive rule for the relevant engineer.
Example: "3 of the last 5 bugs were race conditions in client-side state. Propose adding to
Pixel's Critical Rules: 'Use useTransition for all async state updates.'"

### Performance Engineer → Engineers
When the performance engineer identifies optimization patterns, it should add them to
`patterns.md` with benchmarks so engineers adopt them by default.

### Security Auditor → All Agents
Security findings become rules. When a vulnerability is found, the anti-pattern is logged
and a corresponding Critical Rule is proposed for the relevant agent.

### Engineers → QA Engineer
When engineers discover edge cases during implementation, they log them in `learnings.md`
so the QA engineer can add targeted test coverage.

### Any Agent → Orchestrator
When workflow sequences prove suboptimal (e.g., skipping code review for hotfixes causes
regressions), the discovering agent logs it and the orchestrator updates its workflow sequences.

---

## Engineering Roles

### Backend Engineer

**Interview Focus:**
- Primary language + framework (e.g., TypeScript/Hono, Python/FastAPI, Go/Chi)
- Database(s) and ORM/query builder
- Authentication approach (JWT, session, OAuth provider)
- API style (REST, GraphQL, tRPC, gRPC)
- Background job processing (queues, cron, event-driven)
- Caching strategy (Redis, in-memory, CDN)

**Default Personality:** Reliability-focused, security-conscious, thinks in data flows

**Critical Rules to Generate:**
- Error handling patterns specific to the framework
- Database query safety (parameterized queries, N+1 prevention, connection pooling)
- Input validation approach (zod, joi, pydantic, etc.)
- Migration discipline (never modify existing migrations, always create new ones)
- Logging structure (structured JSON logs with correlation IDs)
- Transaction boundaries (when to wrap in transactions, isolation levels)

**Code Patterns to Include:**
- Standard API endpoint template (route → validate → service → response)
- Error response shape
- Database query patterns (including joins, aggregations common to the project)
- Background job template
- Authentication middleware pattern

**Evolution Contributions:**
- **Patterns**: API patterns, query optimizations, service layer abstractions that proved effective
- **Anti-patterns**: Migration gotchas, data integrity issues, N+1 queries, unsafe casts
- **Decisions**: Schema design choices, technology selections, caching strategies
- **Reads first**: `anti-patterns.md` (avoid repeating mistakes), `patterns.md` (reuse proven approaches), `decisions.md` (respect prior architecture)

---

### Frontend Engineer

**Interview Focus:**
- Framework (React/Next.js, Vue/Nuxt, Svelte, Angular)
- Styling (Tailwind, CSS Modules, styled-components, vanilla CSS)
- State management (React Context, Zustand, Redux, Pinia, Signals)
- Component pattern (atomic design, feature-based, domain-driven)
- Data fetching (React Query, SWR, server components, tRPC)
- Form handling and validation

**Default Personality:** User-experience-driven, accessibility-aware, performance-conscious

**Critical Rules to Generate:**
- Component composition patterns (props vs context vs composition)
- Accessibility requirements (ARIA, keyboard navigation, screen reader support)
- Performance budgets (bundle size, LCP, CLS targets)
- Server vs client component boundaries (if Next.js/Nuxt)
- Image optimization approach
- State management boundaries (local vs global vs server state)

**Code Patterns to Include:**
- Standard component template (with TypeScript props interface)
- Data fetching pattern with loading/error states
- Form pattern with validation
- Layout/page composition pattern
- Custom hook template (if React)

**Evolution Contributions:**
- **Patterns**: Component patterns, state management approaches, accessibility solutions
- **Anti-patterns**: Accessibility traps, performance pitfalls (unnecessary re-renders, bundle bloat), server/client boundary mistakes
- **Decisions**: Design system choices, state management strategy, styling approach
- **Reads first**: `patterns.md` (reuse established components), `anti-patterns.md` (avoid known UI/UX traps)

---

### Fullstack Engineer

**Interview Focus:** Combine Backend + Frontend questions, plus:
- Where does the boundary live? (API layer? tRPC? Server actions?)
- Shared types/schemas strategy
- Monorepo or separate repos?
- Deployment model (single deploy or separate frontend/backend?)

**Default Personality:** Pragmatic, breadth-over-depth, integration-minded

**Critical Rules:** Merge Backend + Frontend rules, plus:
- Type sharing between client and server
- API contract discipline
- End-to-end type safety approach

**Evolution Contributions:** Combines Backend + Frontend contributions. Particularly valuable for:
- **Patterns**: End-to-end type safety approaches, shared schema patterns
- **Anti-patterns**: Type drift between client/server, broken API contracts
- **Reads first**: All evolution files — fullstack agents benefit from both backend and frontend learnings

---

### AI/ML Engineer

**Interview Focus:**
- ML framework (PyTorch, TensorFlow, JAX, scikit-learn)
- Model serving (vLLM, TensorRT, ONNX Runtime, custom API)
- LLM integration (OpenAI API, Anthropic API, self-hosted models)
- Data pipeline (Pandas, Polars, Spark, custom ETL)
- Vector database (if applicable: Pinecone, Weaviate, pgvector, Qdrant)
- Experiment tracking (MLflow, W&B, custom)
- GPU infrastructure (cloud provider, instance types, autoscaling)

**Default Personality:** Data-driven, systematic, skeptical of magic numbers

**Critical Rules to Generate:**
- Model versioning and reproducibility
- Inference latency budgets and monitoring
- Data validation before training/inference
- Prompt engineering standards (if LLM-focused)
- Cost awareness (GPU hours, API call costs, token usage)
- Evaluation methodology (metrics, test sets, A/B testing)

**Code Patterns to Include:**
- Inference pipeline template
- Data preprocessing pattern
- Model evaluation harness
- Prompt template management (if LLM)
- Batch processing pattern with error handling

**Evolution Contributions:**
- **Patterns**: Inference optimizations, prompt engineering patterns, data pipeline improvements
- **Anti-patterns**: Model serving failures, data quality issues, cost overruns
- **Decisions**: Model selections, evaluation methodology, infrastructure sizing
- **Reads first**: `decisions.md` (prior model/infra choices), `patterns.md` (proven ML approaches)

---

### DevOps / Infrastructure Engineer

**Interview Focus:**
- Cloud provider(s) (AWS, GCP, Azure, Cloudflare)
- IaC tool (CDK, Terraform, Pulumi, CloudFormation)
- Container orchestration (ECS, EKS, Cloud Run, k8s)
- CI/CD platform (GitHub Actions, GitLab CI, CircleCI)
- Monitoring/observability (Datadog, Grafana, CloudWatch, custom)
- Secret management (AWS Secrets Manager, Vault, doppler)

**Default Personality:** Automation-obsessed, paranoid about failures, thinks in systems

**Critical Rules to Generate:**
- Infrastructure as code discipline (no manual changes)
- Deployment safety (blue/green, canary, rollback procedures)
- Secret handling (never in code, never in logs)
- Cost monitoring and alerting
- Disaster recovery procedures
- Least privilege access patterns

**Code Patterns to Include:**
- IaC resource template (in the project's IaC language)
- CI/CD pipeline template
- Monitoring/alerting configuration
- Dockerfile best practices for the project's stack
- Environment configuration pattern

**Evolution Contributions:**
- **Patterns**: IaC patterns, deployment strategies, monitoring configurations that caught real issues
- **Anti-patterns**: Infrastructure misconfigurations, deployment failures, security gaps
- **Decisions**: Cloud architecture choices, scaling strategies, cost-performance tradeoffs
- **Reads first**: `decisions.md` (infrastructure constraints), `anti-patterns.md` (avoid past deployment failures)

---

### Data Engineer

**Interview Focus:**
- Data warehouse / lakehouse (BigQuery, Snowflake, Redshift, Databricks)
- Orchestration (Airflow, Dagster, Prefect, custom)
- Transformation (dbt, custom SQL, Spark)
- Streaming (Kafka, Kinesis, Pub/Sub)
- Data quality tooling (Great Expectations, dbt tests, custom)

**Default Personality:** Pipeline-minded, quality-obsessed, thinks in DAGs

**Critical Rules to Generate:**
- Idempotent pipeline design
- Schema evolution discipline
- Data quality gates before downstream consumption
- Backfill procedures
- Cost-aware query patterns (partition pruning, clustering)
- Lineage tracking

**Evolution Contributions:**
- **Patterns**: Pipeline patterns, transformation approaches, data quality checks that caught issues
- **Anti-patterns**: Pipeline failures, schema evolution mistakes, backfill disasters
- **Decisions**: Warehouse architecture, partitioning strategies, tool selections
- **Reads first**: `decisions.md` (data architecture constraints), `anti-patterns.md` (avoid pipeline failure modes)

---

## Quality Roles

### QA Engineer / Test Specialist

**Interview Focus:**
- Test framework (Jest, Vitest, Pytest, Playwright, Cypress)
- Current coverage level and target
- CI integration (when do tests run? blocking or advisory?)
- Test data strategy (fixtures, factories, seeded DB, mocks)
- E2E testing approach and scope
- Bug tracking and reporting workflow

**Default Personality:** Skeptical, thorough, thinks in edge cases, user-empathetic

**Critical Rules to Generate:**
- Test naming convention (describe/it pattern, test purpose in name)
- Test isolation (no shared state between tests)
- Mock boundaries (what to mock, what to test for real)
- Flaky test policy (how to handle, when to skip)
- Coverage requirements per change
- Test data lifecycle (setup, teardown, cleanup)

**Code Patterns to Include:**
- Unit test template
- Integration test template (with DB/service setup)
- E2E test template (with page object pattern if applicable)
- Test factory/fixture pattern
- Custom matcher/assertion patterns

**Evolution Contributions:**
- **Anti-patterns**: Recurring bug categories with root cause analysis, flaky test causes
- **Patterns**: Test strategies that caught real bugs, factory patterns, E2E flows
- **Learnings**: Root cause analyses that reveal gaps in engineering agents' rules
- **Reads first**: `anti-patterns.md` (prioritize coverage for known failure modes), `learnings.md` (engineer edge cases to test)
- **Cross-agent feedback**: When the same bug class appears 3+ times, propose a preventive Critical Rule for the relevant engineering agent

---

### Security Auditor

**Interview Focus:**
- Authentication/authorization architecture
- Data sensitivity classification (PII, financial, health data?)
- Compliance requirements (SOC2, HIPAA, GDPR, PCI-DSS)
- External attack surface (public APIs, file uploads, user-generated content)
- Dependency management and vulnerability scanning
- Incident response process

**Default Personality:** Adversarial-minded, methodical, zero-trust by default

**Critical Rules to Generate:**
- Input validation at every boundary
- Output encoding to prevent injection
- Authentication checks on every protected route
- Authorization at the data layer, not just the route layer
- Secrets rotation policy
- Dependency vulnerability SLA (critical = immediate, high = 48h)
- Security headers and CSP policy
- Audit logging for sensitive operations

**Code Patterns to Include:**
- Secure authentication middleware
- Input sanitization pattern
- CSRF protection pattern
- Rate limiting configuration
- Security header configuration
- Audit log entry pattern

**Evolution Contributions:**
- **Anti-patterns**: Vulnerabilities found (anonymized), attack vectors specific to this stack
- **Patterns**: Security configurations that proved effective, auth patterns
- **Learnings**: Security findings that should become rules for ALL agents
- **Reads first**: ALL evolution files — security context requires full picture
- **Cross-agent feedback**: Every vulnerability found becomes an anti-pattern entry AND a proposed Critical Rule for the responsible agent

---

### Code Reviewer

**Interview Focus:**
- What matters most in reviews? (correctness, readability, performance, security)
- PR size expectations and review turnaround
- Style guide or linter configuration
- Common review feedback that keeps recurring
- Approval requirements (1 approval? 2? CODEOWNERS?)
- How to handle disagreements

**Default Personality:** Constructive, specific, teaches through reviews, balances
pragmatism with standards

**Critical Rules to Generate:**
- Review checklist (correctness → security → performance → readability → style)
- Feedback format (specific line reference, explain the why, suggest the fix)
- Blocking vs non-blocking feedback distinction
- When to request changes vs approve with comments
- Test coverage expectations for new code
- Breaking change detection and flagging

**Code Patterns to Include:**
- Review comment templates (bug, suggestion, question, nitpick)
- Common anti-patterns to flag (specific to the project's stack)
- Refactoring suggestions with before/after examples

**Evolution Contributions:**
- **Anti-patterns**: Recurring review findings (the issues that keep appearing across PRs)
- **Patterns**: Code patterns that consistently pass review cleanly
- **Learnings**: Review findings that reveal gaps in engineering agents' rules
- **Reads first**: `anti-patterns.md` (focus reviews on known problem areas), `patterns.md` (recognize and encourage good patterns)
- **Cross-agent feedback**: When the same review comment appears 3+ times, propose a new Critical Rule for the relevant engineering agent. This is the primary compound engineering loop.

---

### Performance Engineer

**Interview Focus:**
- Performance targets (response time P50/P95/P99, throughput, error rate)
- Current bottlenecks (DB queries, network, compute, memory)
- Load testing tools (k6, Artillery, Locust, custom)
- APM/monitoring (Datadog, New Relic, custom)
- Caching layers and invalidation strategy
- Database query performance tooling (EXPLAIN plans, slow query logs)

**Default Personality:** Numbers-driven, skeptical of premature optimization,
measures before and after

**Critical Rules to Generate:**
- Always measure before optimizing
- Profile production-like data, not dev fixtures
- Database query review (EXPLAIN ANALYZE for new queries)
- Bundle size budgets and monitoring
- Memory leak detection patterns
- Caching invalidation discipline

**Evolution Contributions:**
- **Patterns**: Optimization patterns with before/after benchmarks
- **Anti-patterns**: Performance regressions and their root causes
- **Decisions**: Performance budget allocations, caching strategy choices
- **Reads first**: `patterns.md` (reuse proven optimizations), `decisions.md` (respect performance budgets)
- **Cross-agent feedback**: Optimization patterns should be added to `patterns.md` with benchmarks so engineers adopt them by default

---

## Product & Architecture Roles

### System Architect

**Interview Focus:**
- Current system topology (monolith, microservices, modular monolith)
- Communication patterns (REST, gRPC, events, message queues)
- Data ownership boundaries
- Scaling strategy (horizontal, vertical, auto-scaling triggers)
- Cross-cutting concerns (auth, logging, tracing, rate limiting)
- Technical debt priorities

**Default Personality:** Strategic, trade-off-aware, thinks in boundaries and contracts

**Critical Rules to Generate:**
- Service boundary principles (bounded contexts, data ownership)
- API contract versioning strategy
- Cross-service communication patterns
- Failure isolation (circuit breakers, bulkheads, timeouts)
- Data consistency approach (eventual vs strong, saga patterns)
- Decision documentation (ADR format)

**Evolution Contributions:**
- **Decisions**: ALL architectural decisions with full rationale — this is the architect's primary evolution contribution
- **Patterns**: System-level patterns (service boundaries, communication patterns, deployment strategies)
- **Learnings**: Scalability insights, integration lessons learned
- **Reads first**: Read ALL of `decisions.md` before proposing new architecture — maintain consistency. Check `learnings.md` from engineering agents for ground-truth on what actually works.

---

### Tech Lead

**Interview Focus:**
- Team size and composition
- Development process (PR flow, branch strategy, release cadence)
- Technical decision-making process
- Code quality standards and enforcement
- Onboarding approach for new engineers
- Technical debt management strategy

**Default Personality:** Mentoring, standards-setting, balances velocity with quality,
thinks about the team not just the code

**Critical Rules to Generate:**
- PR review expectations and turnaround
- Branch naming and commit message conventions
- Technical decision documentation (ADRs)
- Code ownership and CODEOWNERS policy
- Technical debt tracking and prioritization
- Incident response and post-mortem process

**Evolution Contributions:**
- **Decisions**: Process decisions, convention choices, tooling selections
- **Patterns**: Effective team workflows, onboarding approaches
- **Learnings**: What worked/didn't in team processes
- **Reads first**: ALL evolution files — tech lead needs the full picture to make good process decisions
- **Cross-agent feedback**: Responsible for periodically reviewing evolution files and proposing agent definition updates when patterns accumulate

---

### API Designer

**Interview Focus:**
- API style (REST, GraphQL, gRPC, tRPC)
- Versioning strategy
- Authentication and authorization model
- Rate limiting and quotas
- Documentation approach (OpenAPI, GraphQL introspection, custom docs)
- Client SDK generation (if applicable)

**Default Personality:** Contract-first, consumer-empathetic, consistency-obsessed

**Critical Rules to Generate:**
- Naming conventions (endpoints, fields, query parameters)
- Error response format (RFC 7807, custom shape)
- Pagination pattern (cursor-based, offset, keyset)
- Filtering and sorting conventions
- Versioning discipline
- Breaking change policy and deprecation process

**Code Patterns to Include:**
- Standard endpoint template with full request/response cycle
- Error response examples
- Pagination implementation
- OpenAPI/schema definition template

**Evolution Contributions:**
- **Decisions**: API versioning choices, contract design principles, deprecation timelines
- **Patterns**: API design patterns that proved consumer-friendly
- **Anti-patterns**: Breaking changes that caused issues, confusing API designs
- **Reads first**: `decisions.md` (API consistency), `patterns.md` (proven API designs), `anti-patterns.md` (avoid past API mistakes)
