---@type LazySpec
return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.editing-support.copilotchat-nvim" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.go" },
    { import = "astrocommunity.pack.java" },
    { import = "astrocommunity.completion.copilot-lua" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.cpp" },
    -- { import = "astrocommunity.pack.typescript-all-in-one" },
    {
        import = "astrocommunity.color.transparent-nvim",
        opts = {
            extra_groups = {
                "NormalFloat",    -- plugins which have float panel such as Lazy, Mason, LspInfo
                "NvimTreeNormal", -- NvimTree
                "NeoTree",
                "Neo-tree"
            },
        },
        config = function()
            require('transparent').clear_prefix('NeoTree')
        end,
    },
}
