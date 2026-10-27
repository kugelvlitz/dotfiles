# Dotfiles

My personal Linux configuration files for a terminal-focused development environment. The setup combines Zsh and Oh My Zsh, Alacritty, tmux, Helix, Neovim, Visual Studio Code, and mpv, with additional desktop tweaks for systems using Pacman.

These files reflect personal preferences and include machine-specific paths. Install the pieces you need and adjust them for your environment; there is no automated installer or dependency bootstrap script.

## Repository contents

| File or directory | Purpose | Typical destination |
| --- | --- | --- |
| [`zshrc/`](zshrc/) | Zsh startup configuration, aliases, helper functions, and Dracula syntax highlighting | `~/.config/zshrc/`, with `.zshrc` linked to `~/.zshrc` |
| [`david.zsh-theme`](david.zsh-theme) | Oh My Zsh prompt with Git status, exit status, and the working directory | Oh My Zsh's custom `themes/` directory |
| [`alacritty/`](alacritty/) | Terminal settings and Dracula colors; includes TOML and legacy YAML configurations | `~/.config/alacritty/` |
| [`.tmux.conf`](.tmux.conf) | tmux key bindings, mouse support, and plugin configuration | `~/.tmux.conf` |
| [`helix/`](helix/) | Helix settings and a collection of editor themes | `~/.config/helix/` |
| [`nvim/`](nvim/) | Neovim settings and an optional nvim-tree configuration | `~/.config/nvim/` |
| [`vscode_settings.json`](vscode_settings.json) | VS Code appearance, formatting, and extension settings | VS Code's user `settings.json` |
| [`profile.code-profile`](profile.code-profile) | Saved VS Code profile export | Import through VS Code's Profiles interface |
| [`mpv.conf`](mpv.conf) | Video rendering, hardware decoding, audio, and screenshot settings | `~/.config/mpv/mpv.conf` |
| [`rc.conf`](rc.conf) | Ranger file manager display settings | `~/.config/ranger/rc.conf` |
| [`pacman_hooks/`](pacman_hooks/) | Package hooks for desktop entry names and Jellyfin backdrops | `/etc/pacman.d/hooks/` |

## Setup

Run commands from the repository root. Back up any existing files before copying or linking configurations. The examples below assume the default `~/.config` location and that the destination files do not already exist.

For example, install the mpv configuration with a symbolic link:

```sh
mkdir -p "$HOME/.config/mpv"
ln -s "$PWD/mpv.conf" "$HOME/.config/mpv/mpv.conf"
mkdir -p "$HOME/Pictures/Frames"
```

Link an entire configuration directory in the same way:

```sh
mkdir -p "$HOME/.config"
ln -s "$PWD/helix" "$HOME/.config/helix"
```

Links follow future changes in this checkout, so keep the repository at a stable location. Copy files instead if you want to customize them independently. Install each application and its supporting tools separately.

### Zsh

The shell configuration loads aliases, functions, and Dracula syntax highlighting from `~/.config/zshrc/`. To preserve those paths:

```sh
mkdir -p "$HOME/.config"
ln -s "$PWD/zshrc" "$HOME/.config/zshrc"
ln -s "$HOME/.config/zshrc/.zshrc" "$HOME/.zshrc"
```

Before starting a new shell, review `zshrc/.zshrc`:

- Oh My Zsh is expected at `/usr/share/oh-my-zsh/`, with `ZSH_THEME="david"`. Install `david.zsh-theme` in your Oh My Zsh custom themes directory, or select another installed theme.
- Syntax highlighting, autosuggestions, and NVM are sourced from paths under `/usr/share/`. Update these paths to match your installations.
- Startup runs `zoxide` and `cowsay`; FZF integration loads when `~/.fzf.zsh` exists. The local editor is set to `helix`, while SSH sessions use `vi`.
- Several aliases use additional tools, including `exa` and `protontricks-launch`, or refer to personal Steam paths.

Helpers include `mkcd` to create and enter a directory, `aperture` to change Alacritty opacity through its IPC socket, `gswitch` to control GNOME's workspace-only app switching, and `subgrab` to download and rename subtitles for a video in the current directory.

Review helpers before using them: `nukeparucache` deletes package caches, `recovery-pacman` changes Pacman's database with dependency checks and scriptlets disabled, and `subgrab` removes temporary files while processing a download.

### Alacritty and tmux

Alacritty uses a 100 × 30 window, 15-pixel padding, 70% opacity, no window decorations, and a 14-point FiraCode font. The TOML configuration imports Dracula from `/home/david/.config/alacritty/themes/dracula.toml`; change that path to your own copy. The YAML file preserves an older configuration with inline colors.

tmux uses **Ctrl+A** as its prefix, enables mouse support, and sets the escape delay to zero for Helix compatibility. Nord is the enabled theme; a Dracula plugin declaration is commented out. The configuration expects TPM at `/usr/share/tmux-plugin-manager/tpm` and replaces tmux's `PATH` with `/usr/local/bin:/bin:/usr/bin`. Adjust both settings for your system. With TPM installed, use **prefix + I** to install the configured plugins.

### Editors and file manager

- **Helix:** selects the `bogster` theme, enables soft wrapping, and excludes hidden files from the file picker. Additional themes include Edge, Everforest, Gruvbox, Kanabox, and Sonokai variants. Change `theme` in `helix/config.toml` to select one of the bundled theme filenames without `.toml`.
- **Neovim:** enables line numbers, filetype plugins and indentation, four-space indentation, and spaces instead of tabs. The optional `nvim-tree-setup.lua` file is not loaded by default: its `require` line in `init.vim` is commented out. Install nvim-tree and review its configuration for compatibility before enabling it.
- **VS Code:** uses Fira Code with ligatures, One Dark Pro Monokai Darker, Material Icon Theme, smooth scrolling, and language-specific formatters. Merge `vscode_settings.json` into your user settings, or import the profile export. Install the referenced themes and extensions separately, and review the personal localhost PostgreSQL connection settings before using them.
- **Ranger:** requests a `devicons` line mode and borders. The line mode requires a compatible devicons extension.

### mpv

The player configuration enables the `gpu-hq` profile, `ewa_lanczossharp` scaling for luma and chroma, automatic hardware decoding, and display-resampled video synchronization. It allows volume up to 200% and saves screenshots to `~/Pictures/Frames`. Interpolation settings are present but commented out.

Rendering performance and hardware decoding depend on the GPU and drivers. Review these options against your installed mpv version if playback or configuration loading causes problems.

### Pacman hooks

These hooks run after the matching packages are installed or upgraded:

| Hook | Effect |
| --- | --- |
| `figma-rename.hook` | Changes “Figma Linux” to “Figma” in its desktop entry |
| `firefox-rename.hook` | Changes “Firefox Web Browser” to “Firefox” |
| `spotify-rename.hook` | Changes the Spotify Launcher name and icon to Spotify |
| `steam-runtime-rename.hook` | Changes “Steam (Runtime)” to “Steam” |
| `jellyfin-default-client-backdrops.hook` | Patches the Jellyfin web bundle to enable backdrops by default |

On a Pacman-based system, copy only the hooks you want into `/etc/pacman.d/hooks/` with administrator privileges. They use `sed` to modify installed files under `/usr/share/`. Package names, desktop entry text, and Jellyfin's bundled JavaScript must match the patterns in the hooks; upstream changes may require updating them.
