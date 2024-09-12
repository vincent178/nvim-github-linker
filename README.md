> With the help of ChatGPT, I went from having no knowledge of Neovim plugins to being able to write all the code and README.

# GithubLink

GithubLink is a small plugin that generate a sharable GitHub link, it works for both single line or a range of lines.

## Installation

To install GithubLink, you can use your preferred plugin manager for Neovim. Here's an example with [vim-plug](https://github.com/junegunn/vim-plug):

```lua
local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- your other plugins
Plug("vincent178/nvim-github-linker")

vim.call('plug#end')

require("nvim-github-linker").setup()
```

## Usage

Once GithubLink is installed, you can use it by running the `:GithubLink` command in Normal mode or Visual mode to generate the Github link.

## Test

This section is for plugin developer, GithubLink use [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) to test. If you already installed plenary, you can run tests via command `:PlenaryBustedDirectory tests`. You can also run tests standalone via `make test` or `make` for short.

## License
GithubLink is released under the MIT license. See the LICENSE file for more details.

