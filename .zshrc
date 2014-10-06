# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
setopt share_history
autoload -U compinit
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
compinit
setopt prompt_subst

alias ll=ls -al

stty stop undef
#export LANG=ja_JP.eucJP
RPROMPT='[%~]'
SPROMPT="%r is correct? [n,y,a,e]: " 
#export EDITOR=vi
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'    
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'

export EDITOR=vi

bindkey -e

if [ -f ~/.zshlocal ]; then
	source ~/.zshlocal
fi


case $TERM in
    screen)
        preexec() {
            echo -ne "\ek$1\e\\"
        }
        precmd() {
            echo -ne "\ek$(basename $SHELL)\e\\"
            vcs_info
    }
        ;;
    *)
        precmd() {
            vcs_info
	}
        ;;
esac

PROMPT='[${vcs_info_msg_0_}]:%(!.#.$) '   
