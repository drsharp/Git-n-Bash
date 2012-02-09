# A collection of functions that I use in my bash scripts/aliases
# # NOTE: This must be included in .bash_profile: if [ -f ~/.bash_functions ]; then . ~/.bash_functions; fi

# generates a colored divider line. I use it in aliases, mostly
function line() { # line x y z  # => x=character, y=count, z=color (as a String)
	if [ "$1" ]; then CHAR=$1; else CHAR="-"; fi      # - is the default character
	if [ "$2" ]; then COUNT=$2; else COUNT=80; fi     # 80 is the default line width
	if [ "$3" ]; then COLOR=$3; else COLOR="Red"; fi  # Red is the default color
	EVALCOLOR=${!COLOR}
	printf ${EVALCOLOR}
	for (( i=0; i < $COUNT; i++ )); do printf $CHAR; done
	printf "${None}\n"
}
# Usage Example (escape chars that might otherwise confuse bash)
# [~]$ line \~ 50 White
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# shows current RVM info: ruby vesion | gemset
function print_rvm_info() {
	RUBY_VERSION=`rvm list | grep \=\> | awk -F" " '{print $2}'`
	GEMSET_NAME=`rvm gemset list | grep \=\> | awk -F" " '{print $2}'`
	if test "$RUBY_VERSION" = ""; then
		printf "${Yellow}no ruby/gemset set!${None}\n"
		# printf "\e[0;33mno ruby/gemset set!\e[0m\n"
	else
		if test "$GEMSET_NAME" = ""; then
			printf "${Green}RVM: ${Red}$RUBY_VERSION ${Yellow}| ${Yellow}no gemset${None}\n"
			# printf "\e[0;32mRVM: \e[0;31m$RUBY_VERSION \e[0;33m| \e[0;33m-none-${None}\n"
		else
			printf "${Green}RVM: ${Red}$RUBY_VERSION ${Green}| ${Red}$GEMSET_NAME${None}\n"
		fi
	fi
}

# parses out the current git branch
function parse_git_branch_and_add_brackets() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\(\1\)/'
}

# pushes the current branch to origin/branch
function push() {
	BRANCH=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	git push origin $BRANCH
}
# pushes (forced!) the current branch to origin/branch
function pushf() {
	BRANCH=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	git push -f origin $BRANCH
}
# removes current and remote branch, sanity check and skip for master
function clean() {
	BRANCH=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if test "$BRANCH" = "master"; then
		printf "Tsk Tsk! You cannot clean master!\n"
		return;
	fi
	read -p "Are you sure you want to remove branch '$BRANCH'? (y/n) " RESP
	case $RESP in
	    [yY]*) git checkout master;git push origin :heads/$BRANCH;git branch -D $BRANCH;printf "Branch '$BRANCH' has been cleaned.\n"
		    ;;
	    *) printf "Aborting clean. Keeping branch '$BRANCH'\n"
	esac
}

# Prints out a pretty version of git log. Optional param of # lines to show. defaults to 25
function glog() {
	if [ "$1" ]; then LINES=$1; else LINES="25"; fi      # - is the default character
	git --no-pager log --graph --pretty=format:'%Cred%h%Creset %C(yellow)%ad%Creset | %s %Cgreen[%an]%Creset' --abbrev-commit --date=short -$LINES
	printf "\n"
}

# prints a summary of git data for a repo.
function print_git_data() { # print_git_data 10 av # => 10 lines, use -av instead of -v
	if [ "$1" ]; then LINES=$1; else LINES="15"; fi # 15 is the default number of lines
	if [ "$2" ]; then BRANCH_VARS=$2; else BRANCH_VARS="v"; fi # v is the default git branch param
	line v 100 Blue
	glog $LINES
	line - 100 Blue
	git branch -$BRANCH_VARS
	line ^ 100 Blue
}

# cd's to a dir, sets rvm, prints info
function go_and_report() {
	if [ "$1" ]; then CD=$1; else CD="."; fi # "." is the default dir
	if [ "$2" ]; then RVM=$2; else RVM="system"; fi # "system" is the default rvm use call
	printf "\n\n\n\n" # four blank lines. To clear things
	printf "Loading data from: '$CD'...\n"
	cd $CD
	rvm $RVM
	print_git_data
	print_rvm_info
	printf "\n"
}
