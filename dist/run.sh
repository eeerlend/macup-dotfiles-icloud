#!/bin/bash

#### Package: macup/macup-dotfiles-icloud
#### Description: macup module that keeps your dotfiles in sync through icloud drive
function symlink_dotfile {
  local file=$1
  local chmod=$2
  local num_links=0
  local path_to_dotfiles="$HOME"/Library/Mobile\ Documents/com~apple~CloudDocs/.dotfiles
  local path_to_file=$(dirname $file)

  # Create dirs locally if neccesary
  if [ ! -d "$HOME"/"$path_to_file" ]; then
    report_from_package " the directory $path_to_file doesn't exist locally. Creating"
    mkdir -p "$HOME"/"$path_to_file"

    # Ensure .ssh dir is chmod'ed correctly
    if [ "$path_to_file" == ".ssh" ]; then
      chmod 700 "$path_to_file"
    fi
  fi
  
  # Detect if the file is a hard link
  if [ -f "$HOME"/"$file" ]; then
    num_links=$(stat -f "%l" $HOME/$file)
  fi

  # If the file doesn't exist as hard link in your system, we'll create a hard link to icloud
  if [ "$num_links" != "2" ]; then

    report_from_package "~/$file doesn't exist as hard link locally. Will create a hard link to iCloud"

    if [ -f "$HOME"/"$file" ]; then
      report_from_package "Removing static file $file"
      rm "$HOME"/"$file"
    fi

    if [ -f "$path_to_dotfiles"/"$file" ]; then
      ln "$path_to_dotfiles"/"$file" "$HOME"/"$file"
    else
      report_from_package "WARN: $file doesn't exist in iCloud. Skipping" 'yellow'
    fi
  else
    if [ ! -f "$path_to_dotfiles"/"$file" ]; then
      report_from_package "WARN: $file doesn't exist in iCloud. Removing" 'yellow'
      unlink "$HOME"/"$file"
    fi

    report_from_package "~/$file is already hard linked to iCloud"
  fi
  
  if [ -n "$chmod" ] && [ "$chmod" -eq "$chmod" ] 2>/dev/null; then
    if [ -L "$HOME"/"$file" ]; then
      report_from_package " chmod -h $chmod $HOME/$file"
      chmod $chmod "$HOME"/"$file"
    elif [ -f "$HOME"/"$file" ]; then
      report_from_package " chmod $chmod $HOME/$file"
      chmod $chmod "$HOME"/"$file"
    fi
  fi
}

if [ ! -L .dotfiles-in-icloud ]; then
  # Check if .dotfiles exist in iCloud drive
  if [ ! -d "$HOME"/Library/Mobile\ Documents/com~apple~CloudDocs/.dotfiles ]; then
    report_from_package "Creating .dotfiles directory in iCloud drive"
    mkdir "$HOME"/Library/Mobile\ Documents/com~apple~CloudDocs/.dotfiles
  else
    report_from_package ".dotfiles directory already exist in iCloud drive"
  fi

  report_from_package "Creating a local symlink to the iCloud dotfiles folder (.dotfiles-in-icloud)"
  ln -s "$HOME"/Library/Mobile\ Documents/com~apple~CloudDocs/.dotfiles .dotfiles-in-icloud
fi

if [ ${#macup_dotfiles_icloud[@]} -eq 0 ]; then
  report_from_package "No dotfiles to install. Addd files to the \$macup_dotfiles_icloud array" "yellow"
fi

for ((i=0; i<${#macup_dotfiles_icloud[@]}; ++i)); do
  file="$(echo "${macup_dotfiles_icloud[i]}" | cut -d':' -f1)"
  chmod="$(echo "${macup_dotfiles_icloud[i]}" | cut -d':' -f2)"

  symlink_dotfile $file $chmod
done
