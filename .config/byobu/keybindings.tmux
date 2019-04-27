set-window-option -g mode-keys vi
unbind-key -n C-b
set -g prefix ^B
set -g prefix2 F12
bind b send-prefix
bind-key p run 'xclip -o -sel clip | tmux load-buffer - ; tmux paste-buffer'
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'V' send -X select-line
bind-key -T copy-mode-vi 'r' send -X rectangle-toggle
bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
