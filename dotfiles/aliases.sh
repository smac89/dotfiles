alias joe='/usr/bin/joe -nobackups'
alias apt='/usr/bin/apt-fast'
alias egrep='egrep --color=auto'
alias multicd='multicd -i -v -m'
{%@@ if profile == 'home' @@%}
alias jython='TERM=xterm-color jython'

{%@@ elif profile == 'skip' @@%}
alias skip-search='egrep -RiIn --exclude-dir="target/" --exclude-dir=".idea/"'

{%@@ endif @@%}
