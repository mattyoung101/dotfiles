--[[

I stole this from kickstart.nvim (https://github.com/nvim-lua/kickstart.nvim)
and just added stuff as I went.

--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Source: https://stackoverflow.com/a/656232/5007892
function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

-- File types which we should display a word count in
local wcFileTypes = Set { "md", "txt", "markdown", "tex", "latex", "typst", "typ" }

-- Source: https://github.com/nvim-lualine/lualine.nvim/issues/328#issuecomment-982672253
local function getWords()
    if wcFileTypes[vim.bo.filetype] then
        if vim.fn.wordcount().visual_words == 1 then
            return tostring(vim.fn.wordcount().visual_words) .. " word"
        elseif not (vim.fn.wordcount().visual_words == nil) then
            return tostring(vim.fn.wordcount().visual_words) .. " words"
        else
            return tostring(vim.fn.wordcount().words) .. " words"
        end
    else
        return ""
    end
end

local function tinymistPinMain(path)
    -- For some reason, this doesn't work; exec_cmd is nil. We have to use buf_request directly.
    -- local tinymist_options = vim.lsp.get_clients({name = "tinymist"})
    -- if next(tinymist_options) == nil then
    --     print("Tinymist is not active.")
    --     return
    -- end
    -- local tinymist = tinymist_options[1]
    -- print("Found Tinymist client")
    -- tinymist:exec_cmd({
    --     command = "tinymist.pinMain",
    --     arguments = {"/home/matt/workspace/tamara/papers/thesis/uqthesis.typ"}
    -- })

    vim.lsp.buf_request(0, "workspace/executeCommand", {
        command = "tinymist.pinMain",
        arguments = { path },
    }, function(err, _, _)
        if err then
            vim.notify("Error executing tinymist.pinMain: " .. err.message, vim.log.levels.ERROR)
        else
            vim.notify("Command tinymist.pinMain executed successfully", vim.log.levels.INFO)
        end
    end)
end

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>ca', require("actions-preview").code_actions, '[C]ode [A]ction')
    nmap('<leader>fm', vim.lsp.buf.format, 'LSP [F]or[m]at')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- Enable inlay hints for clients that support them
    -- References:
    -- https://github.com/gennaro-tedesco/dotfiles/blob/master/nvim/lua/plugins/lsp.lua#L46-L59
    -- https://www.reddit.com/r/neovim/comments/1530wur/comment/jsgnk05/
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    else
        --print("no inlay hints available")
    end
end

require('lazy').setup({
    -- NOTE: First, some plugins that don't require any configuration

    -- Detect tabstop and shiftwidth automatically
    --'tpope/vim-sleuth',

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'mason-org/mason.nvim', opts = {} },
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Allows extra capabilities provided by blink.cmp
            'saghen/blink.cmp',

            -- lazydev for init.lua editing
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                -- group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    local bufnr = event.buf
                    on_attach(client, bufnr)

                    vim.api.nvim_create_autocmd('LspDetach', {
                        -- group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                        end,
                    })
                end
            })

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. They will be passed to
            --  the `settings` field of the server config. You must look up that documentation yourself.
            local servers = {
                -- ADD LSP LANGUAGE SERVERS HERE
                clangd = {},
                texlab = {},
                rust_analyzer = {
                    cargo = {
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true
                    }
                },
                neocmake = {},
                glsl_analyzer = {},
                yamlls = {},
                sqls = {},
                tinymist = {
                    settings = {
                        systemFonts = false,
                        formatterMode = "typstyle",
                        previewFeature = "disable"
                    }
                },

                html = {},
                terraformls = {},
                biome = {},
                ts_ls = {},

                -- https://www.reddit.com/r/neovim/comments/1lmd4ic/comment/n06upm2/
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                autoImportCompletions = false,
                                typeCheckingMode = "standard"
                            }
                        }
                    }
                },

                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        },
                    }
                },

                serve_d = {},

                svlangserver = {},

                gopls = {},

                kotlin_lsp = {},

                gh_actions_ls = {},

                ruff = {}, -- ruff ruff :3

                -- NOTE: jdtls is handled by AUR, so we can use it with the jdtls extension
            }

            -- setup my slingshot systemverilog LSP for development
            -- references used:
            --  https://neovim.discourse.group/t/how-to-add-a-custom-server-to-nvim-lspconfig/3925a
            --  https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/veridian.lua
            --  https://github.com/neovim/nvim-lspconfig/issues/691#issuecomment-766199011
            --  https://github.com/VHDL-LS/rust_hdl/issues/10#issuecomment-1000289556
            local lspconfig = require 'lspconfig'
            local configs = require 'lspconfig.configs'

            if not configs.slingshot then
                -- this require lspconfig.configs is the trick required to make it work
                require("lspconfig.configs").slingshot = {
                    default_config = {
                        cmd = { 'java', '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005', '-jar', '/home/matt/workspace/slingshot/build/libs/slingshot-1.0-SNAPSHOT-all.jar' },
                        filetypes = { 'verilog', 'systemverilog' },
                        root_dir = function(fname)
                            return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
                        end,
                        settings = {},
                    },
                }
            end
            -- lspconfig.slingshot.setup {}

            -- add rust_hdl vhdl language server (not in mason)
            -- require 'lspconfig'.vhdl_ls.setup {}

            -- Ensure the servers and tools above are installed
            --
            -- To check the current status of installed tools and/or manually install
            -- other tools, you can run
            --    :Mason
            --
            -- You can press `g?` for help in this menu.
            --
            -- `mason` had to be setup earlier: to configure its options see the
            -- `dependencies` table for `nvim-lspconfig` above.
            --
            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require('mason-lspconfig').setup {
                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end
    },


    { -- Autocompletion
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            -- Snippet Engine
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
                opts = {},
            },
            'folke/lazydev.nvim',
            "moyiz/blink-emoji.nvim",

            -- doesn't currently seem to work
            -- "p00f/clangd_extensions.nvim"
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = {
                -- 'default' (recommended) for mappings similar to built-in completions
                --   <c-y> to accept ([y]es) the completion.
                --    This will auto-import if your LSP supports it.
                --    This will expand snippets if the LSP sent a snippet.
                -- 'super-tab' for tab to accept
                -- 'enter' for enter to accept
                -- 'none' for no mappings
                --
                -- For an understanding of why the 'default' preset is recommended,
                -- you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                --
                -- All presets have the following mappings:
                -- <tab>/<s-tab>: move to right/left of your snippet expansion
                -- <c-space>: Open menu or open docs if already open
                -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
                -- <c-e>: Hide menu
                -- <c-k>: Toggle signature help
                --
                -- See :h blink-cmp-config-keymap for defining your own keymap
                preset = 'enter',

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono',
            },

            completion = {
                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = {
                    enabled = true
                },
                accept = {
                    auto_brackets = {
                        enabled = true
                    }
                }
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev', 'emoji' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15, -- Tune by preference
                        opts = {
                            insert = true, -- Insert emoji (default) or complete its name
                            ---@type string|table|fun():table
                            trigger = function()
                                return { ":" }
                            end,
                        },
                        should_show_items = function()
                            return vim.tbl_contains(
                            -- Enable emoji completion only for git commits and markdown.
                            -- By default, enabled for all file-types.
                                { "gitcommit", "markdown", "typst" },
                                vim.o.filetype
                            )
                        end,
                    }
                },
            },

            snippets = { preset = 'luasnip' },

            -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
            -- which automatically downloads a prebuilt binary when enabled.
            --
            -- By default, we use the Lua implementation instead, but you may enable
            -- the rust implementation via `'prefer_rust_with_warning'`
            --
            -- See :h blink-cmp-config-fuzzy for more information
            fuzzy = {
                implementation = 'prefer_rust_with_warning',
                sorts = {
                    'exact',
                    -- default sorts
                    'score',
                    -- doesn't currently seem to work
                    -- require("clangd_extensions").cmp_scores,
                    'sort_text',
                },
            },

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = true },
        },
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim',                opts = {} },
    { -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    -- COLOUR THEME
    -- Kanagawa colour theme
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        config = function()
            require("kanagawa").setup({
                transparent = true,
                undercurl = true,
                compile = true,
            })
            -- load the colorscheme here
            vim.cmd([[colorscheme kanagawa]])
        end,
    },

    -- { -- transparent plugin if i have image background
    --   'xiyaowong/transparent.nvim',
    --   config = function()
    --     require("transparent").setup({})
    --   end,
    -- },

    { -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`

        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
            sections = {
                lualine_x = { getWords, 'aerial', 'encoding', 'fileformat', 'filetype' }
            }
        },
    },

    { "lukas-reineke/indent-blankline.nvim", main = "ibl",      opts = {} },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim',               opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim',       branch = 'master', dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' } },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },

    -- greetz to henry
    -- https://github.com/henrybatt/neovim-config/blob/refactor/lua/plugins/treesitter.lua
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",

        dependencies = {
            { "nvim-treesitter/nvim-treesitter-context" },
            { "HiPhish/rainbow-delimiters.nvim" },
        },

        opts = function()
            -- Install default parsers using nvim-treesitter
            require("nvim-treesitter").install({
                'c', 'cpp', 'lua', 'python', 'rust', 'vimdoc', 'vim', 'markdown', 'markdown_inline',
                'jsonc', 'cmake', 'bibtex', 'fish', 'make', 'javascript', 'php', 'verilog', 'yaml', 'toml', 'html',
                'javascript', 'java', 'kotlin', 'dockerfile', 'cuda', 'query', 'css', 'ini', 'rust', 'glsl', 'capnp',
                'proto', 'latex', 'typst', 'robot', 'mermaid', 'groovy', 'bash', 'json', 'xml', 'http', 'terraform',
                'd', 'supercollider', 'go', 'scala', 'regex', 'commonlisp', 'gitmodules', 'gitignore'
            })

            -- autocmd to automatically install and start treesitter parsers based on filetype
            -- from: https://www.reddit.com/r/neovim/comments/1kuj9xm/has_anyone_successfully_switched_to_the_new/
            vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
                desc = "Start (and install missing) treesitter parsers based on filetype",
                group = vim.api.nvim_create_augroup("treesitter-buf-win-enter", { clear = true }),
                callback = function(event)
                    local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })

                    if filetype == "" then
                        return
                    end

                    local name = vim.treesitter.language.get_lang(filetype)

                    if name and require("nvim-treesitter.parsers")[name] then
                        if not vim.treesitter.language.add(name) then
                            require("nvim-treesitter").install({ name }):wait(60000)
                            if not vim.treesitter.language.add(name) then
                                vim.notify("Failed to find " .. name .. " parser after installation.",
                                    vim.log.levels.WARN,
                                    { title = "treesitter" }
                                )
                                return
                            end
                        end

                        vim.treesitter.start(event.buf, name)
                    end
                end,
            })
        end,
    },

    { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- use LSP semantic highlighting
-- source: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
local links = {
    --['@lsp.type.namespace'] = '@namespace',
    ['@lsp.type.type'] = '@type',
    ['@lsp.type.class'] = '@type',
    ['@lsp.type.enum'] = '@type',
    ['@lsp.type.interface'] = '@type',
    ['@lsp.type.struct'] = '@structure',
    ['@lsp.type.parameter'] = '@parameter',
    ['@lsp.type.variable'] = '@variable',
    ['@lsp.type.property'] = '@property',
    ['@lsp.type.enumMember'] = '@constant',
    ['@lsp.type.function'] = '@function',
    ['@lsp.type.method'] = '@method',
    ['@lsp.type.macro'] = '@macro',
    ['@lsp.type.decorator'] = '@function',
}
for newgroup, oldgroup in pairs(links) do
    vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

-- Spaces not tabs. I mean it!!!!
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.opt.expandtab = true
vim.o.expandtab = true

-- Set encoding
vim.opt.encoding = 'utf-8'

-- No line wrap
vim.opt.wrap = false

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- 110 character ruler
vim.opt.colorcolumn = "110"
vim.opt.textwidth = 110

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = { 'en_gb', 'en', 'programming' }
vim.opt.spelloptions = 'camel'

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            file_ignore_patterns = { ".git/", "node_modules", "poetry.lock" },
        },
        grep_string = {
            hidden = true
        },
        live_grep = {
            hidden = true,
            file_ignore_patterns = { ".git/", "node_modules", "poetry.lock" },
            -- https://github.com/nvim-telescope/telescope.nvim/issues/855#issuecomment-1032325327
            -- https://github.com/fredrikaverpil/dotfiles/blob/ee04215d632f7c91287031af41497bae98d63dd8/nvim-lazyvim/lua/plugins/telescope.lua#L43-L54
            -- https://github.com/LazyVim/LazyVim/discussions/804#discussioncomment-7184331
            additional_args = function(opts)
                return { "--hidden" }
            end
        }
    }
}

vim.g.lazygit_on_exit_callback = function()
    -- once LazyGit has exited, update the neo-tree git status
    -- ref: https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1381#issuecomment-1985679097
    local state = require("neo-tree.sources.manager").get_state("filesystem")
    require("neo-tree.sources.filesystem.commands").refresh(state)
end

vim.keymap.set('n', '<leader>lg', require('lazygit').lazygit, { desc = '[L]azy[G]it' })

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    -- Note: Grep in current buffer instead of fuzzy find
    -- Reference: https://github.com/nvim-telescope/telescope.nvim/issues/762#issuecomment-933036711
    require('telescope.builtin').current_buffer_fuzzy_find({ fuzzy = false, case_mode = 'ignore_case' })
end, { desc = '[/] Grep in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set("n", "<Leader>tf",
    function() require("telescope").extensions.frecency.frecency {} end,
    { desc = '[T]elescope [F]recency' }
)
vim.keymap.set("n", "<Leader>tw", function()
        require("telescope").extensions.frecency.frecency {
            workspace = "CWD",
        }
    end,
    { desc = '[T]elescope [W]orkspace Frecency' }
)

-- Barbar keybindings
local bbmap = vim.api.nvim_set_keymap
local bbopts = { noremap = true, silent = true }

-- Move to previous/next
bbmap('n', '<A-,>', '<Cmd>BufferPrevious<CR>', bbopts)
bbmap('n', '<A-.>', '<Cmd>BufferNext<CR>', bbopts)
-- Re-order to previous/next
bbmap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', bbopts)
bbmap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', bbopts)
-- Goto buffer in position...
bbmap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', bbopts)
bbmap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', bbopts)
bbmap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', bbopts)
bbmap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', bbopts)
bbmap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', bbopts)
bbmap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', bbopts)
bbmap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', bbopts)
bbmap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', bbopts)
bbmap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', bbopts)
bbmap('n', '<A-0>', '<Cmd>BufferLast<CR>', bbopts)
-- Pin/unpin buffer
bbmap('n', '<A-p>', '<Cmd>BufferPin<CR>', bbopts)
-- Close buffer
bbmap('n', '<A-c>', '<Cmd>BufferClose<CR>', bbopts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
bbmap('n', '<C-p>', '<Cmd>BufferPick<CR>', bbopts)
-- Sort automatically by...
bbmap('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', bbopts)
bbmap('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', bbopts)
bbmap('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', bbopts)
bbmap('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', bbopts)

-- Pin thesis main file (for TaMaRa thesis)
vim.api.nvim_create_user_command("PinThesisMain", function()
    tinymistPinMain("/home/matt/workspace/tamara/papers/thesis/uqthesis.typ")
end, {})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "[R]e[n]ame" })

local luasnip = require 'luasnip'

luasnip.config.setup {}

-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

-- We have to configure rainbow delimiters here like this. It seems like any
-- configuration we attempt to do in the rainbow.lua file shits up the entire
-- lazy plugin loader. This is absolutely infuriating but we have no other choice.
-- I'm assuming Lazy is at fault here.
-- FIXME: configure this in the rainbow.lua file not here
vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        commonlisp = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
        verilog = 'rainbow-blocks',
        latex = 'rainbow-blocks',
    },
    highlight = {
        --'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}
