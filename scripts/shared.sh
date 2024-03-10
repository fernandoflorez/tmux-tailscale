#!/usr/bin/env bash


get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

tailscale_bin(){
    for op in "$@"; do
        if command -v "$op" > /dev/null 2>&1; then
            echo "$op"
            return 0
        fi
    done
    return 1
}

current_status(){
    local ts=$(tailscale_bin $HOME/go/bin/tailscale /Applications/Tailscale.app/Contents/MacOS/Tailscale)
    "$ts" status --json | jq -r 'if .BackendState == "Running" then if .Self.Online then "Online" else "Offline" end else .BackendState end'
}

print_icon(){
    local status=""
    if [ "$#" == 0 ]; then
        status=$(current_status)
    else
        status=$1
    fi
    if [[ $status == "Online" ]]; then
        icon="$(get_tmux_option @tailscale_online_icon ✅)"
    elif [[ $status == "Offline" ]]; then
        icon="$(get_tmux_option @tailscale_offline_icon ⛔️)"
    elif [[ $status == "Stopped" ]]; then
        icon="$(get_tmux_option @tailscale_stopped_icon 🛑)"
    elif [[ $status == "Starting" ]]; then
        icon="$(get_tmux_option @tailscale_starting_icon 🔄)"
    else
        icon="$(get_tmux_option @tailscale_unknown_icon ❓)"
    fi
    echo "$icon"
}

print_status(){
    local status=$(current_status)
    local icon=$(print_icon $status)
}
