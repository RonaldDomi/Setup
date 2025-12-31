# Personal Laptop Setup

This document outlines the configuration and tools used on my personal development machine.

## Overview
- Karabiner-Elements
- Alfred
- Hammerspoon
- zshrc + zsh_aliases
- tmux
- vim + coc
- Obsidean

## Keyboard Customization

### Karabiner-Elements

Karabiner-Elements is used for advanced keyboard remapping on macOS.

**Key Remappings:**
- Caps Lock remapped to Control when hold
- Caps Lock remapped to Escape when tapped
- FN remapped to Hyper
- f+j opens Alfred

**Configuration Location:** `~/.config/karabiner/karabiner.json`

## Alfred

Alfred serves as a replacement for macOS Spotlight, providing faster search and workflow automation capabilities.   
Alfred is opened with `f+j`

## Window Management - Hammerspoon

Hammerspoon - Lua scripting with system-level APIs.

**Use Cases:**
- Window management and tiling
- Opens applications on command

**Configuration Location:** `~/.hammerspoon/init.lua`


## Shell Configuration - Zsh

### .zshrc
Location: `~/.zshrc`

Contains shell initialization, plugin loading, and environment setup.

### .zsh_aliases
Location: `~/.zsh_aliases`

Custom shell aliases for frequently used commands and shortcuts.

**Key Aliases:**
- connectiong to working servers
- printing helper texts
- git aliases

## Terminal Multiplexer - tmux

tmux enables multiple terminal sessions within a single window and session persistence.

**Configuration Location:** `~/.tmux.conf`

**Installation:**
```bash
brew install tmux
```

## Editor - Vim

### .vimrc
Location: `~/.vimrc`

### Coc (Conquer of Completion)

Coc provides LSP-based code completion and IDE-like features within Vim.

**Configuration Location:** `~/.vim/coc-settings.json`

**Installation:**
```vim
:CocInstall coc-json coc-tsserver coc-python
```

## Note Taking - Obsidian

Obsidian is a personal knowledge base and note-taking application built on markdown files.

