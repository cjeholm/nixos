{ config, pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = '' # used for less common options, intelligently combines if defined in multiple places.
    ...
    '';
  }   

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
