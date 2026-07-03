# Verification Protocol — Pre-Flight, Final Synthesis, Final Verification

> On-demand reference file. Read before sending Tier 1+ responses.

## Pre-Flight Checklist (Tier 1+)

Answer ALL before sending. If ANY = "NO" → STOP, fix, then send.

| # | Check | Tier |
|---|-------|------|
| 1 | Tier classified using decision tree? | All |
| 2 | Documentation searched (variation-aware)? | 1+ |
| 3 | Response STARTS with checkpoint template? | 1+ |
| 4 | Terminology consistent with workspace docs? | 1+ |
| 5 | Patterns from project documentation used? | 1+ |
| 6 | User mode override checked (@quick/@dev/@teach)? | All |
| 7 | Design Considerations section included? | 2+ |
| 8 | ADR section included? | 3 |
| 9 | Can cite file:line for all assumptions? | 1+ |
| 10 | Confidence level declared? | 1+ |
| 11 | Adversarial self-check completed? | 2+ |
| 12 | Assumption registry completed? | 2+ |
| 13 | Three-path convergence completed? | 3 |

## Final Synthesis (Before Sending)

### Cognitive Forcing Questions (All Tiers 1+)

| # | Question | Purpose |
|---|----------|---------|
| 1 | "Is there a simpler way?" | YAGNI enforcement |
| 2 | "Does this solve what user ACTUALLY asked?" | Intent verification |
| 3 | "What are 3 ways this could fail?" | Risk identification |

If ANY answer uncertain → STOP. Re-analyze.

### Alternative Generation

- **Tier 1**: Mental only (1-2 alternatives)
- **Tier 2**: 3+ structured alternatives in Design Considerations
- **Tier 3**: 5+ structured alternatives in ADR

### Decision Criteria Weights

| Criterion | Weight |
|-----------|--------|
| Correctness | 40% |
| Simplicity | 25% |
| Consistency | 20% |
| Robustness | 15% |

## Final Verification (MANDATORY — Tier 1+)

```
1. STOP → Review solution for inconsistencies → Fix
2. STOP → Generate improvement hypotheses (3-5 Tier 1, 5-7 Tier 2, 7+ Tier 3)
3. STOP → Critique each hypothesis (Keep/Reject + Reason)
4. STOP → Synthesize optimal solution
5. STOP → Self-verification checklist
6. ONLY THEN → Send response
```

### Self-Verification Checklist

- [ ] All requirements addressed
- [ ] Terminology correct (workspace docs)
- [ ] Patterns followed (project documentation)
- [ ] YAGNI compliant (no extras)
- [ ] Code complete (no TODOs)
- [ ] Solution is NOT the first thing that came to mind
- [ ] At least ONE alternative genuinely considered
- [ ] No "gold plating"
