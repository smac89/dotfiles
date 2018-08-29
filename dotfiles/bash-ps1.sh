#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time24h="\t"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
UserName='\u'
Jobs="\j"

export PS1="$BBlack$Time24h$Color_Off ($BBlue$PathShort$Color_Off)\n "\
'$(if [ $? = 0 ]; then \
    echo "'$Green' ✔'$Color_Off' ";
  else
    echo "'$Red' ✘'$Color_Off' ";
  fi)'\
'$(git status &> /dev/null;\
    # Test if we are on a git branch
    if [ $? -eq 0 ]; then
        name=$(git config user.name)
        # If the name does not exist, prompt the user for a name
        if [ -z "$name" ]; then
            read -p "git config user.name: " name

            # If the user specified empty name, use the local user name
            if [ -z "$name" ]; then
                name=${USER}
                echo -e "\\t* Name set to '$BIWhite'$name'$Color_Off'"
                echo -e "\\t* Set '$BYellow'name'$Color_Off' with the command: '$UYellow'git config user.name '"''"$Color_Off'"
            fi
            git config user.name ${name}
        fi

        email=$(git config user.email)
        # If the email does not exist, prompt the user for an email
        if [ -z "$email" ]; then
            read -p "git config user.email: " email

            # If the user specified empty email, use name + hostname
            # email=${name}@$(pcregrep -o1 ".*@(\w+\.\w+)" <(git config --get remote.origin.url))
            if [ -z "$email" ]; then
                email=${name}@$(hostname)
                echo -e "\\t* Email set to '$BIWhite'$email'$Color_Off'"
                echo -e "\\t* Set '$BYellow'email'$Color_Off' with the command: '$UYellow'git config user.email '"''"$Color_Off'"
            fi
            git config user.email ${email}
        fi
    else
        name=${USER}
    fi
    [ $EUID = 0 ] && echo "'$BIRed'$name'$Color_Off':" || echo "'$BIWhite'$name'$Color_Off':")'\
'$(git status &> /dev/null;\
    if [ $? -eq 0 ]; then
        if [[ `git status | egrep -o "nothing to commit"` = "nothing to commit" ]]; then
            echo -n "'$BIGreen'";
        elif [[ `git status | egrep -o "untracked files"` = "untracked files" ]]; then
            echo -n "'$BIRed'";
        else
            echo -n "'$BIYellow'";
        fi
        echo "`__git_ps1 " (%s branch)"`"
    fi)'\
'`echo "'$Color_Off' $"` '

## Cleanup
# Reset
unset Color_Off       # Text Reset

# Regular Colors
unset Black       # Black
unset Red         # Red
unset Green       # Green
unset Yellow      # Yellow
unset Blue        # Blue
unset Purple      # Purple
unset Cyan        # Cyan
unset White       # White

# Bold
unset BBlack      # Black
unset BRed        # Red
unset BGreen      # Green
unset BYellow     # Yellow
unset BBlue       # Blue
unset BPurple     # Purple
unset BCyan       # Cyan
unset BWhite      # White

# Underline
unset UBlack      # Black
unset URed        # Red
unset UGreen      # Green
unset UYellow     # Yellow
unset UBlue       # Blue
unset UPurple     # Purple
unset UCyan       # Cyan
unset UWhite      # White

# Background
unset On_Black      # Black
unset On_Red        # Red
unset On_Green      # Green
unset On_Yellow     # Yellow
unset On_Blue       # Blue
unset On_Purple     # Purple
unset On_Cyan       # Cyan
unset On_White      # White

# High Intensty
unset IBlack      # Black
unset IRed        # Red
unset IGreen      # Green
unset IYellow     # Yellow
unset IBlue       # Blue
unset IPurple     # Purple
unset ICyan       # Cyan
unset IWhite      # White

# Bold High Intensty
unset BIBlack     # Black
unset BIRed       # Red
unset BIGreen     # Green
unset BIYellow    # Yellow
unset BIBlue      # Blue
unset BIPurple    # Purple
unset BICyan      # Cyan
unset BIWhite     # White

# High Intensty backgrounds
unset On_IBlack  # Black
unset On_IRed    # Red
unset On_IGreen  # Green
unset On_IYellow # Yellow
unset On_IBlue   # Blue
unset On_IPurple # Purple
unset On_ICyan   # Cyan
unset On_IWhite  # White

# Various variables you might want for your PS1 prompt instead
unset Time12h
unset Time24h
unset Time12a
unset PathShort
unset PathFull
unset NewLine
unset UserName
unset Jobs
