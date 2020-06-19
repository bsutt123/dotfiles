# install vim
apt-get update
apt-get install neovim
apt-get install python-neovim
apt-get install python3-neovim
apt-get install silversearcher-ag
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

cd ~
git clone https://github.com/bsutt123/dotfiles
mkdir .config
cd .config
mkdir nvim
cd nvim
cp ~/dotfiles/minimal-vim/vimrc ~/.config/nvim/init.vim
