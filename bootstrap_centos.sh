#!/bin/sh

PWD=$(pwd)
echo "Installing dependencies..."
sudo yum -y install zsh vim byobu clang-3.4.2 cmake valgrind fb-ycm-1.1

echo "Creating build directory..."
rm -rf build
mkdir build

export http_proxy=fwdproxy:8080
export https_proxy=fwdproxy:8080

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing z..."
cd ~/.oh-my-zsh
rm -rf z
git clone https://github.com/rupa/z.git
cd "${PWD}"

# Update zshrc
cp "${PWD}"/zshrc ~/.zshrc

echo "Installing spf13-vim..."
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
rm "${PWD}"/spf13-vim.sh
cp "${PWD}"/vimrc.local ~/.vimrc.local
cp "${PWD}"/vimrc.before.local ~/.vimrc.before.local
# Clean up vimviews to make changes effective
rm ~/.vimviews

# YCM
cd ~/.vim/bundle && rm -rf YouCompleteMe
ln -s /usr/share/vim/vim74/bundle/YouCompleteMe .

cd "${PWD}"

# Configure byobu
byobu-enable
