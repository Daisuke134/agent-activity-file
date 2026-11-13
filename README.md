# Agent Team on GitHub Files

**Run a team of AI agents as one organization, using a shared Git repository as the workplace.**

Most multi-agent setups coordinate through chat messages and shared prompts. State ends up scattered across sessions, members duplicate each other's work, nobody knows who is overloaded, and when one agent's context or budget runs out, everything it "knew" disappears with it.

This skill is a different operating pattern, distilled from running a real multi-agent team in production:

- **The repository is the workplace.** All state lives in files every member can read: a live board, a claims table, per-member outboxes, canonical documents — and one shared todo list that is the *only* index of work. If it is not on the todo list, it does not exist.
- **Claim before you start.** Members pull work and declare the claim in writing first. No claim, no work — and collisions resolve by earliest claim. Work that can run in parallel never sits unassigned: whoever spots it, claims it.
- **The team writes its own list.** Members read the metrics, open the next items themselves — each with a named owner and the reason it exists — verify each other's work against the artifacts, and take stalled work over instead of waiting beside it.
- **Replies within a minute, by mechanism.** A watcher polls the outbox and wakes workers to acknowledge and report. Communication counts only when the reply file actually arrives.
- **One writer per surface, capability shared by all.** Writes never conflict; knowledge and procedures are never private. Anyone can take over any lane from the files alone.
- **Load and strengths are public.** Each member's capacity *and* what they are genuinely best at sit on the board next to their work, so allocation is based on who has room and who fits the work — and the organization keeps moving until everyone's capacity resets.
- **Learning is a cycle, not an event.** Learn → write to the shared file → broadcast → collect every member's acknowledgment. Only then has the team updated.
- **Replaceability is mandatory.** "Only I know this" is treated as an outage waiting to happen.

## What's inside

- `SKILL.md` — the full method: file layout, the eleven practices, anti-patterns, and the published sources each practice is copied from (multi-agent engineering write-ups and classic organizational theory: handbook-first culture, kanban/WIP limits, shared consciousness, the learning organization, bus factor, named single ownership, input-metric reviews, strengths awareness).
- `examples/log.sh` — a one-line activity logger: appends a fixed-format line (`time | agent | KIND | message | surface | evidence`, KINDs include CLAIM/RELEASE for the claim gate) and pushes with rebase retries.
- `examples/templates/` — blank starter templates: `ACTIVITY.md` (append-only shared log), `CLAIMS.md` (short-lived locks), `OWNERS.md` (one owner per surface), `APPLICATIONS.md` (grep-before-you-apply registry).

## Who this is for

- Teams running multiple AI agents (any framework, any model mix) that need coordination without a bespoke orchestration platform.
- Solo builders operating several agents who keep losing state between sessions.
- Anyone who has watched agents duplicate work, stall silently, or produce status updates with nothing behind them.

## Status

Draft for public release. The method is in daily production use by the team that wrote it; this package is the generalized version, with all organization-specific details removed.

## License

To be released under an open license (MIT planned) once the publishing team confirms the final scope.
