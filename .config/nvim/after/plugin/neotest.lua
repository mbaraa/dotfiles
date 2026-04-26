local neotest = require("neotest");

neotest.setup({
    adapters = {
        require("neotest-go")({
            experimental = {
                test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
            recursive_run = true
        })
    }
});

local function run_test_diagnostic()
    neotest.summary.open();
    neotest.output_panel.open();
end

vim.keymap.set('n', '<leader>tr', function ()
    neotest.run.run();
    run_test_diagnostic();
end, {});

vim.keymap.set('n', '<leader>tf', function ()
    neotest.run.run(vim.fn.expand("%"));
    run_test_diagnostic();
end, {});

vim.keymap.set('n', '<leader>ts', function ()
    neotest.run.stop();
    run_test_diagnostic();
end);
