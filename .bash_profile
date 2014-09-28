# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

unset file

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# >------------ Extras ------------ < 
# Terminal colours (after installing GNU coreutils)
NM="\[\033[0;0m\]" #means no background and white lines
HI="\[\033[0;34m\]" #change this for letter colors
HII="\[\033[0;34m\]" #change this for letter colors
SI="\[\033[0;33m\]" #this is for the current directory
AI="\[\033[0;32m\]" #this is for the current directory
IN="\[\033[0m\]"

#export PS1="$NM[ $HI\u$AI@$HII\h $SI\w$NM ] $IN$ "
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion # for RVM completion

if [ -f /usr/share/git-core/git-completion.bash ] ; then
  GIT_COMPLETION=/usr/share/git-core/git-completion.bash
elif [ -f ~/.git-completion.sh ] ; then
  GIT_COMPLETION=~/.git-completion.sh
elif [ -f ~/.git-completion.bash ] ; then
  GIT_COMPLETION=~/.git-completion.bash
fi
source $GIT_COMPLETION

#export PS1="${USER} : \[\033[01;34m\]\$(~/.rvm/bin/rvm-prompt) \[\033[01;32m\]\w\[\033[00;33m\]\$(__git_ps1 \" (%s)\") \[\033[01;36m\]\$\[\033[00m\] "
history -a

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
BASH_VER=$(bash --version | head -1 | awk '{ print $4 }' | grep -E \^4)
if [ -n $BASH_VER ] ; then
  for option in autocd globstar; do
  	shopt -s "$option" 2> /dev/null
  done
fi

