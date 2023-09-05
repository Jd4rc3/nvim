local dap = require("dap")

dap.adapters["pwa-node"] = {
    type = "server",
    host = "127.0.0.1",
    port = 8123,
    executable = {
        command = "js-debug-adapter",
    },
}

for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
        },
    }
end

vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "toggle breakpoint" })
vim.keymap.set("n", "<F10>", "<cmd> DapContinue <CR>", { desc = "Continue" })
vim.keymap.set("n", "<F8>", "<cmd> DapStepOver <CR>", { desc = "Step over" })
vim.keymap.set("n", "<F7>", "<cmd> DapStepInto <CR>", { desc = "Step into" })
vim.keymap.set("n", "<S-F8>", "<cmd> DapStepOut <CR>", { desc = "Step out" })
