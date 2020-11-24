currentAppName = "NONE"
windowFilter = hs.window.filter.new(false)
windowSwitcher = hs.window.switcher.new(windowFilter)

filters = {}

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
  filters[currentAppName] = false
  filters[appName] = true
  currentAppName = appName
  windowFilter = windowFilter:setFilters(filters)
end)

function moveCursorToCenter ()
  local currentApp = hs.application.frontmostApplication()
  local currentWindow = currentApp:focusedWindow()
  local currentScreen = currentWindow:screen()
  local rect = currentScreen:fullFrame()
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
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

hs.hotkey.bind({"ctrl", "cmd","alt"}, "P", function()
  setOpenApp("Postico")
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "K", function()
  setOpenApp("kitty")
end)

hs.hotkey.bind({"ctrl","alt","cmd"}, "T", function()
  setOpenApp("Tower")
end)

hs.hotkey.bind({"cmd","alt","ctrl"}, "H", function()
  windowSwitcher:next()
  moveCursorToCenter()
end)

hs.hotkey.bind({"cmd","alt","ctrl"}, "U", function()
  hs.application.launchOrFocus(currentAppName)
end)

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
  end
  if doReload then
      hs.reload()
  end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.alert.show("Config loaded")
