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

describe('build_anchor', function()
    it('support single line', function()
        local input = "L14"
        local output = plugin.build_anchor(14, 14)
        local expected = "L14"
        assert(output == expected)
    end)

    it('support multi line', function()
        local input = "L14-L18"
        local output = plugin.build_anchor(14, 18)
        local expected = "L14-L18"
        assert(output == expected)
    end)
end)
