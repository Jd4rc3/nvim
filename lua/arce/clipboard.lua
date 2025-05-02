local M = {}

-- Función para verificar si un ejecutable está disponible
function M.check_executable(exe)
  return vim.fn.executable(exe) == 1
end

-- Función para configurar el portapapeles dependiendo del sistema operativo
function M.setup_clipboard()
  local uname = vim.loop.os_uname()

  -- Detectar el sistema operativo
  if uname.sysname == "Linux" then
    if uname.release:find("Microsoft") then
      -- WSL (Windows Subsystem for Linux)
      print('win32yank configured')
      vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
          ["+"] = "win32yank.exe -i --crlf",
          ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
          ["+"] = "win32yank.exe -o --lf",
          ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = 0,
      }
    else
      -- Linux nativo
      local clipboard_tool

      -- Determinar la herramienta de portapapeles disponible
      if M.check_executable("wl-copy") then
        print('wl-copy configured')
        clipboard_tool = {
          copy = {
            ["+"] = "wl-copy",
            ["*"] = "wl-copy",
          },
          paste = {
            ["+"] = "wl-paste",
            ["*"] = "wl-paste",
          },
        }
      elseif M.check_executable("xclip") then
        print('xclip configured')
        clipboard_tool = {
          copy = {
            ["+"] = "xclip -selection clipboard",
            ["*"] = "xclip -selection primary",
          },
          paste = {
            ["+"] = "xclip -selection clipboard -o",
            ["*"] = "xclip -selection primary -o",
          },
        }
      elseif M.check_executable("xsel") then
        print('xsel configured')
        clipboard_tool = {
          copy = {
            ["+"] = "xsel --clipboard --input",
            ["*"] = "xsel --primary --input",
          },
          paste = {
            ["+"] = "xsel --clipboard --output",
            ["*"] = "xsel --primary --output",
          },
        }
      else
        -- Si no hay herramienta de portapapeles disponible
        print("No clipboard tool found! Please install xclip, xsel or wl-copy.")
        return
      end

      -- Configurar el portapapeles
      vim.g.clipboard = {
        name = "LinuxClipboard",
        copy = clipboard_tool.copy,
        paste = clipboard_tool.paste,
        cache_enabled = 0,
      }
    end
  end
end

return M

