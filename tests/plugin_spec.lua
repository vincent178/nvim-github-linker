local plugin = require('nvim-github-linker')

describe('build_base_url', function()
    it('support https url', function()
        local input = "https://github.com/vincent178/nvim-github-linker.git"
        local output = plugin.build_base_url(input, "master")
        local expected = "https://github.com/vincent178/nvim-github-linker/blob/master"
        assert(output == expected)
    end)

    it('support ssh url', function()
        local input = "git@github.com:vincent178/nvim-github-linker.git"
        local output = plugin.build_base_url(input, "master")
        local expected = "https://github.com/vincent178/nvim-github-linker/blob/master"
        assert(output == expected)
    end)
end)
