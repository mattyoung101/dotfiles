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

# Rust logging
set -x RUST_LOG info

# command to use clang (with ccache)
function use_clang
    # TODO Fix this properly on Ubuntu
    set -gx CXX /usr/lib/ccache/bin/clang++
    set -gx CC /usr/lib/ccache/bin/clang
    echo "Using ccache Clang"
end

########################

# as suggested by avery on uqcs (and slightly modified by me)

function fish_greeting
    echo
    echo (fish --version)
    echo
    echo The time is (set_color yellow; date; set_color normal) on machine (set_color green; hostname; set_color normal)

    # Keep track of how many shells we ever opened (for fun)
    if ! set -q shells_opened
        set -u shells_opened 1
    end
    set -U shells_opened (math $shells_opened + 1)

    if test (math $shells_opened % 100) -eq 0
        echo
        echo -e "\033[1m ==========> Congratulations on opening $shells_opened shells! <========== \033[0m" | lolcat
    end
end

# Activate micromamba, but only on specific machines
if contains (hostname) serpent EMT-LPT-095-LNX
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
set -gx MAMBA_EXE "/home/matt/.local/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/home/matt/micromamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
end

# OpenBSD: use a less shitty mirror
set -x PKG_PATH https://mirror.aarnet.edu.au/pub/OpenBSD/7.7/packages-stable/amd64/
