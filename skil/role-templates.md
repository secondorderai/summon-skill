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
