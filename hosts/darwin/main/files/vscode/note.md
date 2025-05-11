```bash
code --list-extensions | jq -R -s -c 'split("\n")[:-1]' > ./extensions.json
```