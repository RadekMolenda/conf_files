BBRed="\033[1;31m"         # Red
BBGreen="\033[1;32m"       # Green
PROMPT_COMMAND='RET=$?;'
RET_VALUE='$(echo $RET)' #Ret value not colorized - you can modify it.
RET_SMILEY='$(if [[ $RET = 0 ]]; then echo -ne "\[$BBGreen\];)"; else echo -ne "\[$BBRed\];("; fi;)'

PS1_END="\n$RET_VALUE $RET_SMILEY$BIWhite → $Color_Off"
export PS1=$IBlack$Time12h' \u at \h '$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$IRed'"$(__git_ps1 " {%s}"); \
  fi) '$BYellow$PathShort$Color_Off'"; \
else \
  # @2 - Prompt when not in GIT repo
  echo " '$Yellow$PathShort$Color_Off'"; \
fi)'$PS1_END

