# Security Guardrails (Always Active)

> MANDATORY for all AI operations. Cannot be bypassed without explicit user confirmation.

## Core Principle

If environment is unknown, **ASSUME PRODUCTION**. Never execute destructive operations without confirmation.

## Severity Levels

| Level | Action | Example |
|-------|--------|---------|
| FORBIDDEN | Never execute, no override | Drop database, expose secrets |
| BLOCKED | Requires explicit user confirmation | Delete files, modify audit trails |
| CAUTION | Proceed with warning | Write to shared resources, modify configs |

## Rules

### Data Protection
- **PII Masking**: Never log, display, or include PII (emails, passwords, tokens, keys) in outputs
- **No Secrets in Code**: Never hardcode credentials, API keys, connection strings, or tokens
- **Environment Variables**: Always reference secrets via environment variables or secret managers
- **Audit Integrity**: Never modify audit fields (CreatedBy, CreatedAt, ModifiedBy, ModifiedAt)

### Destructive Operations
- **No hard DELETE** without explicit user confirmation
- **No DROP TABLE/DATABASE** under any circumstances without multi-step confirmation
- **No force push** (`git push --force`) without explicit request and confirmation
- **No rm -rf** on directories without listing contents first

### Access Control
- **Principle of Least Privilege**: Request minimum permissions needed
- **No Privilege Escalation**: Never suggest bypassing authentication/authorization
- **No Security Bypass**: Never disable SSL verification, CORS, CSRF, or other security controls
- **Input Validation**: Always validate at system boundaries (API endpoints, form inputs)

### Code Security (OWASP Top 10)
- **Injection Prevention**: Use parameterized queries, never string concatenation for SQL/commands
- **Authentication**: Never store passwords in plain text, use proper hashing (bcrypt, Argon2)
- **Sensitive Data Exposure**: Never log request/response bodies containing PII
- **XXE**: Disable external entity processing in XML parsers
- **Access Control**: Enforce server-side, never rely solely on client-side checks
- **Security Misconfiguration**: Never expose stack traces, debug info, or internal paths in production
- **XSS**: Always encode/escape output, use framework's built-in protection
- **Deserialization**: Never deserialize untrusted data without validation
- **Dependencies**: Flag known vulnerable packages, suggest upgrades
- **Logging**: Log security events, never log sensitive data

### Compliance Awareness
- **GDPR**: Right to deletion, data minimization, consent tracking
- **Data Residency**: Respect geographic data storage requirements
- **Retention Policies**: Follow defined data retention periods

## Environment Detection

```
IF environment == "production" OR environment == UNKNOWN:
  → Apply ALL guardrails at MAXIMUM severity
  → Require explicit confirmation for ANY write operation
  → Never expose internal paths, connection strings, or debug info

IF environment == "development":
  → Apply guardrails at CAUTION level
  → Allow write operations with standard checks
  → Still never expose real credentials
```
