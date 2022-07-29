# Dependencies


```
npm i -g pyright

go install github.com/nametake/golangci-lint-langserver@latest
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.42.1
go install github.com/go-delve/delve/cmd/dlv@latest

pip3 install debugpy

curl https://sh.rustup.rs -sSf | sh
cargo install beancount-language-server


# Linux
$ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
$ sudo dpkg -i ripgrep_13.0.0_amd64.deb

# Mac
brew install ripgrep
```

# Nerd Font Issue

Only needed at the local machine:

download nerd font:

```
$brew tap homebrew/cask-fonts
$brew install --cask font-hack-nerd-font
```

set iterm2 to use nerd font:

![image](https://user-images.githubusercontent.com/14134844/173153332-feb12a92-46e3-4134-882b-e4ef3cea9167.png)


