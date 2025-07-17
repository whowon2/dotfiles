#!/bin/bash

WAYBAR_DIR="$HOME/.config/waybar"
SASS_INPUT="$WAYBAR_DIR/style.scss"
CSS_OUTPUT="$WAYBAR_DIR/style.css"

# Function to compile Sass
compile_sass() {
    echo "Compiling Sass..."
    sass --no-source-map "$SASS_INPUT":"$CSS_OUTPUT"
    if [ $? -ne 0 ]; then
        echo "Sass compilation failed. Skipping restart."
        return 1
    fi
    return 0
}

# Kill any existing Waybar instances
killall waybar

# Start Waybar and store PID
start_waybar() {
    echo "Starting Waybar..."
    waybar &
    WAYBAR_PID=$!
}

# Stop Waybar
stop_waybar() {
    echo "Stopping Waybar (PID $WAYBAR_PID)..."
    kill "$WAYBAR_PID" 2>/dev/null
}

# Initial compile and run
if compile_sass; then
    start_waybar
else
    exit 1
fi

# Ensure Waybar stops on script exit
trap "stop_waybar" EXIT

# Watch for changes and restart
while inotifywait -r -e modify,create,delete "$WAYBAR_DIR"; do
    echo "Config changed. Recompiling and restarting Waybar..."
    if compile_sass; then
        stop_waybar
        start_waybar
    fi
done
