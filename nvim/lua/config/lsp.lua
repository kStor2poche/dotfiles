--
-- setup LSP list
--
local h = require("helpers")

-- all config "presets" flavors
local default_config = {"clangd", "jdtls", "ltex", "basedpyright", "lua_ls", "bashls", "dockerls", "docker_compose_language_service", "arduino_language_server", "cssls","intelephense","denols","spectral","rust_analyzer", "glsl_analyzer"}
local root_dir_config = {"omnisharp", "asm_lsp"}
local other_config = {"ltex"}

local lsp_list = h.tbl_cat(h.tbl_cat(default_config, root_dir_config), other_config)
local lspconfig = require("lspconfig")

--
-- mason config
--
require("mason").setup({
    ui = {
        check_outdated_packages_on_open = true,
        border = "none",
        icons = {
            package_installed = "",
            package_pending = "→",
            package_uninstalled = "✕"
        }
    }
})

--
-- mason-lspconfig config
--
require("mason-lspconfig").setup({
    ensure_installed = lsp_list,
    automatic_installation = false,
})

-- setup capabilities and on_attach according to what nvim_cmp can do
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- DEBUG
    --[[local function dump(o)
       if type(o) == 'table' then
         local s = '{ '
           for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
             s = s .. '['..k..'] = ' .. dump(v) .. ','
           end
         return s .. '} '
         else
         return tostring(o)
         end
     end

    print(dump(h.tbl_cat(bufopts, {desc = "biboup"})), "vs", dump({ noremap = true, silent = true, buffer = bufnr, desc = "biboup" }))
    ]]
    --
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, h.tbl_append(bufopts, "desc", "Lsp - Go to definition"))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, h.tbl_append(bufopts, "desc", "Lsp - Go to declaration"))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, h.tbl_append(bufopts, "desc", "Lsp - Hover"))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, h.tbl_append(bufopts, "desc", "Lsp - Go to implementation"))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, h.tbl_append(bufopts, "desc", "Lsp - Signature help"))
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, h.tbl_append(bufopts, "desc", "Lsp - Add ws folder"))
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, h.tbl_append(bufopts, "desc", "Lsp - Rm ws folder"))
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, h.tbl_append(bufopts, "desc", "Lsp - ls ws folders"))
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, h.tbl_append(bufopts, "desc", "Lsp - Go to type definition"))
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, h.tbl_append(bufopts, "desc", "Lsp - Rename symbol"))
    -- Apply action when "fix available" from lsp
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, h.tbl_append(bufopts, "desc", "Lsp - Code actions"))
    vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, h.tbl_append(bufopts, "desc", "Lsp - Show references"))
    vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, h.tbl_append(bufopts, "desc", "Lsp - Format buffer"))
    -- Cycle through code diagnostics
    vim.keymap.set('n', '<leader>o', '<cmd>lua vim.diagnostic.open_float()<CR>', h.tbl_append(bufopts, "desc", "Lsp - Show diagnostics"))
    vim.keymap.set('n', '<leader>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', h.tbl_append(bufopts, "desc", "Lsp - Go to prev diag"))
    vim.keymap.set('n', '<leader>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', h.tbl_append(bufopts, "desc", "Lsp - Go to next diag"))

    -- Snacks/Words
    -- vim.keymap.set("n", "<leader>*", Snacks.words.jump, { desc = "Lsp - Next reference" })
end

--
-- Sugar
--
local _border = "none"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = _border
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = _border
    })

vim.diagnostic.config{
    float={border=_border}
}
-- Progress (prettified with snacks.nvim notifier)
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})


--
-- activate LSPs...
--

-- ... with a default configuration ...
for _,lsp in ipairs(lsp_list) do
    lspconfig[lsp].setup{ capabilities = capabilities, on_attach = on_attach }
end

-- ... specify the root directory for those that need it ...
for _,lsp in ipairs(root_dir_config) do
    lspconfig[lsp].setup{ root_dir = function() return vim.loop.cwd() end }
end

-- and provide special care for some :)
lspconfig.ltex.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        require("ltex_extra").setup({
            path = vim.fn.expand("~") .. "/.local/share/ltex"
        })
    end,
    autostart = false,
    window_border = _border,
    filetypes = { "latex", "tex", "bib", "markdown" },
    settings = {
        ltex = {
            language = "auto",
            --disabledRules = { ["fr"] = { "MORFOLOGIK_RULE_FR_FR" }, },
            --dictionary = { ["fr"] = { "Dummy0", "Dummy1", "Dummy2", "Dummy3", "Dummy4", "Dummy5" } },
        },
    },
})

lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim', 'require' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false, -- to avoid having the "do you want to use the luassert environment" every time
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false, },
        },
    },
})

lspconfig.omnisharp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false,
    enable_roslyn_analyzers = true,
    enable_import_completion = true,
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    cmd = { "omnisharp", '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
})

lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "clangd", "--fallback-style=UseTab: Never", "--fallback-style=IndentWidth: 4", "--fallback-style=TabWidth: 4"},
})
