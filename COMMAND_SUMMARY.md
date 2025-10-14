# Headless Command Summary

## Environment Setup

- Exported temporary paths per invocation: `XDG_DATA_HOME=$PWD/.nvim-xdg/data`, `XDG_STATE_HOME=$PWD/.nvim-xdg/state`, `XDG_CACHE_HOME=$PWD/.nvim-xdg/cache`.
- Copied the existing lazy cache from `~/.local/share/nvim/lazy` into `.nvim-xdg/data/nvim/lazy` to avoid network downloads.

## Commands Executed

- `nvim --headless "+Lazy! sync" +qa`
  - Outcome: Sync completed using the copied cache.
  - Note: `nvim-dap-python` repeated LuaRocks errors because Lua 5.1 binaries could not be fetched without network access.

- `nvim --headless "+Lazy check" +qa`
  - Outcome: Lazy check ran; configuration loaded successfully.
  - Note: Same LuaRocks warnings for `nvim-dap-python`; no write-permission issues encountered.

- `nvim --headless "+checkhealth" +qa`
  - Outcome: Health checks executed without tree-sitter or ShaDa permission failures.
  - Note: dap-python validations skipped due to unresolved LuaRocks dependency.

- `nvim --headless "+luafile init.lua" +qa`
  - Outcome: Config reload succeeded, confirming syntactic validity.
  - Note: LuaRocks warning surfaced again for `nvim-dap-python`; no further errors.

## Outstanding Follow-ups

- Allow network access (or pre-provision LuaRocks artifacts) if full dap-python installation is required.
- Remove temporary `.nvim-xdg` directories or integrate them into the workflow if persistent sandboxed runs are needed.

## Fix History: C/C++ Indentation

- Problem: New lines in C/C++ buffers expanded to 8-space tabs until `:w` triggered clang-format, leaving manual edits misaligned.
- Analysis: Default buffer options from Kickstart left `tabstop`/`shiftwidth` at 8 with `noexpandtab`; formatting only corrected indentation on save.
- Resolution: Added a `FileType` autocmd in `lua/custom/settings.lua` to enforce `expandtab` with 4-space indentation across C-family buffers, aligning edits with clang-format output.
- Adjustment: Overrode `DiagnosticSignWarn` to render as a single yellow `!` for a compact warning indicator in the sign column.
