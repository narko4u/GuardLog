# GuardLog

**EU AI Act Compliance Audit Trail — One Call Per AI Action**

[![Buy on Gumroad](https://img.shields.io/badge/Buy-%2429%2Fmo-red)](https://empirelabs1.gumroad.com/l/guardlog)
[![by Empire Labs](https://img.shields.io/badge/by-Empire%20Labs-purple)](https://empirelabs.com.au)

**⏰ The EU AI Act deadline is August 2, 2026. Non-compliance: €35M or 7% of global turnover.**

---

## The Problem

Every AI action your system takes — every model call, every response generated, every agent decision — is an event that EU regulators can demand records for.

Most teams don't have this infrastructure. They log application errors. They log HTTP requests. But they don't log:

- Which AI model was called and why
- What prompt was sent and what response came back
- Which user or agent triggered the action
- Whether the log has been tampered with after the fact
- A verifiable, time-stamped chain that a regulator can inspect

Without this, your AI product cannot demonstrate compliance with the EU AI Act. Spreadsheet logs don't count. Regulators require **automated, tamper-evident logging** — and the deadline is five months away.

---

## The Solution

GuardLog is a lightweight API that gives you a complete, verifiable audit trail for every AI action in your system — in five minutes.

```
User/System ── POST /log ──▶ GuardLog ──▶ SHA-256 Chain ──▶ Compliance Export
```

Every time your AI does something, you send one POST request. GuardLog:
1. Records the action with full metadata (agent, model, prompt, timestamp)
2. Links it into a **cryptographic hash chain** (SHA-256 Merkle tree)
3. Makes it available for compliance export, chain verification, or health checks

**What makes it tamper-proof:** Each log entry contains the hash of the previous entry. If someone edits or deletes a record after it's written, the chain breaks — and GuardLog's `/verify` endpoint catches it instantly.

---

## What This Means For Developers

| Before GuardLog | After GuardLog |
|---|---|
| Manually logging AI calls to a text file | One POST endpoint, done |
| Can't prove logs weren't tampered with | SHA-256 chain auto-verifies integrity |
| Panic when compliance asks for audit trail | Export a regulator-ready report in one call |
| Custom logging code for every project | Same API for any framework, any language |
| No visibility into AI action history | Full chain per agent, session, or timeframe |

---

## How It Works

GuardLog exposes six REST endpoints:

| Endpoint | What It Does | Use Case |
|---|---|---|
| `POST /log` | Record an AI action | Every time your app calls an LLM |
| `GET /chain` | Get full audit trail for an agent | Review all actions by a specific agent |
| `GET /verify` | Check chain integrity | Automated compliance checks |
| `GET /export` | Download compliance report (JSONL) | Hand to regulators or auditors |
| `GET /compliance` | Compliance status summary | Dashboard / health check |
| `GET /health` | Server health check | Monitoring |

**Example — logging an AI action:**
```bash
curl -X POST http://localhost:8901/log \
  -H "Authorization: Bearer your-key" \
  -H "Content-Type: application/json" \
  -d '{
    "agent_id": "customer-support",
    "session_id": "uuid-123",
    "action": "chat_completion",
    "payload": {
      "model": "gpt-4",
      "tokens": 342,
      "duration_ms": 1800
    }
  }'
```

**Response** (every log is automatically chained):
```json
{
  "status": "recorded",
  "block_index": 1427,
  "hash": "a1b2c3d4e5f6...",
  "previous_hash": "f6e5d4c3b2a1..."
}
```

---

## Why A Hash Chain?

Standard logging lets anyone with database access edit or delete records — and you'd never know.

A Merkle hash chain prevents this:
- **Edit protection** — changing any record changes its hash, breaking the link to the next record
- **Delete protection** — removing a record severs the chain for every subsequent block
- **Insert protection** — inserting a fake record between two real ones would require a hash that matches both neighbours

GuardLog's `/verify` endpoint checks the entire chain in milliseconds and tells you instantly: red = tampered, green = clean.

---

## Self-Hosted vs Managed

| | You run it | We run it |
|---|---|---|
| Setup | `pip install` + `guardlog` | Nothing — just use the endpoint |
| Update frequency | You manage | We manage |
| Compliance guarantees | You audit | We guarantee |
| EU hosting | Your infrastructure | Available on request |
| Cost | Gumroad purchase | Gumroad subscription |
| Best for | Internal tools, dev environments | Production, compliance audits |

**Self-hosted:** The server is a single Python file. No framework, no dependencies beyond stdlib. Runs on any Linux box, Docker container, or even a Raspberry Pi.

**Managed (SaaS):** Subscribe for $29/mo at empirelabs1.gumroad.com/l/guardlog. We handle uptime, scaling, and compliance.

---

## Who Needs This

- **AI startups** deploying LLM-based products in the EU or serving EU users
- **SaaS companies** adding AI features to existing products
- **Enterprise teams** building internal AI tools that need compliance sign-off
- **Agent platforms** running autonomous agents that make decisions on behalf of users
- **Any developer** who doesn't want to build compliance infrastructure from scratch

---

## What You Get With Purchase

- The complete GuardLog server code (single file, zero deps)
- Full API documentation with examples in curl, Python, and JavaScript
- Deployment templates for Docker, systemd, and cloud
- 60 days of email support

---

[**→ Purchase GuardLog on Gumroad ($29/mo)**](https://empirelabs1.gumroad.com/l/guardlog)

**Enterprise pricing available** — contact [contact@empirelabs.com.au](mailto:contact@empirelabs.com.au)

---

*Built by [Empire Labs](mailto:contact@empirelabs.com.au)*
