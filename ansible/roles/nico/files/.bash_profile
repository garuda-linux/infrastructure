# .bash_profile for servers
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Watch motd
sleep 3

# Autostart Tmux
if [ "$SSH_CLIENT" != "" ]; then
  exec tmux
fi
