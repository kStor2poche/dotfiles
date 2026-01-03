set -gx BAT_THEME "gruvbox-dark"
set -gx MANPAGER "sh -c 'col -bx | bat -l man  --paging=always --plain'"
set -gx MANROFFOPT "-c"
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx CLOUDSDK_PYTHON_SITEPACKAGES 1
set -gx SUDO_PROMPT 'Mot de passe sinon conséquences. '
set -gx LIBCLANG_PATH "/home/laio/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-17.0.1_20240419/esp-clang/lib"
set -gx RUSTFLAGS "-C link-arg=-fuse-ld=mold"
