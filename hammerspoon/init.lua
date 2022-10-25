currentAppName = "NONE"
windowFilter = hs.window.filter.new(false)
windowSwitcher = hs.window.switcher.new(windowFilter)


function moveCursorToCenter ()
  local currentApp = hs.application.frontmostApplication()
  local currentWindow = currentApp:focusedWindow()
  local currentScreen = currentWindow:screen()
  local rectangle = currentScreen:fullFrame()
  local center = hs.geometry.rectMidPoint(rectangle)
  hs.mouse.absolutePosition(center)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "F", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  local resizeInt = 0
  f.x = max.x
  f.y = max.y + resizeInt
  f.w = max.w
  f.h = max.h - resizeInt

  win:setFrame(f)
end)

hs.hotkey.bind({"cmd","alt","ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = f.y
  f.w = max.w / 2
  f.h = f.h

  win:setFrame(f)
end)

hs.hotkey.bind({"cmd","alt","ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = f.x + max.w / 2
  f.y = f.y
  f.w = max.w / 2
  f.h = f.h

  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl"}, "N", function()
  local currentWindow = hs.window.frontmostWindow()
  local currentScreen = currentWindow:screen()

  currentWindow:moveToScreen(currentScreen:next())
end)

hs.hotkey.bind({"cmd","alt","ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = f.x
  f.y = max.y
  f.w = f.w
  f.h = max.h / 2

  win:setFrame(f)
end)

hs.hotkey.bind({"cmd","alt","ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = f.x
  f.y = max.h / 2
  f.h = max.h / 2
  f.w = f.w

  win:setFrame(f)
end)

function setOpenApp (appName)
  apps = hs.application.find(appName)
  if (apps == nil or tablelength(apps:allWindows()) == 0) then
    hs.application.launchOrFocus(appName)
  else
    apps:activate()
  end
  moveCursorToCenter()
end

hs.hotkey.bind({"ctrl", "cmd","alt"}, "G", function()
  setOpenApp("Google Chrome")
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "S", function()
  setOpenApp("Spotify")
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "D", function()
  setOpenApp("Slack")
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "M", function()
  setOpenApp("Mattermost")
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "P", function()
  setOpenApp("DataGrip")
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "K", function()
  setOpenApp("iTerm")
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "J", function()
  setOpenApp("WebStorm")
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "R", function()
  setOpenApp("RubyMine")
end)

-- hs.hotkey.bind({"ctrl", "cmd","alt"}, "V", function()
--   setOpenApp("Visual Studio Code")
-- end)

hs.hotkey.bind({"ctrl","alt","cmd"}, "T", function()
  setOpenApp("Tower")
end)

hs.alert.show("Config loaded")
