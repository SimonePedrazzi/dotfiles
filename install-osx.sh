
# Inspired from https://hackernoon.com/personal-macos-workspace-setup-adf61869cd79

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap buo/cask-upgrade
brew tap caskroom/cask
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap homebrew/bundle
brew tap homebrew/core

brew upgrade && brew update

# git
brew install git
git config --global user.name "Simone Pedrazzi"
git config --global user.email "simone@igenius.ai"
git config --global color.ui true
git config --global core.editor "nano"
git config --global core.commentchar "%"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


brew install \
    awscli \
    bat \
    pyenv \
    pyenv-virtualenv \
    n \
    neovim \
    htop \
    httpie \
    postgresql \
    the_silver_searcher \
    tree \
    zsh-completions \
    zsh-autosuggestions \
    zsh-syntax-highlighting


brew cask install \
    1password \
    alfred \
    clipy \
    datagrip \
    docker \
    evernote \
    firefox \
    google-chrome \
    iterm2 \
    postman \
    pycharm-ce \
    spectacle \
    spotify \
    slack \
    visual-studio-code \
    vlc \
    transmission


# sqitch
brew tap sqitchers/sqitch
brew install sqitch --with-postgres-support
sqitch config --user user.name 'Simone Pedrazzi'
sqitch config --user user.email 'simone@igenius.ai'


# ssh
ssh-keygen -t rsa -C "simone@igenius.ai" -b 4096 -N "" -f ~/.ssh/id_rsa


# pyenv
#   suggested packages
brew install openssl readline sqlite3 xz zlib
#   required if mojave or newer
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
#   add init command to zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
