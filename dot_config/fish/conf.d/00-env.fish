set -gx BAT_THEME "gruvbox-dark"
set -gx MANPAGER "sh -c 'col -bx | bat -l man --paging=always --plain'"
set -gx MANROFFOPT "-c"
set -gx LESS "-R -c"
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx SUDO_PROMPT 'Mot de passe sinon conséquences. '
set -gx RUSTFLAGS "-C link-arg=-fuse-ld=mold"
