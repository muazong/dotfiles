return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = {
      {
        "tris203/rzls.nvim",
        branch = "pullDiags",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("rzls").setup({})
        end,
      },
    },
    config = function()
      require("roslyn").setup({
        config = {
          cmd = {
            "roslyn",
            "--stdio",
            "--logLevel=Information",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
            "--razorSourceGenerator=" .. vim.fs.joinpath(
              vim.fn.stdpath("data"),
              "mason",
              "packages",
              "roslyn",
              "libexec",
              "Microsoft.CodeAnalysis.Razor.Compiler.dll"
            ),
            "--razorDesignTimePath=" .. vim.fs.joinpath(
              vim.fn.stdpath("data"),
              "mason",
              "packages",
              "rzls",
              "libexec",
              "Targets",
              "Microsoft.NET.Sdk.Razor.DesignTime.targets"
            ),
          },
          handlers = require("rzls.roslyn_handlers"),
          ["textDocument/hover"] = function(_, params, ctx, config)
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            local bufnr = ctx.bufnr
            local hover_result = client.request_sync("textDocument/hover", params, nil, bufnr)
            return hover_result and hover_result.result or nil
          end,
          settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
            },
          },
        },
      })
    end,
    init = function()
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    end,
  },
}
