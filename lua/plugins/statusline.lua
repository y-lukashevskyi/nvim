return {
    {
        'f-person/git-blame.nvim',
        opts = {
            enabled = true,
            message_when_not_committed = '',
            display_virtual_text = 0,
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'f-person/git-blame.nvim' },
        opts = {
            sections = {
                lualine_c = {
                    { 'filename', path = 1, symbols = { modified = ' ●' } },
                    { function() return require('gitblame').get_current_blame_text() end },
                },
            },
        },
    },
}
