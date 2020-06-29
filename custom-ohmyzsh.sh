#!/bin/bash

if [[ -z "$ZSH" ]]; then
    echo "还未安装oh-my-zsh!"
    exit 1
fi

os=`uname`

cp "$ZSH/themes/robbyrussell.zsh-theme" "$ZSH/custom/themes/robbyrussell.zsh-theme"

if [ "$os" == "Darwin" ]; then
    # mac os x的sed命令-i选项与Linux的不太一样
    sed -i '.bak' 's/^PROMPT.*$//' $ZSH/custom/themes/robbyrussell.zsh-theme 1>/dev/null
elif [ "$os" == "Linux" ]; then
    sed -i 's/^PROMPT.*$//' $ZSH/custom/themes/robbyrussell.zsh-theme 1>/dev/null
else
    echo "NOT SUPPORT OS:${os}"
    exit 1
fi

echo "" >> $ZSH/custom/themes/robbyrussell.zsh-theme

(cat <<EOF
PROMPT='%{\$fg_bold[white]%}%M %{\$fg_bold[red]%}➜ %{\$fg_bold[green]%}%p %{\$fg[cyan]%}%c %{\$fg_bold[blue]%}\$(git_prompt_info)%{\$fg_bold[blue]%} % %{\$reset_color%}'
#PROMPT='%(!.%{%F{yellow}%}.)\$USER @ %{\$fg[white]%}%M %{\$fg_bold[red]%}➜ %{\$fg_bold[green]%}%p %{\$fg[cyan]%}%c %{\$fg_bold[blue]%}\$(git_prompt_info)%{\$fg_bold[blue]%} % %{\$reset_color%}'
EOF
) >> $ZSH/custom/themes/robbyrussell.zsh-theme
