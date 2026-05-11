# Git Commands Reference

Git is an open-source distributed version control system.

## Table of Contents

- [Installation](#installation)
- [Initial Configuration](#initial-configuration)
- [Basic Commands](#basic-commands)
- [Branching and Merging](#branching-and-merging)
- [Remote Operations](#remote-operations)

---

## Installation

### Windows

Download Git from: [https://git-scm.com/download/win](https://git-scm.com/download/win)

### Linux (Ubuntu/Debian)

```bash
sudo apt-get install git
```

### macOS

```bash
brew install git
```

## Initial Configuration

Configure Git with your identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Basic Commands

### Repository Initialization

| Command | Description |
|---------|-------------|
| `git init [repository-name]` | Initialize a new repository |
| `git clone [url]` | Clone an existing repository |

### Staging and Committing

| Command | Description |
|---------|-------------|
| `git add [file]` | Add file to staging area |
| `git add .` | Add all changes to staging area |
| `git commit -m "message"` | Commit staged changes with message |
| `git commit -a` | Commit all tracked changes |
| `git commit -am "message"` | Add and commit in one command |

### Viewing Changes

| Command | Description |
|---------|-------------|
| `git status` | List files to be committed |
| `git diff` | Show unstaged changes |
| `git diff [branch1] [branch2]` | Compare two branches |
| `git log` | Show commit history |
| `git log --follow [file]` | Show history including renames |
| `git show [commit]` | Show commit details |

### Undoing Changes

| Command | Description |
|---------|-------------|
| `git reset [commit]` | Undo commits, preserve changes locally |
| `git reset --hard [commit]` | Discard all changes to specific commit |

### File Operations

| Command | Description |
|---------|-------------|
| `git rm [file]` | Delete file and stage deletion |

## Branching and Merging

### Branch Management

| Command | Description |
|---------|-------------|
| `git branch` | List local branches |
| `git branch [name]` | Create new branch |
| `git branch -d [name]` | Delete branch |
| `git checkout [branch]` | Switch to branch |
| `git checkout -b [name]` | Create and switch to new branch |
| `git merge [branch]` | Merge branch into current branch |

## Remote Operations

### Push Commands

| Command | Description |
|---------|-------------|
| `git push` | Push current branch to remote |
| `git push [remote] [branch]` | Push specific branch |
| `git push --all [remote]` | Push all branches |
| `git push [remote] :[branch]` | Delete remote branch |

### Pull Commands

| Command | Description |
|---------|-------------|
| `git pull` | Fetch and merge remote changes |
| `git fetch` | Download remote changes without merging |

## Quick Reference

```bash
# Common workflow
git status                    # Check current state
git add .                     # Stage all changes
git commit -m "Description"   # Commit with message
git push                      # Push to remote
```
