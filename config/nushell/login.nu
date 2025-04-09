load-env {
    # General
    EDITOR: "nvim",
    VISUAL: "nvim",
    BROWSER: "firefox-developer-edition",

    # Being explicit about the defaults...
    # See: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
    # A bit more comprehensible: https://wiki.archlinux.org/title/XDG_Base_Directory
    XDG_CACHE_HOME: $"($env.HOME)/.cache",
    XDG_CONFIG_HOME: $"($env.HOME)/.config",
    XDG_DATA_HOME: $"($env.HOME)/.local/share",
    XDG_STATE_HOME: $"($env.HOME)/.local/state",

    # The following directories are not defined
    # by the standart (above url), but not everybody listens,
    # and/or this is an undocumented feature/expansion.
    # It is even more likely, that I'm just stupid.
    XDG_BIN_HOME: $"($env.HOME)/.local/bin",
    XDG_DOWNLOADS_DIR: $"($env.HOME)/downloads",
    XDG_DESKTOP_DIR: '/dev/null',

    # Login shell
    ZDOTDIR: $"($env.XDG_CONFIG_HOME)/zsh",
    HISTFILE: $"($env.XDG_DATA_HOME)/.zhistory",
    HISTSIZE: 10000,
    SAVEHIST: 10000,

    # Interactive shell
    # Using fish as a login shell can cause issues on some linux
    # distributions.
    # See: https://fishshell.com/docs/current/language.html#configuration
    # My primary reason for still reling on zsh
    # is that I'm emotionally attached to my config :^)

    # This is just the default
    __fish_config_dir: $"($env.XDG_CONFIG_HOME)/fish",

    # Cargo/Rust
    RUSTUP_HOME: $"($env.XDG_DATA_HOME)/rustup",
    CARGO_HOME: $"($env.XDG_DATA_HOME)/cargo",

    # Git
    GIT_REVIEW_BASE: 'main',
    GIT_PAGER: 'bat',

    # NodeJS - npm global modules/config
    npm_config_prefix: $"($env.XDG_DATA_HOME)/npm",

    # DenoJS
    DENO_DIR: $"($env.XDG_CACHE_HOME)/deno",
    DENO_INSTALL_ROOT: $"($env.XDG_DATA_HOME)/deno/bin",

    # Go
    GOPATH: $"($env.XDG_DATA_HOME)/go",

    # Other
    PROXYCHAINS_CONF_FILE: $"($env.XDG_CONFIG_HOME)/proxychains/proxychains.conf",
    PASSWORD_STORE_DIR: $"($env.XDG_DATA_HOME)/pass",
    WINEPREFIX: $"($env.XDG_DATA_HOME)/wine/pfx/default",

    LESSHISTFILE: $"($env.XDG_DATA_HOME)/lesshist",
    LESSHISTSIZE: 100,

    # Pager for man with some color changes
    MANPAGER: 'less -R --use-color -Dur$Dd+c$Dsy$DPw',
    MANROFFOPT: '-c',

    # GNU GPG
    GNUPGHOME: $"($env.XDG_DATA_HOME)/gnupg",
    GPG_TTY: "(tty)",

    # GNU GDB
    GDBHISTORYPATH: $"($env.XDG_CACHE_HOME)/gdb/gdbhist",

    # Perl
    #PATH: $"($env.XDG_DATA_HOME)/perl5/bin${PATH:+:${PATH}}",
    #PERL5LIB: $"($env.XDG_DATA_HOME)/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}",
    #PERL_LOCAL_LIB_ROOT: $"($env.XDG_DATA_HOME)/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}",
    #PERL_MB_OPT: $"--install_base \"($env.XDG_DATA_HOME)/perl5\"",
    #PERL_MM_OPT: $"INSTALL_BASE=($env.XDG_DATA_HOME)/perl5",

    # Fixing "bugs" in dwm... see dwm(1)
    _JAVA_AWT_WM_NONREPARENTING: 1,

    # Personal exports for script mangement... AHHHAH
    DOTFILES_ROOT: $"($env.HOME)/dotfiles",
    DISK_ONE: "/mnt/data_0",
}

do --env {
    use std *

    path add $"($env.HOME)/.local/bin"
    path add $"($env.CARGO_HOME)/bin"
    path add $"($env.npm_config_prefix)/bin"
    path add $"($env.HOME)/.bun/bin"
    path add $"($env.DOTFILES_ROOT)/bin"
}
