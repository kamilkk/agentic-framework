# Project Configuration — Example (Acme Commerce Platform)

> This is a SAMPLE configuration showing how to fill in `project.template.md`.
> Copy this pattern for your own project.

## Organization

- **org.name**: Acme Corp
- **org.url**: https://acme-corp.example.com

## Project

- **project.name**: Acme Commerce Platform
- **project.description**: E-commerce microservices platform serving B2B and B2C customers across 12 markets
- **project.type**: microservices

## Technology Stack

- **stack.backend**: .NET 8, ASP.NET Core
- **stack.frontend**: Angular 19, NX Workspace
- **stack.database**: SQL Server, Redis Cache
- **stack.cloud**: Azure (App Service, Functions, Service Bus)
- **stack.auth**: OAuth 2.0 / OIDC via Azure AD B2C

## Architecture

- **arch.pattern**: Clean Architecture with CQRS (MediatR)
- **arch.messaging**: Azure Service Bus + MassTransit
- **arch.containerization**: Docker + Azure Kubernetes Service

## Repositories

| Name | Path | Description |
|------|------|-------------|
| CartAPI | CartAPI/ | Shopping cart management service |
| OrderAPI | OrderAPI/ | Order processing and fulfillment |
| ProductsAPI | ProductsAPI/ | Product catalog and inventory |
| PricingAPI | PricingAPI/ | Dynamic pricing and discounts |
| UsersAPI | UsersAPI/ | User management and permissions |
| CustomerAPI | CustomerAPI/ | Customer profiles and preferences |
| Frontend | Frontend/ | Angular SPA with SSR |
| Shared | Shared/ | Configuration manager, shared utilities |
| Infrastructure | Infrastructure/ | Terraform IaC, CI/CD |
| MessageContracts | MessageContracts/ | Shared message contracts for async |

## Work Item System

- **workitems.tool**: Azure DevOps
- **workitems.project**: AcmeCommerce
- **workitems.url_pattern**: https://dev.azure.com/acme/AcmeCommerce/_workitems/edit/{id}

## Conventions

### Naming

- **naming.branch_pattern**: feature/{id}-{slug}, bugfix/{id}-{slug}
- **naming.primary_branch**: main
- **naming.commit_format**: conventional commits — {type}({scope}): {message}

### Code

- **code.test_pattern**: *.spec.ts (frontend), *Tests.cs (backend)
- **code.docs_location**: .github/docs/

## Teams / Squads

| Name | Repositories | Focus Area |
|------|-------------|-----------|
| Checkout | CartAPI, OrderAPI, PricingAPI | Purchase flow |
| Catalog | ProductsAPI, Frontend | Product discovery |
| Platform | UsersAPI, CustomerAPI, Shared | Identity & shared services |
| DevOps | Infrastructure | CI/CD & cloud |

## Custom Fields (Optional)

| Field Name | Purpose |
|-----------|---------|
| Custom.AccessibilityRequirements | WCAG 2.2 AA requirements per story |
| Custom.NonFunctionalRequirements | Performance, scalability criteria |
| Custom.ReleaseNotes | User-facing change description |
