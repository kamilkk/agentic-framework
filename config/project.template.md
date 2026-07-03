# Project Configuration Template

> Fill in these values to customize the agentic framework for your project.
> This file is NEVER overwritten by the installer on subsequent runs.

## Organization

- **org.name**: {Your Organization Name}
- **org.url**: {Organization URL}

## Project

- **project.name**: {Project Name}
- **project.description**: {Brief project description}
- **project.type**: {microservices | monolith | monorepo | library}

## Technology Stack

- **stack.backend**: {e.g., .NET 8, Node.js 20, Go 1.22, Python 3.12}
- **stack.frontend**: {e.g., Angular 19, React 19, Vue 3, Next.js 15}
- **stack.database**: {e.g., PostgreSQL 16, SQL Server, MongoDB 7}
- **stack.cloud**: {e.g., Azure, AWS, GCP}
- **stack.auth**: {e.g., OAuth2, OIDC, API keys}

## Architecture

- **arch.pattern**: {e.g., Clean Architecture, Hexagonal, Layered, CQRS}
- **arch.messaging**: {e.g., RabbitMQ, Kafka, Azure Service Bus, None}
- **arch.containerization**: {e.g., Docker, Kubernetes, None}

## Repositories

List your repositories/services (used by agents for navigation):

| Name | Path | Description |
|------|------|-------------|
| {ServiceA} | {relative/path} | {brief description} |
| {ServiceB} | {relative/path} | {brief description} |

## Work Item System

- **workitems.tool**: {e.g., Azure DevOps, Jira, GitHub Issues, Linear}
- **workitems.project**: {project identifier in the tool}
- **workitems.url_pattern**: {URL template, e.g., https://dev.azure.com/{org}/{project}/_workitems/edit/{id}}

## Conventions

### Naming

- **naming.branch_pattern**: {e.g., feature/{id}-{slug}, fix/{id}-{slug}}
- **naming.primary_branch**: {e.g., main, master, develop}
- **naming.commit_format**: {e.g., conventional commits, {type}({scope}): {message}}

### Code

- **code.test_pattern**: {e.g., *.spec.ts, *Tests.cs, test_*.py}
- **code.docs_location**: {e.g., docs/, .github/docs/, wiki/}

## Teams / Squads

| Name | Repositories | Focus Area |
|------|-------------|-----------|
| {Team A} | {repo1, repo2} | {domain} |

## Custom Fields (Optional)

Define any project-specific metadata fields used in work items:

| Field Name | Purpose |
|-----------|---------|
| {field} | {what it's for} |
