case $(tty) in
/dev/tty1|/dev/pts/0)
  clear && watch -n 3 -d --no-title cat /root/status.txt
  clear;;
esac


[[ -f ~/.bashrc ]] && . ~/.bashrc
