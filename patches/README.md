This directory stores local modifications that are meant to be replayed on top
of upstream repositories when no hosted fork is configured yet.

Current patches:
- `twig-edit-hotkey.patch`: adds an `e` hotkey to Twig to suspend the TUI,
  launch `$VISUAL`/`$EDITOR` with `lvim` fallback, and reload the file on exit.
