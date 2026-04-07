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
        config = function(_, opts)
            require('lualine').setup(opts)
            -- Refresh lualine every 300ms to drive the scrolling animation
            local timer = vim.uv.new_timer()
            timer:start(300, 300, vim.schedule_wrap(function()
                if vim.bo.buftype == '' then
                    require('lualine').refresh()
                end
            end))
        end,
        opts = {
            options = {
                globalstatus = true,
            },
            sections = {
                lualine_y = {
                    {
                        function()
                            local mem = collectgarbage('count')
                            if mem >= 1024 then
                                return string.format('%.1fMB', mem / 1024)
                            end
                            return string.format('%.0fKB', mem)
                        end,
                    },
                },
                lualine_c = {
                    { 'filename', path = 0, symbols = { modified = ' ●' } },
                    {
                        function()
                            local text = require('gitblame').get_current_blame_text()
                            local max_width = 40
                            if not text or text == '' or #text <= max_width then
                                return text or ''
                            end
                            -- Use a global table to track scroll offset per buffer
                            _G._blame_scroll = _G._blame_scroll or {}
                            local key = vim.api.nvim_get_current_buf()
                            local entry = _G._blame_scroll[key] or { offset = 0, last_text = '', tick = 0 }
                            -- Reset offset and start 1s delay when blame text changes
                            if entry.last_text ~= text then
                                entry.last_text = text
                                entry.delay_until = vim.uv.now() + 1000
                                entry.scroll_start = nil
                            end
                            -- Show static (truncated) text during the delay
                            if entry.delay_until and vim.uv.now() < entry.delay_until then
                                _G._blame_scroll[key] = entry
                                return vim.fn.strcharpart(text, 0, max_width)
                            end
                            -- Time-based offset: advance 1 char per 300ms
                            local now = vim.uv.now()
                            entry.scroll_start = entry.scroll_start or now
                            local elapsed = now - entry.scroll_start
                            local offset = math.floor(elapsed / 300) % (#text + 7) -- 7 = separator length
                            local padded = text .. '   ·   ' .. text
                            local display = vim.fn.strcharpart(padded, offset, max_width)
                            _G._blame_scroll[key] = entry
                            return display
                        end,
                    },
                },
            },
        },
    },
}
