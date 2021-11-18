#!/bin/sh
# Install Neovim plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
