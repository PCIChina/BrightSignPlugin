------------------------------------------------------------------ Setup Page ---------------------------------------------------------------------------------------
----- Connect to Device ---------------------
table.insert(ctrls,{Name = "IPAddress", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "Username", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "Password", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
----- Device Information --------------------
table.insert(ctrls,{Name = "txt_Model", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_Time", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "SerialNumber", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_UpTime", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "DeviceFirmware", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_UpTimeSeconds", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_Family", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_IsPlayer", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
----- Power --------------------
table.insert(ctrls,{Name = "txt_Battery", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_Source", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_POE", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
----- Networking --------------------
table.insert(ctrls,{Name = "txt_Name", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_Description", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_InterfaceName", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls,{Name = "txt_MAC", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
----- Refresh --------------------
table.insert(ctrls,{Name = "btnR_Refresh", ControlType = "Button", ButtonType = "Trigger", Count = 1, UserPin = true, PinStyle = "Both"})
----- Connection Status --------------------
table.insert(ctrls,{Name = "Status", ControlType = "Indicator", IndicatorType =  Reflect and "StatusGP" or "Status", Count = 1, UserPin = true, PinStyle = "Output"})
