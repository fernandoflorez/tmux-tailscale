# Tmux tailscale status

Display tailscale's status on your tmux status.

### Usage

Add `#{tailscale_status_icon}` and `#{tailscale_status}` format string to your existing `status-right` tmux
option.

Here's the example in `.tmux.conf`:

    set -g status-right "#{tailscale_status_icon} #{tailscale_status} | %a %h-%d %H:%M"

#### Configure icons
If the icons don't display well on your machine you can change them in
`.tmux.conf`:

    set -g @tailscale_online_icon "✅"
    set -g @tailscale_offline_icon "⛔️"
    set -g @tailscale_stopped_icon "🛑"
    set -g @tailscale_starting_icon "🔄"
    set -g @tailscale_unknown_icon "❓"

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'fernandoflorez/tmux-tailscale'

Hit `prefix + I` to fetch the plugin and source it.

`#{tailscale_status}` interpolation should now work.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/fernandoflorez/tmux-tailscale ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/tailscale_status.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

`#{tailscale_status_icon}` and `#{tailscale_status}` interpolations should now work.

### Catppuccin support
[Catppuccin](https://github.com/catppuccin/tmux/tree/main) is supported:

   set -g @catppuccin_status_modules_right "... tailscale ..."

Copy `catppuccin/tailscale.sh` to catppuccin's custom directory first.

### Dependencies

[jq](https://github.com/jqlang/jq) is required.

### License

[MIT](LICENSE.md)
