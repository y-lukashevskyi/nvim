return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-ui-select.nvim',
    },
    opts = {
        pickers = {
            find_files = {
                hidden = true,
            },
            live_grep = {
                additional_args = { "--hidden" },
            },
        },
        extensions = {
            fzf = {},
            ["ui-select"] = {},
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
}



