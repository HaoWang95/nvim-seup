# Repository Guidelines

## Project Structure & Module Organization

- `init.lua` wires Kickstart defaults, lazy.nvim, and local helpers; keep leader and global toggles at the top so load order stays predictable.
- `lua/kickstart/**` mirrors upstream Kickstart modules; extend behaviour in `lua/custom/**` instead of editing the vendored copies.
- `lua/custom/settings.lua` centralises option tweaks, while `lua/custom/plugins/` should host self-contained plugin specs via `return {...}`.
- Update `doc/kickstart.txt` when user-facing commands change, and commit `lazy-lock.json` only when pinning new plugin versions.

## Build, Test, and Development Commands

- `nvim --headless "+Lazy! sync" +qa` installs or removes plugins after editing specs.
- `nvim --headless "+Lazy check" +qa` validates plugin health and reports missing binaries before review.
- `nvim --headless "+checkhealth" +qa` surfaces provider issues; use it after adding language tooling.
- `nvim --headless "+luafile init.lua" +qa` sanity-checks syntax when touching core files; follow with `:Lazy update` only when you plan to refresh locks.

## Coding Style & Naming Conventions

- Use two-space indentation for Lua, align table literals vertically, and keep one top-level construct per file.
- Prefer single quotes for strings, local helpers over globals, and snake_case (or dashed filenames) for module namespaces.
- Express plugins as concise tables: `return { 'owner/plugin', opts = { ... } }`, setting `opts` over side effects.
- Let conform.nvim enforce formatting (`:ConformInfo` lists active formatters) and reserve comments for non-obvious behaviour.

## Testing Guidelines

- Pair each change with a reproducible check (e.g., `:FloatTerm`, telescope pickers) and list the steps in the PR.
- Trigger `:checkhealth` and inspect `:messages` after configuring providers or language servers.
- When adding formatters or linters, run `:ConformInfo` and confirm they appear under the intended filetype.
- Capture before/after screenshots for UI-affecting tweaks and note any required settings in review notes.

## Commit & Pull Request Guidelines

- Mirror the history: short, imperative, lowercase subjects (`fix nvim deprecated configs`).
- Group related edits per commit and keep plugin bumps separate from option tweaks.
- Reference issues or trackers in the body and call out any follow-up tasks.
- Document test commands, impacted workflows, and UI evidence in the PR; request review only when headless checks pass.
