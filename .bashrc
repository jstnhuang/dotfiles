# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Aliases
alias u='cd ..'
alias rmrf='rm -rf'
alias lsla='ls -la'
alias lslah='ls -lah'
alias p3='python3'
alias myprocs='ps -ef | grep "^jstn"'
alias vrc="vim ~/.bashrc"
alias reload="source ~/.bashrc"
alias fn='find -name'
alias k9='kill -9'
alias tn='tmux new -s'
alias ta='tmux attach-session -t'
alias tk='tmux kill-session -t'
alias st='git status'
alias com='git commit -m'
alias coma='git commit -am'
alias br='git branch'
alias brd='git branch -d'
alias dty='git difftool -y'
alias co='git checkout'
alias cob='git checkout -b'
alias ga='git add'
alias gd='git diff'
alias gid='git icdiff'

set_upstream() {
  git branch --set-upstream-to=$1/$2 $2
}
gfh() {
  grep -ri $1 *;
}
vfn() {
  vim `find -name $1`
}
ros_logs() {
  cd ~/.ros/log/`rosparam get run_id`
}

# Terminal prompt formatting.
#PS1='\[\e[1;35m\][\h \w]$ \[\e[m\]'
PS1='\[\e[1;35m\][$ROS_WS \h \w]$ \[\e[m\]'

# vi mode
export VISUAL=vim
set -o vi

# Call setros groovy or setros hydro to source the appropriate environment.
function setros() {
  source /opt/ros/$1/setup.bash
  source ~/catkin_ws_$1/devel/setup.bash --extend
}
source /opt/ros/indigo/setup.bash # Run setup commands for ROS stuff.
#source ~/catkin_ws_indigo/devel/setup.bash --extend

function setws() {
  if [ "$1" = "catkin" ]; then
    source ~/catkin_ws_indigo/devel/setup.bash
    export ROS_WS=catkin
  else 
    source ~/$1_ws/devel/setup.bash
    export ROS_WS=$1
  fi
}

function addws() {
  source ~/$1_ws/devel/setup.bash
  export ROS_WS=$ROS_WS:$1
}

export ROS_HOSTNAME=olivaw # Optional, the name of this computer.
export ROS_MASTER_URI=http://localhost:11311 # The location of the ROS master.
export ROBOT=sim # The type of robot.
export ROSCONSOLE_FORMAT='${time} ${node} ${function}:${line}: ${message}'
export ROS_WS=.
export KINECT1=true

# Get IP address on ethernet
# If you're on a laptop, change eth0 to wlan0
function my_ip() {
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function setrobot() {
  if [ "$1" = "sim" ]; then
    export ROS_HOSTNAME=olivaw;
    export ROS_MASTER_HOST=olivaw;
    export ROS_MASTER_URI=http://olivaw:11311;
    export ROBOT=sim;
  elif [ "$1" = "c1" ]; then
    unset ROBOT;
    unset ROS_HOSTNAME;
    export ROS_MASTER_HOST=$1;
    export ROS_MASTER_URI=http://mayarobot-wired:11311;
    export ROS_IP=`my_ip`;
  elif [ "$1" = "astro" ]; then
    unset ROBOT;
    unset ROS_HOSTNAME;
    export ROS_MASTER_HOST=$1;
    export ROS_MASTER_URI=http://$1:11311;
    export ROS_IP=`my_ip`;
  elif [ "$1" = "mayarobot-wired" ]; then
    unset ROBOT;
    unset ROS_HOSTNAME;
    export ROS_MASTER_HOST=c1;
    export ROS_MASTER_URI=http://mayarobot-wired:11311;
    export ROS_IP=`my_ip`;
  else
    unset ROBOT;
    unset ROS_HOSTNAME;
    export ROS_MASTER_HOST=$1;
    export ROS_MASTER_URI=http://$1.cs.washington.edu:11311;
    export ROS_IP=`my_ip`;
  fi
}

function hostrobot() {
  export ROS_HOSTNAME=olivaw.cs.washington.edu
  export ROS_MASTER_URI=http://olivaw.cs.washington.edu:11311
  export DISPLAY=:0
  export ROS_IP=`my_ip`
  export ROBOT=sim
}

export TURTLEBOT_GAZEBO_WORLD_FILE="/opt/ros/indigo/share/turtlebot_gazebo/worlds/playground.world"

# Go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Clang-format
export PATH=$PATH:/home/jstn/local/clang+llvm-6.0.0-x86_64-linux-gnu-ubuntu-14.04/bin

# Custom scripts
export PATH=$PATH:~/scripts

# icdiff
export PATH=$PATH:/home/jstn/local/icdiff

# Caddy
export PATH=$PATH:/home/jstn/local/caddy

# Cuda
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64"
export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=/usr/local/cuda

# Tracking project: source tensorflow
function setvenv() {
  source /home/jstn/venvs/$1/bin/activate
}

# Caffe
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/atlas-base"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/caffe/lib"

function getdeps() {
  rosdep install --from-paths src --ignore-src --rosdistro=$ROS_DISTRO -y
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# added by travis gem
[ -f /home/jstn/.travis/travis.sh ] && source /home/jstn/.travis/travis.sh
