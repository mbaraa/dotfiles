#!/bin/bash

install_lsp() {
  mkdir -p ~/.config/lsp
  cd ~/.config/lsp

  git clone --depth=1 https://github.com/LuaLS/lua-language-server
  cd lua-language-server
  git submodule update --init --recursive
  cd 3rd/luamake
  compile/install.sh
  cd ../../
  ./3rd/luamake/luamake rebuild

  SHELL_NAME=`basename $SHELL`
  SHELL_RC="./.${SHELL_NAME}rc"
  echo 'export PATH="${HOME}/.config/lsp/lua-language-server/bin:${PATH}"' >> $SHELL_RC
  source $SHELL_RC
  execute $SHELL_NAME
}

install_ranger() {
    sudo emerge -qav ranger atool elinks ffmpegthumbnailer highlight imagemagick libcaca mediainfo odt2txt perl-image-exiftool poppler w3m
}

# TODO: install rest of the dependencies
