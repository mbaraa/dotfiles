local lspconfig = require("lspconfig")
local default_configs = lspconfig.util.default_config
local cmp = require('cmp')

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
default_configs.capabilities = vim.tbl_deep_extend(
    'force',
    default_configs.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F6>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F7>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

local function foo()
  -- On neovim 0.11+, use the vim.o.winborder option by default
  local has_winborder, winborder = pcall(function()
    return vim.o.winborder
  end)
  if has_winborder and winborder ~= '' then
    return winborder
  end

  -- On lower versions return the default
  return 'none'
end

-- require('luasnip.loaders.from_snipmate').lazy_load()
cmp.setup({
    view = {
        -- entries = "custom" -- can be "custom", "wildmenu" or "native"
        entries = {name = 'custom', selection_order = 'near_cursor' },
    },
    window = {
        completion = cmp.config.window.bordered({
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:menu,FloatBorder:menu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:menu,FloatBorder:menu,CursorLine:PmenuSel,Search:None",
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'cmp-tw2css' },
        { name = "calc" },
        { name = "tsnip" },
        { name = 'conventionalcommits' },
        { name = 'sql' },
        { name = "nvim-lua" },
        {
            name = 'path',
            option = {
                pathMappings = {
                    ['@'] = '${folder}/src',
                    ['/'] = '${folder}/src/public/',
                    ['~@'] = '${folder}/src',
                },
            },
        },
    },
    preselect = 'item',
    completion = {
        winhighlight = "Normal:menu,FloatBorder:menu,Search:None",
        col_offset = -3,
        side_padding = 0,
    },

    formatting = {
        format = function(entry, vim_item)
            local custom_menu_icon = {
                calc = " 󰃬 ",
            }

            if entry.source.name == "calc" then
                vim_item.kind = custom_menu_icon.calc
            end

            local lspkind = require("lspkind")
            local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            kind.icon = "" .. (kind.icon or "") .. ""
            kind.kind = "(" .. (kind.kind or "") .. ")"

            return kind
        end,
    },

    mapping = cmp.mapping.preset.insert({
        -- Navigate between completion items
        ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),

        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = true}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        -- Simple tab complete
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item({behavior = 'select'})
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),

        -- Go to previous item
        ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),

    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

local function setup_templ()
    default_configs.templ = {}
    -- start the templ language server for go projects with .templ files
    lspconfig.templ.setup({
        cmd = { "templ", "lsp", "-http=localhost:7474", "-log=/tmp/templ.log" },
        filetypes = { "templ" },
        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
        settings = {},
    })

    -- register .templ as a filetype
    vim.filetype.add({ extension = { templ = "templ" } })
    lspconfig.html.setup({
        on_attach = default_configs.on_attach,
        capabilities = default_configs.capabilities,
        filetypes = { "html", "templ" },
    })

    -- htmx, the frontend library of peace
    lspconfig.htmx.setup({
        on_attach = default_configs.on_attach,
        capabilities = default_configs.capabilities,
        filetypes = { "html", "templ" },
    })

    -- needed tailwindcss classes auto complete
    lspconfig.tailwindcss.setup({
        on_attach = default_configs.on_attach,
        capabilities = default_configs.capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        init_options = { userLanguages = { templ = "html" } },
    })

    -- needed for auto tag insertion
    lspconfig.emmet_ls.setup({
        on_attach = default_configs.on_attach,
        capabilities = default_configs.capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        init_options = { userLanguages = { templ = "html" } },
    })

    -- format thingy
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "*.templ" },
        callback = function()
            local file_name = vim.api.nvim_buf_get_name(0) -- Get file name of file in current buffer
            vim.cmd(":silent !templ fmt " .. file_name)

            local bufnr = vim.api.nvim_get_current_buf()
            if vim.api.nvim_get_current_buf() == bufnr then
                vim.cmd('e!')
            end
        end
    })
end

local function setup_clangd()
    lspconfig.clangd.setup({
        cmd = {"clangd", "--query-driver=/usr/bin/arm-none-eabi-g*"}
    })
end

lspconfig.gopls.setup({
    single_file_support = true,
})

lspconfig.rust_analyzer.setup({
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
            },
            settings = {
            },
        },
    }
})

lspconfig.ts_ls.setup({})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        },
    }
})

lspconfig.bashls.setup({})
lspconfig.cssls.setup({})
lspconfig.elixirls.setup({})
lspconfig.emmet_ls.setup({})
lspconfig.eslint.setup({})
lspconfig.jsonls.setup({})
lspconfig.svelte.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.templ.setup({})
lspconfig.vimls.setup({})
lspconfig.yamlls.setup({})
lspconfig.dartls.setup({})

setup_templ()
setup_clangd()

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = '󰋖',
            [vim.diagnostic.severity.INFO] = ' ',
        },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
