# Nushell Environment Config File
#
# version = "0.94.1"

def _prompt_left [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi yellow } else { ansi white })
    let separator_color = (if (is-admin) { ansi yellow } else { ansi white })
    let path_segment = $"($path_color)($dir)"

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def _prompt_right [] {
    # TODO: Integrate plugin: gstat

    ""
}

def _prompt_indicator [] {
    let exit_code_str = (if (is-empty $env.LAST_EXIT_CODE) { "" } else { $" ($env.LAST_EXIT_CODE)" })
    let indicator_color = (if (is-empty $exit_code_str) { ansi green_bold } else { ansi red_bold })

    [($indicator_color) ($exit_code_str) (char space) ">" (ansi reset) (char space)] | str join
}

$env.PROMPT_COMMAND = {|| _prompt_left }
$env.PROMPT_COMMAND_RIGHT = {|| _prompt_right }

$env.PROMPT_INDICATOR = " > "
$env.PROMPT_INDICATOR_VI_INSERT = { || _prompt_indicator }
$env.PROMPT_INDICATOR_VI_NORMAL = { || _prompt_indicator }
$env.PROMPT_MULTILINE_INDICATOR = {"::: " }

# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')
