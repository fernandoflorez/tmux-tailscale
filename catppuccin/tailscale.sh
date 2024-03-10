show_tailscale(){
    local index=$1
    local icon="#{tailscale_status_icon}"
    local color=$(get_tmux_option "@catppuccin_tailscale_color" "$thm_yellow")
    local text="#{tailscale_status}"
    local module=$(build_status_module "$index" "$icon" "$color" "$text")
    echo "$module"
}
