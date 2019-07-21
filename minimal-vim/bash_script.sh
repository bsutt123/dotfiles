# install vim
apt-get update
apt-get install vim
apt-get install silversearcher-ag

cd ~
git clone https://github.com/bsutt123/dotfiles
cp dotfiles/minimal-vim/vimrc ~/.vimrc
