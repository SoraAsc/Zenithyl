return {
  {
    "mason-org/mason-lspconfig.nvim",
    ensure_installed = {
      "vtsls",
      "html",
      "cssls",
      "tailwindcss",
      "eslint",
      "emmet_ls",
      "jsonls",
      "lua_ls"
    },
    dependencies = {
      { "mason-org/mason.nvim", opts= {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      vim.lsp.config("tsserver", {
        settings = {},
      })
      vim.lsp.enable("tsserver")
    end,
  },
}
