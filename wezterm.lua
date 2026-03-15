local wezterm = require('wezterm')
local Config = require('config')

require('utils.backdrops')
   -- :set_focus('#000000')
   -- :set_images_dir(require('wezterm').home_dir .. '/Pictures/Wallpapers/')
   :set_images()
   :random()

require('events.left-status').setup()
require('events.right-status').setup({ date_format = '%a %H:%M:%S' })
require('events.tab-title').setup({ hide_active_tab_unseen = false, unseen_icon = 'numbered_box' })
require('events.new-tab-button').setup()
require('events.gui-startup').setup()

-- Handle neovim smart-splits pane navigation via escape sequences
wezterm.on('user-var-changed', function(window, pane, name, value)
   if name == 'WEZTERM_NAVIGATE' then
      local direction_map = {
         Left = 'Left',
         Right = 'Right',
         Up = 'Up',
         Down = 'Down',
      }
      local direction = direction_map[value]
      if direction then
         window:perform_action(
            wezterm.action.ActivatePaneDirection(direction),
            pane
         )
      end
   end
end)

return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch')).options
