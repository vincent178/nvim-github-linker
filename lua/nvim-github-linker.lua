local M = {}

function M.github_linker(start_line, end_line)
    local line_number = start_line or vim.fn.line('.')
    local end_line_number = end_line or line_number
    local file_name = vim.fn.expand('%:t')
    local repo_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
    local repo_path = vim.fn.substitute(repo_url, '\\(.*github.com\\)\\(:\\|/\\)\\([^/]*\\)/\\(.*\\)\\.git',
        'https://github.com/\\3/\\4', '')
    local branch_name = vim.fn.systemlist("git symbolic-ref --short HEAD")[1]
    local base_url = repo_path .. '/blob/' .. branch_name
    local range = 'L' .. line_number
    if line_number ~= end_line_number then
        range = 'L' .. line_number .. '-L' .. end_line_number
    end
    local full_url = base_url .. '/' .. file_name .. '#' .. range

    return full_url
end

function M.github_linker_command(...)
    local args = { ... }
    local repo = vim.fn.systemlist("git config --get remote.origin.url")[1]
    local branch = vim.fn.systemlist("git symbolic-ref --short HEAD")[1]
    local start_line, end_line = args[1], args[2]
    if start_line and end_line then
        print(M.github_linker(start_line, end_line))
    else
        print(M.github_linker())
    end
end

vim.cmd([[command! -nargs=* GithubLink lua require('nvim-github-linker').github_linker_command(<f-args>)]])

return M
