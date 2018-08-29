alias egrep='egrep --color=auto'
{%@@ if profile == 'home' @@%}
alias jython='TERM=xterm-color jython'

{%@@ elif profile == 'skip' @@%}
alias skip-search='egrep -RiIn --exclude-dir="target/" --exclude-dir=".idea/"'

{%@@ endif @@%}
