return {
    { "folke/tokyonight.nvim", priority = 1000 },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },
}
