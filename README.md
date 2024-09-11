> With the help of ChatGPT, I went from having no knowledge of Neovim plugins to being able to write all the code and README.

# GithubLink

GithubLink is a small plugin that generate a sharable GitHub link, it works for both single line or a range of lines.

## Installation

To install GithubLink, you can use your preferred plugin manager for Neovim. Here's an example using the `packer.nvim` plugin manager:

```lua
use {
    "vincent178/nvim-github-linker",
    cmd = "GithubLink",
    config = function()
        require("nvim-github-linker").setup()
    end,
}
```

## Usage

Once GithubLink is installed, you can use it by running the :GithubLink command in Normal mode, or by using the : command in Visual mode to select a range of code and generate a link.

To customize the behavior of GithubLink, you can pass options to the setup() function. Here's an example:

```lua
require("nvim-github-linker").setup({
    mappings = true,
    default_remote = "origin",
    copy_to_clipboard = true,
})
```

* mappings: If set to true, GithubLink will create default mappings for the `:GithubLink` command in Normal mode and the : command in Visual mode. Default value is true.
* default_remote: The default Git remote to use when generating links. Default value is "origin".
* copy_to_clipboard: If set to true, GithubLink will copy the generated link to the system clipboard. Default value is true.

## Test

```bash
$ make
```

## License
GithubLink is released under the MIT license. See the LICENSE file for more details.

