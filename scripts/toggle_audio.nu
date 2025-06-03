#!/usr/bin/env nu

# Get all available sink names
let sinks = (
    pactl list short sinks
    | from tsv --noheaders
    | get column1
)

# Get the current default sink
let current = (pactl get-default-sink)

# Enumerate sinks to find index of current sink
let indexed_sinks = ($sinks | enumerate) | rename id name
let index = ($indexed_sinks | where name == $current | get id | first)

# Calculate the next index (wrap around)
let next_index = (($index | into int) + 1) mod ($sinks | length)

# Get the name of the next sink
let next_sink = ($sinks | get $next_index)

# Set the new default sink
pactl set-default-sink $next_sink

# Move all currently playing audio streams to the new sink
for input in (pactl list short sink-inputs | from tsv --noheaders | get column0) {
    pactl move-sink-input $input $next_sink
}

# Optional: print confirmation
echo $"Switched to: ($next_sink)"

