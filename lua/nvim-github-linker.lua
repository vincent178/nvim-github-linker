local M = {}

function M.setup(opts)
    local defaults = {
        mappings = true,
        default_remote = "origin",
        copy_to_clipboard = true,
    }

    local options = vim.tbl_extend("keep", opts or {}, defaults)

    vim.g.nvim_github_linker_default_remote = options.default_remote
    vim.g.nvim_github_linker_copy_to_clipboard = options.copy_to_clipboard

    if options.mappings then
        vim.cmd([[command! -range GithubLink lua require('nvim-github-linker').github_linker_command(<line1>,<line2>)]])
    end
end

-- github.com has two types of remote url
-- * HTTPS, for example: https://github.com/vincent178/nvim-github-linker.git
-- * SSH, for example: git@github.com:vincent178/nvim-github-linker.git
function M.build_base_url(git_remote_url, branch_name)
    local repo_path = vim.fn.substitute(git_remote_url, '\\(.*github.com\\)\\(:\\|\\/\\)\\([^/]*\\)/\\(.*\\)\\.git', 'https://github.com/\\3/\\4', '')
    return repo_path .. "/blob/" .. branch_name
end

function M.get_remote_url(remote_name)
    return vim.fn.systemlist("git config --get remote." .. remote_name .. ".url")[1]
end

function M.get_brand_name()
    return vim.fn.systemlist("git symbolic-ref --short HEAD")[1]
end

function M.get_relative_path()
    local current_file = vim.fn.expand('%:p')
    local project_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    return vim.fn.fnamemodify(current_file, ':gs?' .. project_root .. '??')
end

function M.github_linker(start_line, end_line)
    local remote_url = M.get_remote_url(vim.g.nvim_github_linker_default_remote)
    local brand_name = M.get_brand_name()
    local base_url = M.build_base_url(remote_url, brand_name)
    local relative_path = M.get_relative_path()

    local line_number = start_line or vim.fn.line('.')
    local end_line_number = end_line or line_number

    local range = 'L' .. line_number
    if line_number ~= end_line_number then
        range = 'L' .. line_number .. '-L' .. end_line_number
    end
    return base_url .. relative_path .. '#' .. range
end

function M.github_linker_command()
    local start_line, end_line, url

    -- Check if a range is provided
    if vim.fn.line("'<") == 0 and vim.fn.line("'>") == 0 then
        start_line = vim.fn.line('.')
        end_line = start_line
    else
        -- If no range is provided, use the current line
        start_line = vim.fn.line("'<")
        end_line = vim.fn.line("'>")
    end

    if start_line and end_line then
        url = M.github_linker(start_line, end_line)
    else
        url = M.github_linker()
    end

    if vim.g.nvim_github_linker_copy_to_clipboard then
        vim.fn.setreg("+", url)
    else
        print(url)
    end
end

return M
