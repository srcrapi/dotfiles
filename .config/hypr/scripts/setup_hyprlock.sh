#!/usr/bin/env bash

script_random_quotes="$HOME/.local/bin/random_quotes.py"
out_random_quotes="/tmp/out_random_quotes.txt"

python3 ${script_random_quotes}

export RANDOM_QUOTE=$(head -1 ${out_random_quotes})

hyprlock
