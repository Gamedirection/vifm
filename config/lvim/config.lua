-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "qwen3-coder-next:cloud", -- Or whatever model you have pulled in Ollama
      host = "100.106.163.87",
      port = "11434",
      display_mode = "float", -- Opens in a floating window
      show_prompt = true,    -- Shows what you sent to the AI
      show_model = true,     -- Shows which model is responding
      no_auto_close = false, -- Close the window automatically when you switch buffers
      init = function() end,
      -- init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
      -- The command for the Ollama service.
      command = function(options)
          local body = {model = options.model, stream = true}
          return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
      end,
    },
  },
}

-- Normal and Visual mode mapping
-- Press <Leader>] to open the AI menu
lvim.builtin.which_key.mappings["]"] = {
  name = "Ollama AI",
  ["]"] = { ":Gen<CR>", "AI Menu" },
  ["c"] = { ":Gen Chat<CR>", "Chat with AI" },
  ["e"] = { ":Gen Enhance_Code<CR>", "Enhance Code" },
}

-- Visual mode specifically for highlighting code and asking for changes
vim.keymap.set('v', '<leader>]]', ':Gen<CR>')
