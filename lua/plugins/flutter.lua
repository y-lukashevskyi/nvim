return {
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = { "dart" },
    -- pubspec.yaml / *.dart aren't the only entry points: loading on the commands
    -- too means `:FlutterRun` works from any buffer in the project.
    cmd = {
      "FlutterRun",
      "FlutterDevices",
      "FlutterEmulators",
      "FlutterReload",
      "FlutterRestart",
      "FlutterQuit",
      "FlutterDetach",
      "FlutterOutlineToggle",
      "FlutterDevTools",
      "FlutterLogToggle",
      "FlutterPubGet",
      "FlutterPubUpgrade",
      "FlutterSuper",
      "FlutterReanalyze",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("flutter-tools").setup({
        -- If you switch to fvm, point this at the pinned SDK instead:
        -- flutter_lookup_cmd = "dirname $(dirname $(readlink -f $(which flutter)))"
        ui = {
          border = "rounded",
          -- Route flutter-tools messages through vim.notify (noice renders them)
          notification_style = "native",
        },
        decorations = {
          statusline = { app_version = true, device = true, project_config = true },
        },
        widget_guides = { enabled = true },
        closing_tags = { enabled = true, highlight = "Comment", prefix = "// " },
        dev_log = {
          enabled = true,
          notify_errors = true,
          open_cmd = "botright 15split",
        },
        dev_tools = { autostart = false, auto_open_browser = false },
        outline = { open_cmd = "30vnew", auto_open = false },
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = {},
          register_configurations = function(_)
            require("dap").configurations.dart = {}
            -- Pick up .vscode/launch.json flavors/targets if the project has them
            pcall(function()
              require("dap.ext.vscode").load_launchjs(nil, { dart = { "dart" }, flutter = { "dart" } })
            end)
          end,
        },
        lsp = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
            -- Don't analyze generated / vendored code
            analysisExcludedFolders = {
              vim.fn.expand("$HOME/development/flutter/packages"),
              vim.fn.expand("$HOME/.pub-cache"),
              vim.fn.expand("$HOME/development/flutter/.pub-cache"),
            },
          },
          on_attach = function(_, bufnr)
            -- Inline colour swatches for Color(0xFF...) / Colors.red.
            -- Neovim 0.12 does this natively; flutter-tools' own `lsp.color`
            -- option is deprecated, so drive vim.lsp.document_color instead.
            vim.lsp.document_color.enable(true, { bufnr = bufnr }, { style = "virtual" })

            local map = function(lhs, rhs, desc)
              vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
            end
            -- Dart-only LSP extras (generic LSP maps live in config.mappings)
            map("<leader>Fu", "<cmd>FlutterSuper<cr>", "Go to super class/method")
            map("<leader>Fa", "<cmd>FlutterReanalyze<cr>", "Reanalyze project")
          end,
        },
      })

      require("telescope").load_extension("flutter")

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
      end

      -- Run / hot reload
      map("<leader>Fr", "<cmd>FlutterRun<cr>", "Flutter run")
      map("<leader>Fh", "<cmd>FlutterReload<cr>", "Flutter hot reload")
      map("<leader>FR", "<cmd>FlutterRestart<cr>", "Flutter hot restart")
      map("<leader>Fq", "<cmd>FlutterQuit<cr>", "Flutter quit")
      map("<leader>FQ", "<cmd>FlutterDetach<cr>", "Flutter detach")
      -- Targets
      map("<leader>Fd", "<cmd>FlutterDevices<cr>", "Flutter devices")
      map("<leader>Fe", "<cmd>FlutterEmulators<cr>", "Flutter emulators")
      -- Inspect
      map("<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", "Toggle widget outline")
      map("<leader>Fl", "<cmd>FlutterLogToggle<cr>", "Toggle dev log")
      map("<leader>Fc", "<cmd>FlutterLogClear<cr>", "Clear dev log")
      map("<leader>Ft", "<cmd>FlutterDevTools<cr>", "Start DevTools")
      -- Packages
      map("<leader>Fp", "<cmd>FlutterPubGet<cr>", "Pub get")
      map("<leader>FP", "<cmd>FlutterPubUpgrade<cr>", "Pub upgrade")
      -- Picker over everything above
      map("<leader>FF", "<cmd>Telescope flutter commands<cr>", "Flutter commands")
    end,
  },

  -- Debugging (Flutter attaches to this via `debugger.run_via_dap` above)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    lazy = true,
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
      end
      map("<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
      map("<leader>dB", function()
        vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
          if cond and cond ~= "" then dap.set_breakpoint(cond) end
        end)
      end, "Conditional breakpoint")
      map("<leader>dc", dap.continue, "Continue / start")
      map("<leader>di", dap.step_into, "Step into")
      map("<leader>do", dap.step_over, "Step over")
      map("<leader>dO", dap.step_out, "Step out")
      map("<leader>dr", dap.repl.toggle, "Toggle REPL")
      map("<leader>dx", dap.terminate, "Terminate session")
      map("<leader>du", dapui.toggle, "Toggle DAP UI")
    end,
    keys = {
      { "<leader>db", desc = "Toggle breakpoint" },
      { "<leader>dc", desc = "Continue / start" },
      { "<leader>du", desc = "Toggle DAP UI" },
    },
  },
}
