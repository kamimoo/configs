local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local config = {
  font = wezterm.font 'Cica',
  font_size = 14.0,
  front_end = "Software",
  color_scheme = 'Dracula',
  window_background_opacity = 0.90,
  use_fancy_tab_bar = true,
  	
  keys = {
    -- CTRL-SHIFT-l activates the debug overlay
    { key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
    -- Clears only the scrollback and leaves the viewport intact.
    -- You won't see a difference in what is on screen, you just won't
    -- be able to scroll back until you've output more stuff on screen.
    -- This is the default behavior.
    {
      key = 'k',
      mods = 'CMD',
      action = act.ClearScrollback 'ScrollbackOnly',
    },
    -- Clears the scrollback and viewport leaving the prompt line the new first line.
    {
      key = 'k',
      mods = 'CMD',
      action = act.ClearScrollback 'ScrollbackAndViewport',
    },
    -- Clears the scrollback and viewport, and then sends CTRL-L to ask the
    -- shell to redraw its prompt
    {
      key = 'k',
      mods = 'CMD',
      action = act.Multiple {
        act.ClearScrollback 'ScrollbackAndViewport',
        act.SendKey { key = 'L', mods = 'CTRL' },
      },
    },
    -- Full Screen
    {
      key = 'n',
      mods = 'SHIFT|CTRL',
      action = act.ToggleFullScreen,
    },
    {
      key = 'c',
      mods = 'SHIFT|SUPER',
      action = act.ActivateCopyMode,
    },
  },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.front_end = "Software"

  local launch_menu = {}

  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })

  -- Enumerate any WSL distributions that are installed and add those to the menu
  local success, wsl_list, wsl_err =
    wezterm.run_child_process { 'wsl.exe', '-l' }
  -- `wsl.exe -l` has a bug where it always outputs utf16:
  -- https://github.com/microsoft/WSL/issues/4607
  -- So we get to convert it
  wsl_list = wezterm.utf16_to_utf8(wsl_list)

  for idx, line in ipairs(wezterm.split_by_newlines(wsl_list)) do
    -- Skip the first line of output; it's just a header
    if idx > 1 then
      -- Remove the "(Default)" marker from the default line to arrive
      -- at the distribution name on its own
      local distro = line:gsub(' %(Default%)', '')

      -- Add an entry that will spawn into the distro with the default shell
      table.insert(launch_menu, {
        label = distro .. ' (WSL default shell)',
        args = { 'wsl.exe', '--distribution', distro },
      })

      -- Here's how to jump directly into some other program; in this example
      -- its a shell that probably isn't the default, but it could also be
      -- any other program that you want to run in that environment
      table.insert(launch_menu, {
        label = distro .. ' (WSL zsh login shell)',
        args = {
          'wsl.exe',
          '--distribution',
          distro,
          '--exec',
          '/bin/zsh',
          '-l',
        },
      })
    end
  end
  config.launch_menu = launch_menu
end

return config

