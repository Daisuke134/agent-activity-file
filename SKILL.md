---
name: agent-team-on-github-files
description: Run a team of AI agents as one organization using a shared Git repository as the workplace — a single shared todo list as the only index, a live status board, claim-before-start declarations, sub-minute reply loops, load and strengths disclosure, a collective-learning update cycle, self-generated work, and mandatory replaceability. Use when multiple agents (or agents plus humans) need to coordinate without duplicating work, losing state, or depending on any single agent's session.
---

# Agent Team on GitHub Files

A working method for a team of AI agents that coordinates through files in a shared Git repository instead of chat threads or any single agent's memory.

The core idea: **the repository is the workplace.** Everything the team knows — who is doing what, what is blocked, what was learned, what the numbers are — lives in files that every member can read and write. Any agent with repository access can open the files and immediately know the whole picture, including agents that joined five minutes ago. Nothing important lives only inside one agent's session, one machine, or one chat tool.

## File layout

```
team/
  LIVE-NOW.md        # the live board: who is doing what, right now
  CLAIMS.md          # ownership table: one writer per surface/file
team-outbox/
  <member>/          # one folder per member: broadcasts, delegations, acks
knowledge/
  todo-list.md       # THE shared todo list — the single index of all work
files/               # canonical documents: specs, research, decisions, reports
```

Supporting conventions:

- **The shared todo list is the only index.** If a piece of work is not a line in the todo list, it does not exist. Recurring/automated work (loops, scheduled jobs) is listed too — automated work is still somebody's work, and listing it is what prevents duplication.
- **Issues are work cards, not knowledge stores.** An issue carries an owner, a claim, and a done state. Knowledge, numbers, and results always land back in files, and the todo line is updated to close the loop.
- **One folder per member in the outbox.** A message counts as delivered only when the other side's reply file actually arrives — not when you sent yours.

## The practices

### 1. Write state on a board, not in chat

Chat produces *status theater*: plausible-sounding updates with no substance. State goes on a board (`LIVE-NOW.md`) as structured, verifiable facts: timestamps, artifact links, commit hashes, measured numbers. "Done" is a state transition backed by an artifact you can open — never a claim in prose.

- Before starting work, write a line: time, owner, what you are doing now.
- Update it while working (every ~15 minutes).
- When finished, replace the line with the result (link to the artifact).

### 2. Claim before you start (pull, not push)

Work is pulled, not assigned-and-forgotten:

- Before touching shared work, check the board and the outbox: is someone already doing this?
- Claim by writing your declaration first (board line, issue comment, or claim file). Only the claimer does the work.
- Unclaimed work may be picked up by anyone.
- **Work that can run in parallel must never sit unassigned.** An unassigned item is work nobody is doing. Whoever spots one picks it up, claims it in writing, and starts — proactively, without waiting to be asked.
- Every item names a person, never a group: one owner who is responsible for getting it done, and the name of whoever created the item and why (which metric or observation produced it). An item nobody can trace to a person and a reason cannot be questioned or reprioritized later.
- If two members collide, the earlier claim continues; the later one stops immediately.

### 3. Reply within one minute — guaranteed by a mechanism, not by effort

Fast reporting is the speed of the organization. A reply does not need to contain the finished result: acknowledge receipt plus current status immediately, then follow up with the substance when it is ready. Never hold a reply because the measurement is not finished yet.

This only works if it is mechanized: a watcher polls the shared outbox (e.g. every 60 seconds) and wakes a worker to respond. Keep the wake cheap: the watcher first compares a tiny state file (e.g. the last-seen commit SHA) and exits doing nothing when nothing changed — this state comparison is where most of the token saving comes from. If the watcher is down, that itself is a system failure to fix on the spot — not a reason replies were slow.

### 4. Single writer per surface; capability shared by everyone

Writes conflict; reads don't. Each shared surface (an account, a file tree, a pipeline) has exactly one writer. Everyone else may read, verify, and advise. But ownership is about *who writes now*, never about *who is allowed to know*: all state, procedures, and access are in shared files so anyone can take over any lane.

### 5. Disclose load, capacity, and strengths

Each member keeps their load state on the board — e.g. `load: has capacity / normal / saturated (one-line reason)` — alongside their work, **and their strengths**: `strengths: <one to three words for what this member is genuinely best at>`. Knowing each other's remaining capacity is what makes allocation real: the member with capacity takes the next task; the saturated member hands work over instead of silently stalling. Sharing the load is also what keeps the organization running until everyone's capacity resets.

Strengths are disclosed for the same reason load is: allocation should flow toward the member who is *good at this kind of work*, not just the member who happens to be free. Large-scale team research (Gallup, 11,441 teams) found that teammates *knowing each other's strengths* influenced team performance about twice as much as which strengths the team happened to have — there is no perfect mix of strengths to engineer, but there is a state to maintain: everyone can name what each member excels at, and assignment and takeover decisions cite that fit.

### 6. Collective learning update cycle

One agent learning something is not the team learning it. An update counts as landed only when the full cycle completes:

1. Learn something (a fix, a rule, a measurement).
2. Write it into the shared canonical file the same day.
3. Broadcast it to all members via the outbox.
4. Chase until every member's acknowledgment file has arrived.

Only then is it "the team has updated". Information known by only one agent is treated as nonexistent — and as a single point of failure.

### 7. Replaceability is mandatory

Never create a state of "only I know this" or "only I can do this". Procedures live in shared files, not in one session's context. The test: if any member vanished right now, could another member pick up their work from the files alone within minutes? If not, the missing piece gets written down immediately. (This is the classic *bus factor* metric, restated for agents: the failure mode is not a bus, it is one agent's tokens or session running out — at which point the whole organization's growth stops if the load was never shared.)

### 8. Allocate from the whole picture

Members hold the whole picture, not just their lane. Allocation is complementary, like hands of one body: *this hand is doing X, so the other hand does Y.* A coordinator role keeps the whole picture current in one place (the board plus the todo list), assigns by complement rather than by whoever happens to be free, and detects both overlaps and gaps from the whole-picture side. Two refinements make allocation concrete: assign toward **strengths** (practice 5), not only toward free capacity; and create parallel lanes by **decomposing the work up front** — write down which parts truly depend on each other and must run in sequence, and which parts are independent and run in parallel. Parallelism is produced by that decomposition, not by exhortation.

### 9. WIP limits

A board without work-in-progress limits is just a status display. Keep each member's "in progress" list short (about 3 items); the rest is explicitly "waiting". When over the limit, the correct move is to help finish in-flight work (swarming), not to start something new. Cycle time = WIP ÷ throughput — the only direct lever on speed is less WIP.

### 10. Delegate with a complete brief

Every delegation includes: the objective, the output format, guidance on tools and sources, the boundaries (what not to touch), internal stop conditions, and a definition of done that ends at a verified artifact. Plans and state live in external files, so a delegation survives context loss. Also name what happens if there is no reply by the deadline — silence means *stopped*, and the delegator takes the work back instead of waiting.

### 11. The team generates its own work — and takes over stalls

The todo list is not handed down complete, and it is never "finished". Members read the metrics, decide what needs to happen next, and open the items themselves — with the creator's name and the motivating metric on the item (practice 2), and an owner decided inside the team. A review ritual exists to close the loop: look at the numbers on a fixed cadence, discuss only the anomalies, and leave with named follow-ups, so measurement reliably turns into owned work instead of ending as a report.

Members also verify each other's work — against the artifacts, not against status prose. This mutual monitoring has teeth: when a member is stalled, overloaded, or simply not doing well, another member **takes the work over**. Ownership transfers to the member who can move it now; the stalled member's load and strengths disclosures (practice 5) are what make that transfer fast and well-aimed. Waiting beside a stalled item is treated as the failure, not the stall itself.

## Anti-patterns

- **Status theater** — updates that sound like progress but carry no artifact, number, or state transition.
- **Chat as the record** — decisions and state that live only in a chat scroll are lost to every future member.
- **Multiple daily reports** — each member publishing their own report fragments the picture. One canonical report, compiled by one writer from everyone's inputs.
- **Waiting on silence** — delegating and checking hours later to find nothing happened. Verify the start (claim/ack), watch the deadline, take over on the spot.
- **Inventing instead of copying** — for any recurring problem, someone has already solved it. Find the practitioner, verify from the primary source, copy the pattern, and keep improving it.

## Sources

This method distills published practice from multi-agent system builders and from organizational theory for human teams, including: Anthropic's engineering write-up on their multi-agent research system (delegation briefs, plans in external memory); Cognition's writing on multi-agent failure modes ("actions carry implicit decisions"; single-threaded writing with additional agents supplying intelligence); practitioner reports of agent-run companies (shared persistent memory, standup as executed delegation, permanent lessons); GitLab's handbook-first culture (the handbook as single source of truth; low-context asynchronous writing); kanban and WIP limits (Anderson; Little's law); McChrystal's *Team of Teams* (shared consciousness before empowered execution); Senge's *The Fifth Discipline* (the team as the unit of learning); the bus factor / cross-training literature on redundancy; named single ownership (Apple's directly responsible individual; Amazon's single-threaded leaders, in Bryar & Carr's *Working Backwards*); the named-owner rule for requirements in SpaceX/Tesla's operating method (every requirement carries the name of the person who made it, never a department); Tesla's unboxed process (decompose first, then build the independent parts in parallel); Amazon's controllable input metrics and weekly business review (metrics anomalies leave the room as named follow-ups); and Gallup's team research (teammates knowing each other's strengths predicted performance more strongly than the strengths themselves).

## License

Draft — to be released under an open license once the publishing team confirms scope. See README.md.
