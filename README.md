## Dotfiles

## Installation

```bash
git clone https://github.com/smac89/dotfiles.git
cd dotfiles
git submodule update
mkvirtualenv -a . -r dotdrop/requirements.txt -p /path/to/python3 DotFiles
echo 'alias dotdrop="$(realpath dotdrop.sh)"' >> $VIRTUAL_ENV/bin/postactivate
echo 'unalias dotdrop' >> $VIRTUAL_ENV/bin/postdeactivate
source postactivate
```

## Usage

See https://github.com/deadc0de6/dotdrop#usage
