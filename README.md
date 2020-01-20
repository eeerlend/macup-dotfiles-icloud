# macup-dotfiles-icloud

A [macup](https://github.com/eeerlend/macup-builder) module that keeps your dotfiles in sync through icloud drive

## Installation
Run the following command to add it to your repo

```bash
npm install eeerlend/macup-dotfiles-icloud
```

## Configuration
Dotfiles are added in the main config file (e.g. my.config)

```bash
macup_dotfiles_icloud+=(
  myfile
  myotherfile:644
  .ssh/config:644
  .ssh/my_private_key:600
)
```

The list follows the `filename:chmod` pattern. All filenames should be relative to your HOME directory, `$HOME/`
