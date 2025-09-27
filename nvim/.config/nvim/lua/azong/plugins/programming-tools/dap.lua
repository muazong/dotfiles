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
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle Debug UI",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      desc = "Add expression to watch",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle Debug REPL",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

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
      ensure_installed = { "js-debug-adapter", "debugpy" },
      automatic_installation = true,
    })

    dap.adapters.python = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
      args = { "-m", "debugpy.adapter" },
    }

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

    -- Config debug JS/TS + NestJS
    local js_ts_configs = {
      -- Debug current file (Node.js)
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
      -- Attach on process Node
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Node Process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      -- Debug NestJS with ts-node
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
      -- Debug NestJS build dist/
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

    dap.configurations.javascript = js_ts_configs
    dap.configurations.typescript = js_ts_configs
    dap.configurations.javascriptreact = js_ts_configs
    dap.configurations.typescriptreact = js_ts_configs
    dap.configurations.json = js_ts_configs
    dap.configurations.python = python_configs
  end,
}
