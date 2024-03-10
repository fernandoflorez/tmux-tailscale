#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/shared.sh"


status_icon="#($CURRENT_DIR/scripts/tailscale_status_icon.sh)"
status_icon_interpolation="\#{tailscale_status_icon}"
status_text="#($CURRENT_DIR/scripts/tailscale_status_text.sh)"
status_text_interpolation="\#{tailscale_status}"

show_tailscale(){
    local index=$1
    local icon=$(get_tmux_option "@catppuccin_tailscale_icon" "#{tailscale_status_icon}")
    local color=$(get_tmux_option "@catppuccin_tailscale_color" "$thm_bg")
    local text=$(get_tmux_option "@catppuccin_tailscale_text" "#{tailscale_status}")
    local module=$(build_status_module "$index" "$icon" "$color" "$text")
    echo "$module"
}

do_interpolation(){
	local input="$1"
    local result=""

	result=${input/$status_icon_interpolation/$status_icon}
	result=${result/$status_text_interpolation/$status_text}

	echo "$result"
}

update_tmux_option(){
	local option=$1
	local option_value=$(get_tmux_option "$option")
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_option "$option" "$new_option_value"
}

main(){
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
