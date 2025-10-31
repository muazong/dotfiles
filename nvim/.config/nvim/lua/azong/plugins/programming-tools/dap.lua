return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  keys = {
    { "<leader>b", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
    { "<leader>cs", "<cmd>DapContinue<cr>", desc = "Continue/Start Debug" },
    { "<leader>sI", "<cmd>DapStepInto<cr>", desc = "Step Into" },
    { "<leader>sO", "<cmd>DapStepOver<cr>", desc = "Step Over" },
    { "<leader>O", "<cmd>DapStepOut<cr>", desc = "Step Out" },
    { "<leader>tn", "<cmd>DapTerminate<cr>", desc = "Terminate Debug" },
    {
      "<leader>sU",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle Debug UI",
    },
    {
      "<leader>se",
      function()
        require("dapui").eval()
      end,
      desc = "Add expression to watch",
    },
    {
      "<leader>sr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle Debug REPL",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- highlight
    vim.cmd("hi DapBreakpointColor guifg=#A7AAE1")
    vim.cmd("hi DapStoppedColor guifg=#98c379")
    vim.cmd("hi DapLogPointColor guifg=#61afef")
    vim.cmd("hi DapBreakpointRejectedColor guifg=#e06c75")

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedColor", linehl = "Visual", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPointColor", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "DapBreakpointRejectedColor", linehl = "", numhl = "" }
    )

    -- UI setup
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Mason adapter setup
    require("mason-nvim-dap").setup({
      ensure_installed = { "js-debug-adapter", "debugpy", "netcoredbg" },
      automatic_installation = true,
    })

    -- Python adapter
    dap.adapters.python = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
      args = { "-m", "debugpy.adapter" },
    }

    -- Node adapter
    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
    end

    -- .NET / ASP.NET adapter
    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    -- Config debug JS/TS + NestJS
    local js_ts_configs = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file (Node.js)",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Node Process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch NestJS (ts-node)",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "node",
        runtimeArgs = { "-r", "ts-node/register", "src/main.ts" },
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        envFile = "${workspaceFolder}/.env",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch NestJS (dist)",
        program = "${workspaceFolder}/dist/main.js",
        cwd = "${workspaceFolder}",
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        sourceMaps = true,
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Next.js",
        runtimeExecutable = "npm",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
    }

    -- Config debug Python
    local python_configs = {
      {
        type = "python",
        request = "launch",
        name = "Launch file (Python)",
        program = "${file}",
        console = "integratedTerminal",
      },
      {
        type = "python",
        request = "launch",
        name = "Launch with arguments",
        program = "${file}",
        console = "integratedTerminal",
        args = { "arg1", "arg2" },
      },
      {
        type = "python",
        request = "attach",
        name = "Attach to process",
        processId = require("dap.utils").pick_process,
      },
    }

    -- Config debug .NET / ASP.NET
    local dotnet_configs = {
      {
        type = "coreclr",
        name = "Launch ASP.NET (auto DLL)",
        request = "launch",
        program = function()
          local cwd = vim.fn.getcwd()
          local dlls = vim.fn.glob(cwd .. "/bin/Debug/net*/**/*.dll", false, true)
          if not dlls or vim.tbl_isempty(dlls) then
            error("Not found DLL in bin/Debug/")
          end
          table.sort(dlls, function(a, b)
            return vim.fn.getftime(a) > vim.fn.getftime(b)
          end)
          return dlls[1]
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        env = { ASPNETCORE_ENVIRONMENT = "Development" },
      },
      {
        type = "coreclr",
        name = "Attach to .NET process",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
    }

    -- Register configs
    dap.configurations.javascript = js_ts_configs
    dap.configurations.typescript = js_ts_configs
    dap.configurations.javascriptreact = js_ts_configs
    dap.configurations.typescriptreact = js_ts_configs
    dap.configurations.json = js_ts_configs
    dap.configurations.python = python_configs
    dap.configurations.cs = dotnet_configs
  end,
}
