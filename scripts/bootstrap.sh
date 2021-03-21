#!/bin/sh

ROOT="$(cd "$(dirname "$0")" &>/dev/null; pwd -P)"
echo ROOT: $ROOT
pushd $ROOT

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
"
for df in $DOTFILES ; do
echo -e "copying dotfile [ ${YEL}${df}${NC} ] to ~"
cp -v ../${df} ~
done

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
				pushd tmp
				git clone https://github.com/morhetz/gruvbox.git
				cp ./colors/gruvbox.vim ~/.vim/colors/
				popd
				rm -r ./tmp
				;;
		"vim-go")
			git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
			;;
		"exit") break;;
	esac
done

# other programs
PROGRAMS="vim jq htop"
echo -e "You might want to install..."
echo -e "sudo pacman -Sy ${PROGRAMS}"

popd
