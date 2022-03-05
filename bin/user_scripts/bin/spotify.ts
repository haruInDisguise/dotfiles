#!/usr/bin/env -S deno run

import { parse } from 'https://deno.land/std@0.127.0/flags/mod.ts';

const app_properties = {
    status: 0,
    options: {
        detach_librespot: false,
        mute_script: false,
    },
};

const enum Status {
    None,
    Run,
    Exit,
    Check,
    Continue,
    Stop,
};

const _log_color_values = {
    reset: '\x1b[0m',
    red: '\x1b[31m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    cyan: '\x1b[36m',
};

const log_format= (color: string, level: string, args: string[]): string => {
    const reset_char = _log_color_values.reset;
    const date = new Date().toISOString();
    const fmt_level = `${color}${level}${reset_char}`

    return `${date} ${color}${fmt_level} ${args.join(' ')}`
};

const log_error = (...args: string[]): void => console.error(log_format(_log_color_values.red,   'ERROR', args));
const log_info  = (...args: string[]): void => console.info(log_format(_log_color_values.green,  'INFO ', args));
const log_debug = (...args: string[]): void => console.debug(log_format(_log_color_values.cyan,  'DEBUG', args));
const log_warn  = (...args: string[]): void => console.warn(log_format(_log_color_values.yellow, 'WARN ', args));

const handle_arguments = (): void => {
    const flags = parse(Deno.args);
};

handle_arguments();

log_error("This is an error. Wuuuuu");
Deno.exit();
