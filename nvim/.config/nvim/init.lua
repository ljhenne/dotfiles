-- =====================================================================
-- 1. LEADER KEY
-- =====================================================================
-- Set <space> as the leader key. This must happen before any plugins
-- are loaded. The leader key is your primary prefix for custom commands.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =====================================================================
-- 2. LINE NUMBERS
-- =====================================================================
-- Show the absolute line number of the current line
vim.opt.number = true
-- Show relative line numbers for all other lines (crucial for Vim movement)
-- This lets you look up and type `5k` to jump exactly 5 lines up.
vim.opt.relativenumber = true

-- =====================================================================
-- 3. TABS & INDENTATION (Python-focused)
-- =====================================================================
-- Insert 4 spaces for a tab (PEP 8 standard for Python)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- Convert tab presses to spaces
vim.opt.expandtab = true

-- =====================================================================
-- 4. CLIPBOARD
-- =====================================================================
-- Sync Neovim's clipboard with your operating system's clipboard.
-- This allows you to use `y` (yank) to copy into your OS clipboard,
-- and `p` (put) to paste from other applications.
vim.opt.clipboard = "unnamedplus"

-- =====================================================================
-- 5. SEARCH & UI TWEAKS
-- =====================================================================
-- Ignore case when searching, unless you type a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Always show the signcolumn (the gutter on the left).
-- This prevents the text from shifting left and right when error icons appear.
vim.opt.signcolumn = "yes"

-- =====================================================================
-- 6. PACKAGE MANAGER BOOTSTRAP (lazy.nvim)
-- =====================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy exists, clone it silently if it doesn't
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

-- Add it to Neovim's runtime path
vim.opt.rtp:prepend(lazypath)

-- =====================================================================
-- 7. LOAD PLUGINS
-- =====================================================================
require("lazy").setup({

    -- Plugin 1: Treesitter (Modern API)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- The plugin now only handles downloading the parsers.
            -- This is a no-op if they are already installed.
            require("nvim-treesitter").install({
                "python",
                "go",
                "typescript",
                "lua",
                "vim",
                "vimdoc",
                "markdown",
                "markdown_inline"
            })
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')

            -- Press Space + f + f to find files
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

            -- Press Space + f + g to search text inside files
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

            -- Press Space + f + b to view open buffers
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

            -- Press Space + f + h to search Neovim's help docs
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",      -- Automatically matches your Mocha theme
                    globalstatus = true, -- Keeps one statusline at the bottom instead of one per split pane
                }
            })
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    telescope = true,
                },
            })

            -- Apply the colorscheme
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- Disable netrw (Neovim's clunky built-in file explorer) to prevent conflicts
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                git = {
                    enable = true,
                    show_on_dirs = true,
                    timeout = 400,
                },
                renderer = {
                    highlight_git = "all",

                    icons = {
                        show = {
                            git = true,
                        },
                        glyphs = {
                            git = {
                                unstaged  = "󰜎",
                                staged    = "󰄲",
                                unmerged  = "",
                                renamed   = "➜",
                                untracked = "★",
                                deleted   = "",
                                ignored   = "◌",
                            },
                        },
                    },
                },
                view = {
                    width = 30,
                    side = "left",
                },
            })

            -- Press Space + e to toggle the file explorer sidebar
            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })

	    -- Apply the visual styling rules down here (after setup)
            vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { link = "Comment" })
	    vim.api.nvim_set_hl(0, "NvimTreeGitIgnoredIcon", { link = "Comment" })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- 1. Initialize Mason
            require("mason").setup()

            -- 2. Tell Mason to ensure these servers are always installed
            -- (Mason v2+ automatically enables them for you natively)
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "cssls",
                    "html",
                    "emmet_ls",
                    "lua_ls",
                    "pyright",
                    "sqlls",
                    "ts_ls"
                },
            })

            -- 3. Set up keyboard shortcuts for LSP features
            -- Press 'K' to see documentation for the word under your cursor
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })

            -- Press 'gd' to jump to the definition of a function or variable
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })

            -- Press Space + c + a to see available "Code Actions" (like quick fixes)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })

            -- Press Space + r + n to rename a variable across your whole file
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Variable' })
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- LSP completions
            "hrsh7th/cmp-buffer",       -- Buffer completions (words in current file)
            "hrsh7th/cmp-path",         -- File path completions
            "L3MON4D3/LuaSnip",         -- Snippet engine (required by cmp)
            "saadparwaiz1/cmp_luasnip", -- Snippet completions
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- How cmp triggers snippets
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),            -- Manually trigger menu
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter accepts selection
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' }, -- Prioritize LSP
                    { name = 'luasnip' },  -- Then snippets
                }, {
                    { name = 'buffer' },   -- Then text in the file
                    { name = 'path' },     -- Then file paths
                })
            })
        end
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- Leave this empty to use the default layouts and settings
        },
    },

    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "isort", "black" },
                },
                format_on_save = {
                    timeout_ms = 3000,
                    lsp_fallback = true,
                },
            })
        end,
    },

})

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "html", "cssls", "sqlls" },
    handlers = {
        -- This default handler attaches to all installed servers
        function(server_name)
            require("lspconfig")[server_name].setup({
                -- This line connects the LSP to nvim-cmp
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })
        end,
    }
})

-- Tell Neovim's native core to take over highlighting
vim.api.nvim_create_autocmd("FileType", {
    -- Run this automatically when opening any of these file types
    pattern = { "python", "go", "typescript", "lua", "vim", "help" },
    callback = function()
        -- Start native Treesitter highlighting (pcall prevents crashes if a parser is missing)
        pcall(vim.treesitter.start)
    end,
})

-- LSP Diagnostic Keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous error/warning' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next error/warning' })

-- Resize windows using Alt + hjkl keys
vim.keymap.set('n', '<A-k>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<A-j>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<A-h>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<A-l>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- Split behavior
vim.opt.splitright = true -- Vertically split windows open to the right
vim.opt.splitbelow = true -- Horizontally split windows open below

-- Configure NeoVim to use OSC 52 for system clipboard integration
local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    -- Note: Pasting FROM system clipboard over SSH via OSC 52 is heavily restricted 
    -- by most terminals for security reasons, so this fallback reads from NeoVim's register.
    ["+"] = paste,
    ["*"] = paste,
  },
}

-- Sync NeoVim's default yanks directly to the system clipboard
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
