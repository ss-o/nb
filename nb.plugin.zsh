#!/usr/bin/env zsh

0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

typeset -gA Plugins
Plugins[NB_DIR]="${0:h}"
Plugins[NB_FUNC]="${0:h}/functions"
Plugins[NB_COMP]="${0:h}/functions/_nb"

if [[ ! -d $Plugins[NB_FUNC] ]]; then
  mkdir -p $Plugins[NB_FUNC]
fi

if [[ ! -f $Plugins[NB_COMP] ]]; then
  cp -u "${Plugins[NB_DIR]}/etc/nb-completion.zsh" "$Plugins[NB_COMP]"
fi

if [[ $PMSPEC != *f* ]]; then
  fpath+=("$Plugins[NB_FUNC]")
fi

#no-op placeholder for Bash `shopt`.
shopt() { :; }

nb() {
  "${Plugins[NB_DIR]}"/"nb" "$@"
}
