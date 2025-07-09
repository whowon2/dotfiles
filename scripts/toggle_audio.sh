#!/usr/bin/env bash

# Get all available sink names
mapfile -t sinks < <(pactl list short sinks | awk '{print $2}')

# Get the current default sink
current=$(pactl get-default-sink)

# Find the index of the current sink
index=-1
for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current" ]]; then
        index=$i
        break
    fi
done

# Calculate the next index (wrap around)
next_index=$(( (index + 1) % ${#sinks[@]} ))
next_sink=${sinks[$next_index]}

# Set the new default sink
pactl set-default-sink "$next_sink"

# Move all currently playing audio streams to the new sink
while read -r input_id _; do
    pactl move-sink-input "$input_id" "$next_sink"
done < <(pactl list short sink-inputs)

# Print confirmation
echo "Switched to: $next_sink"
