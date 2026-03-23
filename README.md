# terabox-storage

> TeraBox cloud storage skill — upload, download, transfer, share, search, file management, all in one sentence.

[![skill](https://img.shields.io/badge/skill-terabox--storage-blue)](https://www.terabox.com)
[![Version](https://img.shields.io/badge/version-v1.0.0-green)]()
[![License](https://img.shields.io/badge/license-MIT-yellow)](./LICENSE)

## Install

```bash
npx skills add https://github.com/terabox-storage/skills --skill terabox-storage
```

On first use, the Skill will automatically guide you through CLI tool installation and TeraBox login authorization.

## Features

| Feature | Description |
|---------|-------------|
| File Upload | Upload local files to TeraBox cloud storage |
| File Download | Download cloud files to local |
| Share Link Download | Download directly via share link + password |
| Transfer | Save shared files to your own cloud storage |
| Share | Generate share links with password and expiry options |
| Share Info | View share link details |
| Share File List | List files in a share link |
| File List | View uploaded files in cloud storage |
| File Search | Search files by keyword |
| File Info | Get file details and download links |
| File Move | Move files or folders to a specified directory |
| File Copy | Copy files or folders to a specified directory |
| File Rename | Rename files or folders |
| Stream/Play | Get streaming URL for video files |
| User Info | Get user profile information |
| Storage Quota | Query storage space usage (used/total/free) |
| CLI Update | Check and manage CLI tool updates |

## Quick Start

After installation, use natural language in OpenClaw / Claude Code / DuClaw / Ducc or other AI Agents:

```
Upload ./report.pdf to TeraBox
```

```
Download backup/ from TeraBox
```

```
Transfer this link to my TeraBox: https://terabox.com/s/1xxxxx?pwd=abcd
```

```
List my files on TeraBox
```

```
Search for report files on TeraBox
```

```
Move report.pdf to the backup folder on TeraBox
```

```
Share my project files on TeraBox
```

```
Check my TeraBox storage quota
```

```
Get file info for report.pdf on TeraBox
```

The Skill will automatically identify your intent, execute the corresponding operation, and return formatted results.

## Usage Examples

### Upload

```
Upload ./report.pdf to TeraBox and share it
```

Expected output:

```
Upload and share successful!
Link: https://terabox.com/s/xxxxxxx
Password: abcd
Expiry: 7 days
```

### List Files

```
Show my TeraBox files
```

Expected output:

```
Type    Size          Modified              Name
------  ------------  --------------------  --------
Dir      -            2026-02-20 10:30:00  backup
File    1.5 MB        2026-02-25 15:20:00  report.pdf
File    256 KB        2026-02-24 09:15:00  config.yaml

3 items total
```

### Transfer Shared Files

```
Transfer this TeraBox link: https://terabox.com/s/1xxxxx?pwd=abcd
```

Expected output:

```
Transfer successful!
Saved 3 files to: /From：Other Applications/app/my-folder/
```

### Download Shared Files

```
Download this TeraBox share link to local: https://terabox.com/s/1xxxxx?pwd=abcd
```

## Security

- **Sandbox Isolation** — All operations restricted to the application sandbox directory, cannot access other user files
- **Confirmation Required** — Move, rename, overwrite and other risky operations require user confirmation before execution
- **OAuth 2.0** — No password storage, uses authorization code flow for authentication
- **Token Protection** — Config files and tokens are never exposed in public repos or conversations

> This tool is in BETA stage. Always backup important data and review every AI-executed command in real-time.

## Troubleshooting

When encountering issues, just tell the Skill:

- "TeraBox token expired" — Automatically guides re-login
- "Check TeraBox login status" — Shows current auth info

For detailed error codes and solutions, see [reference/troubleshooting.md](./terabox-storage/reference/troubleshooting.md).

## System Support

| Platform | Architecture |
|----------|-------------|
| Linux | x86-64, ARM64 |
| macOS | x86-64 (Intel), ARM64 (Apple Silicon) |
| Windows | x86-64 |

## Project Structure

```
terabox-skill/
├── LICENSE
├── README.md
└── terabox-storage/              # Skill package
    ├── SKILL.md                  # Skill definition (entry point for AI agents)
    ├── VERSION                   # Skill version file
    ├── .claude/
    │   └── settings.local.json   # Agent permissions configuration
    ├── reference/
    │   ├── authentication.md     # Login/auth flow documentation
    │   ├── examples.md           # Usage examples
    │   ├── notes.md              # Beta notes and security guidelines
    │   ├── terabox-commands.md   # Complete CLI command reference
    │   └── troubleshooting.md    # Error codes and troubleshooting
    └── scripts/
        ├── .claude/
        │   └── settings.local.json  # Scripts directory permissions
        ├── install.sh            # CLI installation script
        ├── login.sh              # Login/authorization script
        └── update.sh             # Skill auto-update script
```

## 📦 Packaging & Sharing

### Local Packaging

```bash
# Show available commands
make help

# List all skills
make list

# Pack a specific skill
make pack SKILL=terabox-storage

# Pack all skills
make pack-all

# Clean packaging output
make clean
```

### Automated Release

Pushing a tag will **automatically trigger a GitHub Release**:

```bash
# Create and push a tag
git tag v1.0.0
git push origin v1.0.0
```

The workflow will automatically:
1. Pack all skills into zip files
2. Generate release notes
3. Create a GitHub Release and upload assets

Supported tag formats:
- `v*` — e.g. `v1.0.0`
- `skill-*` — e.g. `skill-v1.0.0`


## Join Us  

Welcome to the Terabox-storage user community! Here you can:
- 🚀 Get the latest version updates and usage tips
- 💡 Share your use cases and creative ideas
- 🐛 Report issues and communicate directly with developers
- 🤝Connect with other AI Agent and tech enthusiasts

Click to join: https://discord.gg/GyDjKnkJ


## License

[MIT License](./LICENSE)
