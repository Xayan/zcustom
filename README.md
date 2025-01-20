# Custom ZSH Configuration

## Installation

1. Clone the repository:
   ```zsh
   git clone https://github.com/Xayan/zcustom.git ~/.zsh
   ```

2. Add to your ~/.zshenv:
   ```zsh
   export ZDOTDIR="$HOME/.zsh/var/z"
   ```

3. Start a new zsh session to initialize the configuration.

## Dependencies

Required:
- git
- curl
- [jq](https://github.com/jqlang/jq)
- [Antigen](https://github.com/zsh-users/antigen) located in `var/z/` (will be auto-installed if missing)

Optional:
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)
- [micro](https://micro-editor.github.io/)

## Directory Structure

```
./
├── completions/  # Custom completions
├── config/       # Configuration files
├── functions/    # Per-file functions
├── lib/          # General-purpose code
├── plugins/      # Custom plugins
├── scripts/      # Loadable shell scripts
└── var/          # Variable data
    ├── cache/    # Cache files
    ├── logs/     # Log files
    └── z/        # zsh internal files ($ZDOTDIR)
```

## Key Features

- Modular organization with clear separation of concerns
- Lazy loading of functions for faster shell startup
- Utilization of Antigen for plugin management and caching
- Built-in debugging support with `zc_debug` utility
- Custom print function with stack traces (`zc_print`)
- Smart environment detection and setup

## Core Functions

- `zc_load`: Lazy loads functions and sources scripts/libraries
- `zc_print`: Advanced printing with message types and stack traces
- `zc_debug`: Debug utilities for configuration troubleshooting
- `zc_compinit`: Handles completion system initialization

## Environment Variables

- `$ZCUSTOM`: Base directory for ZSH configuration, with subdirectories:
  - `$ZCONFIG`: Configuration directory
  - `$ZFUNCTIONS`: Functions directory
  - `$ZLIB`: Libraries directory
  - `$ZPLUGINS`: Plugins directory
  - `$ZSCRIPTS`: Scripts directory
  - `$ZDOTDIR`, `$ADOTDIR`: ZSH and Antigen dotfile directory (by default both point to `$ZCTUSTOM/var/z`)
- `$ZDEBUG`: Debug mode state (0 or 1)
- `$ZDEBUGFILE`: Enables $ZDEBUG if present; checked upon zsh startup

## Usage

### Libs and scripts

While both libraries and scripts are regular zsh scripts, sourced by `zc_load`, there are some key differences:

| Key point | Libs | Scripts |
|---|---|---|
| Loading Method | All at once | One by one |
| Loading Time | After setting up shell options, before Antigen setup | At any time |
| Loading Order | Irrelevant | Explicitly stated |
| Code Organization | Self-contained | Dependent on load order |
| Access To | Env vars, configs, functions | Same + Anything set by previously executed scripts/libs |
| User Interaction | None | Allowed |

For example, Antigen setup is a script. It needs to be loaded at a specific point during zsh setup; If it's not detected, the user will be prompted to install it.

On the other hand, keybindings setup is considered a library. It can be loaded at any point, and doesn't depend on any code outside of it, with the exception of custom functions (guaranteed to be loaded).

### Functions

1. All files placed in $ZFUNCTIONS - including those in subdirectories - are loaded automatically as functions.
2. Subdirectories can be used to group functions, but they are NOT namespaces. Every function needs to have a unique name, regardless of the directory it is in.
3. Function name and file name should match - so no extensions.
4. Functions are loaded lazily.

### Plugins

1. Plugins are loaded using Antigen, and need to follow zsh plugin guidelines.
2. By default, some plugins are loaded automatically.
3. Any additional plugins can be added to `$ZPLUGINS` directory, from where they will also be loaded automatically.

### Debugging

Debug mode is defined by the `ZDEBUG` environment variable, which can be set manually after the shell has started, or can be pre-set by creating a `ZDEBUGFILE`. This allows you to debug the configuration from the very start. This process can be automated using the `zc_debug` utility.

So, there are the following methods to enable/disable debug mode:

```shell
ZDEBUG=1            # Enable temporary debug mode
ZDEBUG=0            # Disable temporary debug mode

touch $ZDEBUGFILE   # Enable persisent debug mode from next shell session
rm $ZDEBUGFILE      # Disable persistent debug mode from next shell session

zc_debug --enable   # Enable persistent debug mode right now
zc_debug --disable  # Disable persistent debug mode right now
```

When debug mode is enabled:
- Caching is disabled
- You will see many useful messages that are otherwise hidden
- You can print all important variables and their values with `zc_debug --dumpenv`
- Any logs written during debug mode, including Antigen log, will be stored in `$ZLOGS`
- Stack traces can be enabled for any message using `--trace` (also works with `zc_print`):
  ```zsh
  zc_debug "Something went wrong" --trace
  [DBG] Something went wrong
    0: my_function:5
    1: (anon):2
    2: /some/file.zsh:123
  ```

## License

MIT License
