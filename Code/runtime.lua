print(PluginInfo.BuildVersion)
json = require('rapidjson')

if Controls then 
  -- Control aliases
  -- Setup~Connect to Device
  IPAddress = Controls.IPAddress
  Username = Controls.Username
  Password = Controls.Password
  txt_Password2 = SecretStorage["text.1"]

  -- Setup~Device Information
  txt_Model = Controls.txt_Model
  txt_Time = Controls.txt_Time
  SerialNumber = Controls.SerialNumber
  txt_UpTime = Controls.txt_UpTime
  DeviceFirmware = Controls.DeviceFirmware
  txt_UpTimeSeconds = Controls.txt_UpTimeSeconds
  txt_Family = Controls.txt_Family
  txt_IsPlayer = Controls.txt_IsPlayer

  -- Setup~Power
  txt_Battery = Controls.txt_Battery
  txt_Source = Controls.txt_Source
  txt_POE = Controls.txt_POE

  -- Setup~Networking
  txt_Name = Controls.txt_Name
  txt_Description = Controls.txt_Description
  txt_InterfaceName = Controls.txt_InterfaceName
  txt_MAC = Controls.txt_MAC

  -- Setup~Refresh
  btnR_Refresh = Controls.btnR_Refresh

  -- Setup~Connection Status
  Status = Controls.Status

  DebugTx = false 
  DegugRx = false 
  DebugFunctionCalls = false 

  ---------------------------------------------------------------------------------------------------------
  HeartBeat = Timer.New()   
  LoopTimer = Timer.New()
  
  Protocol = "http"  
  TimeoutInSecond = 5  
  PollingRate = Properties["Polling"].Value


  DebugPrint = Properties["Debug Print"].Value  

  ----------------------------------------------- Status Begin ----------------------------------------------
  
  UI = {
    Status = { 
      OK = {Value = 0, Message = { None = "", Success = "Connected successfully"}},
      FAULT = {
        Value = 2, 
        Message = {
          Invalid = "Username or Password Incorrect", 
        }
      },
      MISSING = {
        Value = 4, 
        Message = { 
          None = "", 
          IPInvalid = "No IP Address", 
          NoConnection = "Disconnected"
        }
      }
    }
  }  
  ----------------------------------------------- Status End ----------------------------------------------------
  ----------------------------------------------- Utility Start -------------------------------------------------
  function IsCorrectIP(s)
    if DebugFunctionCalls then print("IsIP() Called") end

    if s == nil or s == ""  then
      return nil
    end

    s = string.gsub(s, " ", "")

    pattern = "%d+%.%d+%.%d+%.%d+"
    tmp = nil

    for item in string.gmatch(s, pattern) do 
      tmp = item      
      break
    end
    if tmp ~= s then
      return nil
    end

    for fragment in string.gmatch(tmp, "%d+") do
      a = tonumber(fragment)
      if a < 0 or a > 255 then
        return nil
      end
    end

    return tmp
  end

  function StringToHex(str)
    local hex = ""
    -- 遍历字符串中的每个字符
    for i = 1, #str do
        -- 获取字符的ASCII值
        local byte = string.byte(str, i)
        -- 转换为两位十六进制数，不足两位前面补0
        hex = hex .. string.format("%02x", byte)
    end
    return hex
  end
  ----------------------------------------------- Utility End ---------------------------------------------------

  ----------------------------------------------- Request Start ---------------------------------------------------
  function CreateUrl(protocol, ip, path, param)
    local tmp = {
      Host = protocol.."://"..ip,
      Path = path,
      Query = param
    }
    return HttpClient.CreateUrl(tmp)
  end

  function Get(url, username, password, done)    
    if IsCorrectIP(IPAddress.String) then
      if DebugTx then print("Tx:"..url) end

      HttpClient.Download {
        Url = url,
        Method = "GET", 
        User = username,
        Password = password,
        Headers = {["Content-Type"] = "application/json"},
        Timeout = TimeoutInSecond,
        EventHandler = done
      }
    end
  end
  ----------------------------------------------- Request End -----------------------------------------------------
  ----------------------------------------------- Event Start ---------------------------------------------------
  function PasswordEnter(ctrl)
    txt_Password2.String = ctrl.String
    ctrl.String = ctrl.String:gsub(".", "*")

    LoginRequest()
  end  

  function LoginRequest()
    if DebugFunctionCalls then print("LoginRequest Called") end

    StopBeat()
    LoopTimer:Stop()
    local ip = IPAddress.String
    local username = Username.String
    local password = txt_Password2.String
    
    isIp = IsCorrectIP(ip)
    if isIp then        
      if username ~= nil and username ~="" and password ~= nil and password ~="" then 
        RefreshRequest() 
        StartBeat()
      else
        ReportStatus(UI.Status.FAULT.Value, UI.Status.FAULT.Message.Invalid)
      end    
    else 
      ReportStatus(UI.Status.MISSING.Value, UI.Status.MISSING.Message.IPInvalid)       
    end
  end

  function GetInfo()
    if DebugFunctionCalls then print("GetInfo Called") end

    local ip = IPAddress.String
    local username = Username.String
    local password = txt_Password2.String
    
    isIp = IsCorrectIP(ip)
    if isIp then        
      if username ~= nil and username ~="" and password ~= nil and password ~="" then  
        Get(CreateUrl(Protocol, ip, "api/v1/info"), username, password, GetInfoDone)
      else
        ReportStatus(UI.Status.FAULT.Value, UI.Status.FAULT.Message.Invalid)
      end    
    else 
      ReportStatus(UI.Status.MISSING.Value, UI.Status.MISSING.Message.IPInvalid)       
    end
  end
  function GetInfoDone(tbl, code, d, err)
    if DebugFunctionCalls then print("GetInfoDone Called") end
    if DebugRx then print("Rx:[code:"..code.." Data:"..d.." Error:"..(err or "None").."]") end

    if code == 200 then
      ChangeStatus(true) 
      local data = (json.decode(d))
      if data ~= nil then
        --Device Information
        txt_Model.String = data.data.result.model
        SerialNumber.String = data.data.result.serial
        DeviceFirmware.String = data.data.result.FWVersion
        txt_UpTime.String = data.data.result.upTime
        txt_Family.String = data.data.result.family
        txt_UpTimeSeconds.String = data.data.result.upTimeSeconds 
        txt_IsPlayer.String = tostring(data.data.result.isPlayer)
        --Power
        txt_Battery.String = data.data.result.power.result.battery
        txt_Source.String = data.data.result.power.result.source
        txt_POE.String = data.data.result.poe.result.status
        --Networking
        txt_Name.String = data.data.result.networking.result.name
        txt_Description.String = data.data.result.networking.result.description
        txt_InterfaceName.String = data.data.result.ethernet[1].interfaceName
        txt_MAC.String = data.data.result.ethernet[1].IPv4[1].mac
      end
    else
      ChangeStatus(false) 
    end
  end

  function GetInfoTime()
    if DebugFunctionCalls then print("GetInfoTime Called") end

    local ip = IPAddress.String
    local username = Username.String
    local password = txt_Password2.String
    
    isIp = IsCorrectIP(ip)
    if isIp then              
      if username ~= nil and username ~="" and password ~= nil and password ~="" then  
        Get(CreateUrl(Protocol, ip, "api/v1/time"), username, password, GetInfoTimeDone)
      else
        ReportStatus(UI.Status.FAULT.Value, UI.Status.FAULT.Message.Invalid)
      end    
    else 
      ReportStatus(UI.Status.MISSING.Value, UI.Status.MISSING.Message.IPInvalid)       
    end
  end
  function GetInfoTimeDone(tbl, code, data, err)
    if DebugFunctionCalls then print("GetInfoTimeDone Called") end
    if DebugRx then print("Rx:[code:"..code.." Data:"..data.." Error:"..(err or "None").."]") end

    if code == 200 then
      ChangeStatus(true)
      local d = (json.decode(data))
      if d ~= nil then
        --Device Information
        txt_Time.String = d.data.result.time
      end
    else
      ChangeStatus(false)
    end
  end

  function RefreshRequest()
    if DebugFunctionCalls then print("RefreshRequest Called") end

    GetInfo()
    GetInfoTime()
  end

  function ChangeStatus(ok)    
    if HeartBeat:IsRunning() == false then
      return
    end
    
    if ok then    
      if Status.Value ~= UI.Status.OK.Value then
        LoopTimer:Start(PollingRate)
        ReportStatus(UI.Status.OK.Value, UI.Status.OK.Message.None)
      end 
    else
      if Status.String ~= UI.Status.MISSING.Message.NoConnection then        
        LoopTimer:Stop()
        ReportStatus(UI.Status.MISSING.Value, UI.Status.MISSING.Message.NoConnection)      
      end
    end
  end

  function CheckTimeout()
    if Status.Value ~= UI.Status.OK.Value then
      RefreshRequest()
    end
  end

  ----------------------------------------------- Event End ---------------------------------------------------

  -- Sets flags based on Debug Print properties that are set before running, allowing end users to determine the print messages going to the debug window.
  function SetupDebugPrint()
    DebugTx = false
    DebugRx = false 
    DebugFunctionCalls = false
    if DebugPrint == "Function Calls" then 
      DebugFunctionCalls = true 
    elseif DebugPrint == "Tx" then
      DebugTx = true
    elseif DebugPrint == "Rx" then
      DebugRx = true
    elseif DebugPrint == "Tx/Rx" then
      DebugTx = true
      DebugRx = true
    elseif DebugPrint == "All" then 
      DebugTx = true
      DebugRx = true
      DebugFunctionCalls = true
    end

    if DebugFunctionCalls then print("SetupDebugPrint() Called") end
  end

  function ReportStatus(id, msg)
    Status.Value = id
    Status.String = msg
  end

  function StartBeat()
    HeartBeat:Start(1)
  end

  function StopBeat()
    HeartBeat:Stop()
  end

  function Initialization()
    SetupDebugPrint()     
    if DebugFunctionCalls then print("Initialization() Called") end

    HeartBeat.EventHandler = function ()        
      CheckTimeout()
    end
    LoopTimer.EventHandler = function ()
      RefreshRequest()
    end
    -- Initialize Event
    IPAddress.EventHandler = LoginRequest
    Username.EventHandler = LoginRequest
    Password.EventHandler = PasswordEnter

    btnR_Refresh.EventHandler = RefreshRequest

    LoginRequest()
  end

  Initialization()
end
