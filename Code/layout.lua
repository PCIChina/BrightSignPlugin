-- Use to locate a block
LogoW = 640
LogoH = 96
LogoRW = 215
LogoRH = 69

TitleLeftRight = 10
TitleX = TitleLeftRight
TitleY = LogoH
TitleW = LogoW - TitleLeftRight * 2
TitleH = 20
TitleFontSize = 16

HeaderLeftRight = 10
HeaderX = TitleX + HeaderLeftRight
HeaderY = LogoH + TitleH
HeaderW = TitleW - HeaderLeftRight * 2
HeaderH = 24
HeaderFontSize = 14

LabelFontSize = 12 
ItemFontSize = 9

Divider = 7   
ComponentH = 20 
BlockLine = 10 
ContentLeftRight = 40

---------------------------------------------------------------------- Setup GroupBox -------------------------------------------------------------------
SetupGroupBoxX = TitleX
SetupGroupBoxY = TitleY + TitleH
SetupGroupBoxW = LogoW - TitleLeftRight * 2
SetupGroupBoxH = HeaderH * 6 + BlockLine * 6 + ComponentH * 11 + Divider * 12 + 50

-- Connect to Device
ConnectToDeviceX = SetupGroupBoxX + HeaderLeftRight
ConnectToDeviceY = SetupGroupBoxY

-- Device Information
DeviceInformationX = SetupGroupBoxX + HeaderLeftRight
DeviceInformationY = SetupGroupBoxY + HeaderH + BlockLine + ComponentH * 2 + Divider * 2

-- Power
PowerX = SetupGroupBoxX + HeaderLeftRight
PowerY = SetupGroupBoxY + HeaderH * 2 + BlockLine * 2 + ComponentH * 6 + Divider * 6

-- Networking
NetworkingX = SetupGroupBoxX + HeaderLeftRight
NetworkingY = SetupGroupBoxY + HeaderH * 3 + BlockLine * 3 + ComponentH * 8 + Divider * 8

-- Refresh
RefreshX = SetupGroupBoxX + HeaderLeftRight
RefreshY = SetupGroupBoxY + HeaderH * 4 + BlockLine * 4 + ComponentH * 10 + Divider * 10

-- Connection Status
ConnectionStatusX = SetupGroupBoxX + HeaderLeftRight
ConnectionStatusY = SetupGroupBoxY + HeaderH * 5 + BlockLine * 5 + ComponentH * 11 + Divider * 11

-- Show Logo at the top
table.insert(graphics, {
  Type = "GroupBox",
  CornerRadius = 0,
  StrokeWidth = 0,
  Position = {0, 0},
  Fill = {255, 255, 255},
  Size = {LogoW, LogoH}
})
table.insert(graphics, {
  Type = "Image",
  Image = Logo,
  Size = {LogoRW, LogoRH},
  Position = {(LogoW - LogoRW)/2, (LogoH - LogoRH)/2},
})
local CurrentPage = PageNames[props["page_index"].Value]
if CurrentPage == "Setup" then
  local text = "Q-SYS Monitoring Plugin V1.0"

  -- GroupBoxes 
  table.insert(graphics, {
    Type = "GroupBox",
    Fill = Colors.Transparent,
    CornerRadius = 0,
    StrokeWidth = 0,
    Position = {SetupGroupBoxX, SetupGroupBoxY},
    Size = {SetupGroupBoxW, SetupGroupBoxH + TitleLeftRight}
  })
  table.insert(graphics, {
    Type = "Label",
    Text = text,
    Fill = Colors.HeaderFill,
    Color = Colors.HeaderColor,
    Font = "Roboto",
    FontStyle = "Bold",
    FontSize = TitleFontSize,
    HTextAlign = "Left",
    Position = {TitleX, TitleY},
    Size = {TitleW, TitleH}
  })
  table.insert(graphics, {
    Type = "GroupBox",
    Fill = Colors.MainGP,
    CornerRadius = 0,
    StrokeWidth = 0,
    Position = {SetupGroupBoxX, SetupGroupBoxY},
    Size = {SetupGroupBoxW, SetupGroupBoxH}
  })

  -- Connect to Device
  table.insert(graphics, {
    Type = "Header",
    Text = "Connect to Device",
    Fill = Colors.HeaderFill,
    Color = Colors.HeaderColor,
    Font = "Roboto",
    FontSize = HeaderFontSize,
    HTextAlign = "Center",
    FontStyle = "Bold",
    Position = {HeaderX, ConnectToDeviceY},
    Size = {HeaderW, HeaderH}
  })
  local ConnectToDevices = {"IPAddress", "Username", "","Password"}
  local ConnectToDeviceNames = {"IPAddress", "Username", "", "Password"}
  local ConnectToDeviceTexts = {"IP Address", "Username", "", "Password"}
  local ConnectToDeviceTypes = {"Text", "Text", "", "Text"}  

  for i = 1, 4, 1 do
    if ConnectToDevices[i] ~= "" then
      table.insert(graphics, {
        Type = "Label",
        Text = ConnectToDeviceTexts[i],
        Fill = Colors.HeaderFill,
        Font = "Roboto",
        FontSize = LabelFontSize,
        Color = Colors.HeaderColor,
        HTextAlign = "Right",
        Position = {i % 2 == 1 and ConnectToDeviceX or ConnectToDeviceX + 290, ConnectToDeviceY + HeaderH + Divider * ((i + 1) // 2) + ComponentH * ((i + 1) // 2 - 1)},
        Size = {i % 2 == 1 and 130 or 110, ComponentH}
      })
      if ConnectToDeviceTypes[i] == "Text" then
        layout[ConnectToDevices[i]] = {
          PrettyName = "Setup~Connect to Device~"..ConnectToDeviceNames[i],
          Style = "Text",
          Position = {i % 2 == 1 and ConnectToDeviceX + 140 or ConnectToDeviceX + 410, ConnectToDeviceY + HeaderH + Divider * ((i + 1) // 2) + ComponentH * ((i + 1) // 2 - 1)},
          Size = {150, ComponentH}
        }     
      end
    end
  end

  -- Device Information
  table.insert(graphics, {
    Type = "Header",
    Text = "Device Information",
    Fill = Colors.HeaderFill,
    Color = Colors.HeaderColor,
    Font = "Roboto",
    FontSize = HeaderFontSize,
    HTextAlign = "Center",
    FontStyle = "Bold",
    Position = {HeaderX, DeviceInformationY},
    Size = {HeaderW, HeaderH}
  })
  local DeviceInformations = {"txt_Model", "txt_Time", "SerialNumber", "txt_UpTime", "DeviceFirmware", "txt_UpTimeSeconds", "txt_Family", "txt_IsPlayer"}
  local DeviceInformationNames = {"Model", "Time", "SerialNumber", "UpTime", "DeviceFirmware", "UpTimeSeconds", "Family", "IsPlayer"}
  local DeviceInformationTexts = {"model", "time", "serial", "upTime", "FWVersion", "upTimeSeconds", "family", "isPlayer"}
  local DeviceInformationTypes = {"ReadOnlyText", "ReadOnlyText", "ReadOnlyText", "ReadOnlyText", "ReadOnlyText", "ReadOnlyText", "ReadOnlyText", "ReadOnlyText"}  
  for i = 1, 8, 1 do
    table.insert(graphics, {
      Type = "Label",
      Text = DeviceInformationTexts[i],
      Fill = Colors.HeaderFill,
      Font = "Roboto",
      FontSize = LabelFontSize,
      Color = Colors.HeaderColor,
      HTextAlign = "Right",
      Position = {i % 2 == 1 and DeviceInformationX or DeviceInformationX + 290, DeviceInformationY + HeaderH + Divider * ((i + 1) // 2) + ComponentH * ((i + 1) // 2 - 1)},
      Size = {i % 2 == 1 and 130 or 110, ComponentH}
    })
    if DeviceInformationTypes[i] == "ReadOnlyText" then
      layout[DeviceInformations[i]] = {
        PrettyName = "Setup~Device Information~"..DeviceInformationNames[i],
        Style = "Text",
        Color = Colors.ReadOnlyTextColor,
        IsReadOnly = true,
        Position = {i % 2 == 1 and DeviceInformationX + 140 or DeviceInformationX + 410, DeviceInformationY + HeaderH + Divider * ((i + 1) // 2) + ComponentH * ((i + 1) // 2 - 1)},
        Size = {150, ComponentH}
      } 
    end
  end

  -- Power
  table.insert(graphics, {
    Type = "Header",
    Text = "Power",
    Fill = Colors.HeaderFill,
    Color = Colors.HeaderColor,
    Font = "Roboto",
    FontSize = HeaderFontSize,
    HTextAlign = "Center",
    FontStyle = "Bold",
    Position = {HeaderX, PowerY},
    Size = {HeaderW, HeaderH}
  })
  local Powers = {"txt_Battery", "txt_Source", "txt_POE"}
  local PowerNames = {"Battery", "Source", "POE"}
  local PowerTexts = {"battery", "source", "POE"}
  local PowerTypes = {"ReadOnlyText", "ReadOnlyText", "ReadOnlyText"}  
  for i = 1, 3, 1 do
    table.insert(graphics, {
      Type = "Label",
      Text = PowerTexts[i],
      Fill = Colors.HeaderFill,
      Font = "Roboto",
      FontSize = LabelFontSize,
      Color = Colors.HeaderColor,
      HTextAlign = "Right",
      Position = {i % 2 == 1 and PowerX or PowerX + 290, PowerY + HeaderH + Divider * ((i + 1) // 2) + ComponentH * ((i + 1) // 2 - 1)},
      Size = {i % 2 == 1 and 130 or 110, ComponentH}
    })
    if PowerTypes[i] == "ReadOnlyText" then
      layout[Powers[i]] = {
        PrettyName = "Setup~Power~"..PowerNames[i],
        Style = "Text",
        Color = Colors.ReadOnlyTextColor,
        IsReadOnly = true,
        Position = {i % 2 == 1 and PowerX + 140 or PowerX + 410, PowerY + HeaderH + Divider * ((i + 1) // 2) + ComponentH * ((i + 1) // 2 - 1)},
        Size = {150, ComponentH}
      } 
    end
  end

  -- Networking
  table.insert(graphics, {
    Type = "Header",
    Text = "Networking",
    Fill = Colors.HeaderFill,
    Color = Colors.HeaderColor,
    Font = "Roboto",
    FontSize = HeaderFontSize,
    HTextAlign = "Center",
    FontStyle = "Bold",
    Position = {HeaderX, NetworkingY},
    Size = {HeaderW, HeaderH}
  })
  local Networkings = {"txt_Name", "txt_Description", "txt_InterfaceName", "txt_MAC"}
  local NetworkingNames = {"Name", "Description", "InterfaceName", "MAC"}
  local NetworkingTexts = {"name", "description", "interfaceName", "mac"}
  local NetworkingTypes = {"ReadOnlyText", "ReadOnlyText", "ReadOnlyText", "ReadOnlyText"}  
  for i = 1, 4, 1 do
    table.insert(graphics, {
      Type = "Label",
      Text = NetworkingTexts[i],
      Fill = Colors.HeaderFill,
      Font = "Roboto",
      FontSize = LabelFontSize,
      Color = Colors.HeaderColor,
      HTextAlign = "Right",
      Position = {i % 2 == 1 and NetworkingX or NetworkingX + 290, NetworkingY + HeaderH + Divider * ((i + 1) // 2) + ComponentH * ((i + 1) // 2 - 1)},
      Size = {i % 2 == 1 and 130 or 110, ComponentH}
    })
    if NetworkingTypes[i] == "ReadOnlyText" then
      layout[Networkings[i]] = {
        PrettyName = "Setup~Networking~"..NetworkingNames[i],
        Style = "Text",
        Color = Colors.ReadOnlyTextColor,
        IsReadOnly = true,
        Position = {i % 2 == 1 and NetworkingX + 140 or NetworkingX + 410, NetworkingY + HeaderH + Divider * ((i + 1) // 2) + ComponentH * ((i + 1) // 2 - 1)},
        Size = {150, ComponentH}
      } 
    end
  end

  -- Refresh
  table.insert(graphics, {
    Type = "Header",
    Text = "Refresh",
    Fill = Colors.HeaderFill,
    Color = Colors.HeaderColor,
    Font = "Roboto",
    FontSize = HeaderFontSize,
    HTextAlign = "Center",
    FontStyle = "Bold",
    Position = {HeaderX, RefreshY},
    Size = {HeaderW, HeaderH}
  })
  layout["btnR_Refresh"] = {
    PrettyName = "Setup~Refresh~Refresh",
    Style = "Button",
    ButtonStyle = "Trigger",
    Legend = "Refresh",
    Position = {RefreshX + (HeaderW - 150)/2, RefreshY + HeaderH + Divider},
    Size = {150, ComponentH}
  } 

  -- Connection Status
  table.insert(graphics, {
    Type = "Header",
    Text = "Connection Status",
    Fill = Colors.HeaderFill,
    Color = Colors.HeaderColor,
    Font = "Roboto",
    FontSize = HeaderFontSize,
    HTextAlign = "Center",
    FontStyle = "Bold",
    Position = {HeaderX, ConnectionStatusY},
    Size = {HeaderW, HeaderH}
  })
  layout["Status"] = {
    PrettyName = "Status",
    Style = "Text",
    Position = {ConnectionStatusX + (HeaderW - 300)/2, ConnectionStatusY + HeaderH + Divider},
    Size = {300, 50}
  } 
end

layout["Code"] = {
  PrettyName = "Code",
  Style = "None"
}