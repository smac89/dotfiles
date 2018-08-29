USER_SHELL="$1"
echo "$USER_SHELL"

PREFIX='sh'
if [ "$USER_SHELL" = 'bash' ]; then
	PREFIX='bash'
elif [ "$USER_SHELL" = 'zsh' ]; then
	PREFIX='zsh'
fi

for file in ~/.aliases ~/.functions; do
	if [ -f "$file" ]; then
		mv "$file" "$file.$PREFIX"
	fi
done
