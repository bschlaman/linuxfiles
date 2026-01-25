#!/bin/sh

# Check if running with bash
if [ -z "$BASH_VERSION" ]; then
    echo "Error: This script requires bash to run properly."
    echo "bash scripts/bootstrap.sh"
    exit 1
fi

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

# handle legacy ~/.profile separately
if [ -e "$HOME/.profile" ]; then
	read -rp "Found ~/.profile. Delete it? [y/N] " del_profile_response
	case "$del_profile_response" in
		[yY]|[yY][eE][sS])
			rm -v "$HOME/.profile"
			;;
		*)
			echo "Keeping existing ~/.profile"
			;;
	esac
else
	echo no ~/.profile found ✓
fi

# Show which dotfiles would be overwritten
echo -e "${BLD}Checking for existing dotfiles...${NC}"
overwrites=()
for dotfile in $DOTFILES ; do
	dest="$HOME/${dotfile}"
	[ -e "$dest" ] && overwrites+=("$dotfile")
done

if [ ${#overwrites[@]} -eq 0 ]; then
	echo "No existing dotfiles will be overwritten."
else
	echo "The following dotfiles already exist and will be overwritten:"
	for dotfile in "${overwrites[@]}"; do
		echo -e " - ${YEL}${dotfile}${NC}"
	done
fi

read -rp "Proceed with copying dotfiles? [y/N] " confirm
case "$confirm" in
	[yY]|[yY][eE][sS]) ;;
	*) echo "Aborting dotfile copy."; exit 0;;
esac

for dotfile in $DOTFILES ; do
	echo -e "copying dotfile [ ${YEL}${dotfile}${NC} ] to ~"
	cp -vr ../${dotfile} ~
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

function check_git() {
	if ! command -v git >/dev/null 2>&1; then
		echo -e "${RED}Error: git is required but not installed. Please install git first.${NC}"
		return 1
	fi
	return 0
}

# optional addons
echo -e "${BLD}Optional addons${NC}"
PS3=" > "
options="
gruvbox
vim-plug
tmux-plugin-manager
exit
"
select opt in $options ; do
	case $opt in
		"gruvbox")
			echo -e "${BLD}Installing gruvbox colorscheme...${NC}"
			curl -L -o ~/.vim/colors/gruvbox.vim --create-dirs https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim
			;;
		"vim-plug")
			curl -L -o ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			;;
		"tmux-plugin-manager")
			if ! check_git; then
				continue
			fi
			echo -e "${BLD}Installing tmux-plugin-manager...${NC}"
			git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
echo "sed -i 's/#FastConnectable = false/FastConnectable = true/' /etc/bluetooth/main.conf"

echo -e "${BLD}source ~/.bashrc${NC}"

popd > /dev/null
