# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# colors thingy
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)
# Regular Colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

PS1='${purple}\u${reset} @ ${blue}\h${reset} => ${green}\w${reset}\n\$ '

# history size
HISTSIZE=50000
HISTFILESIZE=1000000

# ignore duplicates
export HISTCONTROL="$HISTCONTROL erasedups:ignoreboth"

# avoid accidental file overwrites
rm() { command rm -i "${@}"; }
cp() { command cp -i "${@}"; }
mv() { command mv -i "${@}"; }

# onefetch
LAST_REPO=""

cd() {
	builtin cd "$@"
	git rev-parse 2>/dev/null

	if [ $? -eq 0 ]; then
		if [ "$LAST_REPO" != $(basename $(git rev-parse --show-toplevel)) ]; then
			onefetch
			LAST_REPO=$(basename $(git rev-parse --show-toplevel))
		fi
	fi
}

# mkdir and cd
nwdir() { command mkdir "${@}" && cd $_;}

# git stuff
gtcl() { command git clone "${1}" && cd "$(basename "${1}" .git)"; }
gtph() { command git push; }
gtpl() { command git pull; }
gtbr() { command git branch; }
gtco() { command git checkout "${@}"; }
gtcob() { command git checkout -b "${@}"; }
gtcm() { command git commit -S -m "${@}"; }
gtrb() { command git rebase -i HEAD~"${@}"; }
gtst() { command git stash; }
gtsp() { command git stash pop; }

# path
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH

# vars
export EDITOR=nvim
export CHROME_EXECUTABLE=google-chrome-stable
export LANG=en_US.UTF-8

#exec > >(lolcat -F 0.3)

# Aliases:
alias neofetch="neofetch --cpu_temp C"
alias etcup="sudo etc-update"
alias portageconf="sudo ${EDITOR} /etc/portage/make.conf"
alias pp="gping gentoo.org" #ping -c4 gentoo.org"
alias vmconf="sudo modprobe -a vsock vmci vmmon vmnet && sudo rc-service vmware start && sudo rc-service vmware-workstation-server start && sudo /usr/bin/vmware-usbarbitrator"
alias esync="sudo emerge-webrsync && sudo emerge --sync"
alias update="sudo emerge -avNDu @world"
alias mocp="padsp mocp -m ~/General/Lithium/"
alias ff="find . -type f | fzf"
alias ls='ls --color=auto'
alias cp="cp -v"
alias mv="mv -v"
alias plz="sudo"
alias winep="DRI_PRIME=1 wine"
alias wine64p="DRI_PRIME=1 wine64"
alias svim="sudo ${EDITOR}"
alias ls="ls --color=auto"
alias pa="pulseaudio --daemonize=no --exit-idle-time=-1"
alias ssh='TERM=xterm-256color ssh'
alias dive="docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"

# rust replacements
alias ls="exa" # yay exa :)
alias grep="rg" # ripgrep
alias cat="bat"
alias catt="cat"

. "$HOME/.cargo/env"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# dracula tty
if [ "$TERM" = "linux" ]; then
	printf %b '\e[40m' '\e[8]' # set default background to color 0 'dracula-bg'
	printf %b '\e[37m' '\e[8]' # set default foreground to color 7 'dracula-fg'
	printf %b '\e]P0282a36'    # redefine 'black'          as 'dracula-bg'
	printf %b '\e]P86272a4'    # redefine 'bright-black'   as 'dracula-comment'
	printf %b '\e]P1ff5555'    # redefine 'red'            as 'dracula-red'
	printf %b '\e]P9ff7777'    # redefine 'bright-red'     as '#ff7777'
	printf %b '\e]P250fa7b'    # redefine 'green'          as 'dracula-green'
	printf %b '\e]PA70fa9b'    # redefine 'bright-green'   as '#70fa9b'
	printf %b '\e]P3f1fa8c'    # redefine 'brown'          as 'dracula-yellow'
	printf %b '\e]PBffb86c'    # redefine 'bright-brown'   as 'dracula-orange'
	printf %b '\e]P4bd93f9'    # redefine 'blue'           as 'dracula-purple'
	printf %b '\e]PCcfa9ff'    # redefine 'bright-blue'    as '#cfa9ff'
	printf %b '\e]P5ff79c6'    # redefine 'magenta'        as 'dracula-pink'
	printf %b '\e]PDff88e8'    # redefine 'bright-magenta' as '#ff88e8'
	printf %b '\e]P68be9fd'    # redefine 'cyan'           as 'dracula-cyan'
	printf %b '\e]PE97e2ff'    # redefine 'bright-cyan'    as '#97e2ff'
	printf %b '\e]P7f8f8f2'    # redefine 'white'          as 'dracula-fg'
	printf %b '\e]PFffffff'    # redefine 'bright-white'   as '#ffffff'
	clear
fi
