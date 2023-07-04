
# nvim-splitrun

Extremely simple plugin for running a command and displaying the output in a
new split. The command is run with `:terminal`, so colors are kept.

Focus is switched to the new buffer for easy copying, and `<Esc>` is bound to
close the temporary buffer, leaving no trace of it.

The intention is to create simple keybinds to run often repeated commands such
as `cargo test` or `npm run test`.

Usage example:

```
nnoremap <F5> :Splitrun cargo test<CR>
```
