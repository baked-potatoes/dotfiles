local M = {}

function M.setup()
    vim.filetype.add({
        extension = {
            tex = "tex",
        },

        pattern = {
            ["^[^.]+$"] = function(path, bufnr)
                local max_lines = math.min(20, vim.api.nvim_buf_line_count(bufnr))
                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, max_lines, false)
                local text = table.concat(lines, "\n")

                if text:find("\\documentclass", 1, true)
                    or text:find("\\begin{document}", 1, true) then
                    return "tex"
                end

                return nil
            end,
        },
    })end

    return M
