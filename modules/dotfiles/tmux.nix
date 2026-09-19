{ config, pkgs, ... }:

{
  programs.tmux = {
  enable = true;
  clock24 = true;
  extraConfig = ''
    set -g mouse on

    set -g default-terminal "tmux-256color"
    set -as terminal-features ",xterm-256color:RGB"
    set -g history-limit 50000
    set -sg escape-time 0

    unbind C-b
    set -g prefix C-a
    bind C-a send-prefix

    bind | split-window -h -c "#{pane_current_path}"
    bind - split-window -v -c "#{pane_current_path}"
    bind c new-window -c "#{pane_current_path}"

    # Vim-style pane navigation
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R
 
    # Vim-style pane resizing
    bind -r H resize-pane -L 5
    bind -r J resize-pane -D 5
    bind -r K resize-pane -U 5
    bind -r L resize-pane -R 5

    # Use vi keys
    setw -g mode-keys vi
 
    # Vi-style copy bindings
    bind -T copy-mode-vi v send -X begin-selection
    bind -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -selection clipboard -i"
  '';
 };
}
