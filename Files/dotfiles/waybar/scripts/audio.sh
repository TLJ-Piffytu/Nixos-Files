#!/usr/bin/env bash

STEP=2

get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2 * 100}'
}

is_muted() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]'
}

output() {
    vol=$(get_volume)

    if [ -z "$vol" ]; then
        echo '{"text": "VOL: ERR", "tooltip": "wpctl failed", "class": ""}'
        return
    fi

    if is_muted; then
	echo "{\"text\": \"M V: $vol%\", \"tooltip\": \"Volume: $vol% (Muted)\", \"class\": \"muted\"}"
    else
	echo "{\"text\": \"VOL: $vol%\", \"tooltip\": \"Volume: $vol%\", \"class\": \"\"}"
    fi
}

handle_action() {
    case "$1" in
        toggle) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
        up)     wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ "${STEP}%+" ;;
        down)   wpctl set-volume @DEFAULT_AUDIO_SINK@ "${STEP}%-" ;;
    esac
}

# Click actions
if [ -n "$1" ]; then
    handle_action "$1"
    output
    exit 0
fi

# Initial state
output

# Listen to PipeWire events
pw-mon | while read -r line; do
    # Only react to relevant changes (reduces spam a lot)
    case "$line" in
        *"change"*|*"param"*)
            output
            ;;
    esac
done
