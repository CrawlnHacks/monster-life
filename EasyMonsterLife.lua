-- Lua

-- Constants
PET_SLOT = 5
BOX_NUM = 99

-- Mouse Button-Number Mapping
LCLCK = 1       -- Left Click
RCLCK = 2       -- Right Click
WCLCK = 3       -- Wheel Click
BACK = 4        -- Back
FORWARD = 5     -- Forward
DPICYC = 6      -- DPI Cycle
DPIUP = 7       -- DPI Up
DPIDOWN = 8     -- DPI Down
DPISHFT = 9     -- DPI Shift
-- 

function OnEvent(event, arg) -- function call on click

    -- Check profile activation
    if (event == "PROFILE_ACTIVATED") then
        EnablePrimaryMouseButtonEvents(true)
    elseif event == "PROFILE_DEACTIVATED" then
        ReleaseMouseButton(RCLCK) -- to prevent it from being stuck on
    end
    

    -- Conditions
    if (event == "MOUSE_BUTTON_PRESSED" and arg == LCLCK) then
        OutputLogMessage("LCLCK Pressed Print mouse position\n", event)
        PrintMousePosition()
    end
    
    if (event == "MOUSE_BUTTON_PRESSED" and arg == RCLCK) then
        OutputLogMessage("RCLCK Pressed, Print mouse position\n", event)
        PrintMousePosition()
    end

    if (event == "MOUSE_BUTTON_PRESSED" and arg == WCLCK) then
        OutputLogMessage("WCLCK Pressed, Abort Macro\n", event)
        RUNNING = false
    end
    
    if (event == "MOUSE_BUTTON_PRESSED" and arg == FORWARD) then
        OutputLogMessage("FORWARD Pressed\n", event)
        RUNNING = true
        CareReleaseBoxMacro(BOX_NUM) -- repeat 40 times for default
    end

    if (event == "MOUSE_BUTTON_PRESSED" and arg == BACK) then
        OutputLogMessage("BACK Pressed\n", event)
        CareReleaseMacro(PET_SLOT-1)
    end
end


function ReleasePet()
-- Auto release pet
    local xpos, ypos = GetMousePosition();
    PressAndReleaseMouseButton(3)
    Sleep(30)
    
    MoveMouseClient(0,-7)
    Sleep(30)
    
    PressAndReleaseMouseButton(1)
    Sleep(30)
    
    MoveMouseClient(30, -15)
    Sleep(100)

    PressAndReleaseMouseButton(1)
    Sleep(100)

    PressKey("enter");
    Sleep(50)
    ReleaseKey("enter");
    Sleep(50)

    MoveMouseClient(-30, 22)
    Sleep(10)
end




function CarePet(cnt)
-- Auto care pet 3 times
    local xpos, ypos = GetMousePosition();
    for i = 1, cnt do
        PressAndReleaseMouseButton(3); -- Right click
        Sleep(30)

        MoveMouseClient(0, -10.7)
        Sleep(30)

        PressAndReleaseMouseButton(1); -- Left click
        Sleep(30)
        
        for j = 1,2 do
            PressKey("enter");
            Sleep(30)
            ReleaseKey("enter");
            Sleep(30)
        end
        Sleep(30)

        -- Move mouse to the start position
        MoveMouseClient(0, 10.7)
        Sleep(10)
    end
end

function OpenBox()
    MoveMouseClient(5, -5) -- Move cursor to Nongjang Ggumigi
    Sleep(30)

    PressAndReleaseMouseButton(1); -- Left Click
    Sleep(30)

    MoveMouseClient(9, 5)
    Sleep(30)

    PressAndReleaseMouseButton(1); -- Left Click
    Sleep(30)

    for i = 1, 3 do
        PressKey("enter");
        Sleep(50)
        ReleaseKey("enter");
        Sleep(50)
    end

    MoveMouseClient(-14, -5)
    Sleep(100)

    PressAndReleaseMouseButton(1); -- Left Click
    Sleep(30)

    MoveMouseClient(0, 5) -- Move cursor to Nongjang Ggumigi
    Sleep(30)
end

function CareReleaseBoxMacro(cnt)
-- Care and Release Pet [cnt] times
    local i = 1
    while i <= cnt and not IsMouseButtonPressed(2) do
        CarePet(3)
        Sleep(70)
        ReleasePet()
        Sleep(70)
        OpenBox()
        Sleep(70)
        i = i+1
    end
end

function CareReleaseMacro(cnt)
    -- Care and Release Pet [cnt] times
        local i = 1
        while i <= cnt and not IsMouseButtonPressed(2) do
            CarePet(3)
            Sleep(70)
            ReleasePet()
            Sleep(70)
            i = i+1
        end
    end

function PrintMousePosition()
    local _x, _y = GetMousePosition();
    OutputLogMessage("Mouse is at %d, %d\n", _x, _y);
end


function MoveMouseClient(xdiff, ydiff)
    local cx = 1
    local cy = 1
     
    if xdiff > 0 then cx = 1
    elseif xdiff == 0 then cx = 0
    else cx = -1
    end
    
    
    if ydiff > 0 then cy = 1
    elseif ydiff == 0 then cy = 0
    else cy = -1
    end
    
    
    for i = 1, Abs(xdiff) do
        MoveMouseRelative(cx*10, 0)
        Sleep(1)
    end
    
    Sleep(1)
    
    for i = 1, Abs(ydiff) do
        MoveMouseRelative(0, cy*10)
        Sleep(1)
    end
end

function Abs(_x)
    if _x > 0 then return _x
    else return -_x
    end

end


