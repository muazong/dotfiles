vim.lsp.config("roslyn", {
  cmd = {
    "roslyn",
    "--stdio",
    "--logLevel=Information",
    "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.log.get_filename()),
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
  ["textDocument/hover"] = function(_, params, ctx, _)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
      return
    end

    local hover_result = client:request_sync("textDocument/hover", params, 1000, ctx.bufnr)
    return hover_result and hover_result.result or nil
  end,
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      dotnet_enable_inlay_hints_for_parameters = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_indexer_parameters = true,
      dotnet_enable_inlay_hints_for_literal_parameters = true,
      dotnet_enable_inlay_hints_for_object_creation_parameters = true,
      dotnet_enable_inlay_hints_for_other_parameters = true,
      dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
    },

    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})
