# Desensitization Checklist

Before publishing screenshots, demo videos, or any public material derived from the production UP-Analyzer:

## Must Remove or Replace

| Category | Examples to scrub | Replacement |
|----------|-------------------|-------------|
| Company names | Nokia, Motorola, internal codenames | "Vendor-X", "a telecom equipment company" |
| Internal URLs | `gitlabe1.ext.net.nokia.com`, proxy hosts | Remove or blur |
| Site / customer IDs | MRBTS-*, ENB names with real site codes | `SITE-001`, `ENB_9999_000000` |
| Real Pronto/PR IDs | PR895222, PR891909 | `ISSUE-001`, `CHG-0042` |
| Internal email domains | `@nokia-sbell.com` | Personal email only |
| AWS/S3 credentials | Access keys in env vars | Never show terminal with secrets |
| Colleague names | Team member real names in UI | Blur or use synthetic |
| Build strings with internal paths | Full SVN/Git internal URLs | Truncate to `Release R3.2.1` |

## Safe to Show

- Generic UI layout and navigation structure
- Synthetic KPI names (e.g., `COUNTER_AVAIL_CH`, `COUNTER_USED_CH`)
- Architecture diagrams (this repo)
- Staged investigation **workflow** (not real defect data)
- Technology stack names (Electron, React, Python, Cursor)
- Commit counts, version numbers, DAU metrics (rounded)

## Screenshot Capture Tips

1. Use **synthetic test data** from `test/data/` paths with `ENB_9999` style IDs
2. Or use the [interactive mock](../demo/index.html) — zero proprietary content
3. Blur the Windows title bar if it shows internal hostnames
4. Crop out email/IM notifications in screen recordings
5. Run OBS with a **1080p canvas**; scale UI to 125% for readability

## Video-Specific

- Narration: say "a 5G base station product" not the vendor name
- Do not show internal Jira/Pronto web pages
- If showing IDE: use a generic workspace, not `c:\work\UP-Analyzer`
- Terminal: use `curl localhost:PORT` with synthetic port numbers

## Legal Note

The production codebase is company IP. This showcase repo contains only:
- Original documentation written for portfolio
- Synthetic demo HTML
- Desensitized example reports

Do **not** push any code from `c:\work\UP-Analyzer\` to public GitHub.
