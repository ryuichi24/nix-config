```bash
code --list-extensions | jq -R -s -c 'split("\n")[:-1]' > ./extensions.json
```


## neovim vscode
https://zenn.dev/kakifl/articles/vscode-vim-to-neovim