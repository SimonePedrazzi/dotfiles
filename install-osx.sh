
main() {
    # Bootstrap script for setting up a new OSX machine
    # This should be idempotent so it can be run multiple times.
    # 
    # inspired from https://gist.github.com/codeinthehole/26b37efa67041e1307db

    # TODO: see colors here https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

    echo "Starting bootstrapping"


    # Check for Homebrew, install if we don't have it
    if test ! $(which brew); then
        echo "Installing homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Update homebrew recipes
    brew update


    # Install Oh My Zsh if it isn't already present
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
        echo "Installing Oh My Zsh..."
        # 'sed' command at the end should prevent the auto-switch to zsh shell
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) | sed '/\s*env\s\s*zsh\s*/d')"
    fi


    # Install GNU core utilities (those that come with OS X are outdated)
    brew tap homebrew/dupes
    brew install coreutils
    brew install gnu-sed --with-default-names
    brew install gnu-tar --with-default-names
    brew install gnu-indent --with-default-names
    brew install gnu-which --with-default-names
    brew install gnu-grep --with-default-names


    # NOTES:
    #  - bash: for Bash 4
    #  - findutils: installs GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
    PACKAGES=(
        awscli
        bat
        bash
        findutils
        pyenv
        pyenv-virtualenv
        n
        neovim
        git
        htop
        httpie
        postgresql
        the_silver_searcher
        tree
        zsh-completions
        zsh-autosuggestions
        zsh-syntax-highlighting
    )

    echo "Installing packages..."
    brew install ${PACKAGES[@]}


    echo "Tapping cask..."
    brew tap caskroom/cask

    CASKS=(
        1password
        alfred
        clipy
        datagrip
        docker
        evernote
        firefox
        google-chrome
        iterm2
        parallels
        postman
        pycharm-ce
        spectacle
        spotify
        slack
        visual-studio-code
        vlc
        transmission
    )

    echo "Installing cask apps..."
    brew cask install ${CASKS[@]}


    echo "Installing fonts..."
    brew tap caskroom/fonts
    FONTS=(
        font-inconsolidata
        font-roboto
        font-clear-sans
    )
    brew cask install ${FONTS[@]}



    echo "Configuring git..."
    git config --global user.name "Simone Pedrazzi"
    git config --global user.email "simone@igenius.ai"
    git config --global color.ui true
    git config --global core.editor "nano"
    git config --global core.commentchar "%"



    echo "Generating ssh key..."
    ssh-keygen -t rsa -C "simone@igenius.ai" -b 4096 -N "" -f ~/.ssh/id_rsa
    echo "created under ~/.ssh"
    echo "use 'cat ~/.ssh/id_rsa.pub | pbcopy' to copy it to the clipboard"



    echo "Installing sqitch..."
    brew tap sqitchers/sqitch
    brew install sqitch --with-postgres-support
    sqitch config --user user.name 'Simone Pedrazzi'
    sqitch config --user user.email 'simone@igenius.ai'



    echo "Configuring pyenv..."
    # suggested packages
    brew install openssl readline sqlite3 xz zlib
    # required if mojave or newer
    sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
    # add init command to .zshrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc




    echo "Configuring OSX..."

    # Set fast key repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 0

    # Require password as soon as screensaver or sleep mode starts
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # Show filename extensions by default
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Disable "natural" scroll
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false


    echo "Cleaning up brew..."
    brew cleanup


    echo "Bootstrapping complete!!"
    # TODO: echo "After you click any button the shell will be switched to zsh"
    # env zsh -l
    # source ~/.zshrc
}

main
