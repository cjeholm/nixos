{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  environment.systemPackages = with pkgs; [
    python313Packages.python-lsp-server # Python LSP server
    lua-language-server # Lua LSP server
    clang-tools # C++ LSP server
    nixd # nix LSP server
    marksman # Markdown LSP server
    rust-analyzer # Rust LSP 
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint language servers extracted from vscode

    pylint # Linting for Python
    markdownlint-cli2 # Linting for markdown

    stylua # Lua formatter
    nodePackages.prettier
    luajitPackages.jsregexp

    xsel # For clipboard
    ripgrep # For Telescope previews
    fd # find alternative

    alejandra # Nix code formatter. Fast and reliable.
    # nixpkgs-fmt         # Current official style, required for Nixpkgs contributions
    black # Python code formatter
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
