hs.loadSpoon("WindowHalfsAndThirds")

spoon.WindowHalfsAndThirds:bindHotkeys({
    -- Basic halfs
    left_half = { {"ctrl", "alt", "cmd", "shift"}, "h"},
    right_half = { {"ctrl", "alt", "cmd", "shift"}, "l" },

    -- Maximize
    max = { {"ctrl", "alt", "cmd", "shift"}, "f"},
})

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "m", function()
    local win = hs.window.focusedWindow()
    if win then
        win:moveToScreen(win:screen():next())
    end
end)

-- Custom center function (50% width/height, centered)
-- hs.hotkey.bind({"ctrl"}, "c", function()
--     local win = hs.window.focusedWindow()
--     if not win then return end
-- 
--     local screen = win:screen()
--     local frame = screen:frame()
-- 
--     -- Set to 50% width and height, centered
--     win:setFrame({
--         x = frame.x + frame.w * 0.25,  -- Center horizontally
--         y = frame.y + frame.h * 0.15,  -- Center vertically
--         w = frame.w * 0.5,             -- 50% width
--         h = frame.h * 0.7              -- 70% height
--     })
-- end)

-- Cmd+1: Open/focus Chrome and center it
hs.hotkey.bind({"cmd"}, "1", function()
    -- Launch or focus Chrome
    local chromeApp = hs.application.find("Google Chrome")
    local wasRunning = chromeApp ~= nil


    hs.application.launchOrFocus("Google Chrome")

    -- Wait a moment for Chrome to open, then position it
    if not wasRunning then
        hs.timer.doAfter(0.5, function()
            local win = hs.window.focusedWindow()
            if win and win:application():name() == "Google Chrome" then
               win:maximize()
            end
        end)
   end
end)


-- Cmd+2: Open/focus Terminal and put it on right side
hs.hotkey.bind({"cmd"}, "2", function()
    local terminalApp = hs.application.find("Terminal")
    local wasRunning = terminalApp ~= nil

    hs.application.launchOrFocus("Terminal")
end)


-- Cmd+3: Open/focus Obsidian and put it on right side
hs.hotkey.bind({"cmd"}, "3", function()
    local terminalApp = hs.application.find("Obsidian")
    local wasRunning = terminalApp ~= nil

    hs.application.launchOrFocus("Obsidian")
end)


hs.hotkey.bind({"cmd"}, "5", function()
    print("Cmd+2 pressed - trying simplified approach...")

    -- First, just activate Chrome
    hs.application.launchOrFocus("Google Chrome")

    -- Then try to find and switch to Claude tab
    hs.timer.doAfter(0.3, function()
        local script = [[
            tell application "Google Chrome"
                activate

                -- Get the front window
                set frontWindow to front window

                -- Check tabs in front window first
                repeat with i from 1 to (count of tabs of frontWindow)
                    if URL of tab i of frontWindow contains "claude.ai" then
                        set active tab index of frontWindow to i
                        return "Switched to Claude tab " & i
                    end if
                end repeat

                -- If not found in front window, open new tab
                open location "https://claude.ai/chat"
                return "Opened new Claude tab"
            end tell
        ]]

        local ok, result = hs.osascript.applescript(script)
        print("Simplified result:", ok, result)

        if not ok then
            print("AppleScript failed, falling back to URL handler...")
            hs.urlevent.openURL("https://claude.ai/chat")
        end
    end)
end)
