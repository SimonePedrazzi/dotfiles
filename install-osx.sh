
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
brew install git

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


brew install awscli
brew install bat
brew install pyenv
brew install pyenv-virtualenv
brew install n
brew install neovim
brew install htop
brew install httpie
brew install postgresql
brew install the_silver_searcher
brew install tree
brew install zsh-completions
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting


brew cask install 1password
brew cask install alfred
brew cask install clipy
brew cask install datagrip
brew cask install docker
brew cask install evernote
brew cask install firefox
brew cask install google-chrome
brew cask install iterm2
brew cask install postman
brew cask install pycharm-ce
brew cask install spectacle
brew cask install spotify
brew cask install slack
brew cask install visual-studio-code
brew cask install vlc
brew cask install transmission


brew tap sqitchers/sqitch
brew install sqitch --with-postgres-support


# git
git config --global user.name "Simone Pedrazzi"
git config --global user.email "simone@igenius.ai"
git config --global color.ui true
git config --global core.editor "nano"
git config --global core.commentchar "%"


# ssh
ssh-keygen -t rsa -C "simone@igenius.ai" -b 4096 -N "" -f ~/.ssh/id_rsa


# pyenv
#   suggested packages
brew install openssl readline sqlite3 xz zlib
#   required if mojave or newer
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
#   add init command to zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
