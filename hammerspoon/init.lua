function moveCursorToCenter ()
  local currentApp = hs.application.frontmostApplication()
  local currentWindow = currentApp:focusedWindow()
  local currentScreen = currentWindow:screen()
  local rect = currentScreen:fullFrame()
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  win:setFrame(f)
end)

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
  f.h = max.h

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
  f.h = max.h

  win:setFrame(f)
end)



hs.hotkey.bind({"cmd","alt","ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = f.x
  f.y = max.y
  f.h = max.h / 2

  win:setFrame(f)
end)

hs.hotkey.bind({"cmd","alt","ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = f.x
  f.y = max.y / 2
  f.h = max.h / 2

  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "V", function()
  hs.application.launchOrFocus("Visual Studio Code")
  moveCursorToCenter()
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "G", function()
  hs.application.launchOrFocus("Google Chrome")
  moveCursorToCenter()
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "S", function()
  hs.application.launchOrFocus("Slack")
  moveCursorToCenter()
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "M", function()
  hs.application.launchOrFocus("Google Play Music Desktop Player")
  moveCursorToCenter()
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "T", function()
  hs.application.launchOrFocus("iTerm")
  moveCursorToCenter()
end)

hs.hotkey.bind({"ctrl", "cmd","alt"}, "P", function()
  hs.application.launchOrFocus("Postico")
  moveCursorToCenter()
end)


hs.hotkey.bind({"cmd","alt","ctrl"}, "N", function()
  local currentWindow = hs.window.frontmostWindow()
  local currentScreen = currentWindow:screen()

  currentWindow:moveToScreen(currentScreen:next())
end)

hs.hotkey.bind({"ctrl","alt","cmd"}, "U", function()
  hs.application.launchOrFocus("Notes")
  moveCursorToCenter()
end)

hs.hotkey.bind({"ctrl","alt","cmd"}, "E", function()
  hs.application.launchOrFocus("Emacs")
  moveCursorToCenter()
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
