return {
    {
        "mfussenegger/nvim-dap",
        lazy         = true,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap   = require("dap")
            local dapui = require("dapui")

            require("nvim-dap-virtual-text").setup()

            dapui.setup({
                layouts = {
                    {
                        elements = {
                            { id = "scopes",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                        },
                        size = 40, position = "left",
                    },
                    {
                        elements = {
                            { id = "repl",    size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size = 0.25, position = "bottom",
                    },
                },
            })

            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open()  end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

            -- C / C++
            dap.adapters.gdb = {
                type    = "executable",
                command = "gdb",
                args    = { "--interpreter=dap", "--eval-command", "set print pretty on" },
            }
            dap.configurations.c = {
                {
                    name    = "Launch (gdb)",
                    type    = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Ejecutable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd     = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
            dap.configurations.cpp = dap.configurations.c

            -- Python
            dap.adapters.python = {
                type    = "executable",
                command = "python3",
                args    = { "-m", "debugpy.adapter" },
            }
            dap.configurations.python = {
                {
                    type       = "python",
                    request    = "launch",
                    name       = "Launch file",
                    program    = "${file}",
                    pythonPath = function()
                        return vim.fn.executable("python3") == 1 and "python3" or "python"
                    end,
                },
            }

            require("keymaps.dap")
        end,
    },
}
