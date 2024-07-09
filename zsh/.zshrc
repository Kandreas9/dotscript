#Uncomment this line and the last line to enable zprof
#zmodload zsh/zprof

#Extend history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

export EDITOR="/usr/bin/nvim"

#Highlighting and pretty colors
autoload -Uz colors && colors

#https://gist.github.com/ctechols/ca1035271ad134841284
#https://carlosbecker.com/posts/speeding-up-zsh
autoload -Uz compinit

case $SYSTEM in
  Darwin)
    if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
      compinit;
    else
      compinit -C;
    fi
    ;;
esac

#Shell prompt
eval "$(starship init zsh)"

#Fzf shell integration
source <(fzf --zsh)

#Setup environment variables for fnm
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

export ZDOTDIR=$HOME/.config/zsh

#Loop through all .zsh files in dir and source them
for FILE in $ZDOTDIR/*.zsh
do
  source "$FILE"
done

if test ! -d "$ZDOTDIR/plugins/"
then
  mkdir $ZDOTDIR/plugins
fi

zusers="zsh-users"
#Currently this only works with zsh-users plugins if you try smthing else it will fail
for plugin in zsh-autosuggestions zsh-completions zsh-syntax-highlighting
do  
  if test ! -d "$ZDOTDIR/plugins/$plugin"
  then
    git clone https://github.com/${zusers}/${plugin} "${ZDOTDIR}/plugins/${plugin}" --depth 1
  fi

  source "$ZDOTDIR/plugins/${plugin}/${plugin}"*.zsh
done

#Uncomment this line and the first line to enable zprof
#zprof
