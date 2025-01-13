#!/bin/sh

ROOT="$(cd "$(dirname "$0")" &>/dev/null; pwd -P)"
echo ROOT: $ROOT
pushd $ROOT > /dev/null

# TODO: this script needs to be transformed into an update script, not just a
# bootstrap script.  This script shoudl allow me to sync my latest dotfiles
# keeping in mind limitations of the host OS

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
.aliases
.config
"
# TODO: add .bash_completion
# TODO: add file existence checks
for df in $DOTFILES ; do
	echo -e "copying dotfile [ ${YEL}${df}${NC} ] to ~"
	cp -vir ../${df} ~
done

# scripts
mkdir -pv ~/.bin
echo -e "${BLD}Copying scripts...${NC}"
SCRIPTS="
bh_backup.sh
randid
shuffle_keys
"
for s in $SCRIPTS ; do
	echo -e "copying script [ ${YEL}${s}${NC} ] to ~/.bin/"
	cp -vir $ROOT/${s} ~/.bin/
done

# vim
echo -e "${BLD}Creating vim directories...${NC}"
mkdir -pv ~/.vim/colors
mkdir -pv ~/.vim/pack/plugins/start
mkdir -pv ~/.vim/swap

# optional addons
echo -e "${BLD}Optional addons${NC}"
PS3=" > "
options="
gruvbox
vim-plug
exit
"
select opt in $options ; do
	case $opt in
		"gruvbox")
			mkdir tmp
			pushd tmp > /dev/null
			git clone --depth 1 https://github.com/morhetz/gruvbox.git
			cp ./gruvbox/colors/gruvbox.vim ~/.vim/colors/
			popd > /dev/null
			rm -rf ./tmp
			;;
		"vim-plug")
			curl -L -o ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			;;
		"exit") break;;
	esac
done

echo "writing PS1 to ~/.aliases"
echo 'export PS1="\[\e[34m\][\[\e[0m\]\[\e[37m\]\u\[\e[34m\]@\[\e[37m\]\h \[\e[35m\]\W\$(prompt_git \"\[\e[37m\] on \[\e[32m\]\")\[\e[34m\]]\[\e[37m\]$ \[\e[0m\]"' | tee -a ~/.aliases
# other programs
PROGRAMS="vim jq htop figlet git which ripgrep tmux"
# unfortunately, biber depends on perl
LATEX_PROGRAMS="texlive-latex texlive-latexrecommended texlive-latexextra texlive-basic texlive-binextra texlive-fontsrecommended texlive-fontsextra texlive-plaingeneric biber texlive-bibtexextra texlive-mathscience"
echo -e "You might want to install..."
echo -e "sudo pacman -Sy ${PROGRAMS}"
echo -e "sudo pacman -S ${LATEX_PROGRAMS}"

echo -e "${BLD}source ~/.bashrc${NC}"

popd > /dev/null
