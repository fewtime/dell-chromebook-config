source /usr/share/zsh/share/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle archlinux
antigen bundle copyfile
antigen bundle docker
antigen bundle docker-compose
antigen bundle encode64
antigen bundle systemd
antigen bundle tig
antigen bundle tmux
antigen bundle vi-mode
antigen bundle z
antigen bundle history-substring-search
antigen bundle fzf
antigen bundle extract
antigen bundle command-not-found

# Syntax highlighting bundle.
# antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle zsh-users/zsh-apple-touchbar

# wakatime
antigen bundle wbingli/zsh-wakatime

# Load the theme.
antigen theme ys
# antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# Tell Antigen that you're done.
antigen apply

# User config
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export EDITOR='vim'

alias telegram="proxychains telegram-cli"
alias emacs="proxychains emacs -nw"
alias rm="trash"
alias ym="mpsyt"
alias folder-size="du -h --max-depth=1"
alias yv='mpv --ytdl-raw-options-append=proxy=http://127.0.0.1:8118 --ytdl-format="bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]" $1'
alias yvb='mpv --ytdl-raw-options-append=proxy=http://127.0.0.1:8118 --ytdl-format="bestvideo[ext=mp4]+bestaudio/best" $1'
alias yvm='mpv --no-video --ytdl-raw-options-append=proxy=http://127.0.0.1:8118 --ytdl-format="bestvideo[ext=mp4][height<=?1080]+bestaudio/best" $1'

# proxy
export all_proxy='http://127.0.0.1:8118'
# export ALL_PROXY='socks5://127.0.0.1:1103'

# fuck
eval $(thefuck --alias)

export http_proxy="http://127.0.0.1:8118/"
export ftp_proxy="ftp://127.0.0.1:8118/"
export rsync_proxy="rsync://127.0.0.1:8118/"
export no_proxy="localhost,127.0.0.1,192.168.1.1,::1,*.local"
export HTTP_PROXY="http://127.0.0.1:8118/"
export FTP_PROXY="ftp://127.0.0.1:8118/"
export RSYNC_PROXY="rsync://127.0.0.1:8118/"
export NO_PROXY="localhost,127.0.0.1,192.168.1.1,::1,*.local"
export https_proxy="http://127.0.0.1:8118/"
export HTTPS_PROXY="http://127.0.0.1:8118/"
