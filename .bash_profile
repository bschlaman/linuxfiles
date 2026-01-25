# ~/.bash_profile
case $- in
  *i*) [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc" ;;
esac