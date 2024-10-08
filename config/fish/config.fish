# SSH agent, Gnome Keyring
# Reference: https://wiki.archlinux.org/title/GNOME/Keyring
# This only applies to serpent and gecko, the Ubuntu work laptop does not have this issue, hence the somewhat
# ugly host specific check.
# I think $hostname is set by fish, so hopefully this doesn't blow up.
if test "$hostname" != 'EMT-LPT-095-LNX'
    set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
end

# Go
fish_add_path ~/go/bin

# Rust, cargo
fish_add_path ~/.cargo/bin

# ghcup (Haskell)
fish_add_path ~/.ghcup/bin

# Use latest Clang (since we're on Arch now) as compiler
# currently some packages seem to fail with Clang, this is the package's fault,
# but use gcc instead
# TODO: verify this - was mainly CloudCompare, should most other packages work now?
#set -x CXX clang++
#set -x CC clang

# Node (fish nvm)
nvm -s use latest

# Alias vim to nvim because I accidentally type vim sometimes
alias vim=nvim

# Use neovim as man pager
# https://www.chrisdeluca.me/article/use-neovim-as-your-man-pager/
set -x MANPAGER "nvim -c 'Man!' -o -"

# Use nvim as editor
set -x EDITOR nvim

# AMD HIP
set -x HIP_ROOT_DIR /opt/rocm/hip

# opam (OCaml) configuration
source /home/matt/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# for Aspire CPU development
set -x RISCV_LLVM_HOME /home/matt/build/riscv-ilp32

# use Kanagawa theme
source ~/.config/fish/kanagawa.fish

# zoxide
zoxide init fish --cmd cd | source

# Try to prefer Wayland by default for SDL applications
set -x SDL_VIDEODRIVER "wayland,x11"

# command to use clang (with ccache)
function use_clang
    set -gx CXX ccache clang++
    set -gx CC ccache clang
    echo "Using ccache Clang"
end

########################

# legacy stuff

#ESP32
#fish_add_path $HOME/esp/xtensa-esp32-elf/bin $HOME/esp/esp-idf/tools
#fish_add_path /home/matt/workspace/nanopb-0.3.9.3-linux-x86/generator-bin
#set IDF_PATH ~/esp/esp-idf

# ROS
# alias ros='bass source devel/setup.bash'
# alias git-pullall='ls | xargs -P10 -I{} git -C {} pull'
