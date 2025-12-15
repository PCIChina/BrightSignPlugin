-- Bright Sign Plugin
-- by PCI-China
-- December 2025

-- Information block for the plugin
--[[ #include "info.lua" ]]

Logo = "--[[ #encode "logo.png" ]]"
local Colors = {
  MainGP = {220,220,220},
  InnerGP = {230,230,230},
  HeaderFill = {0,0,0,0},
  HeaderColor = {51,51,51},
  ButtonColor = {140,140,140},
  NumberColor = {0,0, 150},
  GroupBoxStrokeColor = {102,102,102},
  ReadOnlyTextColor = {100,100,100,255}
}
-- Define the color of the plugin object in the design
function GetColor(props)
  return { 102, 102, 102 }
end

-- The name that will initially display when dragged into a design
function GetPrettyName(props)
  return "Bright Sign Plugin, version " .. PluginInfo.BuildVersion
end

-- Optional function used if plugin has multiple pages
PageNames = { "Setup" }  --List the pages within the plugin
function GetPages(props)
  local pages = {}
  --[[ #include "pages.lua" ]]
  return pages
end

-- Define User configurable Properties of the plugin
function GetProperties()
  local props = {}
  --[[ #include "properties.lua" ]]
  return props
end

-- Optional function to update available properties when properties are altered by the user
function RectifyProperties(props)
  --[[ #include "rectify_properties.lua" ]]
  return props
end

-- Optional function to define components used within the plugin
function GetComponents(props)
  local components = {}
  --[[ #include "components.lua" ]]
  return components
end

-- Defines the Controls used within the plugin
function GetControls(props)
  local ctrls = {}
  --[[ #include "controls.lua" ]]
  return ctrls
end

--Layout of controls and graphics for the plugin UI to display
function GetControlLayout(props)
  local layout = {}
  local graphics = {}
  --[[ #include "layout.lua" ]]
  return layout, graphics
end

--Start event based logic
if Controls then
  --[[ #include "runtime.lua" ]]
end
