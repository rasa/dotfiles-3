# Set base history settings, ie extended to include timestamps, don't trample
setopt histignorealldups sharehistory incappendhistorytime extendedhistory

# Keep many lines of history within the shell and save it to $ZDOTDIR/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$LOCAL_ZDOTDIR/history/history.$SHORT_HOSTNAME
mkdir -pv ${HISTFILE:h}
