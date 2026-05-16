# Neovim Keymaps Cheatsheet

Leader key: `Space`

---

## Motion — Character & Line

| Key | Action |
|-----|--------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `^` | First non-blank character of line |
| `$` | End of line |
| `0` | Start of line (column 0) |
| `gg` | First line of file |
| `G` | Last line of file |
| `{N}G` | Go to line N |
| `{` | Jump to top next blank line |
| `}` | Jump to bottom next blank line |

---

## Motion — Word

| Key | Action |
|-----|--------|
| `w` | Next word start |
| `b` | Previous word start |
| `e` | Next word end |
| `W` `B` `E` | Same but WORD (whitespace-delimited) |

---

## Motion — Search & Repeat

| Key | Action |
|-----|--------|
| `f{c}` | Jump to next `c` on line |
| `F{c}` | Jump to prev `c` on line |
| `t{c}` | Jump before next `c` on line |
| `T{c}` | Jump before prev `c` on line |
| `;` | Repeat last `f/F/t/T` forward |
| `,` | Repeat last `f/F/t/T` backward |
| `/{pattern}` | Search forward |
| `?{pattern}` | Search backward |
| `n` | Next search match |
| `N` | Previous search match |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |

---

## Motion — Flash (folke/flash.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `s` | Normal / Visual / Operator | Flash jump — type a search label to teleport anywhere on screen |

---

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover docs / function signature |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>ch` | Toggle inlay hints |
| `<leader>ca` | Code action (fix available) |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Show diagnostic |


---

## Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `<Tab>` | Select next item |
| `<S-Tab>` | Select previous item |
| `<Ctrl-Enter>` | Accept selected item |
| `<Ctrl-l>` | Next snippet value |

---

## Clipboard

| Key | Mode | Action |
|-----|------|--------|
| `gy` | Normal / Visual | Copy to system clipboard |
| `gp` | Normal / Visual | Paste from system clipboard (after) |
| `gP` | Normal / Visual | Paste from system clipboard (before) |

---

## Editing

| Key | Mode | Action |
|-----|------|--------|
| `<Alt-j>` | Normal / Visual | Move line / selection down |
| `<Alt-k>` | Normal / Visual | Move line / selection up |
| `<Tab>` | Normal | Indent line |
| `<S-Tab>` | Normal | Unindent line |
| `<Tab>` | Visual | Indent selection (keeps selection) |
| `<S-Tab>` | Visual | Unindent selection (keeps selection) |
| `<S-Tab>` | Insert | Unindent |
| `u` | Normal | Undo |
| `<C-r>` | Normal | Redo |
| `.` | Normal | Repeat last change |

---

## Selection

| Key | Action |
|-----|--------|
| `<leader>a` | Select entire file (`ggVG`) |
| `v` | Enter visual (character) mode |
| `V` | Enter visual line mode |
| `<C-v>` | Enter visual block mode |

---

## File Explorer (mini.files & telescope)

| Key | Action |
|-----|--------|
| `<leader>e` | Open MiniFiles (root) |
| `<leader>E` | Open MiniFiles at current buffer's directory |
| `<leader>ff` | Open list of files in git directory or root folder |
| `<leader>fF` | Open list of files at root folder |
| `<leader>fb` | Open list of open buffers |
| `<leader>fg` | Open list of grep results |
| `<leader>fn` | Open notification history |
| `<leader>fd` | Open workspace diagnostics |


---

## Search & Replace (nvim-spectre)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>S` | Normal | Toggle Spectre (project-wide search & replace) |
| `<leader>sw` | Normal | Search word under cursor |
| `<leader>sw` | Visual | Search selected text |
| `<leader>sp` | Normal | Search in current file only |

---

## Git (lazygit.nvim)

| Key | Action |
|-----|--------|
| `<leader>'` | Open Lazygit |

---

## Operators (combine with motions)

| Key | Action |
|-----|--------|
| `d{motion}` | Delete |
| `c{motion}` | Change (delete + insert) |
| `y{motion}` | Yank (copy) |
| `>{motion}` | Indent |
| `<{motion}` | Unindent |
| `dd` `cc` `yy` | Operate on entire line |
| `D` `C` | Delete / change to end of line |

---

## Text Objects (use after operator or `v`)

| Key | Action |
|-----|--------|
| `iw` / `aw` | Inner / around word |
| `i"` / `a"` | Inner / around double quotes |
| `i'` / `a'` | Inner / around single quotes |
| `i(` / `a(` | Inner / around parentheses |
| `i{` / `a{` | Inner / around braces |
| `i[` / `a[` | Inner / around brackets |
| `it` / `at` | Inner / around XML/HTML tag |
| `ip` / `ap` | Inner / around paragraph |

---

## Windows & Buffers

| Key | Action |
|-----|--------|
| `<C-w>s` | Split horizontal |
| `<C-w>v` | Split vertical |
| `<C-w>h/j/k/l` | Navigate splits |
| `<C-w>q` | Close split |
| `:bn` / `:bp` | Next / previous buffer |
| `:bd` | Delete (close) buffer |
| `<C-o>` | Go back to previous buffer |
| `<C-\>` | Open/close terminal |

---

## Misc

| Key | Action |
|-----|--------|
| `<Esc>` | Return to Normal mode |
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | New line below + insert |
| `O` | New line above + insert |
| `p` / `P` | Paste after / before |
| `x` | Delete character under cursor |
| `r{c}` | Replace character under cursor with `c` |
| `~` | Toggle case of character |
| `J` | Join line below to current |
| `za` | Toggle fold |
| `zz` | Center view window |
| `=` | Format selection or text object like `ap` (paragraph) |
| `q{r}` / `@{r}` | Record / replay macro in register `r` |
