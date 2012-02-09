# A collection of aliases that I use in bash
# NOTE: This must be included in .bash_profile: if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

# ========  SYSTEM ALIASES  =========

alias ls="ls -FG"

# ========  RUBY/RAILS ALIASES  =========

alias regem='rvm --force gemset empty && rm Gemfile.lock && gem install bundler && bundle'
alias sc="script/console"
alias ss="RUBYCOCOA_THREAD_HOOK_DISABLE=1 script/server --debugger"
alias rc="rails console"
alias rs="rails server thin --debugger"
alias be="bundle exec"
alias scss="sass --style=compact --watch public/stylesheets/scss:public/stylesheets"
alias screenie="cd ~/Library/Selenium/selenium-server-2.0b3 && java -jar selenium-server-standalone-2.0b3.jar"

# ========  GIT ALIASES  =========

alias staged="git diff --cached" # show difference between the HEAD and the index
alias unstaged="git diff" # show difference between working tree and the index
alias both="git diff HEAD" # show staged and unstaged changes (what would be committed with "git commit -a")
alias branch="git branch -av"

# ========  PROJECT ALIASES  =========
# Client Work
A='~/Clients/ClientA/Rails'
alias  projecta1="go_and_report ${A}/projecta1 1.9.2@projecta1"
alias  projecta2="go_and_report ${A}/projecta2 1.8.7@projecta2"

B="~/Clients/ClientB"
alias projectb1="go_and_report ${B}/projectb1"

# NOTE: these use the 'go_and_report' function, which takes a directory and an optional RVM call. Customize to your needs