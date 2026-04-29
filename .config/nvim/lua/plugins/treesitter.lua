return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
	ensure_installed = {
	  "c",
	  "lua",
	  "vim",
	  "vimdoc",
	  "query",
	  "html",
	  "css",
	  "json",
	  "typescript",
	  "tsx"
	},
	sync_install = false,
	highlight = {
	  enable = true,
	  additional_vim_regex_highlighting = false,
	},
	indent = {
	  enable = true,
	},
      })
    end
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
    require('treesj').setup()
    end,
  }
}
