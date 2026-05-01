#!/usr/bin/env bash

STATE_FILE="/tmp/waybar-power-state"
CONFIRM_FILE="/tmp/waybar-power-confirm"
RATE_FILE="/tmp/waybar-power-rate"

MAX_STATE=2
CONFIRM_WINDOW=1  # seconds
RATE_MS=100

get_state() {
    [[ -f "$STATE_FILE" ]] && cat "$STATE_FILE" || echo 0
}

set_state() {
    echo "$1" > "$STATE_FILE"
}

get_confirm_time() {
    [[ -f "$CONFIRM_FILE" ]] && cat "$CONFIRM_FILE" || echo 0
}

set_confirm_time() {
    date +%s > "$CONFIRM_FILE"
}

get_rate_time() {
    [[ -f "$RATE_FILE" ]] && cat "$RATE_FILE" || echo 0
}

set_rate_time() {
    date +%s%3N > "$RATE_FILE"   # milliseconds
}

clear_confirm() {
    rm -f "$CONFIRM_FILE"
}

get_label() {
    case "$1" in
        0) echo "[OFF]" ;;
        1) echo "[RBT]" ;;
        2) echo "[OUT]" ;;
    esac
}

get_class() {
    case "$1" in
        0) echo "off" ;;
        1) echo "reboot" ;;
        2) echo "logout" ;;
    esac
}

run_event() {
    case "$(get_state)" in
        0) loginctl poweroff ;;
        1) loginctl reboot ;;
        2) loginctl terminate-user "$USER" ;;
    esac
}

handle_click() {
    now=$(date +%s)
    last=$(get_confirm_time)

    if (( last > 0 && now - last < CONFIRM_WINDOW )); then
        clear_confirm
        run_event
    else
        set_confirm_time
    fi
}

change_state() {
    now=$(date +%s%3N)
    last=$(get_rate_time)

    # Enforce rate limit (RATE is in seconds → convert to ms)
    if (( now - last < RATE_MS )); then
        return
    fi

    set_rate_time

    state=$(get_state)
    new_state=$((state + $1))

    state=$(get_state)
    new_state=$((state + $1))

    if (( new_state > MAX_STATE )); then
        new_state=0
    elif (( new_state < 0 )); then
        new_state=$MAX_STATE
    fi

    set_state "$new_state"
    clear_confirm
}

handle_action() {
    case "$1" in
        run) handle_click ;;
        up) change_state 1 ;;
        down) change_state -1 ;;
    esac
}

print_output() {
    now=$(date +%s)
    last=$(get_confirm_time)
    state=$(get_state)

    if (( last > 0 && now - last < CONFIRM_WINDOW )); then
        echo "{\"text\": \"[CFM]\", \"class\": \"confirm\"}"
        return
    else
        clear_confirm
    fi

    label=$(get_label "$state")
    class=$(get_class "$state")

    echo "{\"text\": \"$label\", \"class\": \"$class\"}"
}

# Entry
case "$1" in
    run|up|down)
        handle_action "$1"
        ;;
    *)
        print_output
        ;;
esac
