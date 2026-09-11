return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "stevearc/conform.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },

        config = function()
            -- Formatter setup
            require("conform").setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    lua = { "stylua" },
                },

                -- format_on_save = {
                --     timeout_ms = 500,
                --     lsp_fallback = false,
                -- },
                format_on_save = false
            })
            -- LSP & autocomplete setup
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            -- Mason setup
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pyright",
                    "rust_analyzer",
                    "gopls",
                    "vtsls",
                    "tailwindcss",
                    "html",
                    "cssls",
                    "emmet_ls",
                },
                automatic_installation = false,
                handlers = {
                    -- default handler
                    function(server_name)
                        require("lspconfig")[server_name].setup({ capabilities = capabilities })
                    end,

                    -- Lua LSP
                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "LuaJIT" },
                                    diagnostics = { globals = { "vim" } },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = false,
                                    },
                                    format = {
                                        defaultConfig = { indent_style = "space", indent_size = "2" },
                                    },
                                },
                            },
                        })
                    end,

                    -- Tailwind CSS
                    ["tailwindcss"] = function()
                        require("lspconfig").tailwindcss.setup({
                            capabilities = capabilities,
                            filetypes = {
                                "html", "css", "scss",
                                "javascript", "javascriptreact",
                                "typescript", "typescriptreact",
                                "vue", "svelte", "heex",
                            },
                        })
                    end,

                    -- Zig LSP
                    zls = function()
                        require("lspconfig").zls.setup({
                            root_dir = require("lspconfig.util").root_pattern(".git", "build.zig", "zls.json"),
                            settings = { zls = { enable_inlay_hints = true, enable_snippets = true, warn_style = true } },
                        })
                        vim.g.zig_fmt_parse_errors = 0
                        vim.g.zig_fmt_autosave = 0
                    end,
                },
            })

            -- Fidget (LSP status)
            require("fidget").setup({})

            -- Keymaps on LSP attach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(e)
                    local opts = { buffer = e.buf }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                end,
            })

            -- cmp setup
            cmp.setup({
                snippet = {
                    expand = function(args) require("luasnip").lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = "copilot", group_index = 2 },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, { { name = "buffer" } }),
            })

            -- Diagnostics
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
}
