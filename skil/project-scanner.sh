#!/usr/bin/env bash
# project-scanner.sh — Scans a project directory and outputs a JSON summary
# of detected technologies, frameworks, and patterns.
#
# Usage: ./project-scanner.sh [project-root]
# Defaults to current directory if no argument provided.
#
# Output: JSON object with detected stack information

set -euo pipefail

PROJECT_ROOT="${1:-.}"
cd "$PROJECT_ROOT"

echo "{"

# --- Language Detection ---
echo '  "languages": ['
LANGS=()
[[ -f "package.json" ]] && LANGS+=("TypeScript/JavaScript")
[[ -f "pyproject.toml" || -f "requirements.txt" || -f "setup.py" ]] && LANGS+=("Python")
[[ -f "go.mod" ]] && LANGS+=("Go")
[[ -f "Cargo.toml" ]] && LANGS+=("Rust")
[[ -f "pom.xml" || -f "build.gradle" ]] && LANGS+=("Java/Kotlin")
[[ -f "Gemfile" ]] && LANGS+=("Ruby")
[[ -f "mix.exs" ]] && LANGS+=("Elixir")

for i in "${!LANGS[@]}"; do
    if [[ $i -eq $((${#LANGS[@]} - 1)) ]]; then
        echo "    \"${LANGS[$i]}\""
    else
        echo "    \"${LANGS[$i]}\","
    fi
done
echo '  ],'

# --- Framework Detection ---
echo '  "frameworks": ['
FRAMEWORKS=()
if [[ -f "package.json" ]]; then
    PKG=$(cat package.json 2>/dev/null || echo "{}")
    echo "$PKG" | grep -q '"next"' && FRAMEWORKS+=("Next.js")
    echo "$PKG" | grep -q '"react"' && FRAMEWORKS+=("React")
    echo "$PKG" | grep -q '"vue"' && FRAMEWORKS+=("Vue")
    echo "$PKG" | grep -q '"nuxt"' && FRAMEWORKS+=("Nuxt")
    echo "$PKG" | grep -q '"angular"' && FRAMEWORKS+=("Angular")
    echo "$PKG" | grep -q '"svelte"' && FRAMEWORKS+=("Svelte")
    echo "$PKG" | grep -q '"express"' && FRAMEWORKS+=("Express")
    echo "$PKG" | grep -q '"hono"' && FRAMEWORKS+=("Hono")
    echo "$PKG" | grep -q '"fastify"' && FRAMEWORKS+=("Fastify")
    echo "$PKG" | grep -q '"@nestjs"' && FRAMEWORKS+=("NestJS")
    echo "$PKG" | grep -q '"astro"' && FRAMEWORKS+=("Astro")
    echo "$PKG" | grep -q '"remix"' && FRAMEWORKS+=("Remix")
fi
if [[ -f "pyproject.toml" ]]; then
    PYPROJ=$(cat pyproject.toml 2>/dev/null || echo "")
    echo "$PYPROJ" | grep -qi "fastapi" && FRAMEWORKS+=("FastAPI")
    echo "$PYPROJ" | grep -qi "django" && FRAMEWORKS+=("Django")
    echo "$PYPROJ" | grep -qi "flask" && FRAMEWORKS+=("Flask")
    echo "$PYPROJ" | grep -qi "pytorch\|torch" && FRAMEWORKS+=("PyTorch")
    echo "$PYPROJ" | grep -qi "tensorflow" && FRAMEWORKS+=("TensorFlow")
fi

for i in "${!FRAMEWORKS[@]}"; do
    if [[ $i -eq $((${#FRAMEWORKS[@]} - 1)) ]]; then
        echo "    \"${FRAMEWORKS[$i]}\""
    else
        echo "    \"${FRAMEWORKS[$i]}\","
    fi
done
echo '  ],'

# --- ORM / Database ---
echo '  "database": ['
DBS=()
[[ -d "prisma" ]] && DBS+=("Prisma")
[[ -d "drizzle" || -f "drizzle.config.ts" || -f "drizzle.config.js" ]] && DBS+=("Drizzle")
[[ -d "alembic" ]] && DBS+=("SQLAlchemy/Alembic")
[[ -d "migrations" && -f "knexfile.js" ]] && DBS+=("Knex")
grep -rq "DATABASE_URL" .env* 2>/dev/null && {
    DB_URL=$(grep "DATABASE_URL" .env* 2>/dev/null | head -1 || echo "")
    echo "$DB_URL" | grep -qi "postgres" && DBS+=("PostgreSQL")
    echo "$DB_URL" | grep -qi "mysql" && DBS+=("MySQL")
    echo "$DB_URL" | grep -qi "sqlite" && DBS+=("SQLite")
    echo "$DB_URL" | grep -qi "mongodb" && DBS+=("MongoDB")
}
if [[ -f "package.json" ]]; then
    PKG=$(cat package.json 2>/dev/null || echo "{}")
    echo "$PKG" | grep -q '"mongoose"' && DBS+=("MongoDB/Mongoose")
    echo "$PKG" | grep -q '"typeorm"' && DBS+=("TypeORM")
    echo "$PKG" | grep -q '"@supabase"' && DBS+=("Supabase")
fi

for i in "${!DBS[@]}"; do
    if [[ $i -eq $((${#DBS[@]} - 1)) ]]; then
        echo "    \"${DBS[$i]}\""
    else
        echo "    \"${DBS[$i]}\","
    fi
done
echo '  ],'

# --- Infrastructure ---
echo '  "infrastructure": ['
INFRA=()
[[ -f "Dockerfile" || -f "docker-compose.yml" || -f "docker-compose.yaml" ]] && INFRA+=("Docker")
[[ -f "cdk.json" ]] && INFRA+=("AWS CDK")
[[ -d "terraform" || -f "main.tf" ]] && INFRA+=("Terraform")
[[ -f "pulumi.yaml" || -f "Pulumi.yaml" ]] && INFRA+=("Pulumi")
[[ -f "serverless.yml" || -f "serverless.yaml" ]] && INFRA+=("Serverless Framework")
[[ -f "vercel.json" || -f ".vercel" ]] && INFRA+=("Vercel")
[[ -f "netlify.toml" ]] && INFRA+=("Netlify")
[[ -f "fly.toml" ]] && INFRA+=("Fly.io")
[[ -f "railway.json" || -f "railway.toml" ]] && INFRA+=("Railway")
[[ -f "wrangler.toml" ]] && INFRA+=("Cloudflare Workers")

for i in "${!INFRA[@]}"; do
    if [[ $i -eq $((${#INFRA[@]} - 1)) ]]; then
        echo "    \"${INFRA[$i]}\""
    else
        echo "    \"${INFRA[$i]}\","
    fi
done
echo '  ],'

# --- CI/CD ---
echo '  "ci_cd": ['
CI=()
[[ -d ".github/workflows" ]] && CI+=("GitHub Actions")
[[ -f ".gitlab-ci.yml" ]] && CI+=("GitLab CI")
[[ -d ".circleci" ]] && CI+=("CircleCI")
[[ -f "Jenkinsfile" ]] && CI+=("Jenkins")
[[ -f "bitbucket-pipelines.yml" ]] && CI+=("Bitbucket Pipelines")

for i in "${!CI[@]}"; do
    if [[ $i -eq $((${#CI[@]} - 1)) ]]; then
        echo "    \"${CI[$i]}\""
    else
        echo "    \"${CI[$i]}\","
    fi
done
echo '  ],'

# --- Testing ---
echo '  "testing": ['
TESTS=()
if [[ -f "package.json" ]]; then
    PKG=$(cat package.json 2>/dev/null || echo "{}")
    echo "$PKG" | grep -q '"vitest"' && TESTS+=("Vitest")
    echo "$PKG" | grep -q '"jest"' && TESTS+=("Jest")
    echo "$PKG" | grep -q '"playwright"' && TESTS+=("Playwright")
    echo "$PKG" | grep -q '"cypress"' && TESTS+=("Cypress")
    echo "$PKG" | grep -q '"@testing-library"' && TESTS+=("Testing Library")
fi
if [[ -f "pyproject.toml" || -f "pytest.ini" || -f "setup.cfg" ]]; then
    (cat pyproject.toml setup.cfg pytest.ini 2>/dev/null || echo "") | grep -qi "pytest" && TESTS+=("Pytest")
fi

for i in "${!TESTS[@]}"; do
    if [[ $i -eq $((${#TESTS[@]} - 1)) ]]; then
        echo "    \"${TESTS[$i]}\""
    else
        echo "    \"${TESTS[$i]}\","
    fi
done
echo '  ],'

# --- Existing Conventions ---
echo '  "conventions": ['
CONVS=()
[[ -f "CLAUDE.md" ]] && CONVS+=("CLAUDE.md")
[[ -f ".cursorrules" ]] && CONVS+=(".cursorrules")
[[ -f ".windsurfrules" ]] && CONVS+=(".windsurfrules")
[[ -f ".editorconfig" ]] && CONVS+=(".editorconfig")
[[ -f ".prettierrc" || -f ".prettierrc.json" || -f ".prettierrc.js" ]] && CONVS+=("Prettier")
[[ -f ".eslintrc" || -f ".eslintrc.json" || -f ".eslintrc.js" || -f "eslint.config.js" || -f "eslint.config.mjs" ]] && CONVS+=("ESLint")
[[ -d ".claude/agents" ]] && CONVS+=("Existing Claude agents")

for i in "${!CONVS[@]}"; do
    if [[ $i -eq $((${#CONVS[@]} - 1)) ]]; then
        echo "    \"${CONVS[$i]}\""
    else
        echo "    \"${CONVS[$i]}\","
    fi
done
echo '  ],'

# --- Existing Agents ---
echo '  "existing_agents": ['
if [[ -d ".claude/agents" ]]; then
    AGENTS=($(ls .claude/agents/*.md 2>/dev/null || echo ""))
    for i in "${!AGENTS[@]}"; do
        if [[ $i -eq $((${#AGENTS[@]} - 1)) ]]; then
            echo "    \"${AGENTS[$i]}\""
        else
            echo "    \"${AGENTS[$i]}\","
        fi
    done
fi
echo '  ]'

echo "}"
