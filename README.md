
# nvim-splitrun

The super simple command runner plugin I've always wanted.

![Screenshot](.github/screenshots/example.png)

Runs a command and displays the output in a scratch buffer in a new split. The
split direction is automatically selected based on where you have the most
room.

The command is run with `:terminal`, so terminal colors work as you would
expect.

Keyboard focus is moved to the new window for convenient scrolling and yanking.
The `<Esc>` key is automatically bound to close the split, leaving no trace of
the temporary buffer.

The intention is to create simple keybinds to run often repeated commands such
as `cargo test` or `npm run test`.

Usage example:

```
nnoremap <F5> :Splitrun cargo test<CR>
```

## Installation

Installs like any other Neovim plugin.

Example installation with Lazy:

```lua
{
  "Hubro/nvim-splitrun",
  opts = {},
},
```
