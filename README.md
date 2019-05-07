# macup-dotfiles-icloud

A [macup](https://github.com/eeerlend/macup) module that keeps your dotfiles in sync through icloud drive

## Configuration
Add your dotfiles to your configuration, and this module will make sure to keep them in sync

```bash
macup-dotfiles-icloud+=(
  myfile
  myotherfile:644
  .ssh/config:644
  .ssh/my_private_key:600
)
```
