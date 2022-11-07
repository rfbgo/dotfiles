#!/bin/sh

# Put vimrc in right place
ln -s `pwd`/.vimrc $HOME/.vimrc

# Grab oh-my-sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add iterm support?!
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
