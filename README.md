# macup-dotfiles-icloud

NOTE! This package is replaced with [macup-dotfiles-cloud](https://github.com/eeerlend/macup-dotfiles-cloud), to support more cloud methods

A [macup](https://github.com/eeerlend/macup-builder) module that keeps your dotfiles in sync through icloud drive

## Installation
Run the following command to add it to your repo

```bash
npm install eeerlend/macup-dotfiles-icloud --save
```

## Configuration
Add your dotfiles to your macup configuration file like this...

```bash
macup_dotfiles_icloud+=(
  myfile
  myotherfile:644
  .ssh/config:644
  .ssh/my_private_key:600
)
```

... following the `filename:chmod` pattern. All filenames should be relative to your HOME directory, `$HOME/`
