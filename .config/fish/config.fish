set -gx EDITOR nvim
set -gx VISUAL nvim

# pnpm
set -gx PNPM_HOME "/home/sora/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
