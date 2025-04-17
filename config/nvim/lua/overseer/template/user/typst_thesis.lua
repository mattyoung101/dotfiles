return {
    name = "typst thesis",
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        return {
            cmd = { "typst", "watch" },
            args = { "uqthesis.typ" },
            cwd = "/home/matt/workspace/tamara/papers/thesis",
            components = { "default" },
        }
    end,
    condition = {
        filetype = { "typst", "typ" },
    },
}
