local M = {}

function M.github_linker(start_line, end_line)
    local line_number = start_line or vim.fn.line('.')
    local end_line_number = end_line or line_number
    local file_name = vim.fn.expand('%:t')

    local current_file = vim.fn.expand('%:p')
    local current_dir = vim.fn.expand('%:p:h')
    local project_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    local relative_path = vim.fn.fnamemodify(current_file, ':gs?' .. project_root .. '??')

    local repo_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
    local repo_path = vim.fn.substitute(repo_url, '\\(.*github.com\\)\\(:\\|/\\)\\([^/]*\\)/\\(.*\\)\\.git',
        'https://github.com/\\3/\\4', '')
    local branch_name = vim.fn.systemlist("git symbolic-ref --short HEAD")[1]
    local base_url = repo_path .. '/blob/' .. branch_name
    local range = 'L' .. line_number
    if line_number ~= end_line_number then
        range = 'L' .. line_number .. '-L' .. end_line_number
    end
    local full_url = base_url .. relative_path .. '#' .. range

    return full_url
end

function M.github_linker_command(start_line, end_line)
    local start_line, end_line

    -- Check if a range is provided
    if vim.fn.line("'<") == 0 and vim.fn.line("'>") == 0 then
        start_line = vim.fn.line('.')
        end_line = start_line

    else
        -- If no range is provided, use the current line
        start_line = vim.fn.line("'<")
        end_line = vim.fn.line("'>")
    end

    local repo = vim.fn.systemlist("git config --get remote.origin.url")[1]
    local branch = vim.fn.systemlist("git symbolic-ref --short HEAD")[1]

    -- save to clipboard
    if start_line and end_line then
        local url = M.github_linker(start_line, end_line)
        vim.fn.setreg("*", url)
    else
        local url = M.github_linker()
        vim.fn.setreg("*", url)
    end
end

vim.cmd([[command! -range GithubLink lua require('nvim-github-linker').github_linker_command(<line1>,<line2>)]])

return M
