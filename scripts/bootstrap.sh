#!/bin/sh

ROOT="$(cd "$(dirname "$0")" &>/dev/null; pwd -P)"
echo ROOT: $ROOT
pushd $ROOT > /dev/null

# dependencies
[ -f ./colors.sh ] && source ./colors.sh

# dotfiles
echo -e "${BLD}Copying dotfiles...${NC}"
DOTFILES="
.profile
.bash_profile
.bashrc
.bash_prompt
.vimrc
.tmux.conf
"
for df in $DOTFILES ; do
	echo -e "copying dotfile [ ${YEL}${df}${NC} ] to ~"
	cp -v ../${df} ~
done

mkdir -pv ~/.bin

# vim
echo -e "${BLD}Creating vim directories...${NC}"
mkdir -pv ~/.vim/colors
mkdir -pv ~/.vim/pack/plugins/start/

# optional addons
echo -e "${BLD}Optional addons${NC}"
PS3=" > "
options="
gruvbox
vim-go
exit
"
select opt in $options ; do
	case $opt in
		"gruvbox")
			mkdir tmp
			pushd tmp > /dev/null
			git clone https://github.com/morhetz/gruvbox.git
			cp ./gruvbox/colors/gruvbox.vim ~/.vim/colors/
			popd > /dev/null
			rm -rf ./tmp
			;;
		"vim-go")
			git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
			;;
		"exit") break;;
	esac
done

# other programs
echo 'export PS1="\[\e[34m\][\[\e[0m\]\[\e[37m\]\u\[\e[34m\]@\[\e[37m\]\h \[\e[35m\]\W\$(prompt_git \"\[\e[37m\] on \[\e[32m\]\")\[\e[34m\]]\[\e[37m\]$ \[\e[0m\]"' >> ~/.aliases
PROGRAMS="vim jq htop"
echo -e "You might want to install..."
echo -e "sudo pacman -Sy ${PROGRAMS}"

echo -e "${BLD}source ~/.bashrc${NC}"

popd > /dev/null
