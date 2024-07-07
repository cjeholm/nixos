{ config, pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
       # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };

environment.systemPackages = with pkgs; [

    python311Packages.python-lsp-server   # Python LSP server
    lua-language-server                   # Lua LSP server
    clang-tools                           # C++ LSP server
  
    pylint                # Linting for Python
    markdownlint-cli2     # Linting for markdown

    stylua                # Lua formatter
    nodePackages.prettier
    luajitPackages.jsregexp

    lazygit               # Terminal UI for git commands

    xsel                  # For clipboard
    ripgrep               # For Telescope previews
    fd                    # find alternative
  ];
}
