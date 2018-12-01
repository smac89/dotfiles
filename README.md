## Dotfiles

## Installation

```bash
git clone https://github.com/smac89/dotfiles.git
cd dotfiles
git submodule update
mkvirtualenv -a . -r dotdrop/requirements.txt -p /path/to/python3 dotfiles
cat >> $VIRTUAL_ENV/bin/postactivate <<'EOF'
VIRTUAL_ENV_PROJECT="$(cat $VIRTUAL_ENV/.project)"
alias dotdrop="$VIRTUAL_ENV_PROJECT/dotdrop.sh --verbose"
EOF
echo 'unalias dotdrop' >> $VIRTUAL_ENV/bin/postdeactivate
source postactivate
```

## Usage

See https://github.com/deadc0de6/dotdrop#usage
