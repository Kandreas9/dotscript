#Run this func to update the zsh plugins
zshup() {
  for DIR in $ZDOTDIR/plugins/*
  do
    cd $DIR
    git pull
  done
}

