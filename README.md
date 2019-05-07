# macup-dotfiles-icloud

A [macup](https://github.com/eeerlend/macup) module that keeps your dotfiles in sync through icloud drive

## Configuration
Add your dotfiles to your macup configuration file like this...

```bash
macup-dotfiles-icloud+=(
  myfile
  myotherfile:644
  .ssh/config:644
  .ssh/my_private_key:600
)
```

... following the `filename:chmod` pattern. All filenames should be relative to your HOME directory, `$HOME/`
