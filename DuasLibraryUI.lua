local Players, TweenService, UIS, RunService, StarterGui, HttpService =
game:GetService("Players"), game:GetService("TweenService"), game:GetService("UserInputService"),
game:GetService("RunService"), game:GetService("StarterGui"), game:GetService("HttpService")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
-- Some games delete any unknown ScreenGui the moment it lands in PlayerGui ("tried to set the parent of DuaKNoUI to NULL"),
-- so the hub is mounted in the executor's protected GUI container first (gethui / CoreGui) and PlayerGui is only the fallback.
local GUI_HOST = PG
do
local host
pcall(function() if gethui then host = gethui() end end)
if not host then pcall(function() host = game:GetService("CoreGui"); local _ = host.Name end) end
if host then GUI_HOST = host end
end
local function mountGui(g)
pcall(function() if syn and syn.protect_gui then syn.protect_gui(g) end end)
for _, h in ipairs({GUI_HOST, PG}) do
local ok = pcall(function() g.Parent = h end)
if ok and g.Parent == h then return true end
end
return false
end
local function findGui(name)
return GUI_HOST:FindFirstChild(name) or PG:FindFirstChild(name)
end
-- @@EMBEDDED_BEGIN
-- auto-managed block: the library rewrites it (auto-save, see CONFIG below); don't edit by hand
local EMBEDDED_ADMINS = {
	"DuaKNo",
	"Saifb90",
}
local EMBEDDED_FEED = "https://gist.githubusercontent.com/GGSOZI/a365d7537cbb6b79907db1c222d385e2/raw/DuaLibrary.json"
local EMBEDDED_PAGES = {
	["Dua's favorites"] = {
		{name = "NPC control | manager by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/cbzgmC91"))()]]},
		{name = "Show Ownership | Increase Ownership by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/crRxyN72"))()]]},
		{name = "Part drag, spin, telekinesis by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/biR1ZZA9"))()]]},
		{name = "Free Cam by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/kZhz0A5x"))()]]},
	},
	["NPCs"] = {
		{name = "Rocket launcher by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/92qkQRNL"))()]]},
		{name = "Push Laser Gun for NPC by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/Ebvc5ALC"))()]]},
		{name = "Laser Gun for NPC by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/VEniSJJZ"))()]]},
		{name = "Kill all NPC by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/MWHU0UDE"))()]]},
		{name = "NPC control | manager by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/cbzgmC91"))()]]},
	},
	["Random"] = {
		{name = "Animation speed changer by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/BwXcvUgg"))()]]},
		{name = "Spin around by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/6Wd3cFJY"))()]]},
		{name = "No limbs by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/idn8Qx2E"))()]]},
	},
	["Utility"] = {
		{name = "Kill all NPC by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/MWHU0UDE"))()]]},
		{name = "Animation speed changer by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/BwXcvUgg"))()]]},
		{name = "Show Ownership | Increase Ownership by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/crRxyN72"))()]]},
		{name = "Part drag, spin, telekinesis by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/biR1ZZA9"))()]]},
		{name = "Free Cam by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/kZhz0A5x"))()]]},
		{name = "NPC control | manager by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/cbzgmC91"))()]]},
	},
	["Weapons"] = {
		{name = "Rocket launcher by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/92qkQRNL"))()]]},
		{name = "Push Laser Gun for NPC by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/Ebvc5ALC"))()]]},
		{name = "Laser Gun for NPC by DuaKNo", code = [[
loadstring(game:HttpGet("https://pastebin.com/raw/VEniSJJZ"))()]]},
	},
}
-- @@EMBEDDED_END
local SELF_FILE = nil
local SELF_CANDIDATES = {"DuasLibraryUI.lua", "DuasLibraryUI.txt", "DuaLibrary.lua", "DuaLibrary.txt"}
local SIZE = UDim2.fromOffset(560, 350)
local TITLE_H, PAD = 34, 10
local PARTICLE_MAX = 150
local WINDOW_TITLE = "Dua's Library"
local SB_CLOSED, SB_OPEN = 44, 176
local SB_TWEEN = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local NOTIF_TIME = 2
local FILE = {
SETTINGS = "DuaLibrary_Settings.json", SCRIPTS = "DuaLibrary_Scripts.json", ADMIN = "DuaLibrary_Admin.json",
ONLINE = "DuaLibrary_Online.json", TOKEN = "DuaLibrary_Token.txt", FEED = "DuaLibrary_Feed.json",
GIST = "DuaLibrary.json", FAVS = "DuaLibrary_Favs.json", NOTES = "DuaLibrary_Notes.json",
}
local ADD_PAGE = "Share Script"
local DEFAULTS = {
hue = 0.75, sat = 1, winTrans = 0.6,
particlesOn = true, particleCount = 90, speed = 1,
shadowOn = true, lockDrag = false,
autoClose = true, autoCloseDelay = 2,
soundOn = true, seenNotice = "", seenMsg = 0, rmDone = 0, favSig = "", reopen = false, reopenMig = false, chatTips = true, reloadUrl = "", antiAfk = false, fullbright = false, noFog = false, esp = false, clockTime = 14, maxZoom = 128,
font = "Nunito", style = "Minimal", uiMig = false, bold = true,
walkSpeed = 16, jumpPower = 50, gravity = 196.2, fov = 70, flySpeed = 60, infJump = false, noclip = false, fly = false,
winW = 560, winH = 350, toggleKey = "RightShift", launcher = true, launX = 0.97, launY = 0.5, ui3Mig = false, ui4Mig = false, val = 1, themeName = "Violet", edgeW = 5, edgeAnim = true, edgeSpeed = 12,
chatGames = false, shareGame = true, chatLang = "", chatLangLast = "", helpSeen = "",
shareAdd = true, dmSeen = "", shareSort = "new", bgUrl = "", bgVis = 0.75, bgOn = true, bgMig = false, bgMig2 = false, bgPreset = 6, bgMig3 = false, ui5Mig = false, bgMig4 = false, ui6Mig = false, duaSort = "def", autoRun = true, autoDelay = 3, updSeen = 0, favFolder = "", ui7Mig = false,
}
local LIMITS = {
hue = {0, 1}, sat = {0.05, 1}, val = {0.1, 1}, edgeW = {1, 12}, edgeSpeed = {3, 30}, winTrans = {0, 0.6},
particleCount = {0, PARTICLE_MAX}, speed = {0.2, 3}, autoCloseDelay = {1, 6},
bgVis = {0.05, 0.9}, winW = {380, 1100}, winH = {260, 800}, walkSpeed = {0, 300}, jumpPower = {0, 300}, gravity = {0, 400}, fov = {30, 120}, flySpeed = {10, 300}, clockTime = {0, 24}, maxZoom = {10, 1000},
}
local WHITE = Color3.new(1, 1, 1)
local RED = Color3.fromRGB(210, 70, 95)
local V2, U2, UO = Vector2.new, UDim2.new, UDim2.fromOffset
local L = {
texts = setmetatable({}, {__mode = "k"}), corners = setmetatable({}, {__mode = "k"}),
strokes = setmetatable({}, {__mode = "k"}), uiOf = {}, plus = {}, DUA = "Dua's script",
ALL = "All", FAVP = "Favorited", FAVL = "Favorite", FAVD = "Favorited by Dua", CHK = "Check favoritisms", isSection = {},
log = {}, unread = 0, sent = {}, cards = {}, grids = {}, names = {}, DISCORD = "https://discord.gg/empgqd5qpq",
nolog = {["Follow on Instagram"] = true, ["Join our Discord"] = true},
}
-- minimal navy palette (everything in the GUI draws from these)
L.P = {
card = Color3.fromRGB(21, 20, 29), ctrl = Color3.fromRGB(35, 34, 47), ctrlHot = Color3.fromRGB(49, 47, 66),
input = Color3.fromRGB(13, 13, 19), line = Color3.fromRGB(58, 56, 78), muted = Color3.fromRGB(148, 146, 170),
btn = Color3.fromRGB(100, 82, 190), info = Color3.fromRGB(58, 86, 156),
}
L.fills = setmetatable({}, {__mode = "k"})
L.fitList = {}
L.LET = {["Dua's script"] = "⭐", ["Completed script request"] = "✅", Favorited = "❤️", ["Share Script"] = "📤", ["ScriptBlox scripts"] = "📜", ["Global chat"] = "💬", Universal = "🌐", Workshop = "🛠️", Info = "ℹ️", Admin = "👑"}
local FAM = "rbxasset://fonts/families/"
local function new(class, props, parent)
local o = Instance.new(class)
for k, v in pairs(props) do o[k] = v end
if props.BackgroundColor3 == L.P.btn then L.fills[o] = "btn" end
if props.Font == Enum.Font.RobotoMono then
pcall(function() o.FontFace = Font.new(FAM .. "RobotoMono.json", Enum.FontWeight.Bold) end)
o:SetAttribute("FixedFont", true)
elseif props.Font then
L.texts[o] = true
if L.face then L.face(o) end
end
o.Parent = parent
return o
end
local function round(o, r)
local c = new("UICorner", {CornerRadius = UDim.new(0, r >= 90 and r or math.floor(math.min(r, 10) * (L.rs or 1) + 0.5))}, o)
L.corners[c] = r
return c
end
local themeStroke = Color3.fromRGB(205, 165, 255)
local accentColor = Color3.fromRGB(190, 140, 255)
local themeBtn = Color3.fromRGB(110, 60, 190)
local themed = setmetatable({}, {__mode = "k"})
local themedFill = L.fills
local function outline(o, thick, trans)
local st = new("UIStroke", {Thickness = thick * (L.ss or 1), Transparency = trans, Color = themeStroke, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o)
themed[st] = true
L.strokes[st] = thick
return st
end
local function text(parent, props)
props.BackgroundTransparency = 1
props.Font = props.Font or Enum.Font.Nunito
props.TextColor3 = props.TextColor3 or WHITE
return new("TextLabel", props, parent)
end
local function fit(l, max, min)
l.TextScaled = true
new("UITextSizeConstraint", {MaxTextSize = max, MinTextSize = min}, l)
end
local function tween(o, t, props) TweenService:Create(o, t, props):Play() end
local FAST = TweenInfo.new(0.15)
L.SW = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
L.PAGE = TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
L.PIN = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
L.POUT = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
L.pageHome = setmetatable({}, {__mode = "k"})
L.cardHome = setmetatable({}, {__mode = "k"})
L.pageTw = setmetatable({}, {__mode = "k"})
L.cardTw = setmetatable({}, {__mode = "k"})
-- dropdown rows fade in whenever they become visible
function L.popIn(o)
local bt = o.BackgroundTransparency
local tt = o:IsA("TextButton") and o.TextTransparency or nil
o:GetPropertyChangedSignal("Visible"):Connect(function()
if not o.Visible then return end
o.BackgroundTransparency = 1
if tt then o.TextTransparency = 1 end
local goal = {BackgroundTransparency = bt}
if tt then goal.TextTransparency = tt end
tween(o, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal)
end)
end
-- pressed feedback: shrink a hair on press, spring back on release / leave
function L.press(b, amt)
local sc = new("UIScale", {Name = "Press", Scale = 1}, b)
local down = false
b.MouseButton1Down:Connect(function() down = true; tween(sc, L.PIN, {Scale = amt or 0.96}) end)
local function up() if down then down = false; tween(sc, L.POUT, {Scale = 1}) end end
b.MouseButton1Up:Connect(up)
b.MouseLeave:Connect(up)
end
local function button(parent, x, y, w, h, label, color, trans, z)
if color == nil or color == WHITE then color, trans = L.P.ctrl, 0 end
local b = new("TextButton", {
Position = UO(x, y), Size = UO(w, h), BackgroundColor3 = color, BackgroundTransparency = trans or 0,
BorderSizePixel = 0, AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12,
Text = label, TextColor3 = WHITE, ZIndex = z,
}, parent)
round(b, 8)
local hov = new("UIStroke", {Thickness = 1, Transparency = 1, Color = themeStroke, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, b)
themed[hov] = true
b.MouseEnter:Connect(function() tween(hov, FAST, {Transparency = 0.3}) end)
b.MouseLeave:Connect(function() tween(hov, FAST, {Transparency = 1}) end)
L.press(b)
return b
end
local function debounce(delay, fn)
local tok = 0
return function()
tok = tok + 1
local t = tok
task.delay(delay, function() if t == tok then fn() end end)
end
end
local canSave = typeof(writefile) == "function" and typeof(readfile) == "function" and typeof(isfile) == "function"
local function readJson(file)
if not canSave then return nil end
local ok, data = pcall(function()
if isfile(file) then return HttpService:JSONDecode(readfile(file)) end
end)
return (ok and type(data) == "table") and data or nil
end
local function writeJson(file, data)
if canSave then pcall(function() writefile(file, HttpService:JSONEncode(data)) end) end
end
L.lastSaved = {}
L.cellH = setmetatable({}, {__mode = "k"})
L.listGrids = setmetatable({}, {__mode = "k"})
function L.packPages(pages)
local codes, idx, out = {}, {}, {}
for name, list in pairs(pages) do
local o = {}
for _, e in ipairs(list) do
local i = idx[e.code]
if not i then i = #codes + 1; codes[i] = e.code; idx[e.code] = i end
o[#o + 1] = {e.name, i, e.by or "", e.desc or "", e.game or "", e.gid or "", e.kinds or "", e.t or 0, e.an or "", e.anb or ""}
end
out[name] = o
end
return {c = codes, p = out}
end
function L.unpackPages(data)
if type(data) ~= "table" or type(data.c) ~= "table" or type(data.p) ~= "table" then return data end
local pages = {}
for name, list in pairs(data.p) do
local o = {}
if type(list) == "table" then
for _, t in ipairs(list) do
local code = type(t) == "table" and data.c[tonumber(t[2]) or 0]
if type(code) == "string" and type(t[1]) == "string" then
local function sv(v) return type(v) == "string" and v ~= "" and v or nil end
local tt = tonumber(t[8])
o[#o + 1] = {name = t[1], code = code, by = sv(t[3]), desc = sv(t[4]), game = sv(t[5]), gid = sv(t[6]), kinds = sv(t[7]), t = (tt and tt > 0) and tt or nil, an = sv(t[9]), anb = sv(t[10])}
end
end
end
pages[name] = o
end
return pages
end
function L.saveIfChanged(file, data)
if not canSave then return end
local ok, str = pcall(function() return HttpService:JSONEncode(data) end)
if not ok or L.lastSaved[file] == str then return end
L.lastSaved[file] = str
pcall(writefile, file, str)
end
function L.note(t, msg)
if L.nolog[t] then return end
table.insert(L.log, 1, {t = tostring(t), m = tostring(msg), at = os.date("%H:%M"), ts = os.time()})
if #L.log > 60 then table.remove(L.log) end
L.unread = L.unread + 1
if L.badge then L.badge() end
end
local function notify(t, msg, icon, dur)
if not (L.toast and pcall(L.toast, t, msg, dur or NOTIF_TIME)) then
pcall(StarterGui.SetCore, StarterGui, "SendNotification",
{Title = t, Text = msg, Icon = icon, Duration = dur or NOTIF_TIME})
end
L.note(t, msg)
end
local S = table.clone(DEFAULTS)
do
local data = readJson(FILE.SETTINGS)
if data then
for k, def in pairs(DEFAULTS) do
local v = data[k]
if type(v) == type(def) then
if type(v) == "number" and LIMITS[k] then v = math.clamp(v, LIMITS[k][1], LIMITS[k][2]) end
S[k] = v
end
end
end
end
if not S.uiMig then S.uiMig, S.style, L.uiMigrated = true, "Minimal", true end
S.infJump, S.noclip, S.fly, S.fullbright, S.noFog, S.esp = false, false, false, false, false, false
L.fonts = {
{"Nunito", "Nunito"}, {"Fredoka", "FredokaOne"}, {"Montserrat", "Montserrat"}, {"Gotham", "GothamSSm"},
{"Source Sans", "SourceSansPro"}, {"Ubuntu", "Ubuntu"}, {"Roboto", "Roboto"}, {"Condensed", "RobotoCondensed"},
{"Oswald", "Oswald"}, {"Titillium", "TitilliumWeb"}, {"Josefin", "JosefinSans"}, {"Jura", "Jura"},
{"Merriweather", "Merriweather"}, {"Kalam", "Kalam"}, {"Patrick Hand", "PatrickHand"}, {"Indie Flower", "IndieFlower"},
{"Bangers", "Bangers"}, {"Luckiest Guy", "LuckiestGuy"}, {"Marker", "PermanentMarker"}, {"Typewriter", "SpecialElite"},
{"Roboto Mono", "RobotoMono"}, {"Arimo", "Arimo"},
}
L.fontCache = {}
function L.face(o)
local key = S.font .. (S.bold and "B" or "R")
local ff = L.fontCache[key]
if ff == nil then
local f = L.fonts[1]
for _, x in ipairs(L.fonts) do if x[1] == S.font then f = x end end
local ok, v = pcall(Font.new, FAM .. f[2] .. ".json", S.bold and Enum.FontWeight.Bold or Enum.FontWeight.Regular)
ff = ok and v or false
L.fontCache[key] = ff
end
if ff then pcall(function() o.FontFace = ff end) end
end
L.styles = {
{name = "Minimal", r = 0.6, stroke = 1.8, tile = L.P.card, hot = L.P.ctrlHot, tileT = 0, plus = L.P.ctrl, plusHot = L.P.ctrlHot, plusT = 0, wt = 0, pm = 0.7, hv = 1, ab = 1, img = true, barT = 0.25, sbT = 0.3},
{name = "Shatter", r = 1.2, stroke = 2, tile = Color3.fromRGB(11, 11, 24), hot = Color3.fromRGB(40, 38, 74), tileT = 0, plus = L.P.btn, plusHot = Color3.fromRGB(46, 190, 90), plusT = 0, wt = 0, pm = 1, hv = 1.05, tf = "FredokaOne", ab = 3, img = true, barT = 0.38, sbT = 0.3},
{name = "Solid", r = 1, stroke = 1.8, tile = L.P.card, hot = Color3.fromRGB(34, 34, 44), tileT = 0, plus = L.P.btn, plusHot = Color3.fromRGB(46, 190, 90), plusT = 0, wt = 0, pm = 1, hv = 1.04, tf = "FredokaOne", ab = 3},
{name = "Glass", r = 1.4, stroke = 1.5, tile = L.P.ctrl, hot = Color3.fromRGB(84, 84, 116), tileT = 0, plus = Color3.fromRGB(80, 220, 130), plusHot = Color3.fromRGB(120, 255, 170), plusT = 0, wt = 0.22, pm = 0.8, hv = 1.06, tf = "Gotham", ab = 3, pcol = {Color3.fromRGB(255,255,255), Color3.fromRGB(190,225,255), Color3.fromRGB(220,200,255), Color3.fromRGB(200,255,240)}},
{name = "Sharp", r = 0.15, stroke = 2.6, tile = Color3.fromRGB(22, 22, 22), hot = Color3.fromRGB(48, 48, 48), tileT = 0, plus = Color3.fromRGB(40, 150, 60), plusHot = Color3.fromRGB(60, 190, 80), plusT = 0, wt = 0, pm = 1.3, hv = 1, tf = "GothamBlack", ab = 2},
{name = "Neon", r = 0.8, stroke = 3.6, tile = Color3.fromRGB(4, 4, 8), hot = Color3.fromRGB(22, 14, 36), tileT = 0, plus = Color3.fromRGB(0, 190, 110), plusHot = Color3.fromRGB(30, 240, 150), plusT = 0, wt = 0, pm = 1.9, hv = 1.09, tf = "GothamBlack", ab = 5, pcol = {Color3.fromRGB(0,255,255), Color3.fromRGB(255,0,200), Color3.fromRGB(120,255,80), Color3.fromRGB(255,255,0)}},
{name = "Soft", r = 1.8, stroke = 1.1, tile = Color3.fromRGB(46, 40, 66), hot = Color3.fromRGB(70, 60, 98), tileT = 0, plus = Color3.fromRGB(70, 190, 110), plusHot = Color3.fromRGB(90, 215, 130), plusT = 0, wt = 0.08, pm = 0.55, hv = 1.07, tf = "Cartoon", ab = 4, pcol = {Color3.fromRGB(255,255,255), Color3.fromRGB(255,200,225), Color3.fromRGB(255,230,200), Color3.fromRGB(210,255,225)}},
{name = "Terminal", r = 0, stroke = 2.4, tile = Color3.fromRGB(0, 14, 0), hot = Color3.fromRGB(0, 40, 6), tileT = 0, plus = Color3.fromRGB(0, 120, 30), plusHot = Color3.fromRGB(0, 160, 44), plusT = 0, wt = 0, pm = 0.45, hv = 1, tf = "Code", ab = 2, pcol = {Color3.fromRGB(0,255,70), Color3.fromRGB(0,200,50), Color3.fromRGB(120,255,120), Color3.fromRGB(0,150,40)}},
}
function L.cur()
for _, st in ipairs(L.styles) do if st.name == S.style then return st end end
return L.styles[1]
end
L.rs, L.ss = L.cur().r, L.cur().stroke
L.pm, L.hv = L.cur().pm or 1, L.cur().hv or 1.04
local scheduleSave = debounce(0.4, function() writeJson(FILE.SETTINGS, S) end)
if not S.reopenMig then S.reopenMig, S.reopen = true, false; scheduleSave() end
if L.uiMigrated then scheduleSave() end
if not S.bgMig then S.bgMig, S.style = true, (S.uiMig and "Minimal" or "Shatter"); scheduleSave() end
if not S.ui3Mig then S.ui3Mig, S.style = true, "Minimal"; L.rs, L.ss = L.cur().r, L.cur().stroke; L.pm, L.hv = L.cur().pm or 1, L.cur().hv or 1.04; scheduleSave() end
if not S.ui4Mig then S.ui4Mig, S.autoClose, S.winW, S.winH = true, false, 720, 430; scheduleSave() end
if not S.bgMig2 then S.bgMig2, S.bgVis, S.winTrans, S.bgPreset = true, 0.75, 0.6, 1; scheduleSave() end
if not S.bgMig3 then S.bgMig3, S.bgPreset = true, 4; scheduleSave() end
if not S.bgMig4 then S.bgMig4, S.bgPreset = true, 6; scheduleSave() end
if not S.ui6Mig then S.ui6Mig, S.particleCount = true, 70; scheduleSave() end
if not S.ui7Mig then S.ui7Mig, S.updSeen = true, os.time(); scheduleSave() end
if not S.ui5Mig then S.ui5Mig, S.edgeW = true, 5; scheduleSave() end
local SND = {
click = "rbxassetid://140207837688369", ok = "rbxassetid://135165335432475", run = "rbxassetid://100754383843032",
}
local function playSound(id, vol)
if not S.soundOn then return end
pcall(function()
local snd = Instance.new("Sound")
snd.SoundId, snd.Volume = id, vol or 0.7
snd.Parent = game:GetService("SoundService")
game:GetService("Debris"):AddItem(snd, 8)
snd:Play()
end)
end
L.ckCache = {}
function L.ago(t)
local d = os.time() - t
if d < 60 then return "just now" end
if d < 3600 then return math.floor(d / 60) .. "m ago" end
if d < 86400 then return math.floor(d / 3600) .. "h ago" end
return math.floor(d / 86400) .. "d ago"
end
function L.ckey(c)
c = tostring(c or "")
if #c < 3000 then return (c:gsub("%s+", "")) end
local r = L.ckCache[c]
if not r then r = (c:gsub("%s+", "")); L.ckCache[c] = r end
return r
end
function L.eKey(e) return tostring(e.by or e.uid or ""):lower() .. "\0" .. tostring(e.name or ""):lower() .. "\0" .. L.ckey(e.code) end
-- a paste that arrived twice in a row (same text repeated) is collapsed to one copy
function L.undouble(code)
local n = #code
for sep = 0, 4 do
if (n - sep) % 2 == 0 and n - sep >= 40 then
local h = (n - sep) / 2
local a = code:sub(1, h)
if code:sub(h + sep + 1) == a and code:sub(h + 1, h + sep):match("^%s*$") then return a, true end
end
end
return code, false
end
-- script health: remembers whether each script last ran cleanly (saved on this device only)
L.health = {}
do
local d = readJson("DuaLibrary_Health.json")
if d and type(d.h) == "table" then
for k, v in pairs(d.h) do
if type(k) == "string" and type(v) == "table" then L.health[k] = {ok = v.ok == true, err = type(v.err) == "string" and v.err:sub(1, 100) or nil, t = tonumber(v.t)} end
end
end
end
function L.hkey(c) local k = L.ckey(c) return #k .. ":" .. k:sub(1, 60) end
L.saveHealth = debounce(1, function() writeJson("DuaLibrary_Health.json", {h = L.health}) end)
function L.mark(code, ok, err)
local k = L.hkey(code)
local old = L.health[k]
if old and old.ok == ok and old.err == err then return end
L.health[k] = {ok = ok, err = err and tostring(err):sub(1, 100) or nil, t = os.time()}
L.saveHealth()
if L.rerender then L.rerender() end
if L.wsRender then L.wsRender() end
end
local function normalizeCode(code)
local t = code:match("^%s*(.-)%s*$")
if t:find("loadstring", 1, true) then
local one = t:match('^(loadstring%s*%(%s*game:HttpGet%s*%(%s*"https?://[^"\n]+"%s*%)%s*%)%s*%(%s*%))%s*;?$')
or t:match("^(loadstring%s*%(%s*game:HttpGet%s*%(%s*'https?://[^'\n]+'%s*%)%s*%)%s*%(%s*%))%s*;?$")
or t:match('^(loadstring%s*%(%s*game:HttpGet%s*%(%s*"https?://[^"\n]+"%s*,%s*true%s*%)%s*%)%s*%(%s*%))%s*;?$')
return one or code
end
if not t:find("^https?://%S+$") then return code end
local url = t
local id = url:match("^https?://[%w%.]*pastebin%.com/(%w+)/?$")
if id then url = "https://pastebin.com/raw/" .. id end
local user, repo, rest = url:match("^https?://github%.com/([^/]+)/([^/]+)/blob/(.+)$")
if user then url = ("https://raw.githubusercontent.com/%s/%s/%s"):format(user, repo, rest) end
return ("loadstring(game:HttpGet(%q))()"):format(url)
end
L.GAMES = {
"Blox Fruits", "Brookhaven RP", "Blade Ball", "Bee Swarm Simulator", "Adopt Me!", "Grow a Garden", "Steal a Brainrot", "Murder Mystery 2",
"Pet Simulator 99", "Arsenal", "Doors", "Jailbreak", "Tower of Hell", "Da Hood", "Rivals", "King Legacy", "Fisch", "Natural Disaster Survival",
"Piggy", "Phantom Forces", "Build A Boat For Treasure", "Dress To Impress", "99 Nights in the Forest", "Pls Donate", "Royale High", "MeepCity",
"Work at a Pizza Place", "Slap Battles", "Evade", "Break In", "Bad Business", "BedWars", "Big Paintball", "Bubble Gum Simulator",
"Anime Defenders", "Anime Adventures", "Anime Vanguards", "Anime Last Stand", "All Star Tower Defense", "Toilet Tower Defense", "Tower Defense Simulator",
"The Strongest Battlegrounds", "Combat Warriors", "Counter Blox", "Flee the Facility", "Mad City", "Lumber Tycoon 2", "Theme Park Tycoon 2",
"Restaurant Tycoon 2", "Car Dealership Tycoon", "Vehicle Simulator", "Driving Empire", "Southwest Florida", "Welcome to Bloxburg", "Livetopia",
"Berry Avenue", "Rainbow Friends", "Type Soul", "Project Slayers", "Blue Lock Rivals", "Volleyball Legends", "Basketball Legends", "Ultimate Football",
"Legends of Speed", "Speed Run 4", "Flood Escape 2", "Survive the Killer", "Prison Life", "Entry Point", "Apocalypse Rising 2", "Frontlines",
"Ro-Ghoul", "Shindo Life", "Sol's RNG", "Dead Rails", "Mining Simulator", "Tapping Simulator", "Obby But You're on a Bike", "Raise a Floppa",
"Murderers vs Sheriffs Duels", "Zombie Attack", "Zombie Uprising", "Sword Fights on the Heights", "Epic Minigames", "Crossroads", "Hide and Seek Extreme",
"Football Fusion", "Strucid", "Gun Game", "Skywars", "The Mimic", "Pressure", "Ink Game", "Squid Game", "Dungeon Quest", "Weapon Fighting Simulator",
"Roblox High School", "Boxing Beta", "Untitled Boxing Game", "Jujutsu Shenanigans", "Deepwoken", "Rogue Lineage", "A Dusty Trip", "Retro Gaming",
}
L.KINDS = {{"K", "Keyless", Color3.fromRGB(40, 150, 85)}, {"U", "Universal", Color3.fromRGB(60, 120, 230)}, {"F", "FE", Color3.fromRGB(200, 115, 35)}}
function L.kindWords(k)
local out = {}
for _, kd in ipairs(L.KINDS) do if type(k) == "string" and k:find(kd[1], 1, true) then out[#out + 1] = kd[2] end end
return table.concat(out, ", ")
end
function L.lev(a, b)
local la, lb = #a, #b
if math.abs(la - lb) > 2 then return 9 end
local prev = {}
for j = 0, lb do prev[j] = j end
for i = 1, la do
local cur = {[0] = i}
for j = 1, lb do
cur[j] = math.min(prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + ((a:byte(i) == b:byte(j)) and 0 or 1))
end
prev = cur
end
return prev[lb]
end
-- closest game names for what the player typed (prefix first, then word start, then anywhere, then typos)
function L.matchGames(q, n)
q = (q or ""):lower():match("^%s*(.-)%s*$")
local pool, seen = {}, {}
if L.curGame then pool[1] = L.curGame; seen[L.curGame:lower()] = true end
for _, g in ipairs(L.GAMES) do
if not seen[g:lower()] then seen[g:lower()] = true; pool[#pool + 1] = g end
end
local out = {}
if q == "" then
for i = 1, math.min(n, #pool) do out[i] = pool[i] end
return out
end
local scored = {}
for i, name in ipairs(pool) do
local ln = name:lower()
local sc
if ln:sub(1, #q) == q then sc = 0
elseif (" " .. ln):find(" " .. q, 1, true) then sc = 1
elseif ln:find(q, 1, true) then sc = 2
elseif #q >= 3 then
local lim = #q >= 6 and 2 or 1
local d = L.lev(q, ln:sub(1, #q))
for w in ln:gmatch("%S+") do d = math.min(d, L.lev(q, w:sub(1, #q))) end
if d <= lim then sc = 3 + d end
end
if sc then scored[#scored + 1] = {name = name, sc = sc, i = i} end
end
table.sort(scored, function(a, b) if a.sc ~= b.sc then return a.sc < b.sc end return a.i < b.i end)
for i = 1, math.min(n, #scored) do out[i] = scored[i].name end
return out
end
function L.gameFromId(id, cb)
task.spawn(function()
local ok, info = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(tonumber(id)) end)
cb(ok and type(info) == "table" and type(info.Name) == "string" and info.Name:sub(1, 40) or nil)
end)
end
if game.PlaceId and game.PlaceId > 0 then
task.spawn(function()
local ok, info = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId) end)
if ok and type(info) == "table" and type(info.Name) == "string" then L.curGame = info.Name:sub(1, 40) end
end)
end
local function cleanList(list)
local out = {}
if type(list) == "table" then
for _, e in ipairs(list) do
if type(e) == "table" and type(e.name) == "string" and type(e.code) == "string" then
local gid = (type(e.gid) == "string" or type(e.gid) == "number") and tostring(e.gid):match("^%d+$") or nil
out[#out + 1] = {name = e.name, code = e.code, by = type(e.by) == "string" and e.by:sub(1, 20) or nil, desc = type(e.desc) == "string" and e.desc ~= "" and e.desc:sub(1, 300) or nil,
game = type(e.game) == "string" and e.game ~= "" and e.game:sub(1, 40) or nil, gid = gid and gid:sub(1, 15) or nil,
kinds = type(e.kinds) == "string" and e.kinds:match("^[KUF]+$") and e.kinds:sub(1, 3) or nil, t = tonumber(e.t),
an = type(e.an) == "string" and e.an ~= "" and e.an:sub(1, 200) or nil, anb = type(e.anb) == "string" and e.anb ~= "" and e.anb:sub(1, 20) or nil}
end
end
end
return out
end
local function cleanPages(pages)
local out = {}
if type(pages) == "table" then
for k, v in pairs(pages) do
if type(k) == "string" then out[k] = cleanList(v) end
end
end
return out
end
local function cleanNames(t)
local out, seen = {}, {}
if type(t) == "table" then
for _, n in ipairs(t) do
if type(n) == "string" and n:match("^[%w_]+$") and not seen[n:lower()] then
seen[n:lower()] = true
out[#out + 1] = n
end
end
end
return out
end
local online, feedUrl = {}, EMBEDDED_FEED
do
local onlineFile = readJson(FILE.ONLINE)
if onlineFile and type(onlineFile.gistId) == "string" then online.gistId = onlineFile.gistId end
if onlineFile and type(onlineFile.feedUrl) == "string" and onlineFile.feedUrl ~= "" then feedUrl = onlineFile.feedUrl end
if onlineFile and type(onlineFile.notice) == "table" then online.notice = onlineFile.notice end
if onlineFile and type(onlineFile.webhook) == "string" then online.webhook = onlineFile.webhook end
if onlineFile and type(onlineFile.helpHook) == "string" then online.helpHook = onlineFile.helpHook end
if onlineFile and type(onlineFile.board) == "string" then online.board = onlineFile.board end
online.messages = onlineFile and type(onlineFile.messages) == "table" and onlineFile.messages or {}
online.muted = onlineFile and type(onlineFile.muted) == "table" and onlineFile.muted or {}
online.clearAt = onlineFile and tonumber(onlineFile.clearAt) or nil
end
local onFeedChanged = function() end
local adminOk, writeLocal
local function fetchFeed(url)
local ok, body = pcall(function()
return game:HttpGet(url .. (url:find("?", 1, true) and "&" or "?") .. "t=" .. os.time())
end)
if not ok or type(body) ~= "string" then return nil end
local ok2, data = pcall(HttpService.JSONDecode, HttpService, body)
if ok2 and type(data) == "table" and type(data.pages) == "table" then
local n = data.notice
if type(n) == "table" and type(n.from) ~= "string" then n.from = nil end
online.remote = type(n) == "table" and type(n.text) == "string" and type(n.id) == "string" and n or nil
local h = data.webhook
online.remoteHook = type(h) == "string" and (h:match("^https://discord%.com/api/webhooks/%d+/[%w_%-]+$") or h:match("^https://discordapp%.com/api/webhooks/%d+/[%w_%-]+$")) or nil
local hh = data.helpWebhook
online.remoteHelpHook = type(hh) == "string" and (hh:match("^https://discord%.com/api/webhooks/%d+/[%w_%-]+$") or hh:match("^https://discordapp%.com/api/webhooks/%d+/[%w_%-]+$")) or nil
local bd = data.board
online.remoteBoard = type(bd) == "string" and bd:match("^https://jsonblob%.com/api/jsonBlob/[%w%-]+$") or nil
online.remoteAdmins = type(data.admins) == "table" and cleanNames(data.admins) or nil
online.remoteMuted = type(data.muted) == "table" and data.muted or {}
if L.applyMuted then pcall(L.applyMuted) end
online.remoteClear = tonumber(data.clearAt) or 0
if L.onClear then pcall(L.onClear, online.remoteClear) end
online.remoteMsgs = {}
if type(data.messages) == "table" then
for _, m in ipairs(data.messages) do
if type(m) == "table" and m.text ~= nil and #online.remoteMsgs < 40 then
table.insert(online.remoteMsgs, {id = tostring(m.id), to = tostring(m.to), from = tostring(m.from or "DuaKNo"), text = tostring(m.text):sub(1, 140), rm = type(m.rm) == "string" and m.rm:sub(1, 60) or nil})
end
end
end
return cleanPages(data.pages)
end
end
-- Dua's Library npoint feed: owner posts go to the gist AND this bin, other admins post only to this bin.
-- PASTE YOUR npoint.io LINK FOR DUA'S LIBRARY HERE, e.g. "https://api.npoint.io/xxxxxxxxxxxxxxxxxxxx"
L.DUA_BOARD = "https://api.npoint.io/2e49b7ead8abe128230e"
L.BOARD_SECTIONS = {["Dua's favorites"] = true, NPCs = true, Weapons = true, Utility = true}
L.OWNER_NAMES = {duakno = true, saifb90 = true}
function L.boardUrlOf()
local u = L.DUA_BOARD
if type(u) == "string" and u:match("^https://api%.npoint%.io/[%w]+$") then return u end
end
-- a script posted by an admin who is not an owner (it carries the poster's name in "by")
function L.isAdminPost(name, e)
return L.BOARD_SECTIONS[name] == true and type(e.by) == "string" and e.by ~= "" and not L.OWNER_NAMES[e.by:lower()]
end
function L.boardFetch()
local url = L.boardUrlOf()
if not url then return nil end
local ok, body = pcall(function() return game:HttpGet(url) end)
if not ok or type(body) ~= "string" then return nil end
local ok2, data = pcall(HttpService.JSONDecode, HttpService, body)
if not ok2 or type(data) ~= "table" then return nil end
local out = {}
if type(data.pages) == "table" then
for name, list in pairs(data.pages) do
if L.BOARD_SECTIONS[name] then out[name] = cleanList(list) end
end
end
return out
end
function L.boardMergeInto(target, bp)
for name, list in pairs(bp) do
target[name] = target[name] or {}
local have = {}
for _, x in ipairs(target[name]) do have[x.name .. "\0" .. x.code] = true end
for _, e in ipairs(list) do
local k = e.name .. "\0" .. e.code
if not have[k] then
have[k] = true
table.insert(target[name], e)
end
end
end
return target
end
local feedPages, feedDone = nil, feedUrl == ""
if not feedDone then
task.spawn(function()
feedPages = fetchFeed(feedUrl)
if feedPages then
L.saveIfChanged(FILE.FEED, {pages = L.packPages(feedPages)})
else
local c = readJson(FILE.FEED)
if c and type(c.pages) == "table" then feedPages = cleanPages(L.unpackPages(c.pages)) end
end
local bp = L.boardFetch()
if bp then feedPages = L.boardMergeInto(feedPages or cleanPages(EMBEDDED_PAGES), bp) end
feedDone = true
end)
end
local function serverName(userId)
for _ = 1, 3 do
local ok, n = pcall(Players.GetNameFromUserIdAsync, Players, userId)
if ok and type(n) == "string" then return n end
task.wait(0.5)
end
end
local rootAdmins = {"DuaKNo", "Saifb90"}
do
local t0 = os.clock()
while not feedDone and os.clock() - t0 < 4 do task.wait(0.1) end
if online.remoteAdmins and #online.remoteAdmins > 0 then
rootAdmins = online.remoteAdmins
for _, o in ipairs({"DuaKNo", "Saifb90"}) do
local has = false
for _, n in ipairs(rootAdmins) do if n:lower() == o:lower() then has = true end end
if not has then table.insert(rootAdmins, o) end
end
end
end
-- SECURITY: put the UserIds of the owners here, e.g. {123456789, 987654321}. Type /myid in the chat to see yours.
-- Once filled in, nobody else can become owner by taking over an old username.
local ADMIN_IDS = {}
local verId, verName = LP.UserId, nil
local isAdmin, tampered = false, false
do
local real = serverName(verId)
if real and real ~= LP.Name then
tampered = true
elseif real then
verName = real
for _, n in ipairs(rootAdmins) do
if n:lower() == real:lower() then isAdmin = true end
end
local rl = real:lower()
if isAdmin and #ADMIN_IDS > 0 and (rl == "duakno" or rl == "saifb90") then
local okId = false
for _, i in ipairs(ADMIN_IDS) do if tonumber(i) == verId then okId = true end end
if not okId then isAdmin, tampered = false, true end
end
end
end
local myName = (verName or LP.Name):lower()
function online.show()
local n = online.remote
if isAdmin or not n or n.id == S.seenNotice then return end
S.seenNotice = n.id
scheduleSave()
if n.text == L.lastLive then return end
L.banner(n.from or "DuaKNo", n.text)
end
function L.banner(from, msg)
notify("" .. tostring(from):sub(1, 24), tostring(msg):sub(1, 140), nil, 6)
local old = findGui("DuaKNoMsg")
if old then old:Destroy() end
local gui = new("ScreenGui", {Name = "DuaKNoMsg", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999})
mountGui(gui)
local bar = new("Frame", {
AnchorPoint = V2(0.5, 0), Position = U2(0.5, 0, 0, -90), Size = U2(0.8, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.35, BorderSizePixel = 0,
}, gui)
round(bar, 10)
new("UISizeConstraint", {MaxSize = V2(760, 400)}, bar)
new("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16)}, bar)
local function esc(x) return (tostring(x):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")) end
local safe = esc(tostring(msg):sub(1, 140))
from = esc(tostring(from):sub(1, 24))
text(bar, {
Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextSize = 22, TextWrapped = true, RichText = true,
Text = '<font color="rgb(255,215,90)">' .. from .. ':</font> ' .. safe,
TextStrokeTransparency = 0.4, TextStrokeColor3 = Color3.new(0, 0, 0),
})
playSound(SND.ok)
tween(bar, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = U2(0.5, 0, 0, 18)})
task.delay(8, function()
if not gui.Parent then return end
tween(bar, TweenInfo.new(0.3), {Position = U2(0.5, 0, 0, -120)})
task.wait(0.35)
gui:Destroy()
end)
end
local localAdmin = readJson(FILE.ADMIN)
if localAdmin then localAdmin.pages = L.unpackPages(localAdmin.pages) end
local adminList = rootAdmins
if isAdmin and localAdmin then
local l = cleanNames(localAdmin.admins)
if #l > 0 then
adminList = l
local has = false
for _, n in ipairs(l) do if n:lower() == myName then has = true end end
if not has then table.insert(adminList, 1, verName) end
end
end
local function migrate(pages)
local PAGE_ALIASES = {Guns = "Weapons", Swords = "Weapons", Random = "Utility", ["Add Scripts"] = "Share Script"}
local out = {}
for k, list in pairs(pages) do
local to = PAGE_ALIASES[k] or k
out[to] = out[to] or {}
for _, e in ipairs(list) do
local dup = false
for _, x in ipairs(out[to]) do if (x.name == e.name and x.code == e.code) or (L.ckey(x.code) == L.ckey(e.code) and tostring(x.by or "") == tostring(e.by or "")) then dup = true end end
if not dup then table.insert(out[to], e) end
end
end
return out
end
local function pagesHash(pages)
local names = {}
for n in pairs(pages) do names[#names + 1] = n end
table.sort(names)
local h = 5381
for _, n in ipairs(names) do
local chunk = n
for _, e in ipairs(pages[n]) do chunk = chunk .. "\0" .. e.name .. "\0" .. e.code end
for i = 1, #chunk do h = (h * 33 + chunk:byte(i)) % 4294967296 end
end
return h
end
do
local t0 = os.clock()
while not feedDone and os.clock() - t0 < 3 do task.wait(0.1) end
end
local basePages = feedPages and migrate(feedPages) or migrate(cleanPages(EMBEDDED_PAGES))
local embeddedHash = pagesHash(basePages)
local adminPages = {}
for k, list in pairs(basePages) do adminPages[k] = table.clone(list) end
if isAdmin and localAdmin and type(localAdmin.pages) == "table" then
local lp = migrate(cleanPages(localAdmin.pages))
if localAdmin.base == embeddedHash then
adminPages = lp
else
for k, list in pairs(lp) do
adminPages[k] = adminPages[k] or {}
for _, e in ipairs(list) do
local dup = false
for _, x in ipairs(adminPages[k]) do
if (x.name == e.name and x.code == e.code) or (L.ckey(x.code) == L.ckey(e.code) and tostring(x.by or "") == tostring(e.by or "")) then dup = true end
end
if not dup then table.insert(adminPages[k], e) end
end
end
end
end
L.favs = {}
L.notes = {}
do
local nd = readJson(FILE.NOTES)
if nd and type(nd.n) == "table" then
for k, v in pairs(nd.n) do if type(k) == "string" and type(v) == "string" then L.notes[k] = v end end
end
end
function L.noteKey(e) return e.name .. "\1" .. #(e.code or "") end
function L.hasNote(e) return L.notes[L.noteKey(e)] ~= nil end
do
local data = readJson(FILE.FAVS)
if data then L.favs = cleanList(data.list) end
end
local userScripts = {}
do
local data = readJson(FILE.SCRIPTS)
if data then userScripts = cleanList(data[ADD_PAGE] or data["Add Scripts"]) end
end
local function longStr(s)
local n = 0
while true do
local closer = "]" .. ("="):rep(n) .. "]"
if (s .. closer):find(closer, 1, true) == #s + 1 then
local eq = ("="):rep(n)
return "[" .. eq .. "[\n" .. s .. closer
end
n = n + 1
end
end
local function serializeEmbedded(admins, pages)
local out = {
"-- @@EMBEDDED_" .. "BEGIN",
"-- auto-managed block: the library rewrites it (auto-save, see CONFIG below); don't edit by hand",
"local EMBEDDED_ADMINS = {",
}
for _, a in ipairs(admins) do out[#out + 1] = string.format("\t%q,", a) end
out[#out + 1] = "}"
out[#out + 1] = string.format("local EMBEDDED_FEED = %q", feedUrl)
out[#out + 1] = "local EMBEDDED_PAGES = {"
local names = {}
for n in pairs(pages) do names[#names + 1] = n end
table.sort(names)
for _, n in ipairs(names) do
if #pages[n] > 0 then
out[#out + 1] = string.format("\t[%q] = {", n)
for _, e in ipairs(pages[n]) do
local extra = ""
for _, f in ipairs({"by", "desc", "game", "gid", "kinds", "an", "anb"}) do
if type(e[f]) == "string" and e[f] ~= "" then extra = extra .. string.format(", %s = %q", f, e[f]) end
end
if tonumber(e.t) then extra = extra .. string.format(", t = %d", math.floor(tonumber(e.t))) end
out[#out + 1] = string.format("\t\t{name = %q, code = %s%s},", e.name, longStr(e.code), extra)
end
out[#out + 1] = "\t},"
end
end
out[#out + 1] = "}"
out[#out + 1] = "-- @@EMBEDDED_" .. "END"
return table.concat(out, "\n")
end
local EMBED_PAT = "%-%-%s*@@EMBEDDED_" .. "BEGIN.-%-%-%s*@@EMBEDDED_" .. "END"
local selfFile
if canSave then
for _, f in ipairs(SELF_FILE and {SELF_FILE} or SELF_CANDIDATES) do
local ok, src = pcall(function() return isfile(f) and readfile(f) end)
if ok and type(src) == "string" and src:find(EMBED_PAT) then
selfFile = f
break
end
end
end
function writeLocal()
L.saveIfChanged(FILE.ADMIN, {admins = adminList, pages = L.packPages(adminPages), base = embeddedHash})
if selfFile then
pcall(function()
local src = readfile(selfFile)
local out, n = src:gsub(EMBED_PAT, function() return serializeEmbedded(adminList, adminPages) end, 1)
if n == 1 then
pcall(writefile, selfFile .. ".bak", src)
writefile(selfFile, out)
end
end)
end
end
local httpReq = (typeof(request) == "function" and request) or (typeof(http_request) == "function" and http_request)
or (typeof(syn) == "table" and typeof(syn.request) == "function" and syn.request)
or (typeof(http) == "table" and typeof(http.request) == "function" and http.request)
or (typeof(fluxus) == "table" and typeof(fluxus.request) == "function" and fluxus.request)
or (typeof(syn) == "table" and syn.request) or (typeof(http) == "table" and http.request)
or (typeof(fluxus) == "table" and fluxus.request) or nil
local function readToken()
if L.memToken then return L.memToken end
if not canSave then return nil end
local ok, t = pcall(function() return isfile(FILE.TOKEN) and readfile(FILE.TOKEN) end)
if ok and type(t) == "string" then
t = t:match("^%s*(.-)%s*$")
if #t > 0 then return t end
end
end
local function saveOnline() writeJson(FILE.ONLINE, {gistId = online.gistId, feedUrl = feedUrl, notice = online.notice, webhook = online.webhook, helpHook = online.helpHook, board = online.board, messages = online.messages, muted = online.muted, clearAt = online.clearAt}) end
-- the gist only gets the owner's scripts: scripts posted by other admins live on the npoint board only
function L.gistPages()
local out = {}
for name, list in pairs(adminPages) do
local l = {}
for _, e in ipairs(list) do
if not L.isAdminPost(name, e) then l[#l + 1] = e end
end
out[name] = l
end
return out
end
local function feedJson() return HttpService:JSONEncode({v = 1, pages = L.gistPages(), notice = online.notice, webhook = online.webhook, helpWebhook = online.helpHook, board = L.DEFAULT_BOARD, admins = adminList, messages = online.messages, muted = online.muted, clearAt = online.clearAt}) end
local function gistCall(method, url, body)
local token = readToken()
if not httpReq then return nil, "this executor has no request function" end
if not token then return nil, "no GitHub token saved" end
local ok, res = pcall(httpReq, {
Url = url, Method = method,
Headers = {
Authorization = "token " .. token, Accept = "application/vnd.github+json",
["Content-Type"] = "application/json", ["User-Agent"] = "DuasLibrary",
},
Body = HttpService:JSONEncode(body),
})
if not ok or type(res) ~= "table" then return nil, "request failed" end
local data
pcall(function() data = HttpService:JSONDecode(res.Body) end)
local code = res.StatusCode or 0
if code >= 200 and code < 300 then return data or {} end
return nil, (type(data) == "table" and data.message) or ("HTTP " .. code)
end
local function publishNow(manual)
if not adminOk() then return end
task.spawn(function()
if L.boardPublish then L.boardPublish(manual) end
if not readToken() and not L.owner() then return end
local files = {[FILE.GIST] = {content = feedJson()}}
local data, err
if online.gistId then
data, err = gistCall("PATCH", "https://api.github.com/gists/" .. online.gistId, {files = files})
else
data, err = gistCall("POST", "https://api.github.com/gists",
{description = "Dua's Library scripts", public = false, files = files})
end
if not data then
notify("Publish failed", tostring(err):sub(1, 90), nil, 3)
return
end
if type(data.id) == "string" and type(data.owner) == "table" and type(data.owner.login) == "string" then
online.gistId = data.id
feedUrl = ("https://gist.githubusercontent.com/%s/%s/raw/%s"):format(data.owner.login, data.id, FILE.GIST)
saveOnline()
writeLocal()
onFeedChanged()
end
notify("Published online", "Everyone with the script now sees it", nil, 3)
task.delay(1.5, function() if L.ping then L.ping("feed") end end)
end)
end
local schedulePublish = debounce(1.5, function() publishNow(false) end)
L.scheduleBoard = debounce(2, function() if L.boardPublish then L.boardPublish(false) end end)
local function syncAdmin()
writeLocal()
if isAdmin and readToken() then schedulePublish() elseif isAdmin then L.scheduleBoard() end
end
local SECTIONS = {
{name = "Dua's favorites", icon = ""}, {name = "NPCs", icon = ""},
{name = "Weapons", icon = ""}, {name = "Utility", icon = ""},
}
local ITEMS = {
{name = "Updates", icon = "", custom = true, sub = "Newest scripts added to Dua's Script and Completed requests"},
{name = L.DUA, icon = ""},
{name = "Completed script request", icon = "", custom = true, sub = "Scripts Dua finished for players' requests"},
{name = L.FAVP, icon = ""},
{name = ADD_PAGE, icon = "➕"},
{name = "ScriptBlox scripts", icon = "", custom = true, sub = "Live from scriptblox.com, nothing saved on your device"},
{name = "Global chat", icon = "", custom = true, sub = "Live chat with everyone using Dua's Library"},
{name = "Workshop", icon = "", custom = true, sub = "Your collection, recent runs, tools and a script editor"},
{name = "Universal", icon = "", custom = true, sub = "Speed, jump, fly and more"},
{name = "Info", icon = "ℹ", custom = true, sub = "What you should know about this library"},
}
if isAdmin then table.insert(ITEMS, {name = "Admin", icon = "", custom = true, sub = "Admin tools"}) end
function L.owner()
local n = verName and verName:lower()
return isAdmin and (n == "duakno" or n == "saifb90") or false
end
local entriesOf = {}
for _, it in ipairs(SECTIONS) do
adminPages[it.name] = adminPages[it.name] or {}
entriesOf[it.name] = adminPages[it.name]
L.isSection[it.name] = true
end
adminPages[L.FAVD] = adminPages[L.FAVD] or {}
entriesOf[L.FAVD], entriesOf[L.FAVL] = adminPages[L.FAVD], L.favs
L.tabs = {
[L.DUA] = {{name = L.ALL, icon = "", label = "All"}},
[L.FAVP] = {{name = L.FAVL, icon = "", label = "Favorite"}, {name = L.FAVD, icon = "", label = "Favorited by Dua"}},
}
for _, sec in ipairs(SECTIONS) do table.insert(L.tabs[L.DUA], sec) end
if isAdmin then table.insert(L.tabs[L.FAVP], {name = L.CHK, icon = "", label = "Check favoritisms"}) end
for page, list in pairs(L.tabs) do
for _, t in ipairs(list) do L.uiOf[t.name] = page end
end
function L.favList() return isAdmin and adminPages[L.FAVD] or L.favs end
L.DUPRED = Color3.fromRGB(235, 45, 55)
L.HEART_ON, L.HEART_OFF = Color3.fromRGB(255, 55, 80), Color3.new(1, 1, 1)
function L.paintHeart(btn, on)
btn.Text = "\u{2665}"
btn.TextColor3 = on and L.HEART_ON or L.HEART_OFF
btn.TextTransparency = on and 0 or 0.1
end
function L.isFav(e)
for _, x in ipairs(L.favList()) do if x.name == e.name and x.code == e.code then return true end end
return false
end
entriesOf[ADD_PAGE] = userScripts
adminPages[ADD_PAGE] = adminPages[ADD_PAGE] or {}
local function persist(name)
if name == ADD_PAGE then writeJson(FILE.SCRIPTS, {[ADD_PAGE] = userScripts}) else syncAdmin() end
end
do
local old = findGui("DuaKNoUI")
if old then old:Destroy() end
local old2 = PG:FindFirstChild("DuaKNoUI")
if old2 then old2:Destroy() end
end
local sg = new("ScreenGui", {Name = "DuaKNoUI", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 10})
if not mountGui(sg) then warn("[DuaKNo] could not mount the hub UI") end
do
local old = findGui("DuaKNoToasts")
if old then pcall(function() old:Destroy() end) end
local tg = new("ScreenGui", {Name = "DuaKNoToasts", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 20})
local ok = mountGui(tg)
sg.Destroying:Connect(function() pcall(function() tg:Destroy() end) end)
local stack
if ok then
stack = new("Frame", {AnchorPoint = V2(1, 1), Position = U2(1, -14, 1, -14), Size = UO(244, 400), BackgroundTransparency = 1}, tg)
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom, HorizontalAlignment = Enum.HorizontalAlignment.Right}, stack)
end
local seq = 0
function L.toast(t, msg, dur)
if not stack or not stack.Parent then error("no toast host") end
seq = seq + 1
local kids = stack:GetChildren()
local count = 0
for _, k in ipairs(kids) do if k:IsA("Frame") then count = count + 1 end end
if count >= 4 then
for _, k in ipairs(kids) do if k:IsA("Frame") then k:Destroy() break end end
end
local holder = new("Frame", {Size = UO(240, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = seq}, stack)
local card = new("Frame", {Position = UO(270, 0), Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = L.P.card, BorderSizePixel = 0}, holder)
round(card, 8)
new("UIStroke", {Thickness = 1, Color = L.P.line, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
new("Frame", {Size = U2(0, 2, 1, 0), BackgroundColor3 = accentColor, BorderSizePixel = 0}, card)
local body = new("Frame", {Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1}, card)
new("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 7), PaddingBottom = UDim.new(0, 8)}, body)
new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}, body)
text(body, {Size = U2(1, 0, 0, 16), Text = tostring(t), TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = 1})
text(body, {Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = tostring(msg), TextSize = 11, TextColor3 = L.P.muted, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 2})
tween(card, TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UO(0, 0)})
task.delay(math.max(dur or 2, 2.5), function()
if not holder.Parent then return end
local h = holder.AbsoluteSize.Y
tween(card, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UO(270, 0)})
task.wait(0.22)
if not holder.Parent then return end
holder.AutomaticSize = Enum.AutomaticSize.None
holder.Size = UO(240, h)
tween(holder, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UO(240, 0)})
task.wait(0.17)
holder:Destroy()
end)
end
end
function adminOk()
if not isAdmin then return false end
if LP.UserId ~= verId or LP.Name ~= verName then
isAdmin = false
pcall(function() sg:Destroy() end)
notify("Admin check failed", "Your name or ID changed after the library started", nil, 4)
return false
end
return true
end
SIZE = UDim2.fromOffset(S.winW, S.winH)
local shadow = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = SIZE,
BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.5,
BorderSizePixel = 0, ZIndex = 0,
}, sg)
round(shadow, 12)
new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(0.55, 0.65), NumberSequenceKeypoint.new(1, 0.45),
})}, shadow)
local win = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = SIZE,
BackgroundColor3 = Color3.fromRGB(45, 15, 80), BorderSizePixel = 0,
ClipsDescendants = true, Active = true, ZIndex = 1,
}, sg)
round(win, 12)
local bgGrad = new("UIGradient", {Rotation = 90}, win)
local winStroke = outline(win, 1.5, 0.1)
themed[winStroke] = nil
L.strokes[winStroke] = nil
winStroke.Color, winStroke.Transparency = WHITE, 0
L.winStroke = winStroke
L.edgeGrad = new("UIGradient", {Rotation = 45}, winStroke)
L.bgImg = new("ImageLabel", {
Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop, Image = "",
ImageTransparency = 0.65, Visible = false, ZIndex = 0,
}, win)
round(L.bgImg, 12)
L.bgDim = new("Frame", {
Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.6,
BorderSizePixel = 0, Visible = false, ZIndex = 0,
}, win)
round(L.bgDim, 12)
local inner = new("Frame", {
Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0),
BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 0,
}, win)
round(inner, 12)
new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0.10), NumberSequenceKeypoint.new(0.2, 0.55),
NumberSequenceKeypoint.new(0.55, 0.88), NumberSequenceKeypoint.new(1, 0.65),
})}, inner)
local layer = new("Frame", {
Position = UO(0, TITLE_H), Size = U2(1, 0, 1, -TITLE_H),
BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 2,
}, win)
new("UIPadding", {
PaddingLeft = UDim.new(0, PAD), PaddingRight = UDim.new(0, PAD),
PaddingTop = UDim.new(0, PAD), PaddingBottom = UDim.new(0, PAD),
}, layer)
local parts, minimized = {}, false
do
local layerW = SIZE.X.Offset - PAD * 2
local layerH = SIZE.Y.Offset - TITLE_H - PAD * 2
local X_MIN = SB_CLOSED - PAD + 6
for i = 1, PARTICLE_MAX do
local depth = 0.35 + math.random() * 0.65
local sz = math.max(2, math.floor(1.5 + depth * 3.5 + 0.5))
local kind = (math.random() < 0.72) and "circle" or "diamond"
local o = new("Frame", {BorderSizePixel = 0, Size = UO(sz, sz)})
round(o, kind == "circle" and 99 or 1)
o.AnchorPoint, o.ZIndex, o.Parent = V2(0.5, 0.5), 2, layer
parts[i] = {
o = o, s = sz, kind = kind, ci = math.random(4), depth = depth,
baseTrans = 0.65 - depth * 0.3,
x = math.random(X_MIN, math.max(layerW - sz, X_MIN + 1)),
y = math.random(-20, layerH + 30),
vy = 10 + depth * 18,
sway = 3 + math.random() * 9, swayF = 0.4 + math.random() * 0.8,
ph = math.random() * 6.28, tw = 1 + math.random() * 2,
rot = math.random(0, 360), spin = math.random(14, 40) * (math.random(2) == 1 and 1 or -1),
}
end
local shadowPos, shadowOff = V2(0.5, 0.5), V2(0, 0)
local shadowW, shadowH = SIZE.X.Offset, SIZE.Y.Offset
local stepConn
stepConn = RunService.Heartbeat:Connect(function(dt)
if not sg.Parent then stepConn:Disconnect() return end
if not sg.Enabled then return end
dt = math.min(dt, 1 / 30)
local pa, sa = 1 - math.exp(-45 * dt), 1 - math.exp(-12 * dt)
local tp, ab = win.Position, win.AbsoluteSize
shadowPos = shadowPos:Lerp(V2(tp.X.Scale, tp.Y.Scale), pa)
shadowOff = shadowOff:Lerp(V2(tp.X.Offset, tp.Y.Offset), pa)
shadowW = shadowW + (ab.X - shadowW) * sa
shadowH = shadowH + (ab.Y - shadowH) * sa
shadow.Position = U2(shadowPos.X, shadowOff.X, shadowPos.Y, shadowOff.Y)
shadow.Size = UO(shadowW, shadowH)
if minimized then return end
L.pacc = (L.pacc or 0) + dt
if L.pacc < 1 / 36 then return end
dt, L.pacc = math.min(L.pacc, 1 / 20), 0
if ab.X > 250 then layerW, layerH = ab.X - PAD * 2, ab.Y - TITLE_H - PAD * 2 end
local count = S.particlesOn and S.particleCount or 0
local speed = S.speed * L.pm
L.pt = (L.pt or 0) + dt
local t = L.pt
for i = 1, count do
local p = parts[i]
p.y = p.y + p.vy * speed * dt
if p.y > layerH + p.s then
p.y = -math.random(0, 20)
p.x = math.random(X_MIN, math.max(layerW - p.s, X_MIN + 1))
end
local alpha = 1
if p.y > layerH - 55 then alpha = math.clamp((layerH + p.s - p.y) / 55, 0, 1) end
if p.y < 45 then alpha = math.min(alpha, math.clamp(p.y / 45, 0, 1)) end
local twinkle = 0.5 + 0.5 * math.sin(t * p.tw + p.ph)
local tr = p.baseTrans + (1 - p.baseTrans) * (1 - alpha) + 0.22 * (1 - twinkle) * alpha
p.o.BackgroundTransparency = math.min(tr, 1)
p.o.Position = U2(0, p.x + math.sin(t * p.swayF + p.ph) * p.sway, 1, -p.y)
if p.kind == "diamond" then
p.rot = (p.rot + p.spin * speed * dt) % 360
p.o.Rotation = p.rot
end
end
end)
end
local bar = new("Frame", {Size = U2(1, 0, 0, TITLE_H), BackgroundColor3 = Color3.fromRGB(12, 8, 20), BorderSizePixel = 0, ZIndex = 3}, win)
round(bar, 12)
local barGrad = new("UIGradient", {Rotation = 90}, bar)
local mask = new("Frame", {AnchorPoint = V2(0, 1), Position = U2(0, 0, 1, 0), Size = U2(1, 0, 0, 11), BorderSizePixel = 0, ZIndex = 3}, bar)
local accent = new("Frame", {AnchorPoint = V2(0, 1), Position = U2(0, 0, 1, 0), Size = U2(1, 0, 0, 3), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 4}, bar)
local accentGrad = new("UIGradient", {Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 0.2),
})}, accent)
local title = text(bar, {
Position = UO(SB_CLOSED + 10, 0), Size = U2(1, -(SB_CLOSED + 152), 1, 0),
Text = WINDOW_TITLE, TextSize = 15, Font = Enum.Font.FredokaOne, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4,
})
fit(title, 15, 10)
L.busyN = 0
do
local loadBar = new("Frame", {AnchorPoint = V2(0, 1), Position = U2(0, 0, 1, 0), Size = U2(0.28, 0, 0, 2), BackgroundColor3 = WHITE, BorderSizePixel = 0, Visible = false, ZIndex = 6}, bar)
local loadTween
function L.busyUpdate()
local on = L.busyN > 0 and not minimized
loadBar.Visible = on
if on and not loadTween then
loadBar.BackgroundColor3 = accentColor
loadBar.Position = U2(0, 0, 1, 0)
loadTween = TweenService:Create(loadBar, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Position = U2(0.72, 0, 1, 0)})
loadTween:Play()
elseif not on and loadTween then
loadTween:Cancel(); loadTween = nil
end
end
function L.busy(d)
L.busyN = math.max(0, L.busyN + d)
if L.busyN > 0 then L.busyUpdate() else task.delay(0.3, function() if L.busyN == 0 then L.busyUpdate() end end) end
end
end
local minBtn = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -8, 0.5, 0), Size = UO(22, 22),
BackgroundColor3 = L.P.ctrl, BackgroundTransparency = 0, BorderSizePixel = 0,
Font = Enum.Font.Nunito, TextSize = 16, Text = "-", TextColor3 = WHITE,
AutoButtonColor = false, ZIndex = 4,
}, bar)
round(minBtn, 6)
L.miniImg = new("ImageLabel", {AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, Visible = false, ZIndex = 5}, minBtn)
minBtn.MouseEnter:Connect(function() if minimized then return end tween(minBtn, FAST, {BackgroundColor3 = L.P.ctrlHot}) end)
minBtn.MouseLeave:Connect(function() if minimized then return end tween(minBtn, FAST, {BackgroundColor3 = L.P.ctrl}) end)
L.press(minBtn, 0.9)
local content = new("Frame", {
Position = UO(SB_CLOSED, TITLE_H), Size = U2(1, -SB_CLOSED, 1, -TITLE_H),
BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 3,
}, win)
local sidebar = new("Frame", {
Name = "Sidebar", Size = U2(0, SB_CLOSED, 1, 0), BorderSizePixel = 0,
ClipsDescendants = true, ZIndex = 5,
}, win)
round(sidebar, 12)
local sbMask = new("Frame", {AnchorPoint = V2(1, 0), Position = U2(1, 0, 0, 0), Size = U2(0, 14, 1, 0), BorderSizePixel = 0, ZIndex = 6}, sidebar)
local sbEdge = new("Frame", {AnchorPoint = V2(1, 0), Position = U2(1, 0, 0, 0), Size = U2(0, 1, 1, 0), BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 7}, sidebar)
local sbDivider = new("Frame", {Position = UO(0, TITLE_H - 1), Size = U2(1, 0, 0, 1), BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 7}, sidebar)
local headHL = new("Frame", {Position = UO(4, 4), Size = U2(1, -10, 0, TITLE_H - 10), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 7}, sidebar)
round(headHL, 6)
local hamBtn = new("TextButton", {
Position = UO(4, 4), Size = UO(SB_CLOSED - 8, TITLE_H - 10),
BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 8,
}, sidebar)
local hamLines = {}
for i = 0, 2 do
hamLines[i] = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, (i - 1) * 6), Size = UO(18, 3),
BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 9,
}, hamBtn)
round(hamLines[i], 2)
end
local hamImg = new("ImageLabel", {
AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UO(24, 24), BackgroundTransparency = 1,
Image = "rbxthumb://type=Asset&id=80894127006690&w=150&h=150", ScaleType = Enum.ScaleType.Fit, ImageTransparency = 1, ZIndex = 10,
}, hamBtn)
function L.b64dec(str)
local A = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local map = {}
for i = 1, 64 do map[A:sub(i, i)] = i - 1 end
local out, n, acc, bits = {}, 0, 0, 0
for i = 1, #str do
local v = map[str:sub(i, i)]
if v then
acc, bits = acc * 64 + v, bits + 6
if bits >= 8 then
bits = bits - 8
local p = 2 ^ bits
local b = math.floor(acc / p)
n = n + 1
out[n] = string.char(b)
acc = acc - b * p
end
end
end
return table.concat(out)
end
L.ICON_B64 = "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"
L.ATLAS_B64 = "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"
L.NAVICON = {Updates = 12, ["Dua's script"] = 0, ["Completed script request"] = 1, Favorited = 2, ["Share Script"] = 3, ["ScriptBlox scripts"] = 4, ["Global chat"] = 5, Workshop = 6, Universal = 7, Info = 8, Admin = 11}
L.KIND_ICON = {U = 7, F = 13, K = 14}
function L.icon(parent, idx, px, props)
if not L.atlasURL then return nil end
local o = new("ImageLabel", {
BackgroundTransparency = 1, Size = UO(px, px), Image = L.atlasURL,
ImageRectOffset = Vector2.new((idx % 6) * 32, math.floor(idx / 6) * 32), ImageRectSize = Vector2.new(32, 32),
ZIndex = (parent.ZIndex or 1) + 1,
}, parent)
if props then for k, v in pairs(props) do o[k] = v end end
return o
end
-- one icon per type, and icons combine: Universal > FE > Keyless picks the big icon, the others sit on its corner
function L.kindBadgeInto(parent, kinds, px)
for _, c in ipairs(parent:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
local list = {}
if type(kinds) == "string" then
for _, k in ipairs({"U", "F", "K"}) do if kinds:find(k, 1, true) then list[#list + 1] = k end end
end
if #list == 0 or not L.atlasURL then return false end
local col = L.P.ctrl
for _, kd in ipairs(L.KINDS) do if kd[1] == list[1] then col = kd[3] end end
parent.BackgroundColor3 = col:Lerp(Color3.new(0, 0, 0), 0.62)
local big = math.floor(px * (#list == 1 and 0.72 or 0.6))
local small = math.floor(px * 0.42)
L.icon(parent, L.KIND_ICON[list[1]], big, {AnchorPoint = V2(0.5, 0.5), Position = (#list == 1) and U2(0.5, 0, 0.5, 0) or U2(0.4, 0, 0.42, 0)})
if list[2] then L.icon(parent, L.KIND_ICON[list[2]], small, {AnchorPoint = V2(1, 1), Position = U2(1, -1, 1, -1)}) end
if list[3] then L.icon(parent, L.KIND_ICON[list[3]], small, {AnchorPoint = V2(1, 0), Position = U2(1, -1, 0, 1)}) end
return true
end
L.navIcons = {}
do
local custom = typeof(getcustomasset) == "function" and getcustomasset or (typeof(getsynasset) == "function" and getsynasset)
if custom and canSave then
local ok, url = pcall(function()
local f = "DuaLibrary_Icons_v2.png"
if not (isfile(f) and #readfile(f) > 200) then writefile(f, L.b64dec(L.ATLAS_B64)) end
return custom(f)
end)
if ok and type(url) == "string" and url ~= "" then L.atlasURL = url end
end
end
task.spawn(function()
local ICON_ID, ICON_FILE = "80894127006690", "DuaLibrary_Icon_v4.png"
local function loaded(secs)
local t0 = os.clock()
while os.clock() - t0 < secs and not hamImg.IsLoaded do task.wait(0.2) end
return hamImg.IsLoaded
end
local function setIcon(img) hamImg.Image = img; L.miniImg.Image = img end
local function show()
hamImg.ImageTransparency = 0
L.iconOK = true
if minimized then L.miniImg.Visible = true; minBtn.Text = "" end
for i = 0, 2 do hamLines[i].Visible = false end
end
local custom = typeof(getcustomasset) == "function" and getcustomasset or (typeof(getsynasset) == "function" and getsynasset)
if custom and canSave then
local ok = pcall(function()
if isfile(ICON_FILE) and #readfile(ICON_FILE) > 1000 then setIcon(custom(ICON_FILE)) return end
writefile(ICON_FILE, L.b64dec(L.ICON_B64))
setIcon(custom(ICON_FILE))
end)
if ok then loaded(1.5); return show() end
end
setIcon("rbxthumb://type=Asset&id=" .. ICON_ID .. "&w=150&h=150")
if loaded(4) then return show() end
pcall(function()
local o = game:GetObjects("rbxassetid://" .. ICON_ID)[1]
local t = o and (o.Texture or o.Image)
if t and t ~= "" then setIcon(t) end
end)
if loaded(4) then return show() end
if custom and canSave then
local ok = pcall(function()
local body = game:HttpGet("https://assetdelivery.roblox.com/v1/asset/?id=" .. ICON_ID)
if body:sub(2, 4) ~= "PNG" then
local img = body:match("asset/%?id=(%d+)") or body:match("rbxassetid://(%d+)")
if not img then error("no image") end
setIcon("rbxassetid://" .. img)
if loaded(4) then return end
body = game:HttpGet("https://assetdelivery.roblox.com/v1/asset/?id=" .. img)
end
writefile(ICON_FILE, body)
setIcon(custom(ICON_FILE))
end)
if ok then loaded(1.5); return show() end
end
if custom and canSave and httpReq then
local ok = pcall(function()
local info = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/assets?assetIds=" .. ICON_ID .. "&size=150x150&format=Png"))
local url = info.data[1].imageUrl
if type(url) ~= "string" or not url:find("^https://") then error("no image") end
writefile(ICON_FILE, game:HttpGet(url))
setIcon(custom(ICON_FILE))
end)
if ok then loaded(1.5); return show() end
end
end)
local settingsBtn = new("TextButton", {
Position = UO(SB_CLOSED, 4), Size = U2(1, -(SB_CLOSED + 6), 0, TITLE_H - 10),
BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 8,
}, sidebar)
local menuLabel = text(settingsBtn, {
Position = UO(8, 0), Size = U2(1, -8, 1, 0), Text = "Settings", TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1, ZIndex = 9,
})
local list = new("ScrollingFrame", {
Position = UO(0, TITLE_H + 4), Size = U2(1, 0, 1, -(TITLE_H + 44)),
BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 8,
}, sidebar)
new("UIListLayout", {
Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
}, list)
local pages, rows, labels, refreshers, bars = {}, {}, {}, {}, {}
local selected, opened = nil, false
local closeToken = 0
local setOpen
do
local avatar = new("ImageLabel", {
AnchorPoint = V2(0, 1), Position = U2(0, 9, 1, -22), Size = UO(26, 26), BackgroundColor3 = L.P.ctrl,
BorderSizePixel = 0, Image = "", ZIndex = 10,
}, sidebar)
round(avatar, 99)
outline(avatar, 1.5, 0.2)
local nm = text(sidebar, {
AnchorPoint = V2(0, 1), Position = U2(0, 44, 1, -22), Size = U2(1, -50, 0, 26), Text = LP.DisplayName, TextSize = 12,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1, ZIndex = 10,
})
fit(nm, 12, 8)
labels[#labels + 1] = nm
task.spawn(function()
local ok, img = pcall(Players.GetUserThumbnailAsync, Players, LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
if ok then avatar.Image = img end
end)
end
local function bump()
closeToken = closeToken + 1
if not opened or not S.autoClose then return end
local t = closeToken
task.delay(S.autoCloseDelay, function()
if t == closeToken and opened then setOpen(false) end
end)
end
local function selectItem(name)
selected = name
if name == ADD_PAGE and L.commPull and os.clock() - (L.commLast or -99) > 8 then L.commPull() end
for n, row in pairs(rows) do
tween(row, FAST, {BackgroundTransparency = (n == name) and 0.72 or 1}) if L.navIcons[n] then tween(L.navIcons[n], FAST, {ImageTransparency = (n == name) and 0 or 0.35}) end
end
for n, b in pairs(bars) do tween(b, SB_TWEEN, {BackgroundTransparency = (n == name) and 0 or 1, Size = (n == name) and UO(3, 18) or UO(3, 6)}) end
tween(headHL, FAST, {BackgroundTransparency = (name == "Settings") and 0.72 or 1})
for n, page in pairs(pages) do
local on = (n == name)
local home = L.pageHome[page]
if on and not page.Visible then
if not home then home = page.Position; L.pageHome[page] = home end
page.Position = home + UO(0, 12)
page.Visible = true
if L.pageTw[page] then L.pageTw[page]:Cancel() end
local tw = TweenService:Create(page, L.PAGE, {Position = home})
L.pageTw[page] = tw
tw:Play()
elseif not on then
if L.pageTw[page] then L.pageTw[page]:Cancel() end
page.Visible = false
if home then page.Position = home end
end
end
if L.pageUI then
local cur = L.pageUI[L.uiOf[name] or name]
for _, u in pairs(L.pageUI) do if u ~= cur then u.lastKey = nil end end
end
if L.renderDirty then L.renderDirty(name) end
if name == "Updates" and L.refreshUpdates then
L.refreshUpdates()
task.delay(2, function()
local p = pages["Updates"]
if p and p.Visible then
S.updSeen = os.time()
scheduleSave()
if L.updDot then L.updDot() end
end
end)
end
end
function setOpen(state)
opened = state
local w = state and SB_OPEN or SB_CLOSED
tween(sidebar, SB_TWEEN, {Size = U2(0, w, 1, 0)})
tween(content, SB_TWEEN, {Position = UO(w, TITLE_H), Size = U2(1, -w, 1, -TITLE_H)})
tween(title, SB_TWEEN, {Position = UO(w + 10, 0), Size = U2(1, -(w + 152), 1, 0)})
local fade = TweenInfo.new(0.2)
local tr = state and 0 or 1
tween(menuLabel, fade, {TextTransparency = tr})
for _, l in ipairs(labels) do tween(l, fade, {TextTransparency = tr}) end
bump()
end
local function makeSwitch(parent, anchor, pos, key, apply, guard)
local btn = new("TextButton", {
AnchorPoint = anchor, Position = pos, Size = UO(34, 18),
Text = "", AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 21,
}, parent)
round(btn, 99)
L.press(btn, 0.93)
local knob = new("Frame", {AnchorPoint = V2(0, 0.5), Size = UO(12, 12), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 22}, btn)
round(knob, 99)
local function refresh()
local on = S[key]
tween(knob, L.SW, {Position = U2(0, on and 19 or 3, 0.5, 0)})
tween(btn, L.SW, {BackgroundColor3 = on and themeBtn or L.P.line})
end
refreshers[#refreshers + 1] = refresh
btn.MouseButton1Click:Connect(function()
if guard and not guard() then return end
S[key] = not S[key]
refresh(); apply(); scheduleSave()
end)
end
local function runScript(entry)
if typeof(loadstring) ~= "function" then return notify("Can't run script", "This executor has no loadstring", nil, 3) end
notify("Running", entry.name)
if L.pushHist then L.pushHist(entry) end
playSound(SND.run)
L.busy(1)
task.spawn(function()
local setId = setthreadidentity or set_thread_identity or setidentity or (syn and syn.set_thread_identity)
if setId then pcall(setId, 8) end
local fn, err = loadstring(entry.code)
if not fn then L.busy(-1) L.mark(entry.code, false, err) notify("Script error: " .. entry.name, tostring(err):sub(1, 120), nil, 3) return end
local ok, e = pcall(fn)
L.busy(-1)
L.mark(entry.code, ok, not ok and e or nil)
if not ok then notify("Error in " .. entry.name, tostring(e):sub(1, 120), nil, 3) end
end)
end
local function overlay(name, z)
local f = new("Frame", {
Name = name, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0),
BackgroundTransparency = 0.3, BorderSizePixel = 0, Active = true, Visible = false, ZIndex = z,
}, win)
round(f, 12)
local baseT = f.BackgroundTransparency
local ovTw
f:GetPropertyChangedSignal("Visible"):Connect(function()
if ovTw then ovTw:Cancel(); ovTw = nil end
for _, c in ipairs(f:GetChildren()) do
if c:IsA("Frame") and c.AnchorPoint == V2(0.5, 0.5) then
local home = L.cardHome[c]
if not home then home = c.Position; L.cardHome[c] = home end
if L.cardTw[c] then L.cardTw[c]:Cancel(); L.cardTw[c] = nil end
c.Position = f.Visible and (home + UO(0, 14)) or home
if f.Visible then
local tw = TweenService:Create(c, TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = home})
L.cardTw[c] = tw
tw:Play()
end
end
end
if not f.Visible then f.BackgroundTransparency = baseT return end
f.BackgroundTransparency = 1
ovTw = TweenService:Create(f, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = baseT})
ovTw:Play()
end)
return f
end
local function card(parent, w, h, z)
local c = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UO(w, h),
BorderSizePixel = 0, ZIndex = z,
}, parent)
round(c, 12)
outline(c, 1.25, 0.3)
L.fitList[#L.fitList + 1] = {new("UIScale", {}, c), w, h, win}
return c
end
local modal = overlay("AddMenu", 40)
local modalCard = card(modal, 500, 322, 41)
local modalTitle = text(modalCard, {
Position = UO(18, 10), Size = U2(1, -36, 0, 26), Text = "Add script", TextSize = 15,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42,
})
fit(modalTitle, 15, 9)
function L.modalLabel(x, y, w, t)
text(modalCard, {Position = UO(x, y), Size = UO(w, 14), Text = t, TextSize = 10, TextColor3 = L.P.muted, TextTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42})
end
L.modalLabel(18, 40, 200, "NAME")
L.modalLabel(18, 90, 230, "SCRIPT OR LINK")
L.modalLabel(18, 198, 230, "ADD A DESCRIPTION (optional)")
L.modalLabel(262, 40, 220, "WHAT GAME IS IT FOR? (name or game ID)")
L.modalLabel(262, 190, 180, "TYPE (Universal needs no game)")
local function inputBox(parent, x, y, w, h, placeholder, multi, z)
local tb = new("TextBox", {
Position = UO(x, y), Size = UO(w, h), BackgroundColor3 = L.P.input,
BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = z,
Font = multi and Enum.Font.RobotoMono or Enum.Font.Nunito, TextSize = 12,
TextColor3 = WHITE, PlaceholderColor3 = Color3.fromRGB(120, 115, 150), PlaceholderText = placeholder,
Text = "", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = multi and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
MultiLine = multi, TextWrapped = multi, ClipsDescendants = true,
}, parent)
round(tb, 8)
new("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, multi and 6 or 0)}, tb)
local st = new("UIStroke", {Thickness = 1, Transparency = 0, Color = L.P.line, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, tb)
tb.Focused:Connect(function() tween(st, FAST, {Color = themeStroke}) end)
tb.FocusLost:Connect(function() tween(st, FAST, {Color = L.P.line}) end)
return tb, st
end
local nameBox, nameStroke = inputBox(modalCard, 18, 55, 232, 30, "Name your script", false, 42)
local codeBox, codeStroke = inputBox(modalCard, 18, 105, 232, 86, "Paste the script, or a pastebin link", true, 42)
local descBox = inputBox(modalCard, 18, 214, 232, 50, "What does it do? (optional)", true, 42)
descBox.Font = Enum.Font.Nunito
local modalAdd = button(modalCard, 18, 278, 300, 32, "Add script", L.P.btn, 0, 42)
local modalCancel = button(modalCard, 326, 276, 156, 34, "Cancel", WHITE, 0.85, 42)
-- game picker: closest matches while typing, game id lookup, Keyless / Universal / FE
L.m = {kinds = {}}
do
local lf = button(modalCard, 160, 86, 90, 18, "Load file", L.P.ctrl, 0, 43)
lf.TextSize = 10
L.m.lf = lf
function L.m.setBig(code)
L.m.big = code
L.m.settingBig = true
codeBox.TextEditable = false
codeBox.Text = "-- Large script: " .. #code .. " characters. Kept safely, not shown in full so nothing lags.\n" .. code:sub(1, 1200) .. "\n..."
L.m.settingBig = false
lf.Text = "Clear"
end
function L.m.clearBig()
if not L.m.big then return end
L.m.big = nil
L.m.settingBig = true
codeBox.TextEditable = true
codeBox.Text = ""
L.m.settingBig = false
lf.Text = "Load file"
end
codeBox:GetPropertyChangedSignal("Text"):Connect(function()
if L.m.settingBig or L.m.big then return end
if #codeBox.Text > 60000 then L.m.setBig(codeBox.Text) end
end)
lf.MouseButton1Click:Connect(function()
if L.m.big then return L.m.clearBig() end
local fn = codeBox.Text:match("^%s*(.-)%s*$")
if fn == "" or #fn > 120 or fn:find("\n", 1, true) then
return notify("Load file", "Type the file name (from your executor's workspace folder) in the script box, then press Load file", nil, 5)
end
if typeof(isfile) ~= "function" or typeof(readfile) ~= "function" or not isfile(fn) then
return notify("Load file", "File not found in the workspace folder: " .. fn:sub(1, 40), nil, 4)
end
local ok, data = pcall(readfile, fn)
if not ok or type(data) ~= "string" or data == "" then return notify("Load file", "Could not read that file", nil, 3) end
if #data > 60000 then L.m.setBig(data) else codeBox.Text = data end
end)
end
do
local M2 = L.m
M2.gameBox, M2.gameStroke = inputBox(modalCard, 262, 55, 220, 30, "Type a game, e.g. B  or a game ID", false, 42)
local sugBtns, sugData, sugTok, setting = {}, {}, 0, false
for i = 1, 3 do
local b = new("TextButton", {
Position = UO(262, 90 + (i - 1) * 27), Size = UO(220, 24), BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = "", TextColor3 = WHITE,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Visible = false, ZIndex = 43,
}, modalCard)
round(b, 6)
new("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 6)}, b)
L.popIn(b)
sugBtns[i] = b
b.MouseButton1Click:Connect(function()
local it = sugData[i]
if not it or not it.name then return end
setting = true
M2.gameBox.Text = it.name
setting = false
M2.gid = it.gid
for _, x in ipairs(sugBtns) do x.Visible = false end
end)
end
text(modalCard, {Position = UO(262, 172), Size = UO(220, 14), Font = Enum.Font.Nunito, Text = "Tap a match, or type your own.", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42})
local function setSug(items)
for i, b in ipairs(sugBtns) do
local it = items[i]
sugData[i] = it
b.Visible = it ~= nil
if it then b.Text = it.label end
end
end
local function refreshSug()
sugTok = sugTok + 1
local my = sugTok
local q = M2.gameBox.Text
local idq = q:match("^%s*(%d+)%s*$")
if idq and #idq >= 3 then
setSug({{label = "Looking up game ID " .. idq .. "..."}})
L.gameFromId(idq, function(nm)
if my ~= sugTok then return end
if nm then setSug({{label = "" .. nm .. "  (ID " .. idq .. ")", name = nm, gid = idq}})
else setSug({{label = "No game found for " .. idq .. ", tap to use the ID", name = "Game ID " .. idq, gid = idq}}) end
end)
return
end
local items = {}
for _, nm in ipairs(L.matchGames(q, 3)) do
items[#items + 1] = {label = "" .. nm .. (nm == L.curGame and "  (this game)" or ""), name = nm}
end
local qt = q:match("^%s*(.-)%s*$")
if #qt >= 2 and L.robloxSearch then
if #items == 0 then items[1] = {label = "Searching all of Roblox..."} end
setSug(items)
local mine = {}
for _, it in ipairs(items) do if it.name then mine[#mine + 1] = it end end
task.delay(0.45, function()
if my ~= sugTok then return end
L.robloxSearch(qt, function(res)
if my ~= sugTok then return end
local mixed = L.mixGames(res or {}, mine, 3)
if #mixed == 0 then mixed = {{label = "No games found, you can type your own"}} end
setSug(mixed)
end)
end)
return
end
setSug(items)
end
M2.gameBox:GetPropertyChangedSignal("Text"):Connect(function()
if setting then return end
M2.gid = nil
refreshSug()
end)
M2.preview = new("Frame", {Position = UO(454, 182), Size = UO(24, 24), BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0, ZIndex = 43}, modalCard)
round(M2.preview, 6)
local chips = {}
local function recolor()
if M2.preview then L.kindBadgeInto(M2.preview, M2.kindStr and M2.kindStr() or "", 24) end
for i, kd in ipairs(L.KINDS) do
local on = M2.kinds[kd[1]]
chips[i].BackgroundColor3 = on and kd[3] or L.P.ctrl
chips[i].Text = (on and "" or "") .. kd[2]
end
end
for i, kd in ipairs(L.KINDS) do
local b = button(modalCard, 262 + (i - 1) * 74, 206, 70, 28, kd[2], L.P.ctrl, 0, 42)
b.TextSize = 12
fit(b, 12, 7)
chips[i] = b
b.MouseButton1Click:Connect(function() M2.kinds[kd[1]] = not M2.kinds[kd[1]]; recolor() end)
end
function M2.kindStr()
local out = ""
for _, kd in ipairs(L.KINDS) do if M2.kinds[kd[1]] then out = out .. kd[1] end end
return out
end
function M2.reset()
if M2.clearBig then M2.clearBig() end
setting = true
M2.gameBox.Text = ""
setting = false
M2.gid, M2.kinds = nil, {}
recolor()
refreshSug()
end
-- sections picker (Dua's script): pick one or more tabs to put the script in
M2.secs, M2.secChips = {}, {}
M2.secCap = text(modalCard, {
Position = UO(262, 237), Size = UO(220, 12), Font = Enum.Font.Nunito, Text = "Put it in (tap more than one):",
TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42, Visible = false,
})
M2.SHORT = {["Dua's favorites"] = "Favs"}
function M2.secPaint()
for i, sec in ipairs(SECTIONS) do
local on = M2.secs[sec.name]
M2.secChips[i].BackgroundColor3 = on and themeBtn or L.P.ctrl
M2.secChips[i].Text = (on and "" or "") .. sec.icon .. (M2.SHORT[sec.name] or sec.name)
end
end
for i, sec in ipairs(SECTIONS) do
local b = button(modalCard, 262 + (i - 1) * 56, 251, 53, 22, "", L.P.ctrl, 0, 42)
b.TextSize, b.Visible = 10, false
M2.secChips[i] = b
b.MouseButton1Click:Connect(function()
M2.secs[sec.name] = not M2.secs[sec.name] or nil
M2.secPaint()
end)
end
function M2.secShow(page, picked)
local show = L.isSection[page] == true
M2.secCap.Visible = show
for _, b in ipairs(M2.secChips) do b.Visible = show end
M2.secs = picked or {[page] = true}
M2.secPaint()
end
function M2.load(e)
setting = true
M2.gameBox.Text = e.game or ""
setting = false
M2.gid = e.gid
M2.kinds = {}
for _, kd in ipairs(L.KINDS) do
if type(e.kinds) == "string" and e.kinds:find(kd[1], 1, true) then M2.kinds[kd[1]] = true end
end
recolor()
for _, b in ipairs(sugBtns) do b.Visible = false end
end
-- the card keeps fitting when the window is small
local mScale = modalCard:FindFirstChildOfClass("UIScale")
local function fitCard()
local a = win.AbsoluteSize
if a.X > 0 and a.Y > 0 then mScale.Scale = math.clamp(math.min((a.X - 12) / 500, (a.Y - 12) / 322), 0.5, 1) end
end
win:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitCard)
function L.fitAll()
for i = #L.fitList, 1, -1 do
local f = L.fitList[i]
if not f[1].Parent then table.remove(L.fitList, i)
else
local a = f[4].AbsoluteSize
if a.X > 0 and a.Y > 0 then f[1].Scale = math.clamp(math.min((a.X - 12) / f[2], (a.Y - 12) / f[3]), 0.5, 1) end
end
end
end
win:GetPropertyChangedSignal("AbsoluteSize"):Connect(L.fitAll)
fitCard()
M2.reset()
end
local confirm = overlay("Confirm", 50)
local confirmCard = card(confirm, 300, 134, 51)
local askConfirm
do
local confirmText = text(confirmCard, {
Position = UO(16, 12), Size = U2(1, -32, 0, 64), Font = Enum.Font.Nunito, TextSize = 14,
TextWrapped = true, ZIndex = 52,
})
fit(confirmText, 14, 9)
local confirmYes = button(confirmCard, 16, 88, 128, 34, "Remove", RED, 0.1, 52)
local confirmNo = button(confirmCard, 156, 88, 128, 34, "Cancel", WHITE, 0.85, 52)
local confirmCb
askConfirm = function(msg, onYes, yes)
confirmYes.Text = yes or "Remove"
confirmText.Text, confirmCb = msg, onYes
confirm.Visible = true
end
confirmYes.MouseButton1Click:Connect(function()
local cb = confirmCb
confirm.Visible, confirmCb = false, nil
if cb then cb() end
end)
confirmNo.MouseButton1Click:Connect(function() confirm.Visible, confirmCb = false, nil end)
end
L.auto = {list = {}}
do
local d = readJson("DuaLibrary_AutoExec.json")
if d and type(d.list) == "table" then
for _, e in ipairs(d.list) do
if type(e) == "table" and type(e.name) == "string" and type(e.code) == "string" then
L.auto.list[#L.auto.list + 1] = {name = e.name:sub(1, 40), code = e.code, place = tonumber(e.place)}
end
end
end
end
L.saveAuto = debounce(0.5, function() writeJson("DuaLibrary_AutoExec.json", {list = L.auto.list}) end)
function L.autoIndex(e)
local k = L.ckey(e.code)
for i, x in ipairs(L.auto.list) do if x.name == e.name and L.ckey(x.code) == k then return i end end
end
function L.autoState(e)
local i = L.autoIndex(e)
if not i then return 0 end
return L.auto.list[i].place and 2 or 1
end
function L.autoCycle(e)
local i = L.autoIndex(e)
if not i then table.insert(L.auto.list, {name = e.name:sub(1, 40), code = e.code})
elseif not L.auto.list[i].place then L.auto.list[i].place = game.PlaceId
else table.remove(L.auto.list, i) end
L.saveAuto()
if L.autoRender then L.autoRender() end
end
function L.autoRunAll(manual)
local ran = 0
for _, it in ipairs(L.auto.list) do
if not it.place or it.place == game.PlaceId then
ran = ran + 1
task.spawn(runScript, it)
task.wait(0.25)
end
end
if manual and ran == 0 then notify("Auto-execute", "Nothing on the list for this game", nil, 3) end
end
L.favMeta = {}
do
local d = readJson("DuaLibrary_FavMeta.json")
if d and type(d.m) == "table" then
for k, v in pairs(d.m) do
if type(k) == "string" and type(v) == "table" then
local tags
if type(v.tags) == "table" then
tags = {}
for _, t in ipairs(v.tags) do if type(t) == "string" and #tags < 6 then tags[#tags + 1] = t:sub(1, 16) end end
end
L.favMeta[k] = {folder = type(v.folder) == "string" and v.folder:sub(1, 24) or nil, tags = tags}
end
end
end
end
L.saveFavMeta = debounce(0.5, function() writeJson("DuaLibrary_FavMeta.json", {m = L.favMeta}) end)
function L.favMetaOf(e) return L.favMeta[L.noteKey(e)] end
function L.favMetaText(e)
local m = L.favMetaOf(e)
return (m and m.folder) or "", (m and m.tags) and table.concat(m.tags, ", ") or ""
end
function L.favMetaSet(e, folder, tagsStr)
folder = tostring(folder or ""):match("^%s*(.-)%s*$"):sub(1, 24)
local tags = {}
for t in tostring(tagsStr or ""):gmatch("[^,]+") do
t = t:match("^%s*#?(.-)%s*$"):lower():sub(1, 16)
if t ~= "" and #tags < 6 and not table.find(tags, t) then tags[#tags + 1] = t end
end
if folder == "" and #tags == 0 then L.favMeta[L.noteKey(e)] = nil
else L.favMeta[L.noteKey(e)] = {folder = folder ~= "" and folder or nil, tags = #tags > 0 and tags or nil} end
L.saveFavMeta()
end
function L.favOptions()
local folders, tags, seenF, seenT = {}, {}, {}, {}
for _, e in ipairs(L.favList()) do
local m = L.favMetaOf(e)
if m then
if m.folder and not seenF[m.folder] then seenF[m.folder] = true; folders[#folders + 1] = m.folder end
for _, t in ipairs(m.tags or {}) do if not seenT[t] then seenT[t] = true; tags[#tags + 1] = t end end
end
end
table.sort(folders); table.sort(tags)
local out = {""}
for _, f in ipairs(folders) do out[#out + 1] = "F:" .. f end
for _, t in ipairs(tags) do out[#out + 1] = "T:" .. t end
return out
end
function L.favBtnText()
local ui = L.pageUI and L.pageUI[L.FAVP]
if not ui or not ui.favBtn then return end
local v = S.favFolder or ""
if v ~= "" and not table.find(L.favOptions(), v) then S.favFolder, v = "", "" end
ui.favBtn.Text = v == "" and "All favorites" or (v:sub(1, 1) == "F" and ("Folder: " .. v:sub(3)) or ("Tag: #" .. v:sub(3)))
end
local openViewer, viewer, viewCard
do
viewer = overlay("Viewer", 45)
viewCard = card(viewer, 580, 424, 46)
local vIcon = new("Frame", {Position = UO(16, 14), Size = UO(40, 40), BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0, ZIndex = 47}, viewCard)
round(vIcon, 9)
local vTitle = text(viewCard, {
Position = UO(66, 12), Size = U2(1, -82, 0, 24), TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 47,
})
fit(vTitle, 15, 9)
local vInfo = text(viewCard, {
Position = UO(66, 36), Size = U2(1, -82, 0, 16), Font = Enum.Font.Nunito, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
TextTransparency = 0.1, Text = "", TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 47,
})
local vDesc = text(viewCard, {
Position = UO(16, 62), Size = U2(1, -32, 0, 30), Font = Enum.Font.Nunito, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, TextTransparency = 0.2, Text = "", ZIndex = 47,
})
local vNote = text(viewCard, {
Position = UO(16, 94), Size = U2(1, -32, 0, 16), Font = Enum.Font.Nunito, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
TextTransparency = 0.1, Text = "", TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 47,
})
-- folder and tags (only for favorited scripts)
local orgRow = new("Frame", {Position = UO(16, 114), Size = UO(548, 28), BackgroundTransparency = 1, ZIndex = 47, Visible = false}, viewCard)
local fBox = inputBox(orgRow, 0, 0, 160, 28, "Folder, e.g. Aimbots", false, 48)
local tBox = inputBox(orgRow, 168, 0, 250, 28, "Tags, e.g. fly, pvp, fun", false, 48)
local oSave = button(orgRow, 426, 0, 122, 28, "Save folder/tags", L.P.btn, 0, 48)
oSave.TextSize = 11
fit(oSave, 11, 7)
-- code view: only the rows on screen exist, so scripts of any size stay smooth
local LH, WRAP, POOL = 15, 64, 20
local codeFrame = new("ScrollingFrame", {
Position = UO(16, 148), Size = UO(548, 204), BackgroundColor3 = L.P.input, BorderSizePixel = 0, ScrollBarThickness = 5,
ScrollBarImageColor3 = WHITE, CanvasSize = UDim2.new(), ZIndex = 47, ClipsDescendants = true,
}, viewCard)
round(codeFrame, 8)
new("UIStroke", {Thickness = 1, Color = L.P.line, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, codeFrame)
local rowsT, numsT, pool = {}, {}, {}
local function mono(o)
o:SetAttribute("FixedFont", true)
o.Font = Enum.Font.RobotoMono
end
for i = 1, POOL do
local g = new("TextLabel", {BackgroundTransparency = 1, Size = UO(38, LH), TextXAlignment = Enum.TextXAlignment.Right, TextSize = 11, TextColor3 = L.P.muted, Text = "", ZIndex = 48, Visible = false}, codeFrame)
local l = new("TextLabel", {BackgroundTransparency = 1, Size = UO(496, LH), TextXAlignment = Enum.TextXAlignment.Left, TextSize = 12, TextColor3 = Color3.fromRGB(215, 215, 230), Text = "", TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 48, Visible = false}, codeFrame)
mono(g); mono(l)
pool[i] = {g, l}
end
local function paint()
local first = math.max(1, math.floor(codeFrame.CanvasPosition.Y / LH) + 1)
local n = #rowsT
for i = 1, POOL do
local idx = first + i - 1
local g, l = pool[i][1], pool[i][2]
if idx <= n then
local y = (idx - 1) * LH + 4
g.Position, l.Position = UO(2, y), UO(46, y)
g.Text = numsT[idx] > 0 and tostring(numsT[idx]) or ""
l.Text = rowsT[idx]
g.Visible, l.Visible = true, true
else
g.Visible, l.Visible = false, false
end
end
end
codeFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(paint)
local vSize = text(viewCard, {
Position = UO(16, 355), Size = UO(548, 14), Font = Enum.Font.Nunito, TextSize = 10, TextTransparency = 0.3,
TextXAlignment = Enum.TextXAlignment.Left, Text = "", ZIndex = 47,
})
local loadTok = 0
local function setCode(str)
loadTok = loadTok + 1
local my = loadTok
rowsT, numsT = {}, {}
codeFrame.CanvasPosition = Vector2.new(0, 0)
codeFrame.CanvasSize = UO(0, 8)
paint()
str = tostring(str or "")
vSize.Text = ""
task.spawn(function()
local pos, n, lineNo, budget = 1, #str, 0, 0
while pos <= n do
if my ~= loadTok then return end
local e = str:find("\n", pos, true) or (n + 1)
local line = str:sub(pos, e - 1):gsub("\r", ""):gsub("\t", "  ")
lineNo = lineNo + 1
if #line == 0 then
rowsT[#rowsT + 1] = ""
numsT[#rowsT] = lineNo
else
local p = 1
while p <= #line do
rowsT[#rowsT + 1] = line:sub(p, p + WRAP - 1)
numsT[#rowsT] = (p == 1) and lineNo or 0
p = p + WRAP
end
end
pos = e + 1
budget = budget + 1
if budget >= 1500 then
budget = 0
codeFrame.CanvasSize = UO(0, #rowsT * LH + 8)
paint()
task.wait()
end
end
if my ~= loadTok then return end
codeFrame.CanvasSize = UO(0, #rowsT * LH + 8)
paint()
local kb = n / 1024
vSize.Text = lineNo .. (lineNo == 1 and " line" or " lines") .. "   -   " .. (kb >= 100 and string.format("%.0f", kb) or string.format("%.1f", kb)) .. " KB"
end)
end
-- buttons
local vRun = button(viewCard, 16, 376, 100, 34, "Run", L.P.btn, 0, 47)
local vCopy = button(viewCard, 16, 376, 100, 34, "Copy", L.P.ctrl, 0, 47)
local vAuto = button(viewCard, 16, 376, 100, 34, "Auto: Off", L.P.ctrl, 0, 47)
local vNoteB = button(viewCard, 16, 376, 100, 34, "Note", L.P.ctrl, 0, 47)
local vPin = button(viewCard, 16, 376, 100, 34, "Admin note", Color3.fromRGB(150, 100, 30), 0, 47)
local vMsg = button(viewCard, 16, 376, 100, 34, "Message", L.P.info, 0, 47)
local vClose = button(viewCard, 16, 376, 100, 34, "Close", WHITE, 0.85, 47)
for _, bt in ipairs({vRun, vCopy, vAuto, vNoteB, vPin, vMsg, vClose}) do fit(bt, 12, 8) end
local function ico(bt, idx)
if not L.atlasURL then return end
new("UIPadding", {PaddingLeft = UDim.new(0, 22)}, bt)
L.icon(bt, idx, 14, {Position = UO(7, 10)})
end
ico(vRun, 10); ico(vCopy, 20); ico(vAuto, 19)
vPin.Visible, vMsg.Visible = false, false
local current, shownCode
local function layout()
local list = {vRun, vCopy, vAuto, vNoteB}
if vPin.Visible then list[#list + 1] = vPin end
if vMsg.Visible then list[#list + 1] = vMsg end
list[#list + 1] = vClose
local gap = 6
local w = (548 - gap * (#list - 1)) / #list
for i, bt in ipairs(list) do
bt.Position, bt.Size = UO(16 + (i - 1) * (w + gap), 376), UO(w, 34)
end
end
local function autoText()
local st = current and L.autoState(current) or 0
vAuto.Text = st == 0 and "Auto: Off" or (st == 1 and "Auto: All games" or "Auto: This game")
vAuto.BackgroundColor3 = st == 0 and L.P.ctrl or themeBtn
end
local function showNote()
local parts = {}
if current and current.an then parts[#parts + 1] = "" .. tostring(current.anb or "Admin") .. ": " .. current.an end
local hh = current and L.health[L.hkey(current.code)]
if hh and not hh.ok then parts[#parts + 1] = "Last run failed: " .. tostring(hh.err or "error") end
local n = current and L.notes[L.noteKey(current)]
if n then parts[#parts + 1] = "" .. n end
local txt = table.concat(parts, "   "):gsub("%s+", " ")
vNote.Text = txt:sub(1, 120)
end
openViewer = function(entry, shown)
current, shownCode = entry, shown or entry.code
vTitle.Text = entry.name
if not L.kindBadgeInto(vIcon, entry.kinds, 40) then
vIcon.BackgroundColor3 = L.P.ctrl
local letter = "?"
pcall(function() letter = utf8.char(utf8.codepoint(entry.name, 1)):upper() end)
text(vIcon, {Size = U2(1, 0, 1, 0), Text = letter, TextSize = 18, ZIndex = 48})
end
setCode(shownCode)
local who = type(entry.by) == "string" and entry.by ~= "" and entry.by or nil
local info = {}
if who then info[#info + 1] = "Shared by " .. who .. ((isAdmin and type(entry.uid) == "string" and entry.uid ~= "") and ("   (ID " .. entry.uid .. ")") or "") end
if entry.game then info[#info + 1] = "" .. entry.game .. (entry.gid and (" (ID " .. entry.gid .. ")") or "") end
if entry.kinds then info[#info + 1] = L.kindWords(entry.kinds) end
local onShare = entry.comm or table.find(adminPages[ADD_PAGE], entry) ~= nil
if onShare then info[#info + 1] = "" .. ((L.favCount or {})[entry.name] or 0) .. " hearts" end
if tonumber(entry.t) then info[#info + 1] = L.ago(tonumber(entry.t)) end
vInfo.Text = table.concat(info, "  -  ")
local adminHere = isAdmin and onShare
vPin.Visible = adminHere
vMsg.Visible = adminHere and (entry.comm or who) and true or false
vDesc.Text = (type(entry.desc) == "string" and entry.desc ~= "") and entry.desc or (who and "No description." or "")
showNote()
orgRow.Visible = L.isFav(entry) and true or false
if orgRow.Visible then
fBox.Text, tBox.Text = L.favMetaText(entry)
end
autoText()
layout()
viewer.Visible = true
local slug = not shown and L.sbSlug(entry.code)
if slug then
setCode("-- Loading from scriptblox.com...")
L.sbFetch(slug, function(code)
if current == entry then shownCode = code; setCode(code) end
end)
end
end
vRun.MouseButton1Click:Connect(function()
if not current then return end
local e = current
if e.comm then
askConfirm('Run "' .. e.name:sub(1, 40) .. '" shared by ' .. tostring(e.by):sub(1, 20) .. "? Scripts from players are not checked. Only run ones you trust.", function() runScript(e) end, "Run")
else
runScript(e)
end
end)
vAuto.MouseButton1Click:Connect(function()
if not current then return end
L.autoCycle(current)
autoText()
end)
oSave.MouseButton1Click:Connect(function()
if not current then return end
L.favMetaSet(current, fBox.Text, tBox.Text)
fBox.Text, tBox.Text = L.favMetaText(current)
if L.favBtnText then L.favBtnText() end
if L.rerender then L.rerender() end
notify("Saved", "Folder and tags updated", nil, 2)
end)
do
local ed = overlay("NoteEditor", 50)
local ec = card(ed, 340, 214, 51)
L.cards[#L.cards + 1] = ec
text(ec, {Position = UO(16, 10), Size = U2(1, -32, 0, 24), Text = "Your note", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
text(ec, {Position = UO(16, 34), Size = U2(1, -32, 0, 14), Font = Enum.Font.Nunito, Text = "Only saved on this device.", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
local eb = inputBox(ec, 16, 54, 308, 100, "Write a note about this script...", true, 52)
local save = button(ec, 16, 166, 120, 32, "Save", L.P.btn, 0, 52)
local del = button(ec, 142, 166, 90, 32, "Delete", RED, 0.3, 52)
local cancel = button(ec, 238, 166, 86, 32, "Cancel", WHITE, 0.85, 52)
local function done()
ed.Visible = false
writeJson(FILE.NOTES, {n = L.notes})
showNote()
L.rerender()
end
vNoteB.MouseButton1Click:Connect(function()
if not current then return end
eb.Text = L.notes[L.noteKey(current)] or ""
ed.Visible = true
end)
save.MouseButton1Click:Connect(function()
local t = eb.Text:match("^%s*(.-)%s*$")
L.notes[L.noteKey(current)] = t ~= "" and t:sub(1, 600) or nil
done()
end)
del.MouseButton1Click:Connect(function() L.notes[L.noteKey(current)] = nil; done() end)
cancel.MouseButton1Click:Connect(function() ed.Visible = false end)
end
do
local an = overlay("AdminNoteEditor", 50)
local ac = card(an, 340, 214, 51)
L.cards[#L.cards + 1] = ac
text(ac, {Position = UO(16, 10), Size = U2(1, -32, 0, 24), Text = "Admin note", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
text(ac, {Position = UO(16, 34), Size = U2(1, -32, 0, 14), Font = Enum.Font.Nunito, Text = "Everyone sees this on the script. Only owner and admins can write it.", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
local ab = inputBox(ac, 16, 54, 308, 100, "e.g. Tested today, works on mobile", true, 52)
local save = button(ac, 16, 166, 120, 32, "Save note", L.P.btn, 0, 52)
local del = button(ac, 142, 166, 90, 32, "Remove", RED, 0.3, 52)
local cancel = button(ac, 238, 166, 86, 32, "Cancel", WHITE, 0.85, 52)
vPin.MouseButton1Click:Connect(function()
if not current or not isAdmin then return end
ab.Text = current.an or ""
an.Visible = true
end)
save.MouseButton1Click:Connect(function()
if not current then return end
if ab.Text:match("^%s*$") then return notify("Admin note", "Write the note first, or press Remove", nil, 2) end
L.setAdminNote(current, ab.Text)
an.Visible = false
showNote()
end)
del.MouseButton1Click:Connect(function()
if not current then return end
L.setAdminNote(current, "")
an.Visible = false
showNote()
end)
cancel.MouseButton1Click:Connect(function() an.Visible = false end)
end
do
local mo = overlay("ScriptMessage", 50)
local mc = card(mo, 340, 214, 51)
L.cards[#L.cards + 1] = mc
local mt = text(mc, {Position = UO(16, 10), Size = U2(1, -32, 0, 24), Text = "Message the sharer", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
fit(mt, 14, 9)
text(mc, {Position = UO(16, 34), Size = U2(1, -32, 0, 14), Font = Enum.Font.Nunito, Text = "They get it in their Messages, with this script's name.", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
local mb = inputBox(mc, 16, 54, 308, 100, "Write your message...", true, 52)
local send = button(mc, 16, 166, 150, 32, "Send", L.P.btn, 0, 52)
local cancel = button(mc, 174, 166, 150, 32, "Cancel", WHITE, 0.85, 52)
vMsg.MouseButton1Click:Connect(function()
if not current or not isAdmin then return end
mt.Text = "Message " .. tostring(current.by or "the sharer"):sub(1, 18)
mb.Text = ""
mo.Visible = true
end)
send.MouseButton1Click:Connect(function()
if not current then return end
if mb.Text:match("^%s*$") then return notify("Message", "Write the message first", nil, 2) end
L.sendScriptMsg(current, mb.Text)
mo.Visible = false
end)
cancel.MouseButton1Click:Connect(function() mo.Visible = false end)
end
vCopy.MouseButton1Click:Connect(function()
if not current then return end
if typeof(setclipboard) == "function" then
setclipboard(shownCode)
notify("Copied", current.name)
else
notify("Can't copy", "Your executor has no clipboard function", nil, 3)
end
end)
vClose.MouseButton1Click:Connect(function() viewer.Visible = false end)
end
local pageUI = {}
L.pageUI = pageUI
local function nop() end
local function shownEntries(name)
if name == L.ALL then
local out, seen = {}, {}
for _, sec in ipairs(SECTIONS) do
for _, e in ipairs(adminPages[sec.name]) do
local k = e.name .. "\0" .. e.code
if not seen[k] then seen[k] = true; out[#out + 1] = e end
end
end
return out, {}
end
if name ~= ADD_PAGE then return entriesOf[name], {} end
local out, shared = {}, {}
for _, e in ipairs(adminPages[ADD_PAGE]) do out[#out + 1] = e; shared[e] = true end
for _, e in ipairs(L.comm or {}) do out[#out + 1] = e end
for _, e in ipairs(L.pending or {}) do
local dup = false
for _, x in ipairs(L.comm or {}) do if x.uid == e.u and x.t == e.t and x.name == e.n:sub(1, 40) then dup = true break end end
if not dup then
out[#out + 1] = {name = e.n:sub(1, 40), code = e.c, comm = true, pending = true, by = e.a, uid = e.u, t = e.t, desc = e.d, game = e.g, gid = e.gi, kinds = e.k}
end
end
for _, e in ipairs(userScripts) do out[#out + 1] = e end
local seen, uniq = {}, {}
for _, e in ipairs(out) do
local k = L.eKey(e)
if not seen[k] then seen[k] = true; uniq[#uniq + 1] = e end
end
return uniq, shared
end
local function renderPage(name)
local ui = pageUI[L.uiOf[name] or name]
if ui.current ~= name then return end
local hostPage = pages[L.uiOf[name] or name]
if hostPage and not hostPage.Visible then ui.dirty = true return end
ui.dirty = false
if ui.top then
local isF = name == L.FAVL
ui.top.Visible = isF
ui.grid.Position, ui.grid.Size = UO(0, isF and 172 or 76), U2(1, 0, 1, -(isF and 172 or 76))
ui.grid.Visible = name ~= L.CHK
if ui.chk then ui.chk.Visible = name == L.CHK end
if isF then L.refreshTop() end
if name == L.CHK then
ui.hint.Visible, ui.count.Text = false, ""
if L.refreshCheck then L.refreshCheck() end
return
end
end
local st = L.cur()
local TILE, TILE_HOT, TILE_T = st.tile, st.hot, st.tileT
local entries, shared = shownEntries(name)
-- duplicates = same script code (name doesn't matter, spaces ignored)
local dupSet, dupGroups = {}, 0
do
local cnt = {}
for _, e in ipairs(entries) do
local k = L.ckey(e.code)
if k ~= "" then cnt[k] = (cnt[k] or 0) + 1 end
end
for _, e in ipairs(entries) do
local k = L.ckey(e.code)
if k ~= "" and cnt[k] > 1 then dupSet[e] = true end
end
for _, n in pairs(cnt) do if n > 1 then dupGroups = dupGroups + 1 end end
end
if not ui.top then
ui.baseTop = ui.baseTop or ui.grid.Position.Y.Offset
local canM = dupGroups > 0 and L.canMerge(name)
if canM and not ui.dupBar and hostPage then
ui.dupBar = button(hostPage, 10, ui.baseTop, 100, 24, "", L.DUPRED, 0.15, 22)
ui.dupBar.Size = U2(1, -20, 0, 24)
ui.dupBar.TextSize = 12
ui.dupBar.MouseButton1Click:Connect(function() L.mergeDups(ui.current) end)
end
if ui.dupBar then
ui.dupBar.Visible = canM
if canM then ui.dupBar.Text = "Merge " .. dupGroups .. " duplicated " .. (dupGroups == 1 and "script" or "scripts") .. " into one (longest name stays)" end
end
local off = canM and 30 or 0
ui.grid.Position, ui.grid.Size = UO(0, ui.baseTop + off), U2(1, 0, 1, -(ui.baseTop + off))
end
local q = (ui.query or ""):lower()
if q ~= "" then
local f = {}
for _, e in ipairs(entries) do
local hay = (e.name .. " " .. (e.game or "") .. " " .. (e.by or "") .. " " .. L.kindWords(e.kinds) .. " " .. (e.gid or "")):lower()
if hay:find(q, 1, true) then f[#f + 1] = e end
end
entries = f
end
if ui.favBtn then
ui.favBtn.Visible = (name == L.FAVL)
if name == L.FAVL then L.favBtnText() end
end
if name == L.FAVL and (S.favFolder or "") ~= "" then
local mode, val, f = S.favFolder:sub(1, 1), S.favFolder:sub(3), {}
for _, e in ipairs(entries) do
local m = L.favMetaOf(e)
if m and ((mode == "F" and m.folder == val) or (mode == "T" and m.tags and table.find(m.tags, val))) then f[#f + 1] = e end
end
entries = f
end
if L.uiOf[name] == L.DUA and S.duaSort ~= "def" then
local mode, fc, seq = S.duaSort, L.favCount or {}, {}
entries = table.move(entries, 1, #entries, 1, {})
for i, e in ipairs(entries) do seq[e] = i end
table.sort(entries, function(a, b)
if mode == "az" or mode == "za" then
local x, y = a.name:lower(), b.name:lower()
if x ~= y then if mode == "az" then return x < y else return x > y end end
elseif mode == "new" then
local x, y = a.t or 0, b.t or 0
if x ~= y then return x > y end
elseif mode == "fav" then
local x, y = fc[a.name] or 0, fc[b.name] or 0
if x ~= y then return x > y end
elseif mode == "kind" then
local x, y = a.kinds or "", b.kinds or ""
if x ~= y then return x < y end
end
return seq[a] < seq[b]
end)
end
if name == ADD_PAGE then
local seq, mode, fc = {}, S.shareSort, L.favCount or {}
for i, e in ipairs(entries) do seq[e] = i end
table.sort(entries, function(a, b)
local x, y = a.t or 0, b.t or 0
if mode == "fav" then
local fa, fb = fc[a.name] or 0, fc[b.name] or 0
if fa ~= fb then return fa > fb end
elseif mode == "az" then
local na, nb = a.name:lower(), b.name:lower()
if na ~= nb then return na < nb end
elseif mode == "old" then
if x ~= y then return x < y end
return seq[a] < seq[b]
end
if x ~= y then return x > y end
return seq[a] > seq[b]
end)
end
if ui.plus then ui.plus.Visible = name == ADD_PAGE or L.isSection[name] == true end
local pageIcon = name == ADD_PAGE and "➕" or ""
for _, it in ipairs(SECTIONS) do if it.name == name then pageIcon = it.icon end end
for _, c in ipairs(ui.grid:GetChildren()) do
if c.Name == "ScriptTile" then c:Destroy() end
end
ui.hint.Visible = #entries == 0 and not (ui.plus and ui.plus.Visible)
ui.hint.Text = q ~= "" and "No match." or (name == L.FAVL and "Nothing favorited yet. Tap the heart on a script.")
or (name == L.FAVD and "DuaKNo hasn't favorited anything yet.") or "No scripts here yet."
ui.count.Text = #entries .. (#entries == 1 and " script" or " scripts") .. ((#entries > 0 and name ~= ADD_PAGE and L.uiOf[name] ~= L.DUA) and "   -   Run starts it, View shows the code, the heart saves it" or "")
if name == ADD_PAGE and L.commStatusText then ui.count.Text = ui.count.Text .. "  ·  " .. L.commStatusText() end
local animKey = name
local animate = ui.lastKey ~= animKey
ui.lastKey = animKey
for i, entry in ipairs(entries) do
local isShared = shared[entry] == true
local isDup = dupSet[entry] == true
local canEdit = ((name == ADD_PAGE and (not entry.comm or isAdmin or entry.uid == tostring(LP.UserId))) or ((L.isSection[name] or name == L.ALL) and (L.owner() or (isAdmin and verName and type(entry.by) == "string" and entry.by:lower() == verName:lower())))) and true or false
local reserve = canEdit and (entry.pending and 200 or 236) or 176
local tile = new("TextButton", {
Name = "ScriptTile", LayoutOrder = i, BackgroundTransparency = 1, BorderSizePixel = 0, Text = "",
AutoButtonColor = false, ClipsDescendants = true, ZIndex = 21,
})
local body = new("Frame", {Position = UO(1, 1), Size = U2(1, -2, 1, -2), BackgroundColor3 = TILE, BackgroundTransparency = TILE_T, BorderSizePixel = 0, ZIndex = 21}, tile)
round(body, 8)
local tStroke = new("UIStroke", {Thickness = (isDup and 1.6 or 1) * (L.ss or 1), Transparency = isDup and 0 or 0.35, Color = isDup and L.DUPRED or L.P.line, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, body)
L.strokes[tStroke] = isDup and 1.6 or 1
local bar = new("Frame", {AnchorPoint = V2(0, 0.5), Position = U2(0, 0, 0.5, 0), Size = UO(3, 0), BackgroundColor3 = themeBtn, BorderSizePixel = 0, ZIndex = 24}, body)
L.fills[bar] = "btn"
local hue = 0
for k = 1, #entry.name do hue = (hue * 31 + entry.name:byte(k)) % 360 end
local badge = new("Frame", {AnchorPoint = V2(0, 0.5), Position = U2(0, 12, 0.5, 0), Size = UO(34, 34), BackgroundColor3 = Color3.fromHSV(hue / 360, 0.38, 0.52), BorderSizePixel = 0, ZIndex = 22}, body)
round(badge, 8)
if not L.kindBadgeInto(badge, entry.kinds, 34) then
local letter = "?"
pcall(function() letter = utf8.char(utf8.codepoint(entry.name, 1)):upper() end)
text(badge, {Size = U2(1, 0, 1, 0), Text = letter, TextSize = 16, ZIndex = 23})
end
text(body, {
Position = UO(56, 8), Size = U2(1, -(56 + reserve), 0, 18), Text = entry.name, TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22,
})
local gtxt = entry.game or (entry.kinds and entry.kinds:find("U", 1, true) and "Universal") or ""
local byName = entry.comm and entry.by or (isShared and (entry.by or "admin")) or nil
local sub = tostring(gtxt)
if byName then sub = sub .. (sub ~= "" and "  ·  " or "") .. "by " .. tostring(byName) .. (entry.pending and "  (sending)" or "") end
text(body, {
Position = UO(56, 26), Size = U2(1, -(56 + reserve), 0, 13), Text = sub, TextSize = 11, Font = Enum.Font.Nunito,
TextColor3 = L.P.muted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 23,
})
do
local meta = new("Frame", {Position = UO(56, 41), Size = U2(1, -(56 + reserve), 0, 13), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 23}, body)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center}, meta)
local mo = 0
local function tag(txt, col, fill)
mo = mo + 1
local t = new("TextLabel", {
LayoutOrder = mo, Size = UO(0, 13), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = col or L.P.ctrl, BackgroundTransparency = fill and 0.2 or 1,
BorderSizePixel = 0, Text = txt, Font = Enum.Font.Nunito, TextSize = 10, TextColor3 = fill and WHITE or L.P.muted, ZIndex = 24,
}, meta)
new("UIPadding", {PaddingLeft = UDim.new(0, fill and 5 or 0), PaddingRight = UDim.new(0, fill and 5 or 0)}, t)
if fill then round(t, 4) end
end
if isDup then tag("Duplicate", L.DUPRED, true) end
if entry.kinds then
for _, kd in ipairs(L.KINDS) do
if entry.kinds:find(kd[1], 1, true) then tag(kd[2], kd[3], true) end
end
end
if name == ADD_PAGE then tag("\u{2665} " .. ((L.favCount or {})[entry.name] or 0)) end
do
local h = L.health[L.hkey(entry.code)]
if h then if h.ok then tag("Ran OK") else tag("Failed", RED, true) end end
end
if L.hasNote(entry) then tag("Note") end
if entry.an then tag("Pinned") end
do
local fm = L.favMetaOf and L.isFav(entry) and L.favMetaOf(entry)
if fm then
if fm.folder then tag(fm.folder, L.P.info, true) end
if fm.tags then for _, tg in ipairs(fm.tags) do tag("#" .. tg) end end
end
end
end
local runBtn = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -10, 0.5, 0), Size = UO(54, 28),
BackgroundColor3 = L.P.btn, BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "Run", TextColor3 = WHITE, ZIndex = 23,
}, body)
round(runBtn, 7)
if L.atlasURL then
runBtn.TextXAlignment = Enum.TextXAlignment.Right
new("UIPadding", {PaddingRight = UDim.new(0, 10)}, runBtn)
new("ImageLabel", {Position = UO(8, 7), Size = UO(14, 14), BackgroundTransparency = 1, Image = L.atlasURL, ImageRectOffset = Vector2.new(128, 32), ImageRectSize = Vector2.new(32, 32), ZIndex = 24}, runBtn)
end
L.press(runBtn, 0.93)
local viewBtn = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -70, 0.5, 0), Size = UO(50, 28),
BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "View", TextColor3 = WHITE, ZIndex = 23,
}, body)
round(viewBtn, 7)
L.press(viewBtn, 0.93)
if L.atlasURL then
viewBtn.TextXAlignment = Enum.TextXAlignment.Right
new("UIPadding", {PaddingRight = UDim.new(0, 8)}, viewBtn)
L.icon(viewBtn, 15, 14, {Position = UO(7, 7)})
end
local heart = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -126, 0.5, 0), Size = UO(26, 26), BackgroundTransparency = 1,
BorderSizePixel = 0, AutoButtonColor = false, Text = "\u{2665}", TextColor3 = L.isFav(entry) and L.HEART_ON or L.HEART_OFF, TextSize = 18, ZIndex = 24,
}, body)
L.paintHeart(heart, L.isFav(entry))
L.press(heart, 0.85)
heart.MouseButton1Click:Connect(function() L.toggleFav(entry) end)
local function go()
if entry.comm then
askConfirm('Run "' .. entry.name:sub(1, 40) .. '" shared by ' .. tostring(entry.by):sub(1, 20) .. "? Scripts from players are not checked. Only run ones you trust.", function() runScript(entry) end, "Run")
else
runScript(entry)
end
end
runBtn.MouseButton1Click:Connect(go)
viewBtn.MouseButton1Click:Connect(function() openViewer(entry) end)
tile.MouseEnter:Connect(function()
tween(body, FAST, {BackgroundColor3 = TILE_HOT})
tween(tStroke, FAST, {Transparency = isDup and 0 or 0.1, Color = isDup and L.DUPRED or themeStroke})
tween(bar, FAST, {Size = UO(3, 30)})
end)
tile.MouseLeave:Connect(function()
tween(body, FAST, {BackgroundColor3 = TILE})
tween(tStroke, FAST, {Transparency = isDup and 0 or 0.35, Color = isDup and L.DUPRED or L.P.line})
tween(bar, FAST, {Size = UO(3, 0)})
end)
tile.MouseButton1Click:Connect(function()
go()
tween(body, TweenInfo.new(0.1), {BackgroundColor3 = L.P.ctrl})
task.delay(0.14, function()
if body.Parent then tween(body, FAST, {BackgroundColor3 = TILE}) end
end)
end)
if canEdit then
if not entry.pending then
local edB = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -156, 0.5, 0), Size = UO(32, 22),
BackgroundColor3 = L.P.ctrl, BackgroundTransparency = 0, BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 11, Text = "Edit",
TextColor3 = WHITE, ZIndex = 25,
}, body)
round(edB, 5)
edB.MouseButton1Click:Connect(function() L.startEdit(entry, (name == L.ALL and L.secOf(entry)) or name, isShared) end)
end
local del = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, entry.pending and -156 or -194, 0.5, 0), Size = UO(22, 22),
BackgroundColor3 = RED, BackgroundTransparency = 0.3, BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 11, Text = "X",
TextColor3 = WHITE, ZIndex = 25,
}, body)
round(del, 5)
del.MouseButton1Click:Connect(function()
askConfirm('Are you sure you want to remove "' .. entry.name .. '" from the list?', function()
if name == L.ALL then
if isAdmin and not adminOk() then return end
local k, any = L.ckey(entry.code), false
for _, sec in ipairs(SECTIONS) do
local list = entriesOf[sec.name]
for i = #list, 1, -1 do
local x = list[i]
if x == entry or (x.name == entry.name and L.ckey(x.code) == k) then
if L.boardMarkDel then L.boardMarkDel(sec.name, x) end
table.remove(list, i)
any = true
end
end
end
if any then
syncAdmin()
for _, sec in ipairs(SECTIONS) do renderPage(sec.name) end
renderPage(L.ALL)
end
return
end
if entry.comm then
if entry.uid ~= tostring(LP.UserId) and isAdmin and not adminOk() then return end
return L.commDelete(entry)
end
local sharedList = isShared or name ~= ADD_PAGE
if sharedList and isAdmin and not adminOk() then return end
local list = isShared and adminPages[ADD_PAGE] or entriesOf[name]
local at = table.find(list, entry)
if at then
if L.boardMarkDel then L.boardMarkDel(name, entry) end
table.remove(list, at)
if sharedList then syncAdmin() else persist(name) end
renderPage(name)
end
end)
end)
end
if animate and i <= 12 then
body.Position = UO(-36, 1)
TweenService:Create(body, TweenInfo.new(0.34, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, (i - 1) * 0.03), {Position = UO(1, 1)}):Play()
end
tile.Parent = ui.grid
end
end
-- who may merge: your own shared scripts, or (owner only) Dua's sections
function L.canMerge(name)
if name == ADD_PAGE then return true end
if name == L.ALL or L.isSection[name] then return L.owner() end
return false
end
-- keeps ONE script per code, named after the longest name; returns how many copies were removed / renamed
function L.mergeDups(name, apply)
if not L.canMerge(name) then return 0, 0 end
if apply == nil then
local rm, rn = L.mergeDups(name, false)
if rm + rn == 0 then return notify("Duplicates", "No duplicated scripts here", nil, 3) end
return askConfirm("Merge duplicated scripts? " .. rm .. " copy(s) will be removed and kept under the longest name.", function() L.mergeDups(name, true) end, "Merge")
end
local sharedOk = isAdmin and adminOk() or false
if apply and (name ~= ADD_PAGE) and not sharedOk then return 0, 0 end
local lists = {}
if name == ADD_PAGE then
lists[1] = {list = userScripts, shared = false}
if sharedOk then lists[2] = {list = adminPages[ADD_PAGE], shared = true, page = ADD_PAGE} end
elseif name == L.ALL then
for _, sec in ipairs(SECTIONS) do lists[#lists + 1] = {list = adminPages[sec.name], shared = true, page = sec.name} end
else
lists[1] = {list = entriesOf[name], shared = true, page = name}
end
local best = {}
for _, l in ipairs(lists) do
for _, e in ipairs(l.list) do
local k = L.ckey(e.code)
if k ~= "" and (not best[k] or #e.name > #best[k]) then best[k] = e.name end
end
end
local removed, renamed, anyShared, anyUser = 0, 0, false, false
for _, l in ipairs(lists) do
local keep, drop = {}, {}
for _, e in ipairs(l.list) do
local k = L.ckey(e.code)
if k ~= "" then
local cur = keep[k]
if not cur then keep[k] = e
elseif e.name == best[k] and cur.name ~= best[k] then drop[cur] = true; keep[k] = e
else drop[e] = true end
end
end
for i = #l.list, 1, -1 do
local e = l.list[i]
if drop[e] then
removed = removed + 1
if apply then
if l.page and L.boardMarkDel then L.boardMarkDel(l.page, e) end
table.remove(l.list, i)
end
end
end
for k, e in pairs(keep) do
if e.name ~= best[k] then
renamed = renamed + 1
if apply then e.name = best[k] end
end
end
if apply and (removed > 0 or renamed > 0) then
if l.shared then anyShared = true else anyUser = true end
end
end
if apply then
if anyShared then syncAdmin() end
if anyUser then persist(ADD_PAGE) end
for _, ui in pairs(pageUI) do renderPage(ui.current) end
notify("Duplicates merged", removed .. " removed, kept the longest names", nil, 3)
end
return removed, renamed
end
function L.renderDirty(name)
local u = pageUI[name]
if u and u.dirty then renderPage(u.current) end
end
local modalPage
local function openAddMenu(name)
if not (name == ADD_PAGE or L.isSection[name]) then return end
modalPage = name
L.editing = nil
modalAdd.Text = "Add script"
modalTitle.Text = (name == ADD_PAGE) and "Add your script" or ("Add script to " .. name)
nameBox.Text, codeBox.Text, descBox.Text = "", "", ""
L.m.reset()
L.m.secShow(name)
modal.Visible = true
end
local function codeKey(c) return (tostring(c or ""):gsub("%s+", "")) end
local function mineEntry(x) return L.owner() or (verName and type(x.by) == "string" and x.by:lower() == verName:lower()) or false end
function L.secOf(entry)
for _, sec in ipairs(SECTIONS) do
for _, x in ipairs(entriesOf[sec.name]) do if x == entry then return sec.name end end
end
local k = codeKey(entry.code)
for _, sec in ipairs(SECTIONS) do
for _, x in ipairs(entriesOf[sec.name]) do if codeKey(x.code) == k then return sec.name end end
end
return SECTIONS[1].name
end
-- save to the picked sections. Same script code (or loadstring) already there = only the name is replaced, in every section it is in
function L.saveSections(entry, e0)
local secs, key = L.m.secs, codeKey(entry.code)
local oldKey = e0 and codeKey(e0.code)
local changed, added, renamed, dups = {}, 0, 0, {}
local function copy() return {name = entry.name, code = entry.code, desc = entry.desc, by = entry.by, game = entry.game, gid = entry.gid, kinds = entry.kinds, t = entry.t} end
for _, sec in ipairs(SECTIONS) do
local list = entriesOf[sec.name]
if e0 then
local at
for i, x in ipairs(list) do if x == e0 or codeKey(x.code) == oldKey then at = i break end end
if secs[sec.name] then
if at then
local x = list[at]
if mineEntry(x) then
local old = {name = x.name, code = x.code}
x.name, x.code, x.desc, x.game, x.gid, x.kinds = entry.name, entry.code, entry.desc, entry.game, entry.gid, entry.kinds
L.favRetarget(old, x)
changed[sec.name] = true
end
else
table.insert(list, copy()); added = added + 1; changed[sec.name] = true
end
elseif at and mineEntry(list[at]) then
if L.boardMarkDel then L.boardMarkDel(sec.name, list[at]) end
table.remove(list, at)
changed[sec.name] = true
end
else
local found
for _, x in ipairs(list) do
if codeKey(x.code) == key then
found = true
dups[#dups + 1] = sec.name
end
end
if secs[sec.name] and not found then
table.insert(list, copy()); added = added + 1; changed[sec.name] = true
end
end
end
if added > 0 and isAdmin then
local fl, dup = adminPages[L.FAVD], false
for _, x in ipairs(fl) do if x.name == entry.name and x.code == entry.code then dup = true end end
if not dup then table.insert(fl, {name = entry.name, code = entry.code, by = entry.by, desc = entry.desc, game = entry.game, gid = entry.gid, kinds = entry.kinds, t = entry.t}) end
end
syncAdmin()
for name in pairs(changed) do renderPage(name) end
renderPage(L.ALL)
renderPage(L.FAVD)
if L.refreshUpdates then L.refreshUpdates() end
if L.updDot then L.updDot() end
local msg = (added > 0 and ("Added to " .. added .. (added == 1 and " section" or " sections")) or "")
if renamed > 0 then msg = msg .. (msg ~= "" and ", " or "") .. "renamed " .. renamed end
if #dups > 0 and not e0 then
notify("Already in the list", "A script with the same code or loadstring is already in " .. table.concat(dups, ", ") .. (added > 0 and ("  (added to " .. added .. " other)") or ""), nil, 5)
if added == 0 then return end
end
notify(e0 and "Saved" or "Done", entry.name .. (msg ~= "" and ("  (" .. msg .. ")") or ""), nil, 3)
end
-- edit a script you shared (same window as adding, filled in)
function L.startEdit(entry, name, isShared)
if entry.comm and entry.uid ~= tostring(LP.UserId) and isAdmin and not adminOk() then return end
if isAdmin and not entry.comm and (isShared or name ~= ADD_PAGE) and not adminOk() then return end
modalPage = name
L.editing = {entry = entry, page = name, shared = isShared}
modalAdd.Text = "Save changes"
modalTitle.Text = "Edit script"
nameBox.Text, descBox.Text = entry.name or "", entry.desc or ""
L.m.clearBig()
if #(entry.code or "") > 60000 then L.m.setBig(entry.code) else codeBox.Text = entry.code or "" end
L.m.load(entry)
local picked
if L.isSection[name] then
picked = {}
for _, sec in ipairs(SECTIONS) do
for _, x in ipairs(entriesOf[sec.name]) do
if x == entry or codeKey(x.code) == codeKey(entry.code) then picked[sec.name] = true break end
end
end
picked[name] = true
end
L.m.secShow(name, picked)
modal.Visible = true
end
-- keep favorites pointing at a script after it was edited
function L.favRetarget(old, new)
local changed = false
local function go(list, full)
for _, x in ipairs(list) do
if x.name == old.name and x.code == old.code then
x.name, x.code = new.name, new.code
if full then x.desc, x.game, x.gid, x.kinds = new.desc, new.game, new.gid, new.kinds end
changed = true
end
end
end
go(L.favs, false)
go(adminPages[L.FAVD], true)
if changed then
if isAdmin then syncAdmin() else writeJson(FILE.FAVS, {list = L.favs}); task.delay(3, L.syncFavs) end
end
end
local function flashRed(st)
st.Color, st.Transparency = Color3.fromRGB(255, 90, 100), 0
task.delay(0.6, function() st.Color, st.Transparency = L.P.line, 0 end)
end
modalCancel.MouseButton1Click:Connect(function() modal.Visible = false end)
modalAdd.MouseButton1Click:Connect(function()
local nm = nameBox.Text:match("^%s*(.-)%s*$"):sub(1, 40)
local code = L.m.big or codeBox.Text
if nm == "" then return flashRed(nameStroke) end
if code:match("^%s*$") then return flashRed(codeStroke) end
local desc = descBox.Text:gsub("%c", " "):match("^%s*(.-)%s*$"):sub(1, 300)
local chatL = L.chat
if chatL and chatL.isHate and (chatL.isHate(desc) or chatL.isHate(nm)) then
notify("Blocked", "Racist or hateful language isn't allowed", nil, 4)
return flashRed(nameStroke)
end
local gname = L.m.gameBox.Text:gsub("%c", " "):match("^%s*(.-)%s*$"):sub(1, 40)
local kinds, gid = L.m.kindStr(), L.m.gid
if gname:match("^%d+$") then gid = gid or gname; gname = "Game ID " .. gname end
if gname == "" and not kinds:find("U", 1, true) then
notify("Pick a game", "Choose the game this script is for, or tick Universal", nil, 4)
return flashRed(L.m.gameStroke)
end
if gname ~= "" and chatL and chatL.isHate and chatL.isHate(gname) then
notify("Blocked", "Racist or hateful language isn't allowed", nil, 4)
return flashRed(L.m.gameStroke)
end
if os.clock() - (L.addAt or -9) < 1.5 then return end
L.addAt = os.clock()
local fixed, was = L.undouble(code)
if was then code = fixed; notify("Paste fixed", "The script was pasted twice, kept one copy", nil, 3) end
local entry = {name = nm, code = normalizeCode(code), desc = desc ~= "" and desc or nil, by = (modalPage == ADD_PAGE) and (verName or LP.Name) or nil,
game = gname ~= "" and gname or nil, gid = gid and tostring(gid):sub(1, 15) or nil, kinds = kinds ~= "" and kinds or nil, t = os.time()}
if modalPage ~= ADD_PAGE and isAdmin and not L.owner() then entry.by = verName or LP.Name end
local ed = L.editing
if ed then
local e0 = ed.entry
if e0.comm then
if e0.uid ~= tostring(LP.UserId) and isAdmin and not adminOk() then return end
L.editing = nil
modal.Visible = false
L.commEdit(e0, entry)
return
end
if isAdmin and (ed.shared or ed.page ~= ADD_PAGE) and not adminOk() then return end
if L.isSection[ed.page] then
if next(L.m.secs) == nil then return notify("Pick a section", "Tap at least one section to put it in", nil, 3) end
L.editing = nil
modal.Visible = false
L.saveSections(entry, e0)
return
end
L.editing = nil
local old = {name = e0.name, code = e0.code}
e0.name, e0.code, e0.desc, e0.game, e0.gid, e0.kinds = entry.name, entry.code, entry.desc, entry.game, entry.gid, entry.kinds
L.favRetarget(old, e0)
if ed.shared or ed.page ~= ADD_PAGE then syncAdmin() else persist(ADD_PAGE) end
renderPage(ed.page)
renderPage(L.FAVD)
modal.Visible = false
notify("Saved", e0.name, nil, 2)
return
end
if L.isSection[modalPage] then
if next(L.m.secs) == nil then return notify("Pick a section", "Tap at least one section to put it in", nil, 3) end
if isAdmin and not adminOk() then return end
modal.Visible = false
L.saveSections(entry, nil)
return
end
do
local k = L.ckey(entry.code)
local function has(list)
for _, x in ipairs(list or {}) do if L.ckey(x.code) == k then return true end end
return false
end
if has(adminPages[ADD_PAGE]) or has(L.comm) or has(userScripts) or (function() for _, e in ipairs(L.pending) do if L.ckey(e.c) == k then return true end end end)() then
modal.Visible = false
return notify("Already shared", "There is already a script with the same code or loadstring", nil, 5)
end
end
local toShared = modalPage ~= ADD_PAGE or S.shareAdd
if modalPage == ADD_PAGE and S.shareAdd and not isAdmin and L.commPush(nm, entry.code, entry.desc, entry.game, entry.gid, entry.kinds) then
modal.Visible = false
return
end
if toShared then
if isAdmin and not adminOk() then return end
table.insert(modalPage == ADD_PAGE and adminPages[ADD_PAGE] or entriesOf[modalPage], entry)
if isAdmin then
local fl, dup = adminPages[L.FAVD], false
for _, x in ipairs(fl) do if x.name == entry.name and x.code == entry.code then dup = true end end
if not dup then table.insert(fl, {name = entry.name, code = entry.code, by = entry.by, desc = entry.desc, game = entry.game, gid = entry.gid, kinds = entry.kinds, t = entry.t}) end
end
syncAdmin()
renderPage(L.FAVD)
if selfFile then
notify("Saved in script", selfFile)
else
notify("Saved on this device", "Only you can see it", nil, 3)
end
else
table.insert(userScripts, entry)
persist(ADD_PAGE)
end
renderPage(modalPage)
modal.Visible = false
if not canSave then notify("Not saved", "Your executor can't save files, so it won't be here next run", nil, 3) end
end)
for i, item in ipairs(ITEMS) do
local name = item.name
local row = new("TextButton", {
Name = name, LayoutOrder = i, Size = U2(1, -10, 0, 32), BackgroundTransparency = 1,
BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 9,
})
round(row, 6)
row.Parent = list
rows[name] = row
bars[name] = new("Frame", {
AnchorPoint = V2(0, 0.5), Position = U2(0, 1, 0.5, 0), Size = UO(3, 16), BackgroundColor3 = WHITE,
BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 11,
}, row)
round(bars[name], 2)
if item.image then
new("ImageLabel", {
AnchorPoint = V2(0.5, 0.5), Position = U2(0, 17, 0.5, 0), Size = UO(16, 16),
BackgroundTransparency = 1, Image = item.image, ZIndex = 10,
}, row)
else
local letter = text(row, {
AnchorPoint = V2(0.5, 0.5), Position = U2(0, 17, 0.5, 0), Size = UO(24, 24),
Text = (L.LET[name] or name:sub(1, 1)), TextSize = 15, TextColor3 = WHITE, ZIndex = 10,
})
local idx = L.NAVICON[name]
if idx and L.atlasURL then
letter.Visible = false
L.navIcons[name] = new("ImageLabel", {
AnchorPoint = V2(0.5, 0.5), Position = U2(0, 17, 0.5, 0), Size = UO(20, 20), BackgroundTransparency = 1,
Image = L.atlasURL, ImageRectOffset = Vector2.new((idx % 6) * 32, math.floor(idx / 6) * 32), ImageRectSize = Vector2.new(32, 32),
ImageTransparency = 0.35, ZIndex = 10,
}, row)
end
end
local lbl = text(row, {
Position = UO(38, 0), Size = U2(1, -40, 1, 0), Text = (name == ADD_PAGE) and "Share & find" or name, TextSize = 12,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1, ZIndex = 10,
})
fit(lbl, 12, 8)
labels[#labels + 1] = lbl
row.MouseMoved:Connect(bump)
row.MouseEnter:Connect(function()
bump()
if selected ~= name then tween(row, TweenInfo.new(0.12), {BackgroundTransparency = 0.9}) end
end)
row.MouseLeave:Connect(function()
if selected ~= name then tween(row, TweenInfo.new(0.12), {BackgroundTransparency = 1}) end
end)
row.MouseButton1Click:Connect(function()
if L.moved then L.moved = false return end
if not opened then setOpen(true) end
selectItem(name)
bump()
end)
local page = new("Frame", {Name = name, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false}, content)
pages[name] = page
local pt = text(page, {
Position = UO(12, 3), Size = U2(1, -24, 0, 22), Text = (name == ADD_PAGE) and "Share script & Find script" or name, TextSize = 15,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
})
fit(pt, 15, 9)
local count = text(page, {
Position = UO(12, 25), Size = U2(1, -24, 0, 14), Font = Enum.Font.Nunito, Text = "",
TextSize = 10, TextTransparency = 0.4, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 21,
})
new("Frame", {
Position = UO(10, 42), Size = U2(1, -20, 0, 1), BackgroundColor3 = L.P.line,
BackgroundTransparency = 0.2, BorderSizePixel = 0, ZIndex = 21,
}, page)
if item.custom then count.Text = item.sub or "" end
if not item.custom then
if name == ADD_PAGE then
pt.Size = U2(1, -190, 0, 22)
count.Size = U2(1, -214, 0, 14)
local lab = text(page, {
AnchorPoint = V2(1, 0), Position = U2(1, -58, 0, 4), Size = UO(122, 30), Text = "Share globally",
TextSize = 12, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 21,
})
fit(lab, 12, 8)
makeSwitch(page, V2(1, 0), U2(1, -10, 0, 8), "shareAdd", nop, isAdmin and adminOk or nil)
end
local tabs = L.tabs[name]
local top = tabs and 76 or (name == ADD_PAGE and 78 or 46)
local grid = new("ScrollingFrame", {
Position = UO(0, top), Size = U2(1, 0, 1, -top), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 3, ScrollBarImageColor3 = WHITE,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 20,
}, page)
L.grids[#L.grids + 1] = new("UIGridLayout", {
CellSize = U2(1, -20, 0, 60), CellPadding = UO(8, 6),
SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Left,
}, grid)
L.cellH[L.grids[#L.grids]] = 60
L.listGrids[L.grids[#L.grids]] = true
new("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8)}, grid)
local plusTile
if name == ADD_PAGE or (name == L.DUA and isAdmin) then
local plus = new("TextButton", {
Name = "PlusTile", LayoutOrder = 0, BackgroundColor3 = L.P.ctrl, BackgroundTransparency = 0,
BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 21,
}, grid)
round(plus, 12)
local pStroke = outline(plus, 1, 0.3)
local pScale = new("UIScale", {}, plus)
text(plus, {Size = U2(1, 0, 1, 0), Text = "+   New script", TextSize = 14, TextColor3 = themeStroke, ZIndex = 22})
plus.BackgroundColor3, plus.BackgroundTransparency = L.cur().plus, L.cur().plusT
L.plus[#L.plus + 1] = plus
plusTile = plus
plus.MouseEnter:Connect(function()
tween(pScale, FAST, {Scale = 1}); tween(plus, FAST, {BackgroundColor3 = L.cur().plusHot}); tween(pStroke, FAST, {Transparency = 0})
end)
plus.MouseLeave:Connect(function()
tween(pScale, FAST, {Scale = 1}); tween(plus, FAST, {BackgroundColor3 = L.cur().plus}); tween(pStroke, FAST, {Transparency = 0.3})
end)
plus.MouseButton1Click:Connect(function() openAddMenu(pageUI[name].current) end)
end
local hint = text(page, {
Position = UO(0, 46), Size = U2(1, 0, 1, -46), Font = Enum.Font.Nunito, TextSize = 13,
Text = "No scripts here yet.", TextTransparency = 0.4, Visible = false, ZIndex = 21,
})
hint.Position, hint.Size = UO(0, top), U2(1, 0, 1, -top)
pageUI[name] = {grid = grid, hint = hint, count = count, current = name, plus = plusTile}
if name == L.FAVP then
local fb = button(page, 0, 0, 170, 24, "All favorites", L.P.ctrl, 0, 22)
fb.AnchorPoint, fb.Position, fb.TextSize = V2(1, 0), U2(1, -10, 0, 3), 11
fit(fb, 11, 7)
pt.Size = U2(0.4, 0, 0, 22)
pageUI[name].favBtn = fb
fb.MouseButton1Click:Connect(function()
local opts = L.favOptions()
local at = table.find(opts, S.favFolder or "") or 1
S.favFolder = opts[at % #opts + 1]
scheduleSave()
L.favBtnText()
renderPage(pageUI[name].current)
end)
end
if name == L.DUA or name == ADD_PAGE then
local box = inputBox(page, 0, 0, 10, 26, "Search...", false, 22)
if name == L.DUA then
box.AnchorPoint, box.Position, box.Size = V2(1, 0), U2(1, -184, 0, 3), U2(0.34, 0, 0, 24)
new("UISizeConstraint", {MinSize = Vector2.new(60, 24), MaxSize = Vector2.new(180, 24)}, box)
pt.Size = U2(0.3, 0, 0, 22)
count.Position, count.Size = UO(12, 27), U2(1, -24, 0, 13)
local rq = button(page, 0, 0, 68, 24, "Request", L.P.btn, 0, 22)
rq.AnchorPoint, rq.Position, rq.TextSize = V2(1, 0), U2(1, -10, 0, 3), 12
local dsort = button(page, 0, 0, 92, 24, "", L.P.ctrl, 0, 22)
dsort.AnchorPoint, dsort.Position, dsort.TextSize = V2(1, 0), U2(1, -84, 0, 3), 11
fit(dsort, 11, 7)
local DS_NAMES = {def = "Sort: Default", az = "Sort: A-Z", za = "Sort: Z-A", new = "Sort: Newest", fav = "Sort: Most loved", kind = "Sort: Type"}
local DS_ORDER = {"def", "az", "za", "new", "fav", "kind"}
if not DS_NAMES[S.duaSort] then S.duaSort = "def" end
dsort.Text = DS_NAMES[S.duaSort]
dsort.MouseButton1Click:Connect(function()
local at = table.find(DS_ORDER, S.duaSort) or 1
S.duaSort = DS_ORDER[at % #DS_ORDER + 1]
dsort.Text = DS_NAMES[S.duaSort]
scheduleSave()
renderPage(pageUI[name].current)
end)
fit(rq, 12, 8)
rq.MouseButton1Click:Connect(function() L.openCompose() end)
else
box.Position, box.Size = UO(10, 46), U2(0.52, -18, 0, 26)
local sortB = button(page, 0, 0, 104, 26, "", L.P.ctrl, 0, 22)
sortB.AnchorPoint, sortB.Position, sortB.TextSize = V2(1, 0), U2(0.8, -14, 0, 46), 11
sortB.Size = U2(0.28, 0, 0, 26)
new("UISizeConstraint", {MinSize = Vector2.new(60, 26), MaxSize = Vector2.new(104, 26)}, sortB)
fit(sortB, 11, 7)
local SORT_NAMES = {new = "Sort: Newest", fav = "Sort: Most ", old = "Sort: Oldest", az = "Sort: A-Z"}
local SORT_ORDER = {"new", "fav", "old", "az"}
if not SORT_NAMES[S.shareSort] then S.shareSort = "new" end
sortB.Text = SORT_NAMES[S.shareSort]
sortB.MouseButton1Click:Connect(function()
local at = table.find(SORT_ORDER, S.shareSort) or 0
S.shareSort = SORT_ORDER[at % #SORT_ORDER + 1]
sortB.Text = SORT_NAMES[S.shareSort]
scheduleSave()
renderPage(pageUI[name].current)
end)
L.rf = button(page, 0, 0, 80, 26, "Refresh", L.P.ctrl, 0, 22)
L.rf.AnchorPoint, L.rf.Position, L.rf.TextSize = V2(1, 0), U2(1, -10, 0, 46), 11
L.rf.Size = U2(0.2, 0, 0, 26)
new("UISizeConstraint", {MinSize = Vector2.new(46, 26), MaxSize = Vector2.new(80, 26)}, L.rf)
fit(L.rf, 11, 7)
L.rf.MouseButton1Click:Connect(function()
L.commBusy = false
if L.commPull then L.commPull(true) end
end)
end
box:GetPropertyChangedSignal("Text"):Connect(function()
pageUI[name].query = box.Text
renderPage(pageUI[name].current)
end)
end
if tabs then
pageUI[name].current = tabs[1].name
local row = new("Frame", {Position = UO(10, 46), Size = U2(1, -20, 0, 24), BackgroundTransparency = 1, ZIndex = 21}, page)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, row)
local tbtn = {}
local ind = new("Frame", {AnchorPoint = V2(0, 1), Position = UO(0, 70), Size = UO(0, 2), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 24}, page)
L.fills[ind] = "hi"
local function recolor()
local first = ind.Size.X.Offset == 0
for k, b in ipairs(tbtn) do
local on = tabs[k].name == pageUI[name].current
tween(b, FAST, {BackgroundColor3 = themeBtn, BackgroundTransparency = on and 0.8 or 1, TextColor3 = on and WHITE or L.P.muted})
if on then
task.defer(function()
if not b.Parent or b.AbsoluteSize.X <= 0 then return end
local goal = {Position = UO(b.AbsolutePosition.X - page.AbsolutePosition.X, 70), Size = UO(b.AbsoluteSize.X, 2)}
if first then ind.Position, ind.Size = goal.Position, goal.Size
else tween(ind, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), goal) end
end)
end
end
end
row:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() recolor() end)
for k, sec in ipairs(tabs) do
local b = new("TextButton", {
LayoutOrder = k, Size = U2(1 / #tabs, -4 * (#tabs - 1) / #tabs, 1, 0), BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = (sec.label or sec.name), TextColor3 = WHITE, ZIndex = 22,
}, row)
round(b, 6)
fit(b, 12, 7)
tbtn[k] = b
b.MouseButton1Click:Connect(function()
pageUI[name].current = sec.name
recolor()
renderPage(sec.name)
end)
end
refreshers[#refreshers + 1] = recolor
recolor()
end
renderPage(pageUI[name].current)
end
end
local function refreshOnline(quiet)
if isAdmin or feedUrl == "" then return end
task.spawn(function()
local fp = fetchFeed(feedUrl)
if not fp then
if not quiet then notify("Online scripts", "Couldn't reach the list", nil, 2) end
return
end
L.saveIfChanged(FILE.FEED, {pages = L.packPages(fp)})
fp = migrate(fp)
local bp = L.boardFetch()
if bp then L.boardMergeInto(fp, bp) end
for name, list in pairs(adminPages) do
if name == ADD_PAGE then
for _, e in ipairs(fp[name] or {}) do
local have
for _, x in ipairs(list) do if x.name == e.name and x.code == e.code then have = x end end
if have then
have.an, have.anb, have.game, have.gid, have.kinds, have.t = e.an, e.anb, e.game, e.gid, e.kinds, e.t or have.t
else
table.insert(list, e)
end
end
else
while #list > 0 do table.remove(list) end
for _, e in ipairs(fp[name] or {}) do table.insert(list, e) end
end
end
for _, ui in pairs(pageUI) do renderPage(ui.current) end
online.show()
L.checkMsgs()
L.syncFavs()
L.commPull()
if not quiet then notify("Online scripts", "Updated", nil, 2) end
end)
end
local function onSettingsClick()
if L.moved then L.moved = false return end
if not opened then
setOpen(true)
selectItem("Settings")
elseif selected == "Settings" then
setOpen(false)
else
selectItem("Settings")
end
bump()
end
hamBtn.MouseButton1Click:Connect(onSettingsClick)
settingsBtn.MouseButton1Click:Connect(onSettingsClick)
hamBtn.MouseMoved:Connect(bump)
settingsBtn.MouseMoved:Connect(bump)
sidebar.MouseMoved:Connect(bump)
sidebar.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then bump() end
end)
list:GetPropertyChangedSignal("CanvasPosition"):Connect(bump)
local function themeColors(h, s, v)
v = v or 1
local function c(sat, val, vs) return Color3.fromHSV(h, math.clamp(sat * s, 0, 1), math.clamp(vs and val * v or val, 0, 1)) end
return {
winBase = c(0.55, 0.10),
bg = ColorSequence.new({ColorSequenceKeypoint.new(0, c(0.60, 0.13)), ColorSequenceKeypoint.new(1, c(0.60, 0.08))}),
stroke = c(0.42, 0.95, true),
barBase = c(0.45, 0.07),
bar = ColorSequence.new({ColorSequenceKeypoint.new(0, c(0.45, 0.085)), ColorSequenceKeypoint.new(1, c(0.45, 0.07))}),
barMask = c(0.45, 0.07),
accent = ColorSequence.new({
ColorSequenceKeypoint.new(0, c(0.65, 0.90)), ColorSequenceKeypoint.new(0.5, c(0.45, 1)),
ColorSequenceKeypoint.new(1, c(0.65, 0.90)),
}),
sb = c(0.45, 0.07),
card = c(0.40, 0.13),
hi = c(0.45, 1, true),
btn = c(0.55, 0.72, true),
pal = {WHITE, c(0.12, 1), c(0.29, 1), c(0.06, 1)},
}
end
L.THEMES = {
{name = "Violet", h = 0.75, s = 1}, {name = "Blue", h = 0.60, s = 1}, {name = "Cyan", h = 0.50, s = 1},
{name = "Green", h = 0.38, s = 1}, {name = "Gold", h = 0.12, s = 0.9}, {name = "Orange", h = 0.07, s = 1},
{name = "Red", h = 0.0, s = 1}, {name = "Pink", h = 0.90, s = 1},
{name = "Black", h = 0, s = 0, v = 0.38, edge = {Color3.fromRGB(0, 0, 0), Color3.fromRGB(48, 48, 56), Color3.fromRGB(170, 170, 185), Color3.fromRGB(12, 12, 16)}},
{name = "White", h = 0, s = 0, v = 0.7, edge = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 150, 160), Color3.fromRGB(235, 240, 255), Color3.fromRGB(110, 110, 120)}},
{name = "Silver", h = 0, s = 0, v = 0.55, edge = {Color3.fromRGB(70, 72, 80), Color3.fromRGB(200, 204, 214), Color3.fromRGB(120, 124, 134), Color3.fromRGB(235, 238, 245)}},
{name = "Rainbow", h = 0.75, s = 1, edge = {Color3.fromHSV(0, 0.8, 1), Color3.fromHSV(0.17, 0.8, 1), Color3.fromHSV(0.33, 0.8, 1), Color3.fromHSV(0.5, 0.8, 1), Color3.fromHSV(0.67, 0.8, 1), Color3.fromHSV(0.83, 0.8, 1)}},
}
function L.edgeFor(p, h, s, v)
if p and p.edge then return p.edge end
h, s, v = h or p.h, s or p.s, v or p.v or 1
local function hc(hh, sat, val) return Color3.fromHSV(hh % 1, math.clamp(sat * s, 0, 1), math.clamp(val * v, 0, 1)) end
return {hc(h, 0.95, 0.35), hc(h, 0.85, 1), hc(h + 0.08, 0.55, 1), hc(h - 0.07, 0.9, 0.75)}
end
function L.edgeSeq(cols)
local n, kp = #cols, {}
for i = 0, n do kp[#kp + 1] = ColorSequenceKeypoint.new(i / n, cols[(i % n) + 1]) end
return ColorSequence.new(kp)
end
function L.applyEdge()
local cur
for _, t in ipairs(L.THEMES) do if t.name == S.themeName then cur = t end end
local cols = (cur and cur.edge) or L.edgeFor({}, S.hue, S.sat, S.val)
local seq = L.edgeSeq(cols)
L.edgeGrad.Color = seq
L.winStroke.Thickness = S.edgeW
local line = math.clamp(math.floor(S.edgeW / 2 + 0.5), 2, 4)
accent.Size = U2(1, 0, 0, line)
accentGrad.Color = seq
sbEdge.Size = U2(0, math.max(1, math.floor(S.edgeW / 2)), 1, 0)
sbEdge.BackgroundTransparency = 0.25
sbDivider.Size = U2(1, 0, 0, math.max(1, math.floor(S.edgeW / 2)))
sbDivider.BackgroundTransparency = 0.25
if L.edgeTw then L.edgeTw:Cancel(); L.edgeTw = nil end
if L.accTw then L.accTw:Cancel(); L.accTw = nil end
L.edgeGrad.Rotation = 45
accentGrad.Offset = Vector2.new(0, 0)
if S.edgeAnim then
L.edgeTw = TweenService:Create(L.edgeGrad, TweenInfo.new(S.edgeSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Rotation = 405})
accentGrad.Offset = Vector2.new(-1, 0)
L.accTw = TweenService:Create(accentGrad, TweenInfo.new(math.max(2, S.edgeSpeed / 2.5), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1, 0)})
if sg.Enabled then L.edgeTw:Play(); L.accTw:Play() end
end
if not L.edgeConn then
L.edgeConn = sg:GetPropertyChangedSignal("Enabled"):Connect(function()
for _, t in ipairs({L.edgeTw, L.accTw}) do
if t then if sg.Enabled then t:Play() else t:Pause() end end
end
end)
end
end
local function applyTheme()
local th = themeColors(S.hue, S.sat, S.val)
accentColor, themeStroke, themeBtn = th.hi, th.stroke, th.btn
win.BackgroundColor3, bgGrad.Color = th.winBase, th.bg
bar.BackgroundColor3, barGrad.Color, mask.BackgroundColor3 = th.barBase, th.bar, th.barMask
accentGrad.Color = th.accent
sidebar.BackgroundColor3, sbMask.BackgroundColor3 = th.sb, th.sb
sbEdge.BackgroundColor3, sbDivider.BackgroundColor3 = th.stroke, th.stroke
headHL.BackgroundColor3 = th.btn
modalCard.BackgroundColor3, confirmCard.BackgroundColor3 = th.card, th.card
viewCard.BackgroundColor3 = th.card
for _, c in ipairs(L.cards) do c.BackgroundColor3 = th.card end
for _, row in pairs(rows) do row.BackgroundColor3 = th.btn end
for _, b in pairs(bars) do b.BackgroundColor3 = th.hi end
for st in pairs(themed) do
if st.Parent then st.Color = th.stroke else themed[st] = nil end
end
for o, key in pairs(themedFill) do
if o.Parent then o.BackgroundColor3 = th[key] else themedFill[o] = nil end
end
for _, p in ipairs(parts) do
local col = L.cur().pcol and L.cur().pcol[p.ci] or th.pal[p.ci]
if p.kind == "triangle" then p.o.TextColor3 = col else p.o.BackgroundColor3 = col end
end
for _, r in ipairs(refreshers) do r() end
L.applyEdge()
end
local function applyWindow() win.BackgroundTransparency = minimized and 1 or math.min(0.92, S.winTrans + (L.cur().wt or 0)) end
L.BGS = {
"https://i.postimg.cc/FRbJj5dM/file-00000000c52c81f7b9ac5699e070f818.png",
"https://i.postimg.cc/KjSXnt2D/a2c1d8b9a752a25fb26be505dcdb954b.jpg",
"https://i.postimg.cc/sXDfD3RG/0d1984a0e2894f4eb79332c20b1f8e45.jpg",
"https://i.postimg.cc/NFrnWMRk/1debb79bdaf1ef138dc75fd2bd0f8df6.jpg",
"https://i.postimg.cc/63PSjR4W/c0b5223f5f091529a7b74174f22e6d01.jpg",
"https://i.postimg.cc/5jWFm7xn/ea060a807fa9edf2d37eb474cac8baae.jpg",
}
-- background image: translucent so text stays readable; bars and sidebar become see-through over it
function L.applyBg()
local st = L.cur()
local img = S.bgOn and true or false
local on = img and not minimized
L.bgImg.Visible, L.bgDim.Visible = on, on
L.bgImg.ImageTransparency = 1 - S.bgVis
bar.BackgroundTransparency = on and (st.barT or 0.38) or 0
mask.Visible = not minimized and not on
sidebar.BackgroundTransparency = on and (st.sbT or 0.3) or 0
sbMask.Visible = not on
end
-- downloads the chosen image once, keeps it as a file, and shows it (nothing is embedded in the script)
function L.loadBg()
local tok = (L.bgTok or 0) + 1
L.bgTok = tok
task.spawn(function()
local custom = typeof(getcustomasset) == "function" and getcustomasset or (typeof(getsynasset) == "function" and getsynasset)
local url = S.bgUrl ~= "" and S.bgUrl or (L.BGS[S.bgPreset] or L.BGS[1])
local function put(img) if L.bgTok == tok and L.bgImg.Parent then L.bgImg.Image = img end end
local id = url:match("^rbxassetid://(%d+)$") or url:match("^(%d+)$")
if id then return put("rbxassetid://" .. id) end
if not custom or not canSave then return notify("Background", "This executor can't load image links", nil, 4) end
local hash = 5381
for i = 1, #url do hash = (hash * 33 + url:byte(i)) % 4294967296 end
local ok, img = pcall(function()
for _, e in ipairs({"png", "jpg"}) do
local ff = "DuaLibrary_BG_" .. hash .. "." .. e
if isfile(ff) and #readfile(ff) > 100 then return custom(ff) end
end
local body = game:HttpGet(url)
if type(body) ~= "string" or #body < 100 then error("empty") end
if #body > 8000000 then error("big") end
local e = body:sub(1, 4) == "\137PNG" and "png" or (body:sub(1, 3) == "\255\216\255" and "jpg") or nil
if not e then error("type") end
local ff = "DuaLibrary_BG_" .. hash .. "." .. e
writefile(ff, body)
return custom(ff)
end)
if ok and img then
put(img)
else
notify("Background", "Couldn't load the background image. Check the link (direct PNG or JPG, max 8 MB).", nil, 5)
end
end)
end
L.applyBg()
L.loadBg()
local function applyShadow() shadow.Visible = S.shadowOn end
local function applyParticles()
for i, p in ipairs(parts) do p.o.Visible = S.particlesOn and i <= S.particleCount end
end
L.applyParticles = applyParticles
function L.rerender()
for _, u in pairs(pageUI) do renderPage(u.current) end
if L.sbRerender then
local h = pages["ScriptBlox scripts"]
if h and not h.Visible then L.sbDirty = true else L.sbRerender() end
end
end
function L.toggleFav(e)
if isAdmin and not adminOk() then return end
local list, at = L.favList(), nil
for i, x in ipairs(list) do if x.name == e.name and x.code == e.code then at = i end end
if at then
table.remove(list, at)
notify("Favorite", "Removed " .. e.name)
else
table.insert(list, {name = e.name, code = e.code})
notify("Favorite", "Added " .. e.name .. (isAdmin and " (everyone sees it)" or ""))
end
if not isAdmin then
L.favCount = L.favCount or {}
L.favCount[e.name] = math.max(0, (L.favCount[e.name] or 0) + (at and -1 or 1))
end
if isAdmin then syncAdmin() else writeJson(FILE.FAVS, {list = L.favs}); task.delay(3, L.syncFavs) end
for _, ui in pairs(pageUI) do renderPage(ui.current) end
if L.sbHearts then L.sbHearts() end
end
function L.applyFont()
for _, o in ipairs(sg:GetDescendants()) do
if (o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox")) and not o:GetAttribute("FixedFont") then
L.face(o)
end
end
end
function L.applyStyle()
local st = L.cur()
L.rs, L.ss = st.r, st.stroke
for c, r in pairs(L.corners) do
if c.Parent then c.CornerRadius = UDim.new(0, r >= 90 and r or math.floor(math.min(r, 10) * st.r + 0.5)) else L.corners[c] = nil end
end
for k, t in pairs(L.strokes) do
if k.Parent then k.Thickness = t * st.stroke else L.strokes[k] = nil end
end
for _, p in ipairs(L.plus) do p.BackgroundColor3, p.BackgroundTransparency = st.plus, st.plusT end
L.pm, L.hv = st.pm or 1, st.hv or 1.04
applyWindow()
accent.Size = U2(1, 0, 0, math.clamp(math.floor(S.edgeW / 2 + 0.5), 2, 4))
if st.tf then
title:SetAttribute("FixedFont", true)
pcall(function() title.Font = Enum.Font[st.tf] end)
else
title:SetAttribute("FixedFont", nil)
L.face(title)
end
local th = themeColors(S.hue, S.sat, S.val)
for _, p in ipairs(parts) do
local col = st.pcol and st.pcol[p.ci] or th.pal[p.ci]
if p.kind == "triangle" then p.o.TextColor3 = col else p.o.BackgroundColor3 = col end
end
for _, ui in pairs(pageUI) do renderPage(ui.current) end
L.applyBg()
end
local function applyAll()
applyWindow(); applyShadow(); applyParticles(); applyTheme(); L.applyStyle(); L.applyFont(); L.applyBg(); bump()
end
local sPage
sPage = new("ScrollingFrame", {
Name = "Settings", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
Visible = false, ZIndex = 20, ScrollBarThickness = 3, ScrollBarImageColor3 = WHITE,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)
pages["Settings"] = sPage
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, sPage)
new("UIPadding", {
PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8),
PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 12),
}, sPage)
L.settingsHost = sPage
local order = 0
local function nextOrder() order = order + 1 return order end
L.secs = {}
local function setSection(sec, collapse)
sec.collapsed = collapse
sec.tok = sec.tok + 1
local tok = sec.tok
sec.btn.Text = (collapse and "+  " or "-  ") .. sec.label
local stop = math.huge
for _, o in ipairs(L.secs) do if o.order > sec.order and o.order < stop then stop = o.order end end
local info = TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
for _, c in ipairs(sPage:GetChildren()) do
if c:IsA("GuiObject") and c.LayoutOrder > sec.order and c.LayoutOrder < stop then
if c.AutomaticSize ~= Enum.AutomaticSize.None then
if collapse then c:SetAttribute("Skip", not c.Visible and true or nil); c.Visible = false
elseif not c:GetAttribute("Skip") then c.Visible = true end
elseif collapse and not c.Visible then
c:SetAttribute("Skip", true)
elseif collapse then
c:SetAttribute("Skip", nil)
c:SetAttribute("H", c.Size.Y.Offset)
c:SetAttribute("Clip", c.ClipsDescendants)
c.ClipsDescendants = true
local tw = TweenService:Create(c, info, {Size = U2(c.Size.X.Scale, c.Size.X.Offset, 0, 0)})
tw.Completed:Connect(function(st) if st == Enum.PlaybackState.Completed and sec.tok == tok then c.Visible = false end end)
tw:Play()
elseif not c:GetAttribute("Skip") then
local h = c:GetAttribute("H") or c.Size.Y.Offset
c.Visible = true
local tw = TweenService:Create(c, info, {Size = U2(c.Size.X.Scale, c.Size.X.Offset, 0, h)})
tw.Completed:Connect(function(st) if st == Enum.PlaybackState.Completed and sec.tok == tok then c.ClipsDescendants = c:GetAttribute("Clip") == true end end)
tw:Play()
end
end
end
end
local function sectionHeader(txt)
local o = nextOrder()
local b = new("TextButton", {
Size = U2(1, 0, 0, 26), Text = "-  " .. txt:upper(), TextSize = 11, TextColor3 = L.P.muted, BackgroundTransparency = 1,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20, LayoutOrder = o,
}, sPage)
new("UIPadding", {PaddingLeft = UDim.new(0, 4), PaddingTop = UDim.new(0, 8)}, b)
local sec = {btn = b, order = o, label = txt:upper(), collapsed = false, tok = 0}
L.secs[#L.secs + 1] = sec
b.MouseEnter:Connect(function() tween(b, FAST, {TextColor3 = WHITE}) end)
b.MouseLeave:Connect(function() tween(b, FAST, {TextColor3 = L.P.muted}) end)
b.MouseButton1Click:Connect(function() setSection(sec, not sec.collapsed) end)
end
local function makeRow(name, tall)
local row = new("Frame", {
Size = U2(1, 0, 0, tall and 60 or 30), BackgroundColor3 = L.P.card, BackgroundTransparency = 0,
BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder(),
}, sPage)
round(row, 8)
local l = text(row, {
Position = UO(10, tall and 4 or 0), Size = tall and U2(1, -20, 0, 22) or U2(0.6, -14, 1, 0),
Text = name, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
})
fit(l, 12, 8)
return row, l
end
local function sliderRow(name, key, min, max, fmt, apply, step, rainbow)
local row, lbl = makeRow(name)
local hit = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -6, 0.5, 0), Size = U2(0.4, 0, 0, 28),
BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 21,
}, row)
new("UISizeConstraint", {MinSize = Vector2.new(70, 28), MaxSize = Vector2.new(150, 28)}, hit)
local track = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = U2(1, -16, 0, 4),
BackgroundColor3 = rainbow and WHITE or L.P.line, BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = 22,
}, hit)
round(track, 99)
local fill = new("Frame", {Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, Visible = not rainbow, ZIndex = 23}, track)
round(fill, 99)
local knob = new("Frame", {AnchorPoint = V2(0.5, 0.5), Size = UO(12, 12), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 24}, track)
round(knob, 99)
if rainbow then
local kp = {}
for k = 0, 6 do kp[#kp + 1] = ColorSequenceKeypoint.new(k / 6, Color3.fromHSV(k / 6, 0.8, 1)) end
new("UIGradient", {Color = ColorSequence.new(kp)}, track)
end
local function refresh()
local v = S[key]
local a = math.clamp((v - min) / (max - min), 0, 1)
fill.Size = UDim2.fromScale(a, 1)
knob.Position = UDim2.fromScale(a, 0.5)
fill.BackgroundColor3 = themeBtn
lbl.Text = name .. ": " .. fmt(v)
end
refreshers[#refreshers + 1] = refresh
local dragging, host = false, sPage
local function fromInput(i)
local a = math.clamp((i.Position.X - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
local v = min + (max - min) * a
if step then v = math.floor(v / step + 0.5) * step end
S[key] = v
refresh(); apply(); scheduleSave()
end
local function isPress(i) return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch end
local cm, ce
local function stop()
dragging = false; host.ScrollingEnabled = true; tween(knob, FAST, {Size = UO(12, 12)})
if cm then cm:Disconnect() cm = nil end
if ce then ce:Disconnect() ce = nil end
end
hit.InputBegan:Connect(function(i)
if isPress(i) then
dragging = true; host.ScrollingEnabled = false; tween(knob, FAST, {Size = UO(15, 15)}); fromInput(i)
if cm then cm:Disconnect() end
if ce then ce:Disconnect() end
cm = UIS.InputChanged:Connect(function(i2)
if dragging and (i2.UserInputType == Enum.UserInputType.MouseMovement or i2.UserInputType == Enum.UserInputType.Touch) then fromInput(i2) end
end)
ce = UIS.InputEnded:Connect(function(i2)
if dragging and isPress(i2) then stop() end
end)
end
end)
end
local function toggleRow(name, key, apply)
makeSwitch(makeRow(name), V2(1, 0.5), U2(1, -12, 0.5, 0), key, apply)
end
local function wideButton(label, color, trans)
if color == WHITE or color == nil then color, trans = L.P.ctrl, 0 end
local b = new("TextButton", {
Size = U2(1, 0, 0, 30), BackgroundColor3 = color, BackgroundTransparency = trans, BorderSizePixel = 0,
AutoButtonColor = false, ZIndex = 20, LayoutOrder = nextOrder(),
Font = Enum.Font.Nunito, TextSize = 12, Text = label, TextColor3 = WHITE,
}, sPage)
round(b, 8)
L.press(b, 0.98)
return b
end
sectionHeader("Interface")
do
local krow = makeRow("Toggle key")
local kb = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -8, 0.5, 0), Size = UO(100, 22), BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = S.toggleKey, TextColor3 = WHITE, ZIndex = 21,
}, krow)
round(kb, 5)
L.press(kb, 0.96)
kb.MouseButton1Click:Connect(function()
kb.Text = "press a key..."
L.listenKey = function(code)
if code == Enum.KeyCode.Escape or code == Enum.KeyCode.Unknown then kb.Text = S.toggleKey return end
S.toggleKey = code.Name
kb.Text = S.toggleKey
scheduleSave()
notify("Toggle key", "Press " .. code.Name .. " to show or hide the hub", nil, 3)
end
end)
end
toggleRow("Floating button", "launcher", function() if L.applyLauncher then L.applyLauncher() end end)
do
local rb = wideButton("Reset position and size")
rb.MouseButton1Click:Connect(function() L.resetPos() end)
local ub = wideButton("Unload hub", RED, 0.2)
ub.MouseButton1Click:Connect(function()
askConfirm("Unload the hub completely? Run the script again to bring it back.", function() sg:Destroy() end, "Unload")
end)
end
sectionHeader("Auto-execute")
toggleRow("Run the auto-execute list when I join", "autoRun", nop)
sliderRow("Delay before running", "autoDelay", 0, 20, function(v) return math.floor(v + 0.5) .. " s" end, function() scheduleSave() end, 1)
do
local autoBox = new("Frame", {LayoutOrder = nextOrder(), Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, ZIndex = 20}, sPage)
new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, autoBox)
function L.autoRender()
for _, c in ipairs(autoBox:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
if #L.auto.list == 0 then
text(autoBox, {LayoutOrder = 1, Size = U2(1, 0, 0, 28), Font = Enum.Font.Nunito, Text = "Empty. Open a script with View and press Auto.", TextSize = 11, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21})
end
for i, it in ipairs(L.auto.list) do
local r = new("Frame", {LayoutOrder = i, Size = U2(1, 0, 0, 32), BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0, ZIndex = 21}, autoBox)
round(r, 6)
text(r, {Position = UO(10, 0), Size = U2(1, -150, 1, 0), Text = it.name, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22})
local pl = button(r, 0, 0, 90, 22, it.place and "This game" or "All games", L.P.ctrlHot, 0, 22)
pl.AnchorPoint, pl.Position, pl.TextSize = V2(1, 0.5), U2(1, -40, 0.5, 0), 11
fit(pl, 11, 7)
pl.MouseButton1Click:Connect(function()
it.place = (not it.place) and game.PlaceId or nil
L.saveAuto()
L.autoRender()
end)
local rm = button(r, 0, 0, 26, 22, "X", RED, 0.3, 22)
rm.AnchorPoint, rm.Position = V2(1, 0.5), U2(1, -8, 0.5, 0)
rm.MouseButton1Click:Connect(function()
local at = table.find(L.auto.list, it)
if at then table.remove(L.auto.list, at) end
L.saveAuto()
L.autoRender()
end)
end
end
L.autoRender()
end
do
local rn = wideButton("Run the list now")
rn.MouseButton1Click:Connect(function() L.autoRunAll(true) end)
end
sectionHeader("Appearance")
do
local row = makeRow("Theme color", true)
local holder = new("Frame", {Position = UO(10, 31), Size = U2(1, -20, 0, 24), BackgroundTransparency = 1, ZIndex = 21}, row)
new("UIGridLayout", {CellSize = UO(20, 20), CellPadding = UO(5, 5)}, holder)
for _, p in ipairs(L.THEMES) do
local b = new("TextButton", {Size = UO(20, 20), Text = "", AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 22, BackgroundColor3 = WHITE}, holder)
round(b, 99)
new("UIGradient", {Color = L.edgeSeq(L.edgeFor(p)), Rotation = 45}, b)
local st = new("UIStroke", {Thickness = 2, Color = WHITE, Transparency = 1}, b)
L.press(b, 0.88)
b.MouseButton1Click:Connect(function()
S.hue, S.sat, S.val, S.themeName = p.h, p.s, p.v or 1, p.name
applyTheme(); scheduleSave()
end)
refreshers[#refreshers + 1] = function() st.Transparency = (S.themeName == p.name) and 0 or 1 end
end
end
sliderRow("Custom hue", "hue", 0, 1, function(v) return math.floor(v * 360) .. "°" end, function() S.themeName, S.val = "Custom", 1; applyTheme() end, nil, true)
sliderRow("Color strength", "sat", 0.05, 1, function(v) return math.floor(v * 100 + 0.5) .. "%" end, function() S.themeName, S.val = "Custom", 1; applyTheme() end)
sliderRow("Border thickness", "edgeW", 1, 12, function(v) return math.floor(v + 0.5) .. " px" end, function() L.applyEdge() end, 1)
toggleRow("Animated border", "edgeAnim", function() L.applyEdge() end)
sliderRow("Border speed", "edgeSpeed", 3, 30, function(v) return math.floor(v + 0.5) .. " s" end, function() L.applyEdge() end, 1)
sliderRow("Window see-through", "winTrans", 0, 0.6, function(v) return math.floor(v / 0.6 * 100 + 0.5) .. "%" end, applyWindow)
sectionHeader("Background")
toggleRow("Background image", "bgOn", function() L.applyBg() end)
sliderRow("Background visibility", "bgVis", 0.05, 0.9, function(v) return math.floor(v * 100 + 0.5) .. "%" end, function() L.applyBg() end)
do
local box
local prow = new("Frame", {Size = U2(1, 0, 0, 68), BackgroundTransparency = 1, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
new("UIGridLayout", {CellSize = U2(1 / 3, -4, 0, 30), CellPadding = UO(4, 4), SortOrder = Enum.SortOrder.LayoutOrder}, prow)
local pbtn = {}
local function recolor()
for i, b in ipairs(pbtn) do
local on = S.bgUrl == "" and S.bgPreset == i
b.BackgroundColor3 = on and themeBtn or L.P.ctrl
b.BackgroundTransparency = 0
end
end
for i = 1, 6 do
local b = button(prow, 0, 0, 10, 10, "Default " .. i, WHITE, 0.45, 21)
b.LayoutOrder, b.TextSize = i, 12
fit(b, 12, 7)
pbtn[i] = b
b.MouseButton1Click:Connect(function()
S.bgPreset, S.bgUrl = i, ""
if box then box.Text = "" end
scheduleSave()
recolor()
L.applyBg()
L.loadBg()
end)
end
refreshers[#refreshers + 1] = recolor
recolor()
local row = new("Frame", {Size = U2(1, 0, 0, 34), BackgroundColor3 = L.P.card, BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
round(row, 8)
box = inputBox(row, 6, 4, 190, 26, "Your own background: paste a direct image link (.png / .jpg)", false, 21)
box.Size, box.Text = U2(1, -100, 0, 26), S.bgUrl
local b = button(row, 0, 0, 80, 26, "Set", WHITE, 0.6, 21)
b.AnchorPoint, b.Position, b.TextSize = V2(1, 0.5), U2(1, -6, 0.5, 0), 12
b.MouseButton1Click:Connect(function()
local t = box.Text:match("^%s*(.-)%s*$")
if t ~= "" and not (t:find("^https?://%S+$") or t:find("^rbxassetid://%d+$") or t:find("^%d+$")) then
return notify("Background", "That isn't an image link", nil, 3)
end
S.bgUrl = t
scheduleSave()
recolor()
L.applyBg()
L.loadBg()
notify("Background", t == "" and ("Back to Default " .. S.bgPreset) or "Loading your image...", nil, 3)
end)
end
sectionHeader("Particles")
toggleRow("Particles", "particlesOn", applyParticles)
sliderRow("Amount", "particleCount", 0, PARTICLE_MAX, function(v) return tostring(math.floor(v)) end, applyParticles, 1)
sliderRow("Speed", "speed", 0.2, 3, function(v) return string.format("%.1fx", v) end, nop, 0.1)
sectionHeader("Window")
toggleRow("Window shadow", "shadowOn", applyShadow)
toggleRow("Lock dragging", "lockDrag", nop)
toggleRow("Sounds", "soundOn", nop)
toggleRow("Sidebar auto-close", "autoClose", bump)
sliderRow("Auto-close delay", "autoCloseDelay", 1, 6, function(v) return string.format("%.1fs", v) end, bump, 0.5)
do
local function pickGrid(items, key, onPick, ownFont)
local box = new("Frame", {
Size = U2(1, 0, 0, math.ceil(#items / 3) * 28), BackgroundTransparency = 1, ZIndex = 20, LayoutOrder = nextOrder(),
}, sPage)
new("UIGridLayout", {CellSize = U2(1 / 3, -3, 0, 24), CellPadding = UO(4, 4), SortOrder = Enum.SortOrder.LayoutOrder}, box)
local btns = {}
local function recolor()
for i, b in ipairs(btns) do
local on = items[i][1] == S[key]
b.BackgroundColor3 = on and themeBtn or L.P.ctrl
b.BackgroundTransparency = 0
end
end
for i, it in ipairs(items) do
local b = button(box, 0, 0, 10, 10, it[1], WHITE, 0.45, 21)
b.LayoutOrder, b.TextSize = i, 12
fit(b, 12, 7)
if ownFont then
b:SetAttribute("FixedFont", true)
pcall(function() b.FontFace = Font.new(FAM .. it[2] .. ".json", Enum.FontWeight.Bold) end)
end
btns[i] = b
b.MouseButton1Click:Connect(function()
S[key] = it[1]
onPick(); recolor(); scheduleSave()
end)
end
refreshers[#refreshers + 1] = recolor
recolor()
end
sectionHeader("Font")
toggleRow("Bold text", "bold", L.applyFont)
pickGrid(L.fonts, "font", L.applyFont, true)
sectionHeader("GUI style")
local names = {}
for _, st in ipairs(L.styles) do names[#names + 1] = {st.name} end
pickGrid(names, "style", applyAll, false)
end
do
sectionHeader("Teleport and rejoin")
toggleRow("Re-open this GUI after teleport / rejoin", "reopen", function() if L.queueReopen then L.queueReopen() end end)
local row = new("Frame", {Size = U2(1, 0, 0, 34), BackgroundColor3 = L.P.card, BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
round(row, 8)
local box = inputBox(row, 6, 4, 190, 26, "Loader link (optional, GUI reopens by itself otherwise)", false, 21)
box.Size, box.Text = U2(1, -100, 0, 26), S.reloadUrl
local b = button(row, 0, 0, 80, 26, "Save", WHITE, 0.6, 21)
b.AnchorPoint, b.Position, b.TextSize = V2(1, 0.5), U2(1, -6, 0.5, 0), 12
b.MouseButton1Click:Connect(function()
local t = box.Text:match("^%s*(.-)%s*$")
if t ~= "" and not t:find("^https?://%S+$") then return notify("Loader link", "That isn't a link") end
S.reloadUrl = t
scheduleSave()
notify("Loader link", t == "" and "Cleared" or "Saved", nil, 2)
end)
end
if isAdmin then
sPage = new("ScrollingFrame", {
Position = UO(0, 46), Size = U2(1, 0, 1, -46), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
ScrollBarImageColor3 = WHITE, ZIndex = 20, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, pages["Admin"])
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, sPage)
new("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 12)}, sPage)
local function inputRow(placeholder, btnText, onClick)
local row = new("Frame", {
Size = U2(1, 0, 0, 34), BackgroundColor3 = L.P.card, BackgroundTransparency = 0,
BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder(),
}, sPage)
round(row, 8)
local box = inputBox(row, 6, 4, 190, 26, placeholder, false, 21)
box.Size = U2(1, -100, 0, 26)
local b = button(row, 0, 0, 80, 26, btnText, WHITE, 0.6, 21)
b.AnchorPoint, b.Position, b.TextSize = V2(1, 0.5), U2(1, -6, 0.5, 0), 12
b.MouseButton1Click:Connect(function() onClick(box.Text:match("^%s*(.-)%s*$"), box) end)
end
if not L.owner() then
text(sPage, {
Size = U2(1, 0, 0, 30), Font = Enum.Font.Nunito, TextSize = 11, TextTransparency = 0.25, TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20, LayoutOrder = nextOrder(),
Text = "You can message players, send announcements, add scripts to Dua's script and use Check favoritisms.",
})
end
if L.owner() then
sectionHeader("Admin")
local adminBox = new("Frame", {
Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
ZIndex = 20, LayoutOrder = nextOrder(),
}, sPage)
new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, adminBox)
local function renderAdmins()
for _, c in ipairs(adminBox:GetChildren()) do
if c:IsA("Frame") then c:Destroy() end
end
for i, nm in ipairs(adminList) do
local you = nm:lower() == myName
local r = new("Frame", {
LayoutOrder = i, Size = U2(1, 0, 0, 30), BackgroundColor3 = L.P.card, BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = 20,
}, adminBox)
round(r, 8)
local l = text(r, {
Position = UO(10, 0), Size = U2(1, -90, 1, 0), Text = nm .. (you and "  (you)" or ""),
TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
})
fit(l, 13, 8)
if not you then
local rm = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -6, 0.5, 0), Size = UO(68, 22),
BackgroundColor3 = RED, BackgroundTransparency = 0.35, BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = "Remove",
TextColor3 = WHITE, ZIndex = 21,
}, r)
round(rm, 6)
rm.MouseButton1Click:Connect(function()
askConfirm('Remove "' .. nm .. '" from the admin list?', function()
local at = table.find(adminList, nm)
if adminOk() and at and nm:lower() ~= myName then
table.remove(adminList, at)
syncAdmin()
renderAdmins()
end
end)
end)
end
end
end
renderAdmins()
local addRow = new("Frame", {
Size = U2(1, 0, 0, 34), BackgroundColor3 = L.P.card, BackgroundTransparency = 0,
BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder(),
}, sPage)
round(addRow, 8)
local adminIn = inputBox(addRow, 6, 4, 190, 26, "New admin username", false, 21)
adminIn.Size = U2(1, -86, 0, 26)
local adminAdd = button(addRow, 0, 0, 68, 26, "Add", WHITE, 0.6, 21)
adminAdd.AnchorPoint, adminAdd.Position, adminAdd.TextSize = V2(1, 0.5), U2(1, -6, 0.5, 0), 13
adminAdd.MouseButton1Click:Connect(function()
if not adminOk() then return end
local nm = adminIn.Text:match("^%s*(.-)%s*$")
local ok = #nm >= 3 and #nm <= 20 and nm:match("^[%w_]+$") ~= nil
for _, a in ipairs(adminList) do
if a:lower() == nm:lower() then ok = false end
end
if not ok then return notify("Admin", "Invalid or already an admin") end
table.insert(adminList, nm)
adminIn.Text = ""
syncAdmin()
renderAdmins()
notify("Admin added", readToken() and (nm .. " is admin the next time they open the script") or "Save your token and publish so " .. nm .. " gets it", nil, 4)
end)
local copyBtn = wideButton("Copy shareable scripts block", WHITE, 0.8)
copyBtn.MouseButton1Click:Connect(function()
if not adminOk() then return end
local block = serializeEmbedded(adminList, adminPages)
if typeof(setclipboard) == "function" then
setclipboard(block)
notify("Copied", "Paste it over the block at the top of the script", nil, 3)
elseif canSave then
writefile("DuaLibrary_Shared.txt", block)
notify("Saved", "DuaLibrary_Shared.txt in your executor workspace", nil, 3)
else
notify("Can't export", "No clipboard or file support in this executor", nil, 3)
end
end)
sectionHeader("Online sharing")
local onlineNote = text(sPage, {
Size = U2(1, 0, 0, 44), Font = Enum.Font.Nunito, TextSize = 11, TextTransparency = 0.25,
TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
ZIndex = 20, LayoutOrder = nextOrder(), Text = "",
})
local function refreshOnlineNote()
onlineNote.Text = (feedUrl ~= "" and "Online list is ON: anyone with this script loads your scripts automatically."
or "Online list is OFF. Save a GitHub token (classic, only the 'gist' scope), then tap Publish.")
.. (httpReq and "" or " This executor has no request function, so paste a feed URL instead.")
end
refreshOnlineNote()
onFeedChanged = refreshOnlineNote
inputRow("GitHub token (stays on this device)", "Save token", function(t, box)
if not adminOk() then return end
if #t < 10 then return notify("Token", "That doesn't look like a token") end
if canSave then pcall(writefile, FILE.TOKEN, t) end
box.Text = ""
notify("Token saved", "Only on this device, never shared")
end)
inputRow("Token for this session only (not saved)", "Use once", function(t, box)
if not adminOk() then return end
if #t < 10 then return notify("Token", "That doesn't look like a token") end
L.memToken = t
box.Text = ""
notify("Token set", "Kept in memory only, gone when you close the Hub", nil, 4)
end)
inputRow("Or paste a feed URL", "Set URL", function(t, box)
if not adminOk() then return end
if t ~= "" and not t:find("^https?://%S+$") then return notify("Feed URL", "That isn't a link") end
feedUrl = t
saveOnline(); writeLocal(); refreshOnlineNote()
box.Text = ""
notify("Feed URL", t == "" and "Cleared" or "Saved")
end)
local pubBtn = wideButton("Publish online now", WHITE, 0.8)
pubBtn.MouseButton1Click:Connect(function() publishNow(true) end)
local jsonBtn = wideButton("Copy feed JSON (manual hosting)", WHITE, 0.85)
jsonBtn.MouseButton1Click:Connect(function()
if not adminOk() then return end
if typeof(setclipboard) == "function" then
setclipboard(feedJson())
notify("Copied", "Paste it into your own gist / paste host", nil, 3)
elseif canSave then
writefile("DuaLibrary_Feed_Export.json", feedJson())
notify("Saved", "DuaLibrary_Feed_Export.json", nil, 3)
end
end)
wideButton("Copy feed link", WHITE, 0.85).MouseButton1Click:Connect(function()
if not adminOk() then return end
if feedUrl == "" then return notify("No link yet", "Publish online first") end
if typeof(setclipboard) == "function" then setclipboard(feedUrl) notify("Copied", "Feed link") end
end)
wideButton("Remove saved token", WHITE, 0.85).MouseButton1Click:Connect(function()
if not adminOk() then return end
L.memToken = nil
if canSave then pcall(writefile, FILE.TOKEN, "") end
notify("Token removed", "Publishing is off until you save a token again", nil, 3)
end)
sectionHeader("Requests and messages")
inputRow("Discord webhook link for script requests", "Set", function(t, box)
if not adminOk() then return end
local ok = t == "" or t:match("^https://discord%.com/api/webhooks/%d+/[%w_%-]+$") or t:match("^https://discordapp%.com/api/webhooks/%d+/[%w_%-]+$")
if not ok then return notify("Webhook", "That isn't a Discord webhook link") end
online.webhook = t ~= "" and t or nil
saveOnline(); box.Text = ""
notify("Requests", t == "" and "Turned off" or "On: requests arrive in that Discord channel", nil, 3)
if readToken() then publishNow(true) end
end)
inputRow("Discord webhook link for Help requests", "Set", function(t, box)
if not adminOk() then return end
local ok = t == "" or t:match("^https://discord%.com/api/webhooks/%d+/[%w_%-]+$") or t:match("^https://discordapp%.com/api/webhooks/%d+/[%w_%-]+$")
if not ok then return notify("Webhook", "That isn't a Discord webhook link") end
online.helpHook = t ~= "" and t or nil
saveOnline(); box.Text = ""
notify("Help", t == "" and "Turned off" or "On: help requests arrive in that Discord channel", nil, 3)
if readToken() then publishNow(true) end
end)
end
sectionHeader("Messages")
inputRow("Message a player  (name: text  or  all: text)", "Send", function(t, box)
if not adminOk() then return end
local who, msg = t:match("^(.-)%s*:%s*(.+)$")
if not who or who == "" then return notify("Message", "Write it like  name: your message") end
local to = "all"
if who:lower() ~= "all" then
local ok, id = pcall(Players.GetUserIdFromNameAsync, Players, who)
if not ok then return notify("Message", "No player called " .. who) end
to = tostring(id)
end
local nid = os.time()
for _, m in ipairs(online.messages) do nid = math.max(nid, (tonumber(m.id) or 0) + 1) end
table.insert(online.messages, {id = tostring(nid), to = to, toName = to ~= "all" and who or nil, from = verName or LP.Name, text = msg:sub(1, 140)})
while #online.messages > 40 do table.remove(online.messages, 1) end
saveOnline(); box.Text = ""
notify("Message", "Sent to " .. who, nil, 3)
if readToken() then publishNow(true) else notify("Not published", "Save a GitHub token first", nil, 3) end
end)
wideButton("Clear sent messages", WHITE, 0.85).MouseButton1Click:Connect(function()
if not adminOk() then return end
online.messages = {}
saveOnline()
if readToken() then publishNow(true) end
notify("Messages", "Cleared", nil, 2)
end)
sectionHeader("Announcement")
inputRow("Message everyone sees once (empty = clear)", "Send", function(t, box)
if not adminOk() then return end
online.notice = t ~= "" and {text = t:sub(1, 140), id = tostring(os.time()), from = verName or LP.Name} or nil
saveOnline()
box.Text = ""
if t ~= "" then L.banner(verName or LP.Name, t); if L.announceLive then L.announceLive(t:sub(1, 140)) end else notify("Announcement", "Cleared", nil, 3) end
if readToken() then publishNow(true) else notify("Not published", "Save a GitHub token first", nil, 3) end
end)
sectionHeader("Help requests")
L.helpBox = new("Frame", {Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, L.helpBox)
wideButton("Refresh help requests", WHITE, 0.85).MouseButton1Click:Connect(function()
L.commBusy = false
if L.commPull then L.commPull(true) end
end)
sPage = L.settingsHost
end
if not isAdmin and feedUrl ~= "" then
sectionHeader("Online scripts")
local rb = wideButton("Refresh online scripts", WHITE, 0.8)
rb.MouseButton1Click:Connect(function() refreshOnline(false) end)
end
wideButton("Reset to defaults", RED, 0.35).MouseButton1Click:Connect(function()
for k, v in pairs(DEFAULTS) do S[k] = v end
if L.setSize then L.setSize(DEFAULTS.winW, DEFAULTS.winH) end
applyAll(); scheduleSave()
end)
do
local BOARD_PAT = "^https://jsonblob%.com/api/jsonBlob/[%w%-]+$"
local BOARD_PAT2 = "^https://api%.npoint%.io/[%w]+$"
L.DEFAULT_BOARD = "https://api.npoint.io/bfda7d2b5a0f0a37df26"
-- Second board only for shared scripts (leave "" to keep them on the main board)
L.SHARE_BOARD = "https://api.npoint.io/ff24c6ba1cbd09eb6ac7"
local ui = pageUI[L.FAVP]
function L.boardOf()
local u = L.DEFAULT_BOARD
return type(u) == "string" and (u:match(BOARD_PAT) or u:match(BOARD_PAT2)) and u or nil
end
function L.shareBoardOf()
local u = L.SHARE_BOARD
if type(u) == "string" and (u:match(BOARD_PAT) or u:match(BOARD_PAT2)) then return u end
return nil
end
local function call(method, url, body)
if not httpReq then return nil end
local ok, res = pcall(httpReq, {
Url = url, Method = method,
Headers = {["Content-Type"] = "application/json", Accept = "application/json", ["Cache-Control"] = "no-cache"},
Body = body,
})
if ok and type(res) == "table" then return res end
end
function L.bRead(url)
local res = call("GET", url)
local body = res and tonumber(res.StatusCode or 200) < 300 and res.Body
L.boardErr = res and ("HTTP " .. tostring(res.StatusCode)) or (httpReq and "no response" or "this executor has no request()")
if not body then
local ok, b = pcall(function() return game:HttpGet(url) end)
body = ok and b
end
local ok, d = pcall(function() return HttpService:JSONDecode(body or "") end)
if ok and type(d) == "table" then
if type(d.users) ~= "table" then d.users = {} end
L.boardErr = nil
return d
end
if body then L.boardErr = "board data unreadable" end
end
function L.bWrite(url, d)
local res = call(url:find("npoint.io", 1, true) and "POST" or "PUT", url, HttpService:JSONEncode(d))
if not res then
L.boardErr = httpReq and "write: no response" or "this executor has no request(), it can read but not write"
return false
end
local sc = tonumber(res.StatusCode) or 200
if sc >= 300 then L.boardErr = "write: HTTP " .. sc; return false end
return true
end
local function nextId()
local id = os.time()
for _, m in ipairs(online.messages) do id = math.max(id, (tonumber(m.id) or 0) + 1) end
return tostring(id)
end
function L.tally(d)
local c = {}
for _, u in pairs(d.users) do
if type(u) == "table" and type(u.f) == "table" then
for _, n in ipairs(u.f) do if type(n) == "string" then c[n] = (c[n] or 0) + 1 end end
end
end
local arr = {}
for n, k in pairs(c) do arr[#arr + 1] = {n = n, k = k} end
table.sort(arr, function(a, b) if a.k ~= b.k then return a.k > b.k end return a.n < b.n end)
return arr
end
L.comm = {}
function L.commStatusText()
if L.commErr then return "board: " .. tostring(L.commErr) end
if not L.commSyncAt then return "syncing..." end
local ok, tm = pcall(os.date, "%H:%M", L.commSyncAt)
return "synced " .. (ok and tm or "") .. ", " .. #(L.comm or {}) .. " from players"
end
function L.commPull(manual)
local url = L.boardOf()
if not url then return end
if L.commBusy and os.clock() - (L.commBusyAt or 0) < 20 then return end
L.commBusy, L.commBusyAt, L.commLast = true, os.clock(), os.clock()
task.spawn(function()
local surl0 = L.shareBoardOf()
local sd0, sdone0
if surl0 then
task.spawn(function() sd0 = L.bRead(surl0); sdone0 = true end)
else
sdone0 = true
end
local d = L.bRead(url)
L.commBusy = false
if not d then
L.commErr = L.boardErr or "can't reach it"
local u = pageUI[ADD_PAGE]
if u and u.count and u.count.Parent then renderPage(ADD_PAGE) end
if manual then notify("Community scripts", "Couldn't reach the board (" .. tostring(L.commErr) .. ")", nil, 4) end
return
end
L.commErr, L.commSyncAt = nil, os.time()
do
local fc = {}
for _, r in ipairs(L.tally(d)) do fc[r.n] = r.k end
L.favCount = fc
end
L.dmList = type(d.dm) == "table" and d.dm or {}
L.processDm()
local surl = surl0
if surl then
local t0 = os.clock()
while not sdone0 and os.clock() - t0 < 10 do task.wait(0.05) end
local sd = sd0
if sd then d.shared = type(sd.shared) == "table" and sd.shared or {}
else d.shared = {}; L.commErr = "share board: " .. tostring(L.boardErr or "can't reach it") end
end
L.helpList = type(d.help) == "table" and d.help or {}
L.processHelp()
for _, e in ipairs({table.unpack(L.pending)}) do
if L.commHas(d, e) then
L.commDone(e)
elseif e.sent and os.time() - (e.sentAt or os.time()) > 90 then
L.commDone(e)
elseif not e.busy and not e.sent and e.tries < 6 then
e.busy, e.tries = true, e.tries + 1
task.spawn(function()
if L.commWrite(e) then
if not e.sent then notify("Shared", "Your script is now on the board", nil, 3) end
e.sent, e.sentAt = true, os.time()
L.commBusy = false
L.commPull()
end
e.busy = false
end)
end
end
local out = {}
for _, x in ipairs(type(d.shared) == "table" and d.shared or {}) do
if type(x) == "table" and type(x.n) == "string" and type(x.c) == "string" and #x.c <= 30000 and #out < 200 then
local gid = (type(x.gi) == "string" or type(x.gi) == "number") and tostring(x.gi):match("^%d+$") or nil
local okNote = type(x.an) == "string" and x.an ~= "" and L.isAdminName(x.anb)
out[#out + 1] = {name = x.n:sub(1, 40), code = x.c, comm = true, by = tostring(x.a or "?"):sub(1, 20), uid = tostring(x.u or ""), t = tonumber(x.t) or 0, desc = type(x.d) == "string" and x.d ~= "" and x.d:sub(1, 300) or nil,
game = type(x.g) == "string" and x.g ~= "" and x.g:sub(1, 40) or nil, gid = gid and gid:sub(1, 15) or nil, kinds = type(x.k) == "string" and x.k:match("^[KUF]+$") and x.k:sub(1, 3) or nil,
an = okNote and x.an:sub(1, 200) or nil, anb = okNote and tostring(x.anb):sub(1, 20) or nil}
end
end
do
local mm, mc = type(d.muted) == "table" and d.muted or {}, 0
for _ in pairs(mm) do mc = mc + 1 end
L.boardMuted = mc <= 40 and mm or {}
if L.applyMuted then pcall(L.applyMuted) end
end
do
local seenK, uniq = {}, {}
for _, e in ipairs(out) do
local k = e.uid .. "\0" .. e.name:lower() .. "\0" .. L.ckey(e.code)
if not seenK[k] then seenK[k] = true; uniq[#uniq + 1] = e end
end
out = uniq
end
local sig = {}
local fcs = L.favCount or {}
for _, e in ipairs(out) do sig[#sig + 1] = e.uid .. e.t .. e.name .. #e.code .. (fcs[e.name] or 0) .. (e.game or "") .. (e.kinds or "") .. (e.an or "") end
sig = table.concat(sig, "|")
if manual then notify("Community scripts", #out .. " shared by players", nil, 3) end
if sig == L.commSig then renderPage(ADD_PAGE) return end
L.commSig, L.comm = sig, out
renderPage(ADD_PAGE)
end)
end
L.pending, L.helpList, L.helpReplies, L.helpAsked, L.dmList, L.dmMine = {}, {}, {}, {}, {}, {}
function L.commHas(d, e)
for _, x in ipairs(type(d.shared) == "table" and d.shared or {}) do
if type(x) == "table" and tostring(x.u) == e.u and x.n == e.n and (tonumber(x.t) == e.t or x.c == e.c) then return true end
end
return false
end
function L.commWrite(e)
local url = L.shareBoardOf() or L.boardOf()
for attempt = 1, 4 do
local d = L.bRead(url)
if d then
if L.commHas(d, e) then return true end
if type(d.shared) ~= "table" then d.shared = {} end
table.insert(d.shared, {n = e.n, c = e.c, u = e.u, a = e.a, t = e.t, d = e.d, g = e.g, gi = e.gi, k = e.k})
local mine = 0
for _, x in ipairs(d.shared) do if tostring(x.u) == e.u then mine = mine + 1 end end
for i = 1, #d.shared do
if mine <= 40 then break end
if tostring(d.shared[i].u) == e.u then table.remove(d.shared, i); mine = mine - 1; break end
end
local function bytes() local n = 0 for _, x in ipairs(d.shared) do n = n + #tostring(x.c) end return n end
while #d.shared > 1 and (#d.shared > 200 or bytes() > 600000) do table.remove(d.shared, 1) end
if L.bWrite(url, d) then return true end
end
task.wait(0.6 * attempt)
end
return false
end
function L.commDone(e)
for i, x in ipairs(L.pending) do if x == e then table.remove(L.pending, i) break end end
end
function L.isAdminName(n)
if type(n) ~= "string" then return false end
local l = n:lower()
for _, list in ipairs({rootAdmins, adminList}) do
for _, a in ipairs(list) do if a:lower() == l then return true end end
end
return false
end
function L.processDm()
local me, mine = tostring(LP.UserId), {}
for _, m in ipairs(L.dmList or {}) do
if type(m) == "table" and type(m.id) == "string" and m.id:match("^%w+$") and tostring(m.u) == me and type(m.t) == "string" then
local ok, tm = pcall(os.date, "%H:%M", tonumber(m.ts) or os.time())
local from, sc = tostring(m.f or "Admin"):sub(1, 20), tostring(m.s or ""):sub(1, 40)
mine[#mine + 1] = {from = from, script = sc, text = m.t:sub(1, 300), at = ok and tm or ""}
if not ("," .. S.dmSeen .. ","):find("," .. m.id .. ",", 1, true) then
S.dmSeen = (S.dmSeen .. "," .. m.id):sub(-300)
scheduleSave()
notify("" .. from .. ' about "' .. sc .. '"', m.t:sub(1, 80), nil, 6)
end
end
end
L.dmMine = mine
if L.inboxRender then L.inboxRender() end
end
-- owner / admin only: a note everyone sees on a shared script
function L.setAdminNote(entry, note)
if not adminOk() then return end
local who = verName or LP.Name
note = (note or ""):gsub("%c", " "):match("^%s*(.-)%s*$"):sub(1, 200)
local an, anb = note ~= "" and note or nil, note ~= "" and who or nil
entry.an, entry.anb = an, anb
if entry.comm then
local url = L.shareBoardOf() or L.boardOf()
if url then
task.spawn(function()
local d = L.bRead(url)
local hit
for _, x in ipairs(d and type(d.shared) == "table" and d.shared or {}) do
if tostring(x.u) == entry.uid and tonumber(x.t) == entry.t and tostring(x.n):sub(1, 40) == entry.name then hit = x break end
end
if hit then
hit.an, hit.anb = an, anb
if L.bWrite(url, d) then
notify("Admin note", an and "Saved, everyone sees it" or "Removed", nil, 3)
L.commBusy = false
L.commPull()
if L.ping then L.ping("board") end
return
end
end
notify("Couldn't save note", tostring(L.boardErr or "script not found on the board"), nil, 4)
end)
end
else
syncAdmin()
notify("Admin note", an and "Saved" or "Removed", nil, 3)
end
renderPage(ADD_PAGE)
end
-- owner / admin only: message the player who shared a script (arrives in their Messages)
function L.sendScriptMsg(entry, msg)
if not adminOk() then return end
msg = (msg or ""):gsub("%c", " "):match("^%s*(.-)%s*$"):sub(1, 300)
if msg == "" then return notify("Message", "Write the message first", nil, 2) end
local url = L.boardOf()
if not url then return notify("Message", "No board is set up yet", nil, 3) end
task.spawn(function()
local uid = tonumber(entry.uid)
local who = entry.by
if not uid and type(who) == "string" then
local ok, id = pcall(Players.GetUserIdFromNameAsync, Players, who)
uid = ok and tonumber(id) or nil
end
if not uid then return notify("Message", "Couldn't find who shared it", nil, 3) end
who = who or L.nameOf(tostring(uid)) or "player"
local id = tostring(os.time()) .. tostring(math.random(100, 999))
local sent = false
for _ = 1, 3 do
local d = L.bRead(url)
if d then
if type(d.dm) ~= "table" then d.dm = {} end
table.insert(d.dm, {id = id, u = tostring(uid), f = verName or LP.Name, s = entry.name:sub(1, 40), t = msg, ts = os.time()})
while #d.dm > 60 do table.remove(d.dm, 1) end
if L.bWrite(url, d) then sent = true break end
end
task.wait(0.4)
end
if sent then
table.insert(L.sent, {to = who, text = 'About "' .. entry.name:sub(1, 30) .. '": ' .. msg:sub(1, 200), at = os.date("%H:%M")})
notify("Message sent", "To " .. who .. ", they get it in their Messages", nil, 3)
if L.ping then L.ping("board") end
else
notify("Couldn't send", tostring(L.boardErr or "board not reachable"), nil, 4)
end
end)
end
function L.commPush(nm, code, desc, gameName, gameId, kinds)
local url = L.boardOf()
if not url then return false end
local e = {n = nm, c = code, d = (type(desc) == "string" and desc ~= "") and desc:sub(1, 300) or nil, u = tostring(LP.UserId), a = LP.Name, t = os.time(), tries = 1,
g = gameName, gi = gameId, k = kinds}
table.insert(L.pending, e)
renderPage(ADD_PAGE)
task.spawn(function()
e.busy = true
local ok = L.commWrite(e)
e.busy = false
if ok then
e.sent, e.sentAt = true, os.time()
notify("Shared", "Everyone can see it on Share script & Find script", nil, 3)
if L.ping then L.ping("board") end
L.commBusy = false
task.delay(0.6, function() L.commPull() end)
else
notify("Share pending", "Couldn't confirm it yet" .. (L.boardErr and (" (" .. L.boardErr .. ")") or "") .. ". It keeps retrying by itself", nil, 5)
end
end)
return true
end
function L.processHelp()
local mine, me = {}, tostring(LP.UserId)
for _, h in ipairs(L.helpList) do
if type(h) == "table" and type(h.id) == "string" and h.id:match("^%w+$") then
if isAdmin then
if not h.r and not L.helpAsked[h.id] then
L.helpAsked[h.id] = true
notify("❓ Help request", tostring(h.n):sub(1, 20) .. ": " .. tostring(h.t):sub(1, 60), nil, 5)
end
elseif tostring(h.u) == me and type(h.r) == "string" and h.r ~= "" then
local from = tostring(h.rn or "DuaKNo"):sub(1, 20)
local ok, tm = pcall(os.date, "%H:%M", tonumber(h.rt) or os.time())
mine[#mine + 1] = {text = h.r:sub(1, 300), from = from, at = ok and tm or ""}
if not (","  .. S.helpSeen .. ","):find("," .. h.id .. ",", 1, true) then
S.helpSeen = (S.helpSeen .. "," .. h.id):sub(-300)
scheduleSave()
notify("❓ Reply from " .. from, h.r:sub(1, 80), nil, 6)
end
end
end
end
L.helpReplies = mine
if L.inboxRender then L.inboxRender() end
if isAdmin and L.renderHelp then L.renderHelp() end
end
function L.sendHelp(msg)
local url = L.boardOf()
local hook = online.helpHook or online.remoteHelpHook
if not url and not hook then return notify("Help isn't set up", "Try again later", nil, 4) end
L.lastReq = os.clock()
task.spawn(function()
local sent = false
local id = tostring(os.time()) .. tostring(math.random(100, 999))
if url then
for _ = 1, 3 do
local d = L.bRead(url)
if d then
if type(d.help) ~= "table" then d.help = {} end
table.insert(d.help, {id = id, u = tostring(LP.UserId), n = LP.Name, t = msg:sub(1, 300), ts = os.time()})
while #d.help > 40 do table.remove(d.help, 1) end
if L.bWrite(url, d) then sent = true break end
end
task.wait(0.4)
end
end
if hook and httpReq then
local ok, res = pcall(httpReq, {
Url = hook, Method = "POST", Headers = {["Content-Type"] = "application/json"},
Body = HttpService:JSONEncode({username = "Dua's Library", allowed_mentions = {parse = {}}, content = "Help request from " .. LP.Name .. "\n```" .. msg:sub(1, 300):gsub("`", "'") .. "```"}),
})
if ok and type(res) == "table" and (tonumber(res.StatusCode) or 0) >= 200 and (tonumber(res.StatusCode) or 0) < 300 then sent = true end
end
if sent then
table.insert(L.sent, {text = "❓ " .. msg:sub(1, 300), at = os.date("%H:%M")})
notify("Help request sent", "The reply will show up in your Messages", nil, 4)
if L.ping then L.ping("board") end
else
L.lastReq = nil
notify("Couldn't send", "Try again in a moment", nil, 3)
end
end)
end
function L.helpEdit(id, fn)
local url = L.boardOf()
if not url then return end
task.spawn(function()
local d = L.bRead(url)
if not d or type(d.help) ~= "table" then return notify("Help", "Couldn't reach the board", nil, 3) end
for i, h in ipairs(d.help) do
if type(h) == "table" and h.id == id then fn(d.help, i, h) break end
end
if L.bWrite(url, d) then
L.commBusy = false
L.commPull()
if L.ping then L.ping("board") end
end
end)
end
function L.renderHelp()
local box = L.helpBox
if not box or not box.Parent then return end
for _, c in ipairs(box:GetChildren()) do
if not c:IsA("UIListLayout") then c:Destroy() end
end
local n = 0
for i = #L.helpList, 1, -1 do
local h = L.helpList[i]
if type(h) == "table" and type(h.t) == "string" and type(h.id) == "string" and h.id:match("^%w+$") then
n = n + 1
local row = new("Frame", {Size = U2(1, 0, 0, 112), BackgroundColor3 = L.P.card, BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = 20, LayoutOrder = n}, box)
round(row, 8)
text(row, {Position = UO(10, 4), Size = U2(1, -50, 0, 16), Text = "❓ " .. tostring(h.n):sub(1, 20) .. (h.r and "  replied" or ""), TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21})
text(row, {
Position = UO(10, 22), Size = U2(1, -20, 0, 42), Font = Enum.Font.Nunito, Text = h.t:sub(1, 300), TextSize = 12, TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextTransparency = 0.1, ZIndex = 21,
})
local rb = inputBox(row, 8, 74, 190, 28, "Reply to " .. tostring(h.n):sub(1, 16) .. "...", false, 21)
rb.Size = U2(1, -100, 0, 28)
local sb = button(row, 0, 0, 80, 28, "Reply", L.P.btn, 0, 21)
sb.AnchorPoint, sb.Position, sb.TextSize = V2(1, 0), U2(1, -8, 0, 74), 12
local xb = button(row, 0, 0, 24, 24, "X", Color3.fromRGB(150, 50, 50), 0.2, 21)
xb.AnchorPoint, xb.Position, xb.TextSize = V2(1, 0), U2(1, -8, 0, 6), 12
sb.MouseButton1Click:Connect(function()
if not adminOk() then return end
local r = rb.Text:match("^%s*(.-)%s*$")
if r == "" then return notify("Reply", "Type your reply first", nil, 2) end
rb.Text = ""
L.helpEdit(h.id, function(list, at, e) e.r, e.rn, e.rt = r:sub(1, 300), verName or LP.Name, os.time() end)
notify("Reply", "Sent to " .. tostring(h.n):sub(1, 20) .. ". They get it automatically", nil, 3)
end)
xb.MouseButton1Click:Connect(function()
if not adminOk() then return end
L.helpEdit(h.id, function(list, at) table.remove(list, at) end)
end)
end
end
if n == 0 then
text(box, {Size = U2(1, 0, 0, 24), Font = Enum.Font.Nunito, Text = "No help requests right now.", TextSize = 12, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20})
end
end
function L.commDelete(e)
local url = L.shareBoardOf() or L.boardOf()
if not url then return end
for i, p in ipairs(L.pending) do
if p.u == e.uid and p.t == e.t then table.remove(L.pending, i) break end
end
for i, x in ipairs(L.comm or {}) do if x == e then table.remove(L.comm, i) break end end
renderPage(ADD_PAGE)
task.spawn(function()
local d = L.bRead(url)
if not d or type(d.shared) ~= "table" then notify("Couldn't remove", tostring(L.boardErr or "can't reach the board"), nil, 4) return end
local removed = false
for i, x in ipairs(d.shared) do
if tostring(x.u) == e.uid and tonumber(x.t) == e.t and tostring(x.n):sub(1, 40) == e.name then table.remove(d.shared, i) removed = true break end
end
if not removed then L.commBusy = false; L.commPull() return end
if L.bWrite(url, d) then
L.commBusy = false
L.commPull()
if L.ping then L.ping("board") end
notify("Removed", e.name, nil, 2)
else
notify("Couldn't remove", tostring(L.boardErr or "write failed"), nil, 4)
L.commBusy = false
L.commPull()
end
end)
end
function L.commEdit(e, n)
local url = L.shareBoardOf() or L.boardOf()
if not url then return notify("Couldn't save", "The board isn't set up", nil, 4) end
local oldName = e.name
notify("Saving...", n.name, nil, 2)
task.spawn(function()
local d = L.bRead(url)
if not d or type(d.shared) ~= "table" then return notify("Couldn't save", tostring(L.boardErr or "can't reach the board"), nil, 4) end
local hit
for _, x in ipairs(d.shared) do
if tostring(x.u) == e.uid and tonumber(x.t) == e.t and tostring(x.n):sub(1, 40) == oldName then hit = x break end
end
if not hit then
L.commBusy = false
L.commPull()
return notify("Couldn't save", "That script is no longer on the board", nil, 4)
end
hit.n, hit.c, hit.d, hit.g, hit.gi, hit.k = n.name, n.code, n.desc, n.game, n.gid, n.kinds
if L.bWrite(url, d) then
L.favRetarget({name = oldName, code = e.code}, n)
L.commBusy = false
L.commPull()
if L.ping then L.ping("board") end
notify("Saved", n.name, nil, 2)
else
notify("Couldn't save", tostring(L.boardErr or "write failed"), nil, 4)
end
end)
end
function L.syncFavs()
if isAdmin then return end
local url = L.boardOf()
if not url or L.syncing then return end
local names = {}
for _, e in ipairs(L.favs) do if #names < 60 then names[#names + 1] = e.name:sub(1, 60) end end
local sig = table.concat(names, "\1")
if sig == S.favSig then return end
L.syncing = true
task.spawn(function()
local d = L.bRead(url)
local done = false
if d then
local uid = tostring(LP.UserId)
local codes, used = {}, 0
for _, e in ipairs(L.favs) do
if type(e.code) == "string" and #e.code <= 3000 and used + #e.code <= 30000 then codes[e.name:sub(1, 60)] = e.code; used = used + #e.code end
end
d.users[uid] = #names > 0 and {n = LP.Name, f = names, fc = codes, t = os.time()} or nil
local cnt, oldest, ot = 0, nil, math.huge
for k, u in pairs(d.users) do
cnt = cnt + 1
local t = type(u) == "table" and tonumber(u.t) or 0
if t < ot then oldest, ot = k, t end
end
if cnt > 300 and oldest and oldest ~= uid then d.users[oldest] = nil end
if L.bWrite(url, d) then S.favSig = sig; scheduleSave(); done = true end
end
L.syncing = false
if done then task.delay(1, L.syncFavs) end
end)
end
function L.applyRemovals()
if isAdmin then return end
local changed = false
for _, m in ipairs(online.remoteMsgs or {}) do
local id = tonumber(m.id) or 0
if m.rm and tonumber(m.to) == LP.UserId and id > S.rmDone then
for i = #L.favs, 1, -1 do
if L.favs[i].name:sub(1, 60) == m.rm then table.remove(L.favs, i); changed = true end
end
S.rmDone = math.max(S.rmDone, id)
scheduleSave()
end
end
if changed then
writeJson(FILE.FAVS, {list = L.favs})
for _, u in pairs(pageUI) do renderPage(u.current) end
L.syncFavs()
end
end
local top = new("Frame", {
Position = UO(10, 76), Size = U2(1, -20, 0, 90), BackgroundColor3 = L.P.card, BorderSizePixel = 0, ZIndex = 21,
}, pages[L.FAVP])
round(top, 8)
outline(top, 1.5, 0.5)
text(top, {Position = UO(10, 4), Size = U2(1, -20, 0, 16), Text = "Most favorited by players", TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22})
local topBody = text(top, {
Position = UO(10, 22), Size = U2(1, -20, 0, 64), Font = Enum.Font.Nunito, TextSize = 11, Text = "",
TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 22,
})
ui.top = top
local function paintTop()
local arr = L.topCache
if not L.boardOf() then topBody.Text = "Not set up yet."
elseif not arr then topBody.Text = "Loading..."
elseif #arr == 0 then topBody.Text = "Nobody has favorited anything yet."
else
local lines = {}
for i = 1, math.min(5, #arr) do lines[i] = i .. ".  " .. arr[i].n:sub(1, 34) .. "   (" .. arr[i].k .. " fav)" end
topBody.Text = table.concat(lines, "\n")
end
end
function L.refreshTop(force)
paintTop()
local url = L.boardOf()
if url and not L.topBusy and (force or os.time() - (L.topAt or 0) > 45) then
L.topBusy = true
task.spawn(function()
local d = L.bRead(url)
if d then L.topCache, L.boardCache = L.tally(d), d end
L.topAt, L.topBusy = os.time(), false
paintTop()
if ui.chk and ui.chk.Visible then L.buildCheck() end
end)
end
end
if isAdmin then
ui.chk = new("ScrollingFrame", {
Position = UO(0, 76), Size = U2(1, 0, 1, -76), BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false,
ScrollBarThickness = 3, ScrollBarImageColor3 = WHITE, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 20,
}, pages[L.FAVP])
new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, ui.chk)
new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 12)}, ui.chk)
local rm = overlay("RemoveFav", 70)
local rmCard = card(rm, 340, 176, 71)
L.cards[#L.cards + 1] = rmCard
local rmTitle = text(rmCard, {Position = UO(16, 10), Size = U2(1, -32, 0, 40), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 72})
text(rmCard, {Position = UO(16, 54), Size = UO(200, 14), Text = "WHY? (sent to the player as a message)", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 72})
local rmBox = inputBox(rmCard, 16, 72, 308, 32, "Reason...", false, 72)
local rmGo = button(rmCard, 16, 124, 150, 34, "Remove + message", RED, 0.2, 72)
local rmNo = button(rmCard, 174, 124, 150, 34, "Cancel", WHITE, 0.85, 72)
local pend
rmNo.MouseButton1Click:Connect(function() rm.Visible, pend = false, nil end)
rmGo.MouseButton1Click:Connect(function()
if not pend or not adminOk() then return end
local reason = rmBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
if reason == "" then return notify("Reason needed", "Write why it is being removed") end
local p = pend
rm.Visible, pend = false, nil
task.spawn(function()
local url = L.boardOf()
local d = url and L.bRead(url)
if d then
local u = d.users[p.uid]
if type(u) == "table" and type(u.f) == "table" then
for i = #u.f, 1, -1 do if u.f[i] == p.fav then table.remove(u.f, i) end end
if #u.f == 0 then d.users[p.uid] = nil end
L.bWrite(url, d)
L.boardCache, L.topCache = d, L.tally(d)
end
end
table.insert(online.messages, {
id = nextId(), to = p.uid, from = verName or LP.Name,
text = ("Removed " .. p.fav .. ": " .. reason):sub(1, 140), rm = p.fav,
})
while #online.messages > 40 do table.remove(online.messages, 1) end
saveOnline()
if readToken() then publishNow(true) else notify("Not published", "Save a GitHub token so the player gets it", nil, 3) end
notify("Favorites", "Removed " .. p.fav .. " from " .. p.name, nil, 3)
L.buildCheck()
end)
end)
local function mk(class, props, parent) return new(class, props, parent) end
function L.buildCheck()
for _, c in ipairs(ui.chk:GetChildren()) do if c.Name == "Row" then c:Destroy() end end
local n = 0
local function row(h)
n = n + 1
return mk("Frame", {Name = "Row", LayoutOrder = n, Size = U2(1, 0, 0, h), BackgroundTransparency = 1, ZIndex = 21}, ui.chk)
end
local function head(t)
text(row(20), {Size = UDim2.fromScale(1, 1), Text = t, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22})
end
if not L.boardOf() then
text(row(48), {
Size = UDim2.fromScale(1, 1), Font = Enum.Font.Nunito, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 22,
Text = "No favorites board yet. Create it once: players' favorite script names then show up here, and everyone gets the top 5.",
})
local b = button(row(32), 0, 0, 200, 30, "Create favorites board", L.P.btn, 0, 22)
b.MouseButton1Click:Connect(function() L.makeBoard() end)
text(row(34), {
Size = UDim2.fromScale(1, 1), Font = Enum.Font.Nunito, TextSize = 11, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 22, TextTransparency = 0.3,
Text = "If that fails: open jsonblob.com, paste {\"v\":1,\"users\":{}} in the box, press Save, and paste the page link here.",
})
local lr = row(34)
local lb = inputBox(lr, 0, 2, 250, 30, "https://jsonblob.com/...", false, 22)
local ub = button(lr, 258, 2, 90, 30, "Use link", L.P.btn, 0, 22)
ub.MouseButton1Click:Connect(function() L.useBoard(lb.Text) end)
return
end
if not ui.chk:FindFirstChild("ChkSearch") then
local sr = mk("Frame", {Name = "ChkSearch", LayoutOrder = 0, Size = U2(1, 0, 0, 34), BackgroundTransparency = 1, ZIndex = 21}, ui.chk)
local sb = inputBox(sr, 0, 3, 330, 28, "Search player or script name...", false, 22)
local ver = 0
sb:GetPropertyChangedSignal("Text"):Connect(function()
ver = ver + 1
local my = ver
task.delay(0.25, function()
if my == ver then L.chkQuery = sb.Text; L.buildCheck() end
end)
end)
end
local d = L.boardCache
local b = button(row(30), 0, 0, 120, 26, "Refresh", WHITE, 0.85, 22)
b.MouseButton1Click:Connect(function() L.refreshTop(true) end)
if not d then head("Loading...") return end
head("Top 5 favorited")
local arr = L.tally(d)
if #arr == 0 then head("Nobody has favorited anything yet.") end
for i = 1, math.min(5, #arr) do
text(row(18), {Size = UDim2.fromScale(1, 1), Font = Enum.Font.Nunito, TextSize = 12, Text = i .. ".  " .. arr[i].n:sub(1, 40) .. "   (" .. arr[i].k .. " fav)", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22})
end
local q = tostring(L.chkQuery or ""):lower()
L.chkOpen = L.chkOpen or {}
local users = {}
for uid, u in pairs(d.users) do
if type(u) == "table" and type(u.f) == "table" and #u.f > 0 then users[#users + 1] = {uid = tostring(uid), u = u} end
end
table.sort(users, function(a, b) return (tonumber(a.u.t) or 0) > (tonumber(b.u.t) or 0) end)
local shown = {}
for _, e in ipairs(users) do
local pname = tostring(e.u.n or e.uid):sub(1, 24)
local nameHit = q ~= "" and pname:lower():find(q, 1, true) ~= nil
local favs = {}
for _, fav in ipairs(e.u.f) do
if type(fav) == "string" and (q == "" or nameHit or fav:lower():find(q, 1, true)) then favs[#favs + 1] = fav end
end
if #favs > 0 then shown[#shown + 1] = {e = e, pname = pname, favs = favs} end
end
head("Players' favorites (" .. (q == "" and tostring(#users) or (#shown .. " of " .. #users)) .. ")")
for i, sh in ipairs(shown) do
if i > 300 then break end
local e, pname = sh.e, sh.pname
local open = q ~= "" or L.chkOpen[e.uid] == true
local hr = row(22)
hr.BackgroundTransparency, hr.BackgroundColor3 = 0, L.P.card
round(hr, 6)
local hb = mk("TextButton", {
Position = UO(8, 0), Size = U2(1, -8, 1, 0), BackgroundTransparency = 1, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = (open and "[-]  " or "[+]  ") .. pname .. "  (" .. #e.u.f .. ")",
TextColor3 = WHITE, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22,
}, hr)
hb.MouseButton1Click:Connect(function()
L.chkOpen[e.uid] = not L.chkOpen[e.uid]
L.buildCheck()
end)
if open then
for _, fav in ipairs(sh.favs) do
local f = row(22)
f.BackgroundTransparency, f.BackgroundColor3 = 0, L.P.card
round(f, 6)
text(f, {Position = UO(14, 0), Size = U2(1, -124, 1, 0), Font = Enum.Font.Nunito, TextSize = 12, Text = fav, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22})
local fcode = type(e.u.fc) == "table" and type(e.u.fc[fav]) == "string" and e.u.fc[fav] or nil
if fcode then
local vw = mk("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -64, 0.5, 0), Size = UO(46, 18), BackgroundColor3 = L.P.ctrl,
BorderSizePixel = 0, AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 11, Text = "View", TextColor3 = WHITE, ZIndex = 23,
}, f)
round(vw, 5)
vw.MouseButton1Click:Connect(function() openViewer({name = fav, code = fcode}) end)
end
local x = mk("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -4, 0.5, 0), Size = UO(56, 18), BackgroundColor3 = RED, BackgroundTransparency = 0.2,
BorderSizePixel = 0, AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 11, Text = "Remove", TextColor3 = WHITE, ZIndex = 23,
}, f)
round(x, 5)
x.MouseButton1Click:Connect(function()
pend = {uid = e.uid, name = pname, fav = fav}
rmTitle.Text = 'Remove "' .. fav:sub(1, 40) .. '" from ' .. pname .. "'s favorites?"
rmBox.Text = ""
rm.Visible = true
end)
end
end
end
end
function L.refreshCheck() L.buildCheck(); L.refreshTop(true) end
function L.makeBoard()
if not adminOk() then return end
task.spawn(function()
local res = call("POST", "https://jsonblob.com/api/jsonBlob", '{"v":1,"users":{}}')
local id
for k, v in pairs(res and res.Headers or {}) do
local lk = tostring(k):lower()
if lk == "location" then id = tostring(v):match("[Jj]son[Bb]lob/([%w%-]+)") end
if not id and lk == "x-jsonblob" then id = tostring(v):match("^([%w%-]+)$") end
end
if not id then
local why = not res and "no response (does your executor allow requests?)" or ("HTTP " .. tostring(res.StatusCode) .. (res.Headers and "" or ", no headers"))
return notify("Couldn't create the board", why .. ". Use the link box below instead.", nil, 6)
end
L.useBoard(id)
end)
end
function L.useBoard(id)
id = tostring(id):match("jsonblob%.com/api/jsonBlob/([%w%-]+)") or tostring(id):match("jsonblob%.com/([%w%-]+)") or tostring(id):match("^([%w%-]+)$")
if not id or #id < 8 then return notify("Board link", "That doesn't look like a jsonblob link", nil, 3) end
online.board = "https://jsonblob.com/api/jsonBlob/" .. id
saveOnline()
if readToken() then publishNow(true) else notify("Board saved", "Save a GitHub token and publish so players use it", nil, 4) end
L.boardCache, L.topCache = {v = 1, users = {}}, {}
L.buildCheck()
end
end
renderPage(ui.current)
end
do
local SBP = "ScriptBlox scripts"
local host = pages[SBP]
local X = {order = 0, chipBtns = {}, page = 1, total = 1, q = "", token = 0, raw = {}, list = {}, hearts = {}, sort = 1, f = {}}
local API = "https://scriptblox.com/api/script/"
X.SORTS = {
{"Newest", "createdAt", nil}, {"Most views", "views", "views"}, {"Most likes", "likeCount", "likeCount"}, {"Updated", "updatedAt", "updatedAt"},
}
function X.get(url)
local ok, body = pcall(function() return game:HttpGet(url) end)
if ok and type(body) == "string" and body ~= "" then return body end
if httpReq then
local ok2, res = pcall(httpReq, {Url = url, Method = "GET"})
if ok2 and type(res) == "table" and type(res.Body) == "string" and (tonumber(res.StatusCode) or 200) < 400 then return res.Body end
end
end
function X.json(body)
local ok, d = pcall(function() return HttpService:JSONDecode(body or "") end)
return ok and type(d) == "table" and d or nil
end
X.LOADER = 'loadstring(game:GetService("HttpService"):JSONDecode(game:HttpGet("' .. API .. '%s")).script.script)()'
X.LOADER_PAT = '^loadstring%(game:GetService%("HttpService"%):JSONDecode%(game:HttpGet%("' .. API:gsub("%p", "%%%0") .. '([%w%-_%.]+)"%)%)%.script%.script%)%(%)$'
function X.ent(s, title)
local slug = type(s.slug) == "string" and s.slug:match("^[%w%-_%.]+$")
return {name = title, code = slug and X.LOADER:format(slug) or tostring(s.script or "")}
end
function L.sbFetch(slug, cb)
task.spawn(function()
local d = X.json(X.get(API .. HttpService:UrlEncode(slug)))
local r = d and d.script
local code = type(r) == "table" and r.script
if type(code) == "string" and code ~= "" then cb(code) else notify("ScriptBlox", "Couldn't get that script", nil, 3) end
end)
end
function L.sbSlug(code) return type(code) == "string" and code:match(X.LOADER_PAT) or nil end
local box = inputBox(host, 10, 46, 10, 26, "Search ScriptBlox (press Enter)...", false, 22)
box.Position, box.Size = UO(10, 46), U2(1, -20, 0, 26)
local chips = new("ScrollingFrame", {
Position = UO(10, 76), Size = U2(1, -20, 0, 26), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X, ZIndex = 21,
}, host)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, chips)
function X.paintChips()
for _, c in ipairs(X.chipBtns) do
local on = c.isOn()
c.b.BackgroundColor3 = on and themeBtn or L.P.ctrl
end
end
function X.chip(label, isOn, onClick)
X.order = X.order + 1
local b = new("TextButton", {
LayoutOrder = X.order, Size = UO(#label * 6 + 20, 24), BorderSizePixel = 0, AutoButtonColor = false, Text = label,
TextColor3 = WHITE, TextSize = 11, Font = Enum.Font.Nunito, ZIndex = 22,
}, chips)
round(b, 12)
X.chipBtns[#X.chipBtns + 1] = {b = b, isOn = isOn}
b.MouseButton1Click:Connect(function() onClick(); X.paintChips() end)
return b
end
function X.toggle(k, other)
return function() X.f[k] = not X.f[k]; if X.f[k] and other then X.f[other] = false end; X.reload() end
end
local sortBtn = X.chip("Sort: Newest", function() return X.sort ~= 1 end, function()
X.sort = X.sort % #X.SORTS + 1
X.reload()
end)
X.chip("Keyless", function() return X.f.keyless end, X.toggle("keyless", "key"))
X.chip("Key", function() return X.f.key end, X.toggle("key", "keyless"))
X.chip("Verified", function() return X.f.verified end, X.toggle("verified"))
X.chip("Universal", function() return X.f.universal end, X.toggle("universal"))
X.chip("No patched", function() return X.f.nopatch end, X.toggle("nopatch"))
local status = text(host, {
Position = UO(12, 104), Size = U2(1, -24, 0, 14), Font = Enum.Font.Nunito, TextSize = 11, TextTransparency = 0.35,
TextXAlignment = Enum.TextXAlignment.Left, Text = "", ZIndex = 21,
})
local grid = new("ScrollingFrame", {
Position = UO(0, 120), Size = U2(1, 0, 1, -154), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 3, ScrollBarImageColor3 = WHITE, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 20,
}, host)
L.grids[#L.grids + 1] = new("UIGridLayout", {
CellSize = U2(0.25, -11, 0, 100), CellPadding = UO(8, 8), SortOrder = Enum.SortOrder.LayoutOrder,
HorizontalAlignment = Enum.HorizontalAlignment.Left,
}, grid)
new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8)}, grid)
local prev = button(host, 0, 0, 84, 26, "< Prev", WHITE, 0.85, 22)
prev.AnchorPoint, prev.Position = V2(0, 1), U2(0, 10, 1, -6)
local nxt = button(host, 0, 0, 84, 26, "Next >", WHITE, 0.85, 22)
nxt.AnchorPoint, nxt.Position = V2(1, 1), U2(1, -10, 1, -6)
local pageLbl = text(host, {
AnchorPoint = V2(0.5, 1), Position = U2(0.5, 0, 1, -6), Size = UO(120, 26), Font = Enum.Font.Nunito, TextSize = 12, Text = "", ZIndex = 22,
})
function X.withCode(s, cb)
if type(s.script) == "string" and s.script ~= "" then return cb(s.script) end
local slug = type(s.slug) == "string" and s.slug
if slug then L.sbFetch(slug, cb) else notify("ScriptBlox", "Couldn't get that script", nil, 3) end
end
function X.short(n)
n = tonumber(n) or 0
return n >= 1000000 and string.format("%.1fM", n / 1000000) or (n >= 1000 and string.format("%.1fK", n / 1000) or tostring(n))
end
function X.gameOf(s)
local g = type(s.game) == "table" and tostring(s.game.name or "") or ""
if s.isUniversal or g == "" then return "Universal" end
return g
end
function X.view()
local f, out = X.f, {}
for _, s in ipairs(X.raw) do
local t = tostring(s.title or ""):lower()
local ok = true
if f.keyless and s.key then ok = false end
if f.key and not s.key then ok = false end
if f.verified and not s.verified then ok = false end
if f.universal and X.gameOf(s) ~= "Universal" then ok = false end
if f.nopatch and s.isPatched then ok = false end
if ok then out[#out + 1] = s end
end
local fld = X.SORTS[X.sort][3]
if fld then table.sort(out, function(a, b)
local x, y = a[fld], b[fld]
if type(x) == "number" and type(y) == "number" then return x > y end
return tostring(x or "") > tostring(y or "")
end) end
X.list = out
end
local function render()
for _, c in ipairs(grid:GetChildren()) do if c.Name == "SbTile" then c:Destroy() end end
X.hearts = {}
local st = L.cur()
for i, s in ipairs(X.list) do
if i > 30 then break end
local title = tostring(s.title or "Untitled")
local id = X.ent(s, title)
local tile = new("TextButton", {
Name = "SbTile", LayoutOrder = i, BackgroundColor3 = st.tile, BackgroundTransparency = 0,
BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 21,
})
round(tile, 10)
new("UIStroke", {Thickness = 1, Transparency = 0.2, Color = L.P.line, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, tile)
local tag = s.isPatched and "PATCHED" or (s.key and "KEY") or (s.verified and "VERIFIED") or "KEYLESS"
text(tile, {Position = UO(10, 5), Size = UO(60, 10), Text = tag, TextSize = 9, Font = Enum.Font.Nunito,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 0.2, ZIndex = 23})
text(tile, {Position = UO(10, 15), Size = U2(1, -34, 0, 12), Text = "" .. X.short(s.views), TextSize = 10, Font = Enum.Font.Nunito,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 0.15, ZIndex = 22})
local gm = X.gameOf(s)
text(tile, {Position = UO(10, 28), Size = U2(1, -16, 0, 12), Text = (gm == "Universal" and "" or "") .. gm, TextSize = 10, Font = Enum.Font.Nunito,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, TextColor3 = gm == "Universal" and Color3.fromRGB(150, 200, 255) or L.P.muted, ZIndex = 22})
local heart = new("TextButton", {
AnchorPoint = V2(1, 0), Position = U2(1, -4, 0, 5), Size = UO(22, 20), BackgroundTransparency = 1,
BorderSizePixel = 0, AutoButtonColor = false, TextSize = 19, ZIndex = 24,
Text = "\u{2665}",
}, tile)
L.paintHeart(heart, L.isFav(id))
X.hearts[#X.hearts + 1] = {h = heart, id = id}
if L.hasNote(id) then
text(tile, {Position = U2(1, -40, 0, 8), Size = UO(14, 14), Text = "", TextSize = 12, ZIndex = 24})
end
heart.MouseButton1Click:Connect(function() L.toggleFav(id) end)
local nm = text(tile, {
Position = UO(10, 42), Size = U2(1, -20, 0, 26), Text = title, TextSize = 12, TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 22,
})
fit(nm, 12, 8)
local run = new("TextButton", {
AnchorPoint = V2(0, 1), Position = U2(0, 8, 1, -7), Size = U2(0.5, -11, 0, 22),
BackgroundColor3 = L.P.btn, BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "Run", TextColor3 = WHITE, ZIndex = 23,
}, tile)
run.Size = U2(0.34, -6, 0, 22)
round(run, 6)
local viewB = new("TextButton", {
AnchorPoint = V2(0, 1), Position = U2(0.34, 4, 1, -7), Size = U2(0.34, -6, 0, 22),
BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "View", TextColor3 = WHITE, ZIndex = 23,
}, tile)
round(viewB, 6)
local chatB = new("TextButton", {
AnchorPoint = V2(0, 1), Position = U2(0.68, 4, 1, -7), Size = U2(0.32, -12, 0, 22),
BackgroundColor3 = L.P.info, BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "Chat", TextColor3 = WHITE, ZIndex = 23,
}, tile)
round(chatB, 6)
chatB.MouseButton1Click:Connect(function()
local function post(code)
if #code > 1500 then return notify("Too long", "That script is too big to link in the chat", nil, 3) end
if L.chat then L.chat.send("", {n = title:sub(1, 30), c = code}) end
notify("Global chat", "Linked " .. title:sub(1, 30) .. " in the chat", nil, 3)
end
if L.sbSlug(id.code) then post(id.code) else X.withCode(s, post) end
end)
run.MouseButton1Click:Connect(function()
askConfirm('Run "' .. title:sub(1, 40) .. '" from ScriptBlox? It was made by other people and is not checked. Tap View first if unsure.', function()
if L.sbSlug(id.code) then runScript({name = title, code = id.code}) else X.withCode(s, function(code) runScript({name = title, code = code}) end) end
end, "Run")
end)
viewB.MouseButton1Click:Connect(function() X.withCode(s, function(code) openViewer(id, code) end) end)
tile.Parent = grid
end
pageLbl.Text = X.page .. " / " .. X.total
prev.TextTransparency = X.page > 1 and 0 or 0.6
nxt.TextTransparency = X.page < X.total and 0 or 0.6
end
L.sbRerender = render
function L.sbHearts()
for _, e in ipairs(X.hearts) do
if e.h.Parent then L.paintHeart(e.h, L.isFav(e.id)) end
end
end
function X.load(pg)
X.token = X.token + 1
local my = X.token
status.Text = "Loading from scriptblox.com..."
task.spawn(function()
local f, q = X.f, {}
q[#q + 1] = "page=" .. pg
q[#q + 1] = "max=30"
if X.sort > 1 then q[#q + 1] = "sortBy=" .. X.SORTS[X.sort][2] .. "&order=desc" end
if f.keyless then q[#q + 1] = "key=0" elseif f.key then q[#q + 1] = "key=1" end
if f.verified then q[#q + 1] = "verified=1" end
if f.universal then q[#q + 1] = "universal=1" end
if f.nopatch then q[#q + 1] = "patched=0" end
if X.q ~= "" then q[#q + 1] = "q=" .. HttpService:UrlEncode(X.q) end
local d = X.json(X.get(API .. (X.q ~= "" and "search?" or "fetch?") .. table.concat(q, "&")))
if my ~= X.token then return end
local r = d and d.result
if type(r) ~= "table" or type(r.scripts) ~= "table" then
status.Text = "Couldn't reach ScriptBlox. Check your connection and try again."
return
end
X.page, X.total, X.raw = pg, math.max(tonumber(r.totalPages) or 1, 1), r.scripts
X.view()
status.Text = (#X.list == 0 and "No results with these filters." or (#X.list .. " scripts. Live from scriptblox.com, not saved. Tap View before you run one."))
render()
grid.CanvasPosition = Vector2.new(0, 0)
end)
end
X.reload = function()
sortBtn.Text = "Sort: " .. X.SORTS[X.sort][1]
X.load(1)
end
prev.MouseButton1Click:Connect(function() if X.page > 1 then X.load(X.page - 1) end end)
nxt.MouseButton1Click:Connect(function() if X.page < X.total then X.load(X.page + 1) end end)
box.FocusLost:Connect(function()
local q = box.Text:gsub("^%s+", ""):gsub("%s+$", "")
if q ~= X.q then X.q = q; X.load(1) end
end)
X.started = false
host:GetPropertyChangedSignal("Visible"):Connect(function()
if host.Visible and not X.started then X.started = true; X.load(1)
elseif host.Visible and L.sbDirty then L.sbDirty = false; render() end
end)
end
do
local function withHost(name, fn)
local host = new("ScrollingFrame", {
Name = name .. "Body", Position = UO(0, 46), Size = U2(1, 0, 1, -46), BackgroundTransparency = 1,
BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = WHITE, ZIndex = 20,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, pages[name])
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, host)
new("UIPadding", {
PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 12),
}, host)
local keep = sPage
sPage = host
fn()
sPage = keep
end
local function note(head, body, h)
sectionHeader(head)
text(sPage, {
Size = U2(1, 0, 0, h), Text = body, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top, TextTransparency = 0.1, ZIndex = 20, LayoutOrder = nextOrder(),
})
end
withHost("Workshop", function()
local H = sPage
L.hist, L.coll = {}, {}
do
local d = readJson("DuaLibrary_History.json")
for _, x in ipairs(d and type(d.h) == "table" and d.h or {}) do
if type(x) == "table" and type(x.name) == "string" and type(x.code) == "string" and #L.hist < 20 then L.hist[#L.hist + 1] = {name = x.name:sub(1, 40), code = x.code, t = tonumber(x.t) or 0} end
end
d = readJson("DuaLibrary_Collection.json")
for _, x in ipairs(d and type(d.c) == "table" and d.c or {}) do
if type(x) == "table" and type(x.name) == "string" and type(x.code) == "string" and #L.coll < 200 then L.coll[#L.coll + 1] = {name = x.name:sub(1, 40), code = x.code, tag = type(x.tag) == "string" and x.tag:sub(1, 20) or ""} end
end
end
local saveH = debounce(1, function() writeJson("DuaLibrary_History.json", {h = L.hist}) end)
local saveC = debounce(0.5, function() writeJson("DuaLibrary_Collection.json", {c = L.coll}) end)
local function ago(t)
local d = os.time() - (t or 0)
if d < 60 then return "just now" end
if d < 3600 then return math.floor(d / 60) .. " min ago" end
if d < 86400 then return math.floor(d / 3600) .. " h ago" end
return math.floor(d / 86400) .. " d ago"
end
local function holder()
local f = new("Frame", {Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, ZIndex = 20, LayoutOrder = nextOrder()}, H)
new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, f)
return f
end
local function strip(parent, order, h)
local f = new("Frame", {Size = U2(1, 0, 0, h), BackgroundTransparency = 1, ZIndex = 21, LayoutOrder = order or nextOrder()}, parent)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, f)
return f
end
local function fillStrip(f, items)
local n = #items
for i, it in ipairs(items) do
local b = it[1]
b.Parent, b.LayoutOrder = f, i
b.Size = U2(it[2] or (1 / n), -4 * (n - 1) / n, 1, 0)
end
end
local function sbtn(label, color, cb)
local b = button(H, 0, 0, 10, 24, label, color, 0, 23)
fit(b, 11, 7)
b.MouseButton1Click:Connect(cb)
return b
end
local function row(parent, order, title, sub, tagTxt, buttons)
local r = new("Frame", {Size = U2(1, 0, 0, 64), BackgroundColor3 = L.P.card, BorderSizePixel = 0, ZIndex = 21, LayoutOrder = order}, parent)
round(r, 8)
text(r, {Position = UO(10, 5), Size = U2(1, -20, 0, 16), Text = title, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22})
local sub2 = new("TextLabel", {Position = UO(10, 21), Size = U2(1, -20, 0, 12), BackgroundTransparency = 1, Font = Enum.Font.Nunito, Text = sub, TextSize = 10, TextColor3 = L.P.muted,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22}, r)
if tagTxt then sub2.Text = sub .. "   " .. tagTxt end
local bf = strip(r, 1, 24)
bf.Position = UO(8, 35)
bf.Size = U2(1, -16, 0, 24)
local items = {}
for _, bt in ipairs(buttons) do
local b = button(bf, 0, 0, 10, 24, bt[1], bt[2], 0, 23)
fit(b, 11, 7)
b.MouseButton1Click:Connect(bt[3])
items[#items + 1] = {b}
end
fillStrip(bf, items)
end
local ed
local function load(code, name)
ed.Text = code
L.wsName = name
L.wsNameBox.Text = name or ""
notify("Editor", "Loaded into the editor below", nil, 2)
end
local function health(code)
local h = L.health[L.hkey(code)]
return h and (h.ok and "Ran OK" or "Failed") or nil
end

sectionHeader("Toolbox")
do
local tools = {
{"Dex++", "https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"},
{"Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
}
local f = strip(H, nextOrder(), 30)
local items = {}
for _, t in ipairs(tools) do
local b = sbtn("Load " .. t[1], L.P.btn, function()
runScript({name = t[1], code = 'loadstring(game:HttpGet("' .. t[2] .. '"))()'})
end)
b.Size = U2(0.5, -2, 1, 0)
items[#items + 1] = {b}
end
fillStrip(f, items)
local cf = strip(H, nextOrder(), 30)
local cb = inputBox(cf, 0, 0, 10, 30, "Any other tool: paste a link (raw script)", false, 21)
local cgo = sbtn("Load", L.P.ctrl, function()
local u = cb.Text:match("^%s*(.-)%s*$")
if not u:find("^https?://%S+$") then return notify("Toolbox", "Paste a direct link to a script", nil, 3) end
runScript({name = "Custom tool", code = ("loadstring(game:HttpGet(%q))()"):format(u)})
end)
cb.Parent, cgo.Parent = cf, cf
cb.Size, cgo.Size = U2(0.75, -2, 1, 0), U2(0.25, -2, 1, 0)
cb.LayoutOrder, cgo.LayoutOrder = 1, 2
end

sectionHeader("Script editor")
ed = inputBox(H, 0, 0, 10, 120, "Write or paste a script here, then press Run.", true, 21)
ed.Size, ed.LayoutOrder = U2(1, 0, 0, 120), nextOrder()
local ctl = strip(H, nextOrder(), 28)
fillStrip(ctl, {
{sbtn("Run", L.P.btn, function()
local c = ed.Text
if c:match("^%s*$") then return notify("Editor", "Write a script first", nil, 2) end
runScript({name = (L.wsName and L.wsName ~= "") and L.wsName or "Editor script", code = c})
end)},
{sbtn("Clear", L.P.ctrl, function() ed.Text = ""; L.wsName = nil; L.wsNameBox.Text = "" end)},
{sbtn("Copy", L.P.ctrl, function()
if typeof(setclipboard) == "function" then setclipboard(ed.Text); notify("Copied", "Editor text", nil, 2) else notify("Can't copy", "No clipboard in this executor", nil, 3) end
end)},
})
local sf = strip(H, nextOrder(), 28)
local nb = inputBox(sf, 0, 0, 10, 28, "Name", false, 21)
local tb = inputBox(sf, 0, 0, 10, 28, "Folder / tag", false, 21)
L.wsNameBox = nb
nb.Parent, tb.Parent = sf, sf
nb.Size, tb.Size = U2(0.38, -3, 1, 0), U2(0.3, -3, 1, 0)
nb.LayoutOrder, tb.LayoutOrder = 1, 2
local saveBtn = sbtn("Save to collection", L.P.btn, function()
local c, nm = ed.Text, nb.Text:match("^%s*(.-)%s*$"):sub(1, 40)
if c:match("^%s*$") then return notify("Collection", "The editor is empty", nil, 2) end
if nm == "" then return notify("Collection", "Give it a name first", nil, 2) end
local k = L.ckey(c)
for _, x in ipairs(L.coll) do
if L.ckey(x.code) == k then return notify("Already in your collection", 'Same code as "' .. x.name .. '"', nil, 4) end
end
table.insert(L.coll, {name = nm, code = c, tag = tb.Text:match("^%s*(.-)%s*$"):sub(1, 20)})
saveC()
L.wsRender()
notify("Collection", "Saved " .. nm, nil, 2)
end)
saveBtn.Parent, saveBtn.Size, saveBtn.LayoutOrder = sf, U2(0.32, 0, 1, 0), 3

sectionHeader("My collection")
local collSearch = inputBox(H, 0, 0, 10, 26, "Search by name or folder...", false, 21)
collSearch.Size, collSearch.LayoutOrder = U2(1, 0, 0, 26), nextOrder()
local collBox = holder()
sectionHeader("Recent")
local histBox = holder()

function L.wsRender()
for _, c in ipairs(collBox:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
for _, c in ipairs(histBox:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
local q = collSearch.Text:lower()
local list = {}
for _, x in ipairs(L.coll) do
if q == "" or (x.name .. " " .. x.tag):lower():find(q, 1, true) then list[#list + 1] = x end
end
table.sort(list, function(a, b)
if a.tag ~= b.tag then return a.tag:lower() < b.tag:lower() end
return a.name:lower() < b.name:lower()
end)
if #list == 0 then
local e = new("Frame", {Size = U2(1, 0, 0, 24), BackgroundTransparency = 1, LayoutOrder = 1, ZIndex = 21}, collBox)
text(e, {Size = U2(1, 0, 1, 0), Text = #L.coll == 0 and "Nothing saved yet. Write a script above and press Save to collection." or "No match.", TextSize = 11, TextColor3 = L.P.muted, ZIndex = 22})
end
for i, x in ipairs(list) do
row(collBox, i, x.name, (x.tag ~= "" and x.tag or "No folder"), health(x.code), {
{"Run", L.P.btn, function() runScript(x) end},
{"Edit", L.P.ctrl, function() load(x.code, x.name) end},
{"Delete", L.P.ctrl, function()
askConfirm('Remove "' .. x.name .. '" from your collection?', function()
local at = table.find(L.coll, x)
if at then table.remove(L.coll, at); saveC(); L.wsRender() end
end)
end},
})
end
if #L.hist == 0 then
local e = new("Frame", {Size = U2(1, 0, 0, 24), BackgroundTransparency = 1, LayoutOrder = 1, ZIndex = 21}, histBox)
text(e, {Size = U2(1, 0, 1, 0), Text = "Scripts you run will show up here.", TextSize = 11, TextColor3 = L.P.muted, ZIndex = 22})
end
for i, x in ipairs(L.hist) do
row(histBox, i, x.name, ago(x.t), health(x.code), {
{"Run again", L.P.btn, function() runScript(x) end},
{"Edit", L.P.ctrl, function() load(x.code, x.name) end},
{"Save", L.P.ctrl, function()
local k = L.ckey(x.code)
for _, c in ipairs(L.coll) do
if L.ckey(c.code) == k then return notify("Already in your collection", 'Same code as "' .. c.name .. '"', nil, 4) end
end
table.insert(L.coll, {name = x.name, code = x.code, tag = ""})
saveC(); L.wsRender()
notify("Collection", "Saved " .. x.name, nil, 2)
end},
})
end
end
collSearch:GetPropertyChangedSignal("Text"):Connect(L.wsRender)
function L.pushHist(entry)
if type(entry.code) ~= "string" or entry.code == "" then return end
local k = L.ckey(entry.code)
for i = #L.hist, 1, -1 do if L.ckey(L.hist[i].code) == k then table.remove(L.hist, i) end end
table.insert(L.hist, 1, {name = tostring(entry.name or "Script"):sub(1, 40), code = entry.code, t = os.time()})
while #L.hist > 20 do table.remove(L.hist) end
saveH()
if L.wsRender then L.wsRender() end
end
L.wsRender()
end)
withHost("Info", function()
note("Account check", "Account: " .. (verName or (LP.Name .. " (not verified)")) .. ".  Admin: " .. (isAdmin and "yes" or "no") .. ".  Online admin list: "
.. (online.remoteAdmins and (#online.remoteAdmins .. " names loaded") or (feedUrl == "" and "no online list set up" or "not loaded (offline, or not published yet)")) .. ".", 48)
note("Discord", "Join the community: discord.gg/empgqd5qpq. Tap the button at the top of the window to copy the link.", 34)
wideButton("Copy Discord link", Color3.fromRGB(88, 101, 242), 0).MouseButton1Click:Connect(function() L.copyDiscord() end)
note("About", "Dua's Library is made by DuaKNo. It's a script hub: tap a tile to run a script. Everything runs in your own executor, on your own device.", 34)
note("Dua's script", "Scripts picked by DuaKNo, sorted in tabs at the top: Dua's favorites, NPCs, Weapons and Utility. Tap View script on a tile to read the code or copy it before you run it.", 48)
note("Share script & Find script", "Add your own scripts with the + tile. Paste code or a link (pastebin links turn into loadstring by themselves). With Share globally on (the default), they are posted for every player, with your name on them. You can remove your own, admins can remove any. Scripts from players are not checked, so only run ones you trust. Off = only this device.", 78)
note("ScriptBlox scripts", "Browse scripts from scriptblox.com live, 30 per page, with views, hearts, Prev / Next and a search bar. They are loaded when you open the page and are never saved on your device. Always tap View first: these scripts are made by other people.", 62)
note("Favorited", "Tap the heart on any script. Favorite = yours only, saved on this device (it also shows the 5 most favorited scripts), but DuaKNo can see the names of what players favorite and can remove inappropriate ones. Favorited by Dua = the scripts DuaKNo hearted, everyone sees them.", 48)
note("Inbox and requests", "Tap the envelope at the top right. Notifications keeps a list of what happened (scripts you ran, favorites). Messages lets you request a script from DuaKNo and shows replies to you.", 48)
note("Online scripts", "Scripts DuaKNo publishes show up for everyone on their own, nothing to set up. Settings > Refresh online scripts updates right away, and announcements from DuaKNo pop up once as a notification.", 48)
note("Sharing the library", "To give it to a friend, send them your copy of DuasLibraryUI.lua. It already contains the shared scripts. Never share a GitHub token: it stays only on your device.", 48)
note("Notes and shortcuts", "Tap View on any script, then Note, to write yourself a note (saved on this device, a shows on the tile). Press Right Ctrl to hide or show this window.", 48)
note("Staying safe", "Only run scripts you trust and read them with View script first. Admin tools only unlock for the real DuaKNo and Saifb90 accounts; renaming yourself in an explorer does nothing.", 48)
note("Follow", "Instagram: Me_DuaKNo", 18)
wideButton("Copy Instagram name", WHITE, 0.8).MouseButton1Click:Connect(function()
if typeof(setclipboard) == "function" then setclipboard("Me_DuaKNo") notify("Copied", "Me_DuaKNo") end
end)
end)
local DEF = {walkSpeed = 16, jumpPower = 50, gravity = 196.2, fov = 70}
local on = false
for k, v in pairs(DEF) do if S[k] ~= v then on = true end end
local function hum() local c = LP.Character return c and c:FindFirstChildOfClass("Humanoid") end
local flyBV, flyBG
local function stopFly()
if flyBV then flyBV:Destroy() flyBV = nil end
if flyBG then flyBG:Destroy() flyBG = nil end
local h = hum()
if h then h.PlatformStand = false end
end
local function apply(fromUi)
if fromUi then on = true end
if not on then return end
local h = hum()
if h then
h.WalkSpeed = S.walkSpeed
h.UseJumpPower = true
h.JumpPower = S.jumpPower
end
workspace.Gravity = S.gravity
if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = S.fov end
if not S.fly then stopFly() end
end
local function ui() apply(true) end
local function ival(v) return string.format("%d", math.floor(v + 0.5)) end
withHost("Universal", function()
sectionHeader("Movement")
sliderRow("Walk speed", "walkSpeed", 0, 300, ival, ui, 1)
sliderRow("Jump power", "jumpPower", 0, 300, ival, ui, 1)
sliderRow("Gravity", "gravity", 0, 400, ival, ui, 1)
sliderRow("Field of view", "fov", 30, 120, ival, ui, 1)
sectionHeader("Abilities")
toggleRow("Infinite jump", "infJump", nop)
toggleRow("Noclip", "noclip", nop)
toggleRow("Fly", "fly", ui)
sliderRow("Fly speed", "flySpeed", 10, 300, ival, nop, 1)
sectionHeader("World")
toggleRow("Fullbright", "fullbright", nop)
toggleRow("No fog", "noFog", nop)
sliderRow("Time of day", "clockTime", 0, 24, ival, function() L.setClock() end, 1)
sectionHeader("Players")
toggleRow("Player ESP (outline)", "esp", nop)
toggleRow("Anti-AFK", "antiAfk", nop)
sliderRow("Max camera zoom", "maxZoom", 10, 1000, ival, function() pcall(function() LP.CameraMaxZoomDistance = S.maxZoom end) end, 1)
do
local row = new("Frame", {Size = U2(1, 0, 0, 34), BackgroundColor3 = L.P.card, BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
round(row, 8)
local box = inputBox(row, 6, 4, 190, 26, "Teleport to player (name)", false, 21)
box.Size = U2(1, -100, 0, 26)
local go = button(row, 0, 0, 80, 26, "Go", WHITE, 0.6, 21)
go.AnchorPoint, go.Position, go.TextSize = V2(1, 0.5), U2(1, -6, 0.5, 0), 12
go.MouseButton1Click:Connect(function()
local nm = box.Text:lower():match("^%s*(.-)%s*$")
if nm == "" then return end
local mine = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
for _, p in ipairs(Players:GetPlayers()) do
if p ~= LP and (p.Name:lower():find(nm, 1, true) == 1 or p.DisplayName:lower():find(nm, 1, true) == 1) then
local theirs = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
if mine and theirs then
mine.CFrame = theirs.CFrame * CFrame.new(0, 0, 3)
return notify("Teleport", "Went to " .. p.DisplayName, nil, 2)
end
end
end
notify("Teleport", "No player found", nil, 2)
end)
end
sectionHeader("Character")
wideButton("Respawn at the same spot", WHITE, 0.85).MouseButton1Click:Connect(function()
local root, h = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart"), hum()
if not (root and h) then return end
local cf, conn = root.CFrame, nil
conn = LP.CharacterAdded:Connect(function(c)
conn:Disconnect()
local r = c:WaitForChild("HumanoidRootPart", 5)
if r then task.wait(0.2) r.CFrame = cf end
end)
h.Health = 0
end)
wideButton("Copy my position", WHITE, 0.85).MouseButton1Click:Connect(function()
local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
if root and typeof(setclipboard) == "function" then
local p = root.Position
setclipboard(string.format("%.1f, %.1f, %.1f", p.X, p.Y, p.Z))
notify("Copied", "Your position", nil, 2)
end
end)
wideButton("Copy place ID / job ID", WHITE, 0.85).MouseButton1Click:Connect(function()
if typeof(setclipboard) == "function" then
setclipboard("PlaceId " .. game.PlaceId .. "  JobId " .. game.JobId)
notify("Copied", "Place and server ID", nil, 2)
end
end)
wideButton("Server hop", L.P.btn, 0.4).MouseButton1Click:Connect(function()
task.spawn(function()
local pick = {}
pcall(function()
local body = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
for _, sv in ipairs(HttpService:JSONDecode(body).data) do
if sv.id ~= game.JobId and sv.playing < sv.maxPlayers then pick[#pick + 1] = sv.id end
end
end)
if #pick == 0 then return notify("Server hop", "No other server found", nil, 3) end
notify("Server hop", "Joining another server...", nil, 2)
pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, pick[math.random(#pick)], LP) end)
end)
end)
wideButton("Reset movement values", WHITE, 0.8).MouseButton1Click:Connect(function()
for k, v in pairs(DEF) do S[k] = v end
apply(true)
for _, r in ipairs(refreshers) do r() end
scheduleSave()
end)
wideButton("Reset character", WHITE, 0.85).MouseButton1Click:Connect(function()
local h = hum()
if h then h.Health = 0 end
end)
wideButton("Rejoin server", RED, 0.55).MouseButton1Click:Connect(function()
pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end)
end)
end)
local function live(signal, fn)
local c
c = signal:Connect(function(...)
if not sg.Parent then c:Disconnect() stopFly() return end
fn(...)
end)
end
task.spawn(function()
while sg.Parent do
apply(false)
task.wait(0.25)
end
end)
live(UIS.JumpRequest, function()
if S.infJump then
local h = hum()
if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end
end)
live(RunService.Stepped, function()
if S.noclip and LP.Character then
for _, d in ipairs(LP.Character:GetDescendants()) do
if d:IsA("BasePart") then d.CanCollide = false end
end
end
end)
live(RunService.Heartbeat, function()
if not S.fly then return end
local h, c, cam = hum(), LP.Character, workspace.CurrentCamera
local root = c and c:FindFirstChild("HumanoidRootPart")
if not (h and root and cam) then return end
if not flyBV then
flyBV = Instance.new("BodyVelocity")
flyBV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
flyBV.Parent = root
flyBG = Instance.new("BodyGyro")
flyBG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
flyBG.P = 9000
flyBG.Parent = root
end
h.PlatformStand = true
local dir, look = h.MoveDirection, cam.CFrame.LookVector
local flat = Vector3.new(look.X, 0, look.Z)
local up = 0
if dir.Magnitude > 0 and flat.Magnitude > 0 then up = look.Y * dir:Dot(flat.Unit) end
flyBV.Velocity = (dir + Vector3.new(0, up, 0)) * S.flySpeed
flyBG.CFrame = cam.CFrame
end)
end
do
local Lighting = game:GetService("Lighting")
local saved
local function restore()
if saved then
for k, v in pairs(saved) do pcall(function() Lighting[k] = v end) end
saved = nil
end
end
local function clearEsp()
for _, p in ipairs(Players:GetPlayers()) do
local h = p.Character and p.Character:FindFirstChild("DuaESP")
if h then h:Destroy() end
end
end
function L.setClock() pcall(function() Lighting.ClockTime = S.clockTime end) end
local espWas = false
task.spawn(function()
while sg.Parent do
if S.fullbright or S.noFog then
if not saved then
saved = {
Brightness = Lighting.Brightness, GlobalShadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd,
Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
}
end
pcall(function()
if S.fullbright then
Lighting.Brightness, Lighting.GlobalShadows = 2, false
Lighting.Ambient, Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178), Color3.fromRGB(178, 178, 178)
end
if S.noFog then Lighting.FogEnd = 1e9 end
end)
else
restore()
end
if S.esp then
espWas = true
for _, p in ipairs(Players:GetPlayers()) do
local c = p.Character
if p ~= LP and c and not c:FindFirstChild("DuaESP") then
pcall(function()
local h = Instance.new("Highlight")
h.Name, h.FillColor, h.FillTransparency, h.OutlineColor = "DuaESP", Color3.fromRGB(190, 140, 255), 0.6, WHITE
h.Parent = c
end)
end
end
elseif espWas then
espWas = false
clearEsp()
end
task.wait(0.5)
end
restore()
clearEsp()
end)
pcall(function()
local vu = game:GetService("VirtualUser")
LP.Idled:Connect(function()
if S.antiAfk and sg.Parent then
vu:CaptureController()
vu:ClickButton2(Vector2.new())
end
end)
end)
if S.maxZoom ~= 128 then pcall(function() LP.CameraMaxZoomDistance = S.maxZoom end) end
end
function L.relayout()
local w = content.AbsoluteSize.X
if type(w) ~= "number" or w <= 0 then return end
local cols = math.clamp(math.floor((w - 20) / 80), 2, 4)
for i = #L.grids, 1, -1 do
local g = L.grids[i]
if g.Parent then
local c = cols
if L.listGrids[g] then c = (w >= 800) and 2 or 1 end
g.CellSize = U2(1 / c, -(c * 8 + 12) / c, 0, L.cellH[g] or 100)
else table.remove(L.grids, i) end
end
end
content:GetPropertyChangedSignal("AbsoluteSize"):Connect(L.relayout)
content:GetPropertyChangedSignal("AbsoluteSize"):Connect(L.fitAll)
L.relayout()
L.fitAll()
function L.clampPos(pos)
local vp, ab = sg.AbsoluteSize, win.AbsoluteSize
if vp.X <= 0 or vp.Y <= 0 or ab.X <= 0 then return pos end
local cx = pos.X.Scale * vp.X + pos.X.Offset
local cy = pos.Y.Scale * vp.Y + pos.Y.Offset
local hw, hh = ab.X / 2, ab.Y / 2
local nx = (hw * 2 >= vp.X) and vp.X / 2 or math.clamp(cx, hw, vp.X - hw)
local ny = (hh * 2 >= vp.Y) and vp.Y / 2 or math.clamp(cy, hh, vp.Y - hh)
return U2(pos.X.Scale, pos.X.Offset + (nx - cx), pos.Y.Scale, pos.Y.Offset + (ny - cy))
end
do
local winTw
local function playWin(props, info, done)
if winTw then winTw:Cancel() end
local tw = TweenService:Create(win, info, props)
winTw = tw
tw.Completed:Connect(function(st) if st == Enum.PlaybackState.Completed and done then done() end end)
tw:Play()
end
function L.snapWin()
if winTw then winTw:Cancel(); winTw = nil end
if L.winHome then win.Position = L.winHome; L.winHome = nil end
L.winTok = (L.winTok or 0) + 1
end
function L.clampWin(animate)
local p = L.clampPos(win.Position)
if p == win.Position then return end
if animate then playWin({Position = p}, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)) else win.Position = p end
end
function L.showWin()
L.snapWin()
local tok = L.winTok
local home = L.clampPos(win.Position)
L.winHome = home
win.Position = home + UO(0, 20)
sg.Enabled = true
playWin({Position = home}, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), function()
if L.winTok == tok then L.winHome = nil end
end)
if L.launcherSync then L.launcherSync() end
end
function L.hideWin()
if not sg.Enabled then return end
L.snapWin()
local tok = L.winTok
local home = win.Position
L.winHome = home
playWin({Position = home + UO(0, 14)}, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), function()
if L.winTok ~= tok then return end
sg.Enabled = false
win.Position = home
L.winHome = nil
if L.launcherSync then L.launcherSync() end
end)
end
function L.toggleWin(force)
local want = force
if want == nil then want = not sg.Enabled end
if want then
if sg.Enabled and minimized then L.setMinimized(false) elseif not sg.Enabled then L.showWin() else L.clampWin(true) end
else
L.hideWin()
end
end
function L.resetPos()
L.snapWin()
if minimized then L.setMinimized(false) end
L.setSize(S.winW, S.winH)
win.Position = U2(0.5, 0, 0.5, 0)
sg.Enabled = false
L.showWin()
S.launcher, S.launX, S.launY = true, 0.97, 0.5
if L.applyLauncher then L.applyLauncher(true) end
scheduleSave()
notify("Position reset", "The hub is back in the center of the screen", nil, 3)
end
end
-- floating launcher: lives in its own ScreenGui so it survives closing the hub window
do
local old = findGui("DuaKNoLauncher")
if old then pcall(function() old:Destroy() end) end
local tg = new("ScreenGui", {Name = "DuaKNoLauncher", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 30})
mountGui(tg)
sg.Destroying:Connect(function() pcall(function() tg:Destroy() end) end)
local lb = new("TextButton", {
Name = "Launcher", AnchorPoint = V2(0.5, 0.5), Size = UO(40, 40), BackgroundColor3 = L.P.card, BorderSizePixel = 0,
AutoButtonColor = false, Text = "", ZIndex = 5,
}, tg)
round(lb, 10)
local lst = outline(lb, 1.25, 0.2)
local lImg = new("ImageLabel", {AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UO(26, 26), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, ImageTransparency = 1, ZIndex = 6}, lb)
local lTxt = text(lb, {Size = UDim2.fromScale(1, 1), Text = "D", TextSize = 18, ZIndex = 6})
L.press(lb, 0.92)
task.spawn(function()
local t0 = os.clock()
while os.clock() - t0 < 20 and lb.Parent do
if L.iconOK and L.miniImg.Image ~= "" then
lImg.Image = L.miniImg.Image
lImg.ImageTransparency = 0
lTxt.Visible = false
return
end
task.wait(0.5)
end
end)
local function place(animate)
local vp = tg.AbsoluteSize
if vp.X <= 0 or vp.Y <= 0 then return end
local x = math.clamp(math.clamp(S.launX, 0, 1) * vp.X, 24, math.max(24, vp.X - 24))
local y = math.clamp(math.clamp(S.launY, 0, 1) * vp.Y, 24, math.max(24, vp.Y - 24))
if animate then tween(lb, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UO(x, y)}) else lb.Position = UO(x, y) end
end
function L.launcherSync()
local open = sg.Enabled
tween(lb, FAST, {BackgroundTransparency = open and 0.45 or 0})
tween(lst, FAST, {Transparency = open and 0.5 or 0.1})
end
function L.applyLauncher(animate)
tg.Enabled = S.launcher
place(animate)
L.launcherSync()
end
local down, moved, startPos, startAbs, mv, tok = false, false, nil, nil, nil, 0
lb.MouseEnter:Connect(function() tween(lst, FAST, {Transparency = 0}) end)
lb.MouseLeave:Connect(function() L.launcherSync() end)
lb.InputBegan:Connect(function(i)
local t = i.UserInputType
if t == Enum.UserInputType.MouseButton2 then L.resetPos() return end
if t ~= Enum.UserInputType.MouseButton1 and t ~= Enum.UserInputType.Touch then return end
down, moved = true, false
tok = tok + 1
local my = tok
startPos = i.Position
startAbs = lb.AbsolutePosition + lb.AbsoluteSize / 2
if mv then mv:Disconnect() end
mv = UIS.InputChanged:Connect(function(i2)
if not down then return end
if i2.UserInputType ~= Enum.UserInputType.MouseMovement and i2.UserInputType ~= Enum.UserInputType.Touch then return end
local d = i2.Position - startPos
if not moved and (math.abs(d.X) > 6 or math.abs(d.Y) > 6) then moved = true end
if moved then
local vp = tg.AbsoluteSize
lb.Position = UO(math.clamp(startAbs.X + d.X, 24, math.max(24, vp.X - 24)), math.clamp(startAbs.Y + d.Y, 24, math.max(24, vp.Y - 24)))
end
end)
task.delay(0.8, function()
if down and not moved and tok == my then
down = false
L.resetPos()
end
end)
i.Changed:Connect(function()
if i.UserInputState ~= Enum.UserInputState.End or not down then return end
down = false
if mv then mv:Disconnect() mv = nil end
local vp = tg.AbsoluteSize
if moved then
local c = lb.AbsolutePosition + lb.AbsoluteSize / 2
S.launX = (c.X < vp.X / 2 and 28 or vp.X - 28) / math.max(vp.X, 1)
S.launY = c.Y / math.max(vp.Y, 1)
scheduleSave()
place(true)
else
L.toggleWin()
end
end)
end)
tg:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
place(false)
if L.clampWin then L.clampWin(true) end
end)
L.applyLauncher(false)
end
UIS.InputBegan:Connect(function(i, gp)
if not sg.Parent then return end
if L.listenKey then
if i.UserInputType == Enum.UserInputType.Keyboard then
local cb = L.listenKey
L.listenKey = nil
cb(i.KeyCode)
end
return
end
if gp then return end
if i.UserInputType == Enum.UserInputType.Keyboard and (i.KeyCode.Name == S.toggleKey or i.KeyCode == Enum.KeyCode.RightControl) then L.toggleWin() end
end)
-- loading bar for the network calls the hub makes
for _, k in ipairs({"sbFetch", "boardFetch", "commPull", "bRead", "bWrite"}) do
local f = L[k]
if type(f) == "function" then
L[k] = function(...)
L.busy(1)
local r = table.pack(pcall(f, ...))
L.busy(-1)
if not r[1] then error(r[2], 0) end
return table.unpack(r, 2, r.n)
end
end
end
L.showWin()
if not S.autoClose then setOpen(true) end
task.spawn(function()
if not S.autoRun or #L.auto.list == 0 then return end
local genv = typeof(getgenv) == "function" and getgenv() or _G
if game.JobId ~= "" and genv.DuaAutoJob == game.JobId then return end
genv.DuaAutoJob = game.JobId
task.wait(math.max(0, tonumber(S.autoDelay) or 0))
if sg.Parent then L.autoRunAll(false) end
end)
do
local qot = (typeof(queue_on_teleport) == "function" and queue_on_teleport)
or (typeof(syn) == "table" and syn.queue_on_teleport) or (typeof(fluxus) == "table" and fluxus.queue_on_teleport)
if qot then
local queued = false
local URLS = {
"https://raw.githubusercontent.com/GGSOZI/DuasLibrary/main/DuasLibraryUI.lua",
"https://raw.githubusercontent.com/GGSOZI/DuasLibrary/master/DuasLibraryUI.lua",
}
function L.queueReopen()
if queued or not S.reopen or not sg.Parent then return end
local parts2 = {}
if canSave then
local files = {}
if selfFile then files[1] = selfFile end
for _, f in ipairs(SELF_CANDIDATES) do files[#files + 1] = f end
for _, f in ipairs(files) do
local ok, src = pcall(function() return isfile(f) and readfile(f) end)
if ok and type(src) == "string" and src:find("DuaKNoUI", 1, true) then
parts2[#parts2 + 1] = ("local ok,s=pcall(readfile,%q) if ok and type(s)=='string' then local f=loadstring(s) if f then return f() end end"):format(f)
break
end
end
end
local list = {}
if S.reloadUrl ~= "" then list[1] = S.reloadUrl end
for _, u in ipairs(URLS) do list[#list + 1] = u end
local q = {}
for _, u in ipairs(list) do q[#q + 1] = ("%q"):format(u) end
parts2[#parts2 + 1] = "for _,u in ipairs({" .. table.concat(q, ",") .. "}) do local ok,s=pcall(game.HttpGet,game,u) if ok and type(s)=='string' and #s>2000 then local f=loadstring(s) if f then return f() end end end"
if pcall(qot, table.concat(parts2, "\n")) then queued = true end
end
LP.OnTeleport:Connect(function() L.queueReopen() end)
task.delay(3, L.queueReopen)
end
end
do
local M = {tab = "n", ord = 0}
local DECAL_DISCORD, DECAL_MAIL = "117836290420200", "107171965293965"
-- decal asset ids are not image ids, so load them as a thumbnail (rbxthumb) and fall back to the decal's own Texture
function L.decal(parent, id, size, props)
props = props or {}
props.AnchorPoint = props.AnchorPoint or V2(0.5, 0.5)
props.Position = props.Position or U2(0.5, 0, 0.5, 0)
props.Size, props.BackgroundTransparency, props.ScaleType = UO(size, size), 1, Enum.ScaleType.Fit
props.Image = "rbxthumb://type=Asset&id=" .. id .. "&w=150&h=150"
props.ZIndex = props.ZIndex or 6
local img = new("ImageLabel", props, parent)
task.spawn(function()
local t0 = os.clock()
while os.clock() - t0 < 4 and not img.IsLoaded do task.wait(0.2) end
if img.IsLoaded or not img.Parent then return end
pcall(function()
local o = game:GetObjects("rbxassetid://" .. id)[1]
local t = o and (o.Texture or o.Image)
if t and t ~= "" then img.Image = t end
end)
end)
return img
end
M.mail = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -60, 0.5, 0), Size = UO(34, 24), BackgroundColor3 = L.P.ctrl,
BorderSizePixel = 0, AutoButtonColor = false, Text = "", ZIndex = 5,
}, bar)
round(M.mail, 6)
L.decal(M.mail, DECAL_MAIL, 22)
M.dot = new("TextLabel", {
AnchorPoint = V2(1, 0), Position = U2(1, -1, 0, 1), Size = UO(14, 14), BackgroundColor3 = RED, BorderSizePixel = 0,
Text = "", TextColor3 = WHITE, TextSize = 10, Font = Enum.Font.Nunito, Visible = false, ZIndex = 8,
}, M.mail)
round(M.dot, 8)
L.mail = M.mail
function L.copyDiscord()
if typeof(setclipboard) == "function" then
setclipboard(L.DISCORD)
notify("Discord link copied", "discord.gg/empgqd5qpq", nil, 3)
else
notify("Join our Discord", "discord.gg/empgqd5qpq", nil, 5)
end
end
M.disc = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -100, 0.5, 0), Size = UO(34, 24), BackgroundColor3 = L.P.ctrl,
BorderSizePixel = 0, AutoButtonColor = false, Text = "", ZIndex = 5,
}, bar)
round(M.disc, 6)
L.decal(M.disc, DECAL_DISCORD, 22)
L.disc = M.disc
M.disc.MouseButton1Click:Connect(function()
if L.moved then L.moved = false return end
L.copyDiscord()
end)
function L.nameOf(id)
local c = L.names[id]
if c then return c end
L.names[id] = tostring(id)
task.spawn(function()
local ok, n = pcall(Players.GetNameFromUserIdAsync, Players, tonumber(id))
if ok and type(n) == "string" then
L.names[id] = n
if L.inboxRender then L.inboxRender() end
end
end)
return L.names[id]
end
function L.myMsgs()
local src = isAdmin and online.messages or (online.remoteMsgs or {})
local out = {}
for i = #src, 1, -1 do
local m = src[i]
if isAdmin or m.to == "all" or tonumber(m.to) == LP.UserId then out[#out + 1] = m end
end
return out
end
function L.badge()
local n = L.unread
if not isAdmin then
for _, m in ipairs(L.myMsgs()) do if (tonumber(m.id) or 0) > S.seenMsg then n = n + 1 end end
end
M.dot.Visible = n > 0
M.dot.Text = n > 9 and "9+" or tostring(n)
end
function L.checkMsgs()
if isAdmin then return end
L.applyRemovals()
for _, m in ipairs(L.myMsgs()) do
local id = tonumber(m.id) or 0
if id > S.seenMsg and id > (L.notified or 0) then
L.notified = id
notify("Message from " .. m.from, m.text:sub(1, 80), nil, 5)
end
end
L.badge()
end
M.inbox = overlay("Inbox", 60)
M.inbox.BackgroundTransparency = 1
M.card = card(M.inbox, 480, 340, 61)
M.card.BackgroundColor3 = L.P.input
M.card.ClipsDescendants = true
L.cards[#L.cards + 1] = M.card
local DARK = Color3.fromRGB(20, 14, 40)
do
local head = new("Frame", {Size = U2(1, 0, 0, 54), BackgroundColor3 = accentColor, BorderSizePixel = 0, ZIndex = 62}, M.card)
round(head, 12)
local fill = new("Frame", {AnchorPoint = V2(0, 1), Position = U2(0, 0, 1, 0), Size = U2(1, 0, 0, 12), BackgroundColor3 = accentColor, BorderSizePixel = 0, ZIndex = 62}, head)
themedFill[head], themedFill[fill] = "hi", "hi"
local ib = new("Frame", {Position = UO(12, 8), Size = UO(40, 38), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 63}, M.card)
round(ib, 12)
L.decal(ib, DECAL_MAIL, 32, {ZIndex = 64})
text(M.card, {Position = UO(62, 8), Size = UO(150, 24), Text = "Inbox", TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 64})
M.sub = text(M.card, {Position = UO(62, 29), Size = UO(170, 16), Text = "Notifications and messages", TextSize = 11, TextTransparency = 0.35, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 64})
local closeB = button(M.card, 0, 0, 34, 34, "X", Color3.fromRGB(0, 0, 0), 0.5, 64)
closeB.TextSize = 15
closeB.AnchorPoint, closeB.Position = V2(1, 0), U2(1, -10, 0, 10)
closeB.MouseButton1Click:Connect(function() M.inbox.Visible = false; M.newN = 0 end)
local dc = button(M.card, 0, 0, 150, 34, "Join Discord", Color3.fromRGB(78, 80, 88), 0, 64)
dc.AnchorPoint, dc.Position, dc.TextSize = V2(1, 0), U2(1, -52, 0, 10), 13
new("UIPadding", {PaddingLeft = UDim.new(0, 34)}, dc)
L.decal(dc, DECAL_DISCORD, 30, {AnchorPoint = V2(0, 0.5), Position = U2(0, 6, 0.5, 0), ZIndex = 65})
dc.MouseButton1Click:Connect(function() L.copyDiscord() end)
end
-- segmented tab switch
local seg = new("Frame", {Position = UO(14, 64), Size = U2(1, -28, 0, 36), BackgroundColor3 = L.P.card, BorderSizePixel = 0, ZIndex = 62}, M.card)
round(seg, 10)
M.tabN = button(seg, 4, 4, 100, 28, "🔔 Notifications", WHITE, 0.5, 63)
M.tabM = button(seg, 4, 4, 100, 28, "✉️ Messages", WHITE, 0.5, 63)
M.tabN.Size, M.tabM.Size = U2(0.5, -6, 0, 28), U2(0.5, -6, 0, 28)
M.tabM.Position = U2(0.5, 2, 0, 4)
M.tabN.TextSize, M.tabM.TextSize = 13, 13
M.q = ""
M.search = inputBox(M.card, 14, 106, 100, 28, "🔍 Search inbox...", false, 63)
M.search.Size = U2(1, -28, 0, 28)
M.search:GetPropertyChangedSignal("Text"):Connect(function()
M.q = M.search.Text:lower():gsub("^%s+", ""):gsub("%s+$", "")
if M.render then M.render() end
end)
M.body = new("ScrollingFrame", {
Position = UO(14, 142), Size = U2(1, -28, 1, -154), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 3, ScrollBarImageColor3 = accentColor, ZIndex = 62,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, M.card)
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, M.body)
local function nextOrd() M.ord = M.ord + 1 return M.ord end
local KIND = {n = accentColor, m = L.P.btn, s = L.P.info}
local KICON = {n = "🔔", m = "✉️", s = "📤"}
local function ago(ts, fallback)
if not ts then return fallback end
local d = os.time() - ts
if d < 45 then return "now" elseif d < 3600 then return math.floor(d / 60 + 0.5) .. "m ago"
elseif d < 86400 then return math.floor(d / 3600) .. "h ago" end
return fallback
end
M.shown = 0
local function line(kind, head, body, when, icon, onDelete, isNew)
if M.q ~= "" and not (tostring(head) .. " " .. tostring(body or "")):lower():find(M.q, 1, true) then return end
M.shown = M.shown + 1
local r = new("TextButton", {
Size = U2(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = L.P.card, BorderSizePixel = 0,
Text = "", AutoButtonColor = false, ZIndex = 63, LayoutOrder = nextOrd(),
}, M.body)
round(r, 10)
new("UISizeConstraint", {MinSize = Vector2.new(0, 52)}, r)
new("UIPadding", {PaddingTop = UDim.new(0, 9), PaddingBottom = UDim.new(0, 9), PaddingLeft = UDim.new(0, 56), PaddingRight = UDim.new(0, 12)}, r)
new("Frame", {Position = UO(-56, -9), Size = U2(0, 3, 1, 18), BackgroundColor3 = KIND[kind] or accentColor, BorderSizePixel = 0, ZIndex = 64}, r)
local ic = new("TextLabel", {
Position = UO(-46, 0), Size = UO(32, 32), BackgroundColor3 = KIND[kind] or accentColor, BackgroundTransparency = 0.6,
BorderSizePixel = 0, Text = icon or KICON[kind] or "🔔", TextSize = 16, TextColor3 = WHITE, ZIndex = 64,
}, r)
round(ic, 16)
if isNew then
local nd = new("Frame", {AnchorPoint = V2(0.5, 0.5), Position = UO(-18, 2), Size = UO(10, 10), BackgroundColor3 = RED, BorderSizePixel = 0, ZIndex = 66}, r)
round(nd, 5)
end
local col = new("Frame", {Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, ZIndex = 64}, r)
new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}, col)
text(col, {
Size = U2(1, -(onDelete and 84 or 58), 0, 16), AutomaticSize = Enum.AutomaticSize.Y, Text = head, TextSize = 13, TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 65, LayoutOrder = 1,
})
if body then
text(col, {
Size = U2(1, 0, 0, 14), AutomaticSize = Enum.AutomaticSize.Y, Text = body, TextSize = 12, TextWrapped = true,
TextColor3 = L.P.muted, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 65, LayoutOrder = 2,
})
end
local tl = text(r, {AnchorPoint = V2(1, 0), Position = U2(1, onDelete and -24 or 0, 0, 0), Size = UO(58, 14), Text = when or "", TextSize = 10, TextColor3 = L.P.muted, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 65})
-- tap a row to copy its text
r.MouseButton1Click:Connect(function()
if L.moved then L.moved = false return end
if typeof(setclipboard) ~= "function" then return end
pcall(setclipboard, tostring(head) .. (body and ("\n" .. tostring(body)) or ""))
local old = tl.Text
tl.Text = "Copied!"
task.delay(1.2, function() if tl.Parent then tl.Text = old end end)
end)
if onDelete then
local x = new("TextButton", {
AnchorPoint = V2(1, 0), Position = U2(1, 4, 0, -4), Size = UO(22, 22), BackgroundTransparency = 1, Text = "X", TextSize = 13,
TextColor3 = L.P.muted, Font = Enum.Font.Nunito, AutoButtonColor = false, ZIndex = 67,
}, r)
x.MouseEnter:Connect(function() x.TextColor3 = RED end)
x.MouseLeave:Connect(function() x.TextColor3 = L.P.muted end)
x.MouseButton1Click:Connect(function() onDelete(); M.render() end)
end
end
local function empty(icon, head, body)
local f = new("Frame", {Size = U2(1, -6, 0, 150), BackgroundTransparency = 1, ZIndex = 63, LayoutOrder = nextOrd()}, M.body)
text(f, {Position = UO(0, 20), Size = U2(1, 0, 0, 44), Text = icon, TextSize = 34, ZIndex = 64})
text(f, {Position = UO(0, 70), Size = U2(1, 0, 0, 20), Text = head, TextSize = 15, ZIndex = 64})
text(f, {Position = UO(0, 92), Size = U2(1, 0, 0, 34), Text = body, TextSize = 12, TextColor3 = L.P.muted, TextWrapped = true, ZIndex = 64})
end
local function render()
for _, c in ipairs(M.body:GetChildren()) do
if not c:IsA("UIListLayout") then c:Destroy() end
end
M.ord = 0
M.shown = 0
local on, off = accentColor, L.P.card
M.tabN.BackgroundColor3, M.tabN.BackgroundTransparency = M.tab == "n" and on or off, M.tab == "n" and 0 or 1
M.tabM.BackgroundColor3, M.tabM.BackgroundTransparency = M.tab == "m" and on or off, M.tab == "m" and 0 or 1
M.tabN.TextColor3 = M.tab == "n" and DARK or WHITE
M.tabM.TextColor3 = M.tab == "m" and DARK or WHITE
M.tabN.Text = "🔔 Notifications" .. (#L.log > 0 and (" (" .. #L.log .. ")") or "")
M.tabM.Text = "✉️ Messages"
M.sub.Text = M.tab == "n" and "What happened in the library" or "Replies and requests"
if M.tab == "n" then
if #L.log > 0 then
local c = button(M.body, 0, 0, 100, 28, "🗑 Clear all", L.P.ctrl, 0, 63)
c.Size, c.LayoutOrder = U2(1, -6, 0, 28), nextOrd()
c.MouseButton1Click:Connect(function() L.log = {}; render() end)
else
empty("🔔", "All clear", "Nothing new. What happens in the library shows up here.")
end
for i, e in ipairs(L.log) do line("n", e.t, e.m, ago(e.ts, e.at), nil, function() table.remove(L.log, i) end, i <= (M.newN or 0)) end
if #L.log > 0 and M.shown == 0 then empty("🔍", "No matches", "Nothing in your notifications matches that search.") end
else
local rq = button(M.body, 0, 0, 100, 32, "📝 Request a script", L.P.btn, 0, 63)
rq.Size, rq.LayoutOrder = U2(1, -6, 0, 32), nextOrd()
rq.MouseButton1Click:Connect(function() L.openCompose("req") end)
local hb = button(M.body, 0, 0, 100, 32, "❓ Help", L.P.info, 0, 63)
hb.Size, hb.LayoutOrder = U2(1, -6, 0, 32), nextOrd()
hb.MouseButton1Click:Connect(function() L.openCompose("help") end)
local msgs = L.myMsgs()
for _, hr in ipairs(L.helpReplies or {}) do line("m", "Help reply from " .. hr.from, hr.text, hr.at, "❓") end
for _, dm in ipairs(L.dmMine or {}) do line("m", "" .. dm.from .. ' about "' .. dm.script .. '"', dm.text, dm.at, "💬") end
for _, m in ipairs(msgs) do line("m", isAdmin and ("To " .. (m.to == "all" and "everyone" or (m.toName or L.nameOf(m.to)))) or ("From " .. m.from), m.text) end
for i = #L.sent, 1, -1 do line("s", "You to " .. (L.sent[i].to or "DuaKNo"), L.sent[i].text, L.sent[i].at) end
if M.q ~= "" and M.shown == 0 then empty("🔍", "No matches", "Nothing in your messages matches that search.") end
if #msgs == 0 and #L.sent == 0 and #(L.helpReplies or {}) == 0 and #(L.dmMine or {}) == 0 then empty("📭", "No messages yet", "Replies from DuaKNo appear here.") end
end
end
M.render = render
L.inboxRender = function() if M.inbox.Visible then render() end end
local function showTab(t)
M.tab = t
if t == "n" then
if L.unread > 0 then M.newN = L.unread end
L.unread = 0
else
for _, m in ipairs(L.myMsgs()) do S.seenMsg = math.max(S.seenMsg, tonumber(m.id) or 0) end
scheduleSave()
end
render(); L.badge()
end
M.tabN.MouseButton1Click:Connect(function() showTab("n") end)
M.tabM.MouseButton1Click:Connect(function() showTab("m") end)
M.mail.MouseButton1Click:Connect(function()
if L.moved then L.moved = false return end
M.inbox.Visible = not M.inbox.Visible
if M.inbox.Visible then showTab(M.tab) else M.newN = 0 end
end)
M.compose = overlay("Compose", 70)
M.ccard = card(M.compose, 360, 262, 71)
L.cards[#L.cards + 1] = M.ccard
M.mode = "req"
M.title = text(M.ccard, {Position = UO(18, 8), Size = U2(1, -36, 0, 24), Text = "Request a script", TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 72})
M.tabReq = button(M.ccard, 18, 36, 150, 26, "Script request", WHITE, 0.5, 72)
M.tabHelp = button(M.ccard, 174, 36, 150, 26, "❓ Help", WHITE, 0.5, 72)
M.hint = text(M.ccard, {Position = UO(18, 66), Size = U2(1, -36, 0, 30), Font = Enum.Font.Nunito, Text = "", TextSize = 11, TextTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 72})
M.box = inputBox(M.ccard, 18, 100, 324, 100, "Type what script you want...", true, 72)
local send = button(M.ccard, 18, 212, 196, 34, "Send request", L.P.btn, 0, 72)
local cancel = button(M.ccard, 222, 212, 120, 34, "Cancel", WHITE, 0.85, 72)
cancel.MouseButton1Click:Connect(function() M.compose.Visible = false end)
function M.setMode(m)
M.mode = m
local on, off = accentColor, L.P.ctrl
M.tabReq.BackgroundColor3, M.tabReq.BackgroundTransparency = m == "req" and on or off, 0
M.tabHelp.BackgroundColor3, M.tabHelp.BackgroundTransparency = m == "help" and on or off, 0
if m == "req" then
M.title.Text = "Request a script"
M.hint.Text = "Be specific about the script you want. One-word script requests will be ignored. One request per minute."
M.box.PlaceholderText, send.Text = "Say what the script should do and for which game...", "Send request"
else
M.title.Text = "Ask for help"
M.hint.Text = "Say what you need help with and what you already tried. DuaKNo or an admin can reply, and the reply shows up in your Messages."
M.box.PlaceholderText, send.Text = "What do you need help with?", "Send help request"
end
end
M.tabReq.MouseButton1Click:Connect(function() M.setMode("req") end)
M.tabHelp.MouseButton1Click:Connect(function() M.setMode("help") end)
function L.openCompose(mode)
M.inbox.Visible = false
M.box.Text = ""
M.setMode(mode or "req")
M.compose.Visible = true
end
function L.hideMail() M.inbox.Visible, M.compose.Visible = false, false end
send.MouseButton1Click:Connect(function()
local msg = M.box.Text:match("^%s*(.-)%s*$")
if msg == "" then return notify("Request", "Type it first") end
if M.mode == "help" then
if os.clock() - (L.lastReq or -999) < 60 then return notify("Slow down", "Wait a minute between requests", nil, 3) end
M.compose.Visible = false
return L.sendHelp(msg)
end
local words = 0
for _ in msg:gmatch("%S+") do words = words + 1 end
if words < 2 or #msg < 8 then return notify("Be specific", "One-word script requests are ignored. Say what the script should do and for which game", nil, 5) end
local hook = online.webhook or online.remoteHook
if not hook then return notify("Requests are off", "DuaKNo hasn't turned requests on yet", nil, 4) end
if not httpReq then return notify("Can't send", "This executor has no request function", nil, 4) end
if os.clock() - (L.lastReq or -999) < 60 then return notify("Slow down", "Wait a minute between requests", nil, 3) end
L.lastReq = os.clock()
M.compose.Visible = false
task.spawn(function()
local ok, res = pcall(httpReq, {
Url = hook, Method = "POST", Headers = {["Content-Type"] = "application/json"},
Body = HttpService:JSONEncode({
username = "Dua's Library", allowed_mentions = {parse = {}},
content = "Script request from " .. LP.Name .. "\n```" .. msg:sub(1, 300):gsub("`", "'") .. "```",
}),
})
local code = ok and type(res) == "table" and tonumber(res.StatusCode) or 0
if code >= 200 and code < 300 then
table.insert(L.sent, {text = msg:sub(1, 300), at = os.date("%H:%M")})
notify("Request sent", "DuaKNo will see it", nil, 3)
else
L.lastReq = nil
notify("Couldn't send", "Try again in a moment", nil, 3)
end
end)
end)
end
local function draggable(handle, anywhere)
local dragging, dStart, sPos, dInput
local mv
local function stop()
dragging = false
if mv then mv:Disconnect() mv = nil end
end
local function canStart(i)
if anywhere ~= true then return true end
local top
local okT, hits = pcall(function() return sg.Parent:GetGuiObjectsAtPosition(i.Position.X, i.Position.Y) end)
if not (okT and hits) then okT, hits = pcall(function() return PG:GetGuiObjectsAtPosition(i.Position.X, i.Position.Y) end) end
if okT and hits then top = hits[1] end
if not top then return true end
if top:IsA("TextButton") or top:IsA("TextBox") or top:GetAttribute("NoDrag") then return false end
if top:IsA("ScrollingFrame") and i.UserInputType == Enum.UserInputType.Touch then return false end
return true
end
handle.InputBegan:Connect(function(i)
if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and canStart(i) then
dragging, L.moved = not S.lockDrag, false
if L.snapWin then L.snapWin() end
dStart, sPos = i.Position, win.Position
if mv then mv:Disconnect() end
mv = UIS.InputChanged:Connect(function(i2)
if i2 == dInput and dragging then
local d = i2.Position - dStart
if math.abs(d.X) > 4 or math.abs(d.Y) > 4 then L.moved = true end
win.Position = L.clampPos(U2(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y))
end
end)
i.Changed:Connect(function()
if i.UserInputState == Enum.UserInputState.End then stop() end
end)
end
end)
handle.InputChanged:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then dInput = i end
end)
end
draggable(win, true)
draggable(sidebar, "force")
do
L.grip = new("TextButton", {
AnchorPoint = V2(1, 1), Position = U2(1, -2, 1, -2), Size = UO(16, 16), BackgroundTransparency = 1, Text = "◢", TextSize = 18,
TextColor3 = WHITE, TextTransparency = 0.3, AutoButtonColor = false, ZIndex = 60,
}, win)
function L.setSize(w, h)
local sc = sg.AbsoluteSize
local mw = (typeof(sc) == "Vector2" and sc.X > 0) and math.max(380, sc.X - 10) or 1100
local mh = (typeof(sc) == "Vector2" and sc.Y > 0) and math.max(260, sc.Y - 10) or 800
w, h = math.clamp(w, 380, math.min(mw, 1100)), math.clamp(h, 260, math.min(mh, 800))
SIZE = UO(w, h)
S.winW, S.winH = w, h
win.Size = SIZE
return w, h
end
local sizing, rStart, rSize, rPos, rInput
local rMove
L.grip.InputBegan:Connect(function(i)
if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not minimized then
sizing, rStart, rSize, rPos = true, i.Position, win.AbsoluteSize, win.Position
if rMove then rMove:Disconnect() end
rMove = UIS.InputChanged:Connect(function(i2)
if sizing and i2 == rInput and not minimized then
local d = i2.Position - rStart
local w, h = L.setSize(rSize.X + d.X, rSize.Y + d.Y)
win.Position = L.clampPos(U2(rPos.X.Scale, rPos.X.Offset + (w - rSize.X) / 2, rPos.Y.Scale, rPos.Y.Offset + (h - rSize.Y) / 2))
end
end)
i.Changed:Connect(function()
if i.UserInputState == Enum.UserInputState.End then
sizing = false
if rMove then rMove:Disconnect() rMove = nil end
scheduleSave()
end
end)
end
end)
L.grip.InputChanged:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then rInput = i end
end)
end
draggable(minBtn)
L.closeBtn = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -34, 0.5, 0), Size = UO(22, 22), BackgroundColor3 = L.P.ctrl, BackgroundTransparency = 0, BorderSizePixel = 0,
Font = Enum.Font.Nunito, TextSize = 13, Text = "X", TextColor3 = WHITE, AutoButtonColor = false, ZIndex = 5,
}, bar)
round(L.closeBtn, 6)
L.press(L.closeBtn, 0.9)
L.closeBtn.MouseEnter:Connect(function() tween(L.closeBtn, FAST, {BackgroundColor3 = RED}) end)
L.closeBtn.MouseLeave:Connect(function() tween(L.closeBtn, FAST, {BackgroundColor3 = L.P.ctrl}) end)
L.closeBtn.MouseButton1Click:Connect(function() L.hideWin() end)
function L.setMinimized(state)
if state == minimized then return end
L.minTok = (L.minTok or 0) + 1
local tok = L.minTok
minimized = state
local function swap()
local show = not minimized
content.Visible, layer.Visible, sidebar.Visible = show, show, show
title.Visible, accent.Visible, mask.Visible = show, show, show
L.mail.Visible = show
L.disc.Visible = show
L.closeBtn.Visible = show
minBtn.AnchorPoint = minimized and V2(0.5, 0.5) or V2(1, 0.5)
minBtn.Position = minimized and UO(16, 16) or U2(1, -8, 0.5, 0)
minBtn.Size = minimized and UO(32, 32) or UO(22, 22)
minBtn.BackgroundColor3 = minimized and Color3.new(0, 0, 0) or L.P.ctrl
minBtn.BackgroundTransparency = 0
applyWindow()
L.applyBg()
L.grip.Visible = not minimized
inner.Visible = not minimized
L.miniImg.Visible = minimized and L.iconOK == true
minBtn.Text = minimized and (L.iconOK and "" or "+") or "-"
if L.busyUpdate then L.busyUpdate() end
end
if minimized then
modal.Visible, confirm.Visible, viewer.Visible = false, false, false
L.hideMail()
local tw = TweenService:Create(win, TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UO(32, 32)})
tw.Completed:Connect(function(st)
if st == Enum.PlaybackState.Completed and L.minTok == tok then swap(); if L.clampWin then L.clampWin(true) end end
end)
tw:Play()
else
swap()
local tw = TweenService:Create(win, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = SIZE})
tw.Completed:Connect(function(st)
if st == Enum.PlaybackState.Completed and L.minTok == tok and L.clampWin then L.clampWin(true) end
end)
tw:Play()
end
end
minBtn.MouseButton1Click:Connect(function()
if L.moved then L.moved = false return end
L.setMinimized(not minimized)
end)

-- Updates page: newest scripts added to Dua's Script sections and to Completed requests
do
local host = pages["Updates"]
if host then
local scroll = new("ScrollingFrame", {
Position = UO(10, 50), Size = U2(1, -20, 1, -58), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
ScrollBarImageColor3 = WHITE, ZIndex = 21, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, host)
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)
new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8), PaddingRight = UDim.new(0, 10)}, scroll)
function L.updFeed()
local items, idx = {}, {}
for _, sec in ipairs(SECTIONS) do
for _, e in ipairs(adminPages[sec.name] or {}) do
local t = tonumber(e.t)
if t then
local k = e.name .. "\0" .. L.ckey(e.code)
local it = idx[k]
if not it then it = {e = e, t = t, where = {}}; idx[k] = it; items[#items + 1] = it end
it.where[#it.where + 1] = sec.name
if t > it.t then it.t = t end
end
end
end
local R = L.csrR
if R and R.list then
for _, e in ipairs(R.list) do
local t = tonumber(e.t)
if t then items[#items + 1] = {e = e, t = t, where = {"Completed request"}, done = true} end
end
end
table.sort(items, function(a, b) return a.t > b.t end)
return items
end
function L.refreshUpdates()
for _, c in ipairs(scroll:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
local feed = L.updFeed()
local seen = tonumber(S.updSeen) or 0
local lo, lastBucket = 0, nil
if #feed == 0 then
text(scroll, {Size = U2(1, 0, 0, 40), Font = Enum.Font.Nunito, Text = "Nothing yet. New scripts added to Dua's Script or Completed script request show up here.", TextSize = 12, TextTransparency = 0.3, TextWrapped = true, ZIndex = 22})
end
for i = 1, math.min(#feed, 40) do
local it = feed[i]
local age = os.time() - it.t
local bucket = age < 86400 and "Today" or (age < 172800 and "Yesterday" or (age < 604800 and "This week" or "Earlier"))
if bucket ~= lastBucket then
lastBucket = bucket
lo = lo + 1
text(scroll, {LayoutOrder = lo, Size = U2(1, 0, 0, 18), Font = Enum.Font.Nunito, Text = bucket:upper(), TextSize = 10, TextColor3 = L.P.muted, TextTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22})
end
lo = lo + 1
local row = new("Frame", {LayoutOrder = lo, Size = U2(1, 0, 0, 56), BackgroundColor3 = L.P.card, BorderSizePixel = 0, ZIndex = 21}, scroll)
round(row, 8)
local rs = new("UIStroke", {Thickness = 1 * (L.ss or 1), Color = L.P.line, Transparency = 0.35, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, row)
L.strokes[rs] = 1
local badge = new("Frame", {AnchorPoint = V2(0, 0.5), Position = U2(0, 11, 0.5, 0), Size = UO(34, 34), BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0, ZIndex = 22}, row)
round(badge, 8)
if not L.kindBadgeInto(badge, it.e.kinds, 34) then
local ic = L.icon(badge, it.done and 1 or 0, 22, {AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0)})
if not ic then
text(badge, {Size = U2(1, 0, 1, 0), Text = tostring(it.e.name):sub(1, 1):upper(), TextSize = 16, ZIndex = 23})
end
end
if it.t > seen then
local dot = new("Frame", {Position = UO(-2, -2), Size = UO(9, 9), BackgroundColor3 = RED, BorderSizePixel = 0, ZIndex = 25}, badge)
round(dot, 99)
end
text(row, {Position = UO(56, 9), Size = U2(1, -140, 0, 18), Text = it.e.name, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22})
local where = it.done and "Completed request" or ("Added to " .. table.concat(it.where, ", "))
text(row, {Position = UO(56, 29), Size = U2(1, -140, 0, 14), Font = Enum.Font.Nunito, Text = where .. "  -  " .. L.ago(it.t), TextSize = 11, TextColor3 = L.P.muted, TextTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22})
local run = new("TextButton", {AnchorPoint = V2(1, 0.5), Position = U2(1, -10, 0.5, 0), Size = UO(54, 28), BackgroundColor3 = L.P.btn, BorderSizePixel = 0, AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = "Run", TextColor3 = WHITE, ZIndex = 23}, row)
round(run, 7)
L.press(run, 0.93)
local view = new("TextButton", {AnchorPoint = V2(1, 0.5), Position = U2(1, -70, 0.5, 0), Size = UO(50, 28), BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0, AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = "View", TextColor3 = WHITE, ZIndex = 23}, row)
round(view, 7)
L.press(view, 0.93)
local e = it.e
run.MouseButton1Click:Connect(function() runScript(e) end)
view.MouseButton1Click:Connect(function() openViewer(e) end)
end
end
function L.updDot()
local row = rows["Updates"]
if not row then return end
local dot = row:FindFirstChild("UpdDot")
if not dot then
dot = new("Frame", {Name = "UpdDot", Position = UO(26, 5), Size = UO(8, 8), BackgroundColor3 = RED, BorderSizePixel = 0, Visible = false, ZIndex = 12}, row)
round(dot, 99)
end
local newest = 0
for _, it in ipairs(L.updFeed()) do if it.t > newest then newest = it.t end end
dot.Visible = newest > (tonumber(S.updSeen) or 0)
end
task.delay(4, function() pcall(L.updDot) end)
task.spawn(function()
while sg.Parent do
task.wait(20)
pcall(function()
L.updDot()
if host.Visible then L.refreshUpdates() end
end)
end
end)
end
end
-- Completed script request page
-- Everyone can see the finished scripts. Only admins/owner can add or delete them.
do
(function()
local CSR = "Completed script request"
-- PASTE YOUR NEW npoint.io LINK HERE, e.g. "https://api.npoint.io/xxxxxxxxxxxxxxxxxxxx"
L.COMPLETED_BOARD = "https://api.npoint.io/045e748727605bd85fd9"
local host = pages[CSR]
local MAXLIST, MAXCODE = 100, math.huge
local GREEN = L.P.btn
local R = {list = {}, busy = false, busyAt = 0, saving = false, at = nil, err = nil}
L.csrR = R
local function boardUrl()
local u = L.COMPLETED_BOARD
if type(u) == "string" and u:match("^https://api%.npoint%.io/[%w]+$") then return u end
end
local function clip(s, n)
s = tostring(s or "")
local len = utf8.len(s)
if len and len > n then return s:sub(1, utf8.offset(s, n + 1) - 1) end
if not len and #s > n then return s:sub(1, n) end
return s
end
local function trim(s) return (tostring(s or ""):match("^%s*(.-)%s*$")) end
local function pull()
local url = boardUrl()
if not url then return nil, "no board link set" end
local d = L.bRead(url)
if not d then return nil, L.boardErr or "can't reach the board" end
local out = {}
if type(d.requests) == "table" then
for _, e in ipairs(d.requests) do
if type(e) == "table" and type(e.name) == "string" and type(e.code) == "string" then out[#out + 1] = e end
end
end
return out
end
local function sortList(list)
table.sort(list, function(a, b) return (tonumber(a.t) or 0) > (tonumber(b.t) or 0) end)
end

local status = text(host, {
Position = UO(12, 47), Size = U2(1, -24, 0, 18), Text = "", TextSize = 11, TextTransparency = 0.3,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
})
local scroll = new("ScrollingFrame", {
Position = UO(10, 98), Size = U2(1, -20, 1, -106), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 3, ScrollBarImageColor3 = WHITE, ZIndex = 21, CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, host)

-- sort + Keyless / FE / Universal filters
R.sort, R.f, R.chips = 1, {}, {}
R.SORTS = {"Newest", "Oldest", "A-Z", "Most "}
local chipRow = new("ScrollingFrame", {
Position = UO(10, 68), Size = U2(1, -20, 0, 26), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X, ZIndex = 21,
}, host)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, chipRow)
local function paintChips()
for _, c in ipairs(R.chips) do
c.b.BackgroundColor3 = c.isOn() and themeBtn or L.P.ctrl
end
end
local function chip(label, isOn, onClick)
local b = new("TextButton", {
LayoutOrder = #R.chips + 1, Size = UO(#label * 6 + 22, 24), BorderSizePixel = 0, AutoButtonColor = false, Text = label,
TextColor3 = WHITE, TextSize = 11, Font = Enum.Font.Nunito, ZIndex = 22,
}, chipRow)
round(b, 12)
R.chips[#R.chips + 1] = {b = b, isOn = isOn}
b.MouseButton1Click:Connect(function() onClick(); paintChips(); L.csrRender() end)
return b
end
local sortChip
sortChip = chip("Sort: Newest", function() return R.sort ~= 1 end, function()
R.sort = R.sort % #R.SORTS + 1
sortChip.Text = "Sort: " .. R.SORTS[R.sort]
end)
sortChip.Size = UO(96, 24)
chip("Keyless", function() return R.f.K end, function() R.f.K = not R.f.K end)
chip("FE", function() return R.f.F end, function() R.f.F = not R.f.F end)
chip("Universal", function() return R.f.U end, function() R.f.U = not R.f.U end)
paintChips()
local function hasKind(e, k) return type(e.kinds) == "string" and e.kinds:find(k, 1, true) ~= nil end
local function viewList()
local out = {}
for _, e in ipairs(R.list) do
if (not R.f.K or hasKind(e, "K")) and (not R.f.F or hasKind(e, "F")) and (not R.f.U or hasKind(e, "U")) then out[#out + 1] = e end
end
local seq = {}
for i, e in ipairs(out) do seq[e] = i end
local fc = L.favCount or {}
table.sort(out, function(a, b)
local ta, tb = tonumber(a.t) or 0, tonumber(b.t) or 0
if R.sort == 2 and ta ~= tb then return ta < tb end
if R.sort == 3 then
local na, nb = tostring(a.name):lower(), tostring(b.name):lower()
if na ~= nb then return na < nb end
elseif R.sort == 4 then
local fa, fb = fc[a.name] or 0, fc[b.name] or 0
if fa ~= fb then return fa > fb end
end
if R.sort ~= 2 and ta ~= tb then return ta > tb end
return seq[a] < seq[b]
end)
return out
end
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)
new("UIPadding", {PaddingRight = UDim.new(0, 6)}, scroll)

local function lbl(parent, t, size, trans, order)
return text(parent, {
Size = U2(1, 0, 0, size + 4), AutomaticSize = Enum.AutomaticSize.Y, Text = t, TextSize = size,
TextTransparency = trans, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
TextWrapped = true, ZIndex = 22, LayoutOrder = order,
})
end

local refresh
local function addCard(e, i)
local c = new("Frame", {
Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = L.P.card, BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = 21, LayoutOrder = i,
}, scroll)
round(c, 8)
new("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder}, c)
new("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)}, c)
lbl(c, "" .. clip(e.name, 60), 15, 0, 1)
local kw = L.kindWords((tostring(e.kinds or ""):gsub("U", "")))
local info = "For " .. clip(e.player or "?", 40)
if hasKind(e, "U") then
info = info .. "   •   Universal"
elseif type(e.game) == "string" and e.game ~= "" then
info = info .. "   •   " .. clip(e.game, 60)
end
if kw ~= "" then info = info .. "   •   " .. kw end
lbl(c, info, 12, 0.2, 2)
local d = trim(e.desc)
if d ~= "" then lbl(c, clip(d, 400), 12, 0.35, 3) end
local okd, ds = pcall(os.date, "%d %b %Y", tonumber(e.t) or 0)
lbl(c, "Completed " .. (okd and ds or "") .. (type(e.by) == "string" and e.by ~= "" and (" by " .. clip(e.by, 30)) or ""), 10, 0.5, 4)
local row = new("Frame", {Size = U2(1, 0, 0, 30), BackgroundTransparency = 1, ZIndex = 22, LayoutOrder = 5}, c)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), VerticalAlignment = Enum.VerticalAlignment.Center}, row)
local run = button(row, 0, 0, 80, 26, "Run", GREEN, 0, 23)
run.MouseButton1Click:Connect(function() runScript({name = e.name, code = e.code}) end)
local cp = button(row, 0, 0, 80, 26, "Copy", WHITE, 0.8, 23)
cp.MouseButton1Click:Connect(function()
if typeof(setclipboard) == "function" then
setclipboard(e.code)
notify("Copied", clip(e.name, 40))
else
notify("Can't copy", "This executor has no setclipboard", nil, 3)
end
end)
local favB = button(row, 0, 0, 104, 26, L.isFav(e) and "Favorited" or "Favorite", L.P.ctrl, 0, 23)
favB.MouseButton1Click:Connect(function()
L.toggleFav(e)
L.csrRender()
end)
if isAdmin then
local edB = button(row, 0, 0, 70, 26, "Edit", L.P.ctrl, 0, 23)
edB.MouseButton1Click:Connect(function() if R.startEdit then R.startEdit(e) end end)
local del = button(row, 0, 0, 80, 26, "Delete", RED, 0.3, 23)
del.MouseButton1Click:Connect(function()
askConfirm('Remove "' .. clip(e.name, 40) .. '" from completed requests?', function()
if not adminOk() then return end
local url = boardUrl()
if not url then return end
task.spawn(function()
local list, err = pull()
if not list then return notify("Completed requests", "Couldn't reach the board (" .. tostring(err) .. ")", nil, 4) end
for k = #list, 1, -1 do
local x = list[k]
if (e.id and x.id == e.id) or (not e.id and x.name == e.name and x.code == e.code and x.t == e.t) then table.remove(list, k) end
end
if not L.bWrite(url, {requests = list}) then
return notify("Completed requests", "Couldn't save (" .. tostring(L.boardErr) .. ")", nil, 4)
end
sortList(list)
R.list, R.at = list, os.time()
L.csrRender()
notify("Removed", clip(e.name, 40), nil, 2)
end)
end)
end)
end
end

function L.csrRender()
for _, c in ipairs(scroll:GetChildren()) do
if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end
end
if not boardUrl() then
status.Text = isAdmin and "Not set up yet: paste your npoint.io link into L.COMPLETED_BOARD" or "Not set up yet"
return
end
if R.err then
status.Text = "board: " .. tostring(R.err)
elseif R.at then
local ok, tm = pcall(os.date, "%H:%M", R.at)
local shown = viewList()
status.Text = "synced " .. (ok and tm or "") .. ", " .. #shown .. (#shown == #R.list and "" or (" of " .. #R.list)) .. " completed"
else
status.Text = "loading..."
end
local shown = viewList()
for i, e in ipairs(shown) do addCard(e, i) end
if #shown == 0 and R.at then
text(scroll, {
Size = U2(1, 0, 0, 40), Text = #R.list == 0 and "No completed scripts yet." or "No scripts match these filters.", TextSize = 13, TextTransparency = 0.4,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22, LayoutOrder = 1,
})
end
end

function refresh(manual)
if not boardUrl() then L.csrRender() return end
if R.busy and os.clock() - R.busyAt < 15 then return end
R.busy, R.busyAt = true, os.clock()
if not R.at then status.Text = "loading..." end
task.spawn(function()
local list, err = pull()
R.busy = false
if list then
sortList(list)
R.list, R.err, R.at = list, nil, os.time()
else
R.err = err
end
L.csrRender()
if manual and not list then notify("Completed requests", "Couldn't reach the board (" .. tostring(err) .. ")", nil, 4) end
end)
end

local rf = button(host, 0, 0, 74, 26, "Refresh", WHITE, 0.8, 22)
rf.AnchorPoint, rf.Position, rf.TextSize = V2(1, 0), U2(1, -10, 0, 8), 12
rf.MouseButton1Click:Connect(function() refresh(true) end)
host:GetPropertyChangedSignal("Visible"):Connect(function()
if host.Visible and R.at then L.csrRender() end
if host.Visible and (not R.at or os.time() - R.at > 20) then refresh(false) end
end)
L.csrRender()

-- add form (admins and owner only)
if isAdmin then
local addBtn = button(host, 0, 0, 112, 26, "+ Add script", GREEN, 0, 22)
addBtn.AnchorPoint, addBtn.Position, addBtn.TextSize = V2(1, 0), U2(1, -90, 0, 8), 12
local form = new("Frame", {
Size = U2(1, 0, 1, 0), BackgroundColor3 = L.P.card, BackgroundTransparency = 0.05,
BorderSizePixel = 0, Active = true, Visible = false, ZIndex = 30,
}, host)
round(form, 10)
local formTitle = text(form, {
Position = UO(12, 6), Size = U2(1, -24, 0, 22), Text = "Add completed script", TextSize = 16,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 31,
})
local fs = new("ScrollingFrame", {
Position = UO(10, 34), Size = U2(1, -20, 1, -84), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 3, ScrollBarImageColor3 = WHITE, ZIndex = 31, CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, form)
new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, fs)
new("UIPadding", {PaddingRight = UDim.new(0, 6)}, fs)
local ord = 0
local function field(label, h, multi, placeholder)
ord = ord + 1
text(fs, {
Size = U2(1, 0, 0, 14), Text = label, TextSize = 10, TextTransparency = 0.3,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 32, LayoutOrder = ord,
})
ord = ord + 1
local box = inputBox(fs, 0, 0, 10, h, placeholder, multi, 32)
box.Size, box.LayoutOrder = U2(1, 0, 0, h), ord
if multi and label ~= "SCRIPT" then box.Font = Enum.Font.Nunito end
return box
end
local f = {}
local function sugList(maxN, onPick)
ord = ord + 1
local holder = new("Frame", {
Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false,
ZIndex = 32, LayoutOrder = ord,
}, fs)
new("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder}, holder)
local btns, data = {}, {}
for i = 1, maxN do
local b = new("TextButton", {
Size = U2(1, 0, 0, 24), LayoutOrder = i, BackgroundColor3 = L.P.ctrl, BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = "", TextColor3 = WHITE,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Visible = false, ZIndex = 33,
}, holder)
round(b, 6)
new("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 6)}, b)
L.popIn(b)
b.MouseButton1Click:Connect(function()
local it = data[i]
if it and it.name then onPick(it) end
end)
btns[i] = b
end
local obj = {}
function obj.set(items)
local any = false
for i, b in ipairs(btns) do
local it = items[i]
data[i] = it
b.Visible = it ~= nil
if it then b.Text = it.label; any = true end
end
holder.Visible = any
end
return obj
end
local function nameScore(q, s2)
s2 = s2:lower()
if s2:sub(1, #q) == q then return 0 end
if (" " .. s2):find(" " .. q, 1, true) then return 1 end
if s2:find(q, 1, true) then return 2 end
if #q >= 3 then
local lim = #q >= 6 and 2 or 1
local d = L.lev(q, s2:sub(1, #q))
if d <= lim then return 3 + d end
end
end
-- closest player names: people in this server first, then people from past requests
local function nameMatches(q, n)
q = trim(q):lower()
local pool, seen = {}, {}
local function add(nm, alt, tag)
if type(nm) == "string" and nm ~= "" and not seen[nm:lower()] then
seen[nm:lower()] = true
pool[#pool + 1] = {name = nm, alt = alt, tag = tag}
end
end
for _, p in ipairs(Players:GetPlayers()) do add(p.Name, p.DisplayName, "in server") end
for _, e in ipairs(R.list) do add(e.player, nil, "past request") end
local out = {}
if q == "" then
for i = 1, math.min(n, #pool) do out[i] = pool[i] end
return out
end
local scored = {}
for i, m in ipairs(pool) do
local sc = nameScore(q, m.name)
if m.alt and m.alt ~= m.name then
local sc2 = nameScore(q, m.alt)
if sc2 and (not sc or sc2 < sc) then sc = sc2 end
end
if sc then scored[#scored + 1] = {m = m, sc = sc, i = i} end
end
table.sort(scored, function(a, b) if a.sc ~= b.sc then return a.sc < b.sc end return a.i < b.i end)
for i = 1, math.min(n, #scored) do out[i] = scored[i].m end
return out
end
f.player = field("PLAYER NAME", 30, false, "Start typing a username")
local pset = false
local pSug
pSug = sugList(4, function(it)
pset = true
f.player.Text = it.name
pset = false
pSug.set({})
end)
local function refreshPlayers()
local items = {}
local typed = trim(f.player.Text):lower()
for _, m in ipairs(nameMatches(f.player.Text, 4)) do
local lab = "" .. m.name
if m.alt and m.alt ~= m.name then lab = lab .. "  (" .. m.alt .. ")" end
lab = lab .. "  ·  " .. m.tag
items[#items + 1] = {label = lab, name = m.name}
end
if #items == 1 and items[1].name:lower() == typed then items = {} end
pSug.set(items)
end
f.player:GetPropertyChangedSignal("Text"):Connect(function()
if not pset then refreshPlayers() end
end)
-- Keyless / Universal / FE
ord = ord + 1
text(fs, {
Size = U2(1, 0, 0, 14), Text = "TYPE (Universal means no game needed)", TextSize = 10, TextTransparency = 0.3,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 32, LayoutOrder = ord,
})
ord = ord + 1
local krow = new("Frame", {Size = U2(1, 0, 0, 28), BackgroundTransparency = 1, ZIndex = 32, LayoutOrder = ord}, fs)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), VerticalAlignment = Enum.VerticalAlignment.Center}, krow)
local kinds, kbtn = {}, {}
local applyUni
local function recolorK()
for i, kd in ipairs(L.KINDS) do
local on = kinds[kd[1]]
kbtn[i].BackgroundColor3 = on and kd[3] or L.P.ctrl
kbtn[i].Text = (on and "" or "") .. kd[2]
end
end
for i, kd in ipairs(L.KINDS) do
local b = button(krow, 0, 0, 96, 26, kd[2], L.P.ctrl, 0, 33)
b.TextSize = 12
kbtn[i] = b
b.MouseButton1Click:Connect(function()
kinds[kd[1]] = not kinds[kd[1]] or nil
recolorK()
applyUni()
end)
end
local function kindStr()
local out = ""
for _, kd in ipairs(L.KINDS) do if kinds[kd[1]] then out = out .. kd[1] end end
return out
end
f.game = field("GAME", 30, false, "Type a game, or a game ID")
local gid, gtok, gset = nil, 0, false
local gSug
gSug = sugList(4, function(it)
gset = true
f.game.Text = it.name
gset = false
gid = it.gid
gSug.set({})
end)
local function refreshGames()
gtok = gtok + 1
local my = gtok
local q = f.game.Text
local idq = q:match("^%s*(%d+)%s*$")
if idq and #idq >= 3 then
gSug.set({{label = "Looking up game ID " .. idq .. "..."}})
L.gameFromId(idq, function(nm)
if my ~= gtok then return end
if nm then
gSug.set({{label = "" .. nm .. "  (ID " .. idq .. ")", name = nm, gid = idq}})
else
gSug.set({{label = "No game found for " .. idq .. ", tap to use the ID", name = "Game ID " .. idq, gid = idq}})
end
end)
return
end
local items = {}
for _, nm in ipairs(L.matchGames(q, 4)) do
items[#items + 1] = {label = "" .. nm .. (nm == L.curGame and "  (this game)" or ""), name = nm}
end
local qt = trim(q)
if #qt >= 2 and L.robloxSearch then
if #items == 0 then items[1] = {label = "Searching all of Roblox..."} end
gSug.set(items)
local mine = {}
for _, it in ipairs(items) do if it.name then mine[#mine + 1] = it end end
task.delay(0.45, function()
if my ~= gtok then return end
L.robloxSearch(qt, function(res)
if my ~= gtok then return end
local mixed = L.mixGames(res or {}, mine, 4)
if #mixed == 0 then mixed = {{label = "No games found, you can type your own"}} end
gSug.set(mixed)
end)
end)
return
end
gSug.set(items)
end
f.game:GetPropertyChangedSignal("Text"):Connect(function()
if gset then return end
gid = nil
if not kinds.U then refreshGames() end
end)
applyUni = function()
if kinds.U then
gtok = gtok + 1
gset = true
f.game.Text = ""
gset = false
gid = nil
f.game.TextEditable = false
f.game.PlaceholderText = "Universal: no game needed"
gSug.set({})
else
f.game.TextEditable = true
f.game.PlaceholderText = "Type a game, or a game ID"
refreshGames()
end
end
f.name = field("SCRIPT NAME", 30, false, "Name of the script")
f.desc = field("DESCRIPTION (optional)", 56, true, "What does it do?")
f.code = field("SCRIPT", 110, true, "Paste the script, or a pastebin link")
local save = button(form, 0, 0, 170, 34, "Add completed script", GREEN, 0, 31)
save.AnchorPoint, save.Position = V2(0, 1), U2(0, 10, 1, -10)
local cancel = button(form, 0, 0, 100, 34, "Cancel", WHITE, 0.85, 31)
cancel.AnchorPoint, cancel.Position = V2(1, 1), U2(1, -10, 1, -10)
local function clearForm()
f.player.Text, f.name.Text, f.desc.Text, f.code.Text = "", "", "", ""
for k in pairs(kinds) do kinds[k] = nil end
recolorK()
gset = true
f.game.Text = ""
gset = false
gid = nil
applyUni()
end
local function setMode(editing)
R.editing = editing
formTitle.Text = editing and "Edit completed script" or "Add completed script"
save.Text = editing and "Save changes" or "Add completed script"
end
addBtn.MouseButton1Click:Connect(function()
if not adminOk() then return end
if R.editing then clearForm() end
setMode(nil)
form.Visible = true
refreshPlayers()
if not kinds.U then refreshGames() end
end)
function R.startEdit(e)
if not adminOk() then return end
setMode(e)
pset = true
f.player.Text = tostring(e.player or "")
pset = false
f.name.Text, f.desc.Text, f.code.Text = tostring(e.name or ""), tostring(e.desc or ""), tostring(e.code or "")
for k in pairs(kinds) do kinds[k] = nil end
for _, kd in ipairs(L.KINDS) do
if hasKind(e, kd[1]) then kinds[kd[1]] = true end
end
recolorK()
gset = true
f.game.Text = tostring(e.game or "")
gset = false
gid = e.gid
if kinds.U then
applyUni()
else
f.game.TextEditable = true
f.game.PlaceholderText = "Type a game, or a game ID"
gSug.set({})
end
pSug.set({})
form.Visible = true
end
cancel.MouseButton1Click:Connect(function()
if R.editing then clearForm() end
setMode(nil)
form.Visible = false
end)
save.MouseButton1Click:Connect(function()
if not adminOk() then return end
local url = boardUrl()
if not url then return notify("Completed requests", "Paste your npoint link into L.COMPLETED_BOARD first", nil, 4) end
if R.saving then return end
local player, gname, sname = clip(trim(f.player.Text), 40), clip(trim(f.game.Text), 60), clip(trim(f.name.Text), 60)
local desc, code = clip(trim(f.desc.Text), 400), f.code.Text
if player == "" then return notify("Player name", "Choose or type who requested it", nil, 3) end
local uni = kinds.U == true
local gid2 = gid
if uni then
gname, gid2 = "", nil
elseif gname:match("^%d+$") then
gid2 = gid2 or gname
gname = "Game ID " .. gname
end
if gname == "" and not uni then return notify("Game", "Pick a game, or tick Universal", nil, 3) end
if sname == "" then return notify("Script name", "Give the script a name", nil, 3) end
if code:match("^%s*$") then return notify("Script", "Paste the script or a link first", nil, 3) end
if #code > MAXCODE then return notify("Script too long", "Max " .. MAXCODE .. " characters", nil, 3) end
code = normalizeCode(code)
local editing = R.editing
R.saving = true
task.spawn(function()
local list, err = pull()
if not list then
R.saving = false
return notify("Completed requests", "Couldn't reach the board (" .. tostring(err) .. ")", nil, 4)
end
local hit
if editing then
for _, x in ipairs(list) do
if (editing.id and x.id == editing.id) or (not editing.id and x.name == editing.name and x.code == editing.code and x.t == editing.t) then hit = x break end
end
if not hit then
R.saving = false
return notify("Completed requests", "That script is no longer on the board", nil, 4)
end
hit.player, hit.name, hit.desc, hit.code = player, sname, desc ~= "" and desc or nil, code
hit.game, hit.gid = gname ~= "" and gname or nil, gid2 and tostring(gid2):sub(1, 15) or nil
hit.kinds = kindStr() ~= "" and kindStr() or nil
else
while #list >= MAXLIST do table.remove(list, 1) end
list[#list + 1] = {
id = tostring(os.time()) .. tostring(math.random(100, 999)), player = player, name = sname,
game = gname ~= "" and gname or nil, gid = gid2 and tostring(gid2):sub(1, 15) or nil,
kinds = kindStr() ~= "" and kindStr() or nil,
desc = desc ~= "" and desc or nil, code = code, by = verName or LP.Name, t = os.time(),
}
end
local ok = L.bWrite(url, {requests = list})
R.saving = false
if not ok then return notify("Completed requests", "Couldn't save (" .. tostring(L.boardErr) .. ")", nil, 4) end
if editing then L.favRetarget({name = editing.name, code = editing.code}, {name = sname, code = code, desc = desc ~= "" and desc or nil, game = hit.game, gid = hit.gid, kinds = hit.kinds}) end
clearForm()
setMode(nil)
form.Visible = false
sortList(list)
R.list, R.err, R.at = list, nil, os.time()
L.csrRender()
notify(editing and "Saved" or "Added", sname, nil, 2)
end)
end)
end
end)()
end
do
local CP = "Global chat"
local host = pages[CP]
local BASE = "https://ntfy.sh/duaslib-463b64284260828291"
local C = {seen = {}, lines = {}, order = 0, last = tostring(os.time() - 1800), busy = false, backoff = 0, primed = false, lastSend = 0, lastToast = 0, muted = {}}
L.chat = C
local MYID = tostring(LP.UserId)
function C.esc(x) return (tostring(x):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")) end
local function uid() return string.format("%x%x%x", os.time(), math.random(0, 65535), math.random(0, 65535)) end

round(new("Frame", {Size = U2(1, 0, 1, 0), BackgroundColor3 = L.P.card, BorderSizePixel = 0, ZIndex = 20}, host), 10)
local scroll = new("ScrollingFrame", {
Position = UO(10, 72), Size = U2(1, -20, 1, -152), BackgroundColor3 = L.P.card, BackgroundTransparency = 0,
BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 22,
}, host)
round(scroll, 8)
new("UIListLayout", {Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)
new("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6)}, scroll)
local empty = text(host, {Position = UO(10, 120), Size = U2(1, -20, 0, 20), Font = Enum.Font.Nunito, TextSize = 13, Text = "No messages yet. Say hi!", TextTransparency = 0.4, ZIndex = 23})
C.foot = text(host, {
AnchorPoint = V2(0, 1), Position = U2(0, 10, 1, -58), Size = U2(1, -20, 0, 14), Font = Enum.Font.Nunito, TextSize = 10, TextTransparency = 0.4,
Text = "Live for everyone using Dua's Library. Tap a name to message them privately. Nothing here is verified or secret.", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22,
})
local toBox = inputBox(host, 0, 0, 84, 34, "To (name)", false, 23)
toBox.AnchorPoint, toBox.Position, toBox.Size = V2(0, 1), U2(0, 10, 1, -18), U2(0.22, 0, 0, 34)
new("UISizeConstraint", {MinSize = Vector2.new(52, 34), MaxSize = Vector2.new(84, 34)}, toBox)
local box = inputBox(host, 0, 0, 10, 34, "Say something...", false, 23)
box.AnchorPoint, box.Position, box.Size = V2(0, 1), U2(0.22, 16, 1, -18), U2(0.58, -36, 0, 34)
local send = button(host, 0, 0, 76, 34, "Send", L.P.btn, 0, 23)
send.AnchorPoint, send.Position, send.Size = V2(1, 1), U2(1, -10, 1, -18), U2(0.2, 0, 0, 34)
new("UISizeConstraint", {MinSize = Vector2.new(48, 34), MaxSize = Vector2.new(76, 34)}, send)
function C.colorOf(name)
local h = 7
for i = 1, #name do h = (h * 31 + name:byte(i)) % 360 end
local c = Color3.fromHSV(h / 360, 0.45, 1)
return string.format("rgb(%d,%d,%d)", math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255))
end
C.uids, C.adminIds, C.idCache, C.lineData, C.active, C.gname, C.gpend = {}, {}, {}, {}, {}, {}, {}
C.TAGS = {
share = ADD_PAGE, find = ADD_PAGE, scripts = ADD_PAGE, dua = L.DUA, duas = L.DUA, favorites = L.FAVP, favorited = L.FAVP, fav = L.FAVP,
scriptblox = "ScriptBlox scripts", sb = "ScriptBlox scripts", chat = CP, global = CP, universal = "Universal", info = "Info",
settings = "Settings", setting = "Settings", options = "Settings", theme = "Settings", themes = "Settings", fonts = "Settings", style = "Settings",
particles = "Settings", reopen = "Settings", rejoin = "Settings", admin = "Admin", fly = "Universal", speed = "Universal", esp = "Universal",
request = L.DUA, requests = L.DUA,
}
function C.isMuted(u)
if C.adminIds[u] or (u == MYID and isAdmin) then return false end
local m = C.muted[u]
if m == nil or m == false then return false end
if type(m) == "table" then
local e = tonumber(m.e) or 0
return e == 0 or e > os.time()
end
return true
end
function C.rankOf(p)
local u = tostring(p.u)
if u == MYID and isAdmin then return L.owner() and "owner" or "admin" end
return C.adminIds[u]
end
function C.body(p)
local t = C.esc(tostring(p.t):sub(1, 200))
if p.hl then
local h = C.esc(p.hl)
local x, y = t:find(h, 1, true)
if x then t = t:sub(1, x - 1) .. '<font color="rgb(110,170,255)"><b>' .. h .. "</b></font>" .. t:sub(y + 1) end
return t
end
t = t:gsub("#([%w_]+)", function(w)
if C.TAGS[w:lower()] then return '<font color="rgb(110,170,255)"><b>#' .. w .. "</b></font>" end
end)
t = t:gsub("@([%w_]+)", function(w)
if w:lower() == LP.Name:lower() then return '<font color="rgb(255,215,90)"><b>@' .. w .. "</b></font>" end
end)
return t
end
function C.fmt(p)
if p.sys then return '<font color="rgb(150,150,168)"><i>' .. C.body(p) .. "</i></font>" end
local mine = p.u == MYID
local rank = C.rankOf(p)
local badge = rank == "owner" and '<font color="rgb(255,200,60)"><b>[OWNER]</b></font> '
or rank == "admin" and '<font color="rgb(110,200,255)"><b>[ADMIN]</b></font> ' or ""
local ok, tm = pcall(os.date, "%H:%M", tonumber(p.ts) or os.time())
local gtag = ""
if S.chatGames and p.g then
local gn = C.gname[p.g]
if not gn then C.gameName(p.g) end
gtag = '  <font color="rgb(120,175,140)">' .. C.esc(gn or "...") .. "</font>"
end
local tag = ""
if type(p.to) == "string" then
tag = '<font color="rgb(255,170,60)">[private' .. (mine and (" to " .. C.esc(p.to:sub(1, 20))) or "") .. "]</font> "
end
return '<font color="rgb(120,120,132)">' .. (ok and tm or "--:--") .. "</font>  " .. badge
.. '<b><font color="' .. (mine and "rgb(255,215,90)" or C.colorOf(tostring(p.n))) .. '">' .. C.esc(tostring(p.n):sub(1, 20)) .. "</font></b>  " .. tag .. C.body(p)
.. (p.sc and ('  <font color="rgb(110,220,140)"><b>' .. C.esc(p.sc.n) .. "</b> (tap)</font>") or "") .. gtag
end
function C.purgeMuted()
for ln, p in pairs(C.lineData) do
if not p.sys and p.u ~= MYID and C.isMuted(tostring(p.u)) then
C.lineData[ln] = nil
for i, x in ipairs(C.lines) do if x == ln then table.remove(C.lines, i) break end end
ln:Destroy()
end
end
end
function C.refreshBadges()
for ln, p in pairs(C.lineData) do
if ln.Parent then C.deco(ln, p) else C.lineData[ln] = nil end
end
end
function C.addLine(p)
empty.Visible = false
C.order = C.order + 1
local mine = p.u == MYID
local ln = new("TextButton", {
LayoutOrder = C.order, Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 13, TextColor3 = WHITE, TextWrapped = true, RichText = true,
TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 23, Text = C.fmt(p),
}, scroll)
C.lines[#C.lines + 1] = ln
C.lineData[ln] = p
new("UIPadding", {Name = "PadR", PaddingRight = UDim.new(0, 6)}, ln)
local held = false
if not p.sys then
local function pos(i)
if i.UserInputType == Enum.UserInputType.Touch then return V2(i.Position.X, i.Position.Y) end
return UIS:GetMouseLocation()
end
local press = 0
ln.InputBegan:Connect(function(i)
if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
held = false
press = press + 1
local my, start = press, pos(i)
task.delay(0.45, function()
if my ~= press or not ln.Parent or i.UserInputState == Enum.UserInputState.End then return end
if (pos(i) - start).Magnitude > 12 then return end
held = true
C.openMenu(p)
end)
end)
ln.InputEnded:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then press = press + 1 end
end)
local jb = new("TextButton", {
Name = "JoinBtn", AnchorPoint = V2(1, 0), Position = U2(1, 0, 0, 0), Size = UO(40, 16), BackgroundColor3 = L.P.btn, BackgroundTransparency = 0.1,
BorderSizePixel = 0, Text = "Join", TextColor3 = WHITE, TextSize = 11, AutoButtonColor = false, Visible = false, ZIndex = 25,
}, ln)
round(jb, 5)
jb.MouseButton1Click:Connect(function() C.join(p) end)
C.deco(ln, p)
end
if #C.lines > 60 then local old = table.remove(C.lines, 1); C.lineData[old] = nil; old:Destroy() end
ln.MouseButton1Click:Connect(function()
if held then held = false return end
local page = p.page
if not page then
for w in tostring(p.t):gmatch("#([%w_]+)") do
if C.TAGS[w:lower()] then page = C.TAGS[w:lower()] break end
end
end
if p.copy then
pcall(function() setclipboard(p.copy) end)
return notify("Copied", "Translation copied", nil, 2)
end
if p.sc then return C.openMenu(p) end
if page and pages[page] then C.jump(page) return end
if not mine and not p.sys then toBox.Text = tostring(p.n):sub(1, 20) end
end)
task.defer(function()
pcall(function() scroll.CanvasPosition = V2(0, math.max(0, scroll.AbsoluteCanvasSize.Y)) end)
end)
end
function C.system(t, page, hl)
C.sysN = (C.sysN or 0) + 1
C.addLine({sys = true, t = t, page = page, hl = hl, i = "sys" .. C.sysN, ts = os.time()})
end
function C.resolveAdmins()
local ids = {}
for _, list in ipairs({rootAdmins, adminList}) do
for _, a in ipairs(list) do
local k = tostring(a):lower()
local pinned = #ADMIN_IDS > 0 and (k == "duakno" or k == "saifb90")
if not pinned then
if C.idCache[k] == nil then
local ok, id = pcall(Players.GetUserIdFromNameAsync, Players, tostring(a))
if ok and id then C.idCache[k] = id end
end
if C.idCache[k] then ids[tostring(C.idCache[k])] = (k == "duakno" or k == "saifb90") and "owner" or "admin" end
end
end
end
for _, id in ipairs(ADMIN_IDS) do ids[tostring(id)] = "owner" end
C.adminIds = ids
C.refreshBadges()
end
function C.updateFoot()
local n, now = 1, os.time()
for u, t in pairs(C.active) do
if u ~= MYID and now - t < 600 then n = n + 1 end
end
C.foot.Text = "" .. n .. " chatting  ·  Tap a name to message them privately  ·  #page links  ·  /help" .. (isAdmin and "  ·  Admins: tap a name, then Mute" or "")
end
-- every new chat message gets a notification; bursts are grouped into one so none are dropped
function C.toast(p)
C.toastQ = C.toastQ or {}
C.toastQ[#C.toastQ + 1] = p
if C.toastBusy then return end
C.toastBusy = true
task.delay(1, function()
C.toastBusy = false
local q = C.toastQ or {}
C.toastQ = {}
local n = #q
if n == 0 then return end
local last = q[n]
if n == 1 then
notify("" .. tostring(last.n):sub(1, 20), tostring(last.t):sub(1, 70), nil, 4)
else
notify("" .. n .. " new messages", tostring(last.n):sub(1, 20) .. ": " .. tostring(last.t):sub(1, 60), nil, 4)
end
end)
end
function C.handle(p, mine, primed)
if type(p.i) ~= "string" or C.seen[p.i] then return end
C.seen[p.i] = true
if not mine and L.clearApplied and tonumber(p.ts) and tonumber(p.ts) <= L.clearApplied then return end
C.nseen = (C.nseen or 0) + 1
if C.nseen > 600 then C.seen, C.nseen = {[p.i] = true}, 1 end
if p.k == "m" and type(p.t) == "string" and type(p.n) == "string" then
p.t, p.n = p.t:gsub("%c", " "):sub(1, 200), p.n:gsub("[^%w_]", ""):sub(1, 20)
if p.n == "" then return end
if C.isMuted(tostring(p.u)) and not mine then return end
if not mine and (C.isHate(p.t) or C.isHate(p.n) or (type(p.sc) == "table" and C.isHate(tostring(p.sc.n)))) then return end
C.uids[tostring(p.n):lower()] = tostring(p.u)
C.active[tostring(p.u)] = os.time()
p.ts = tonumber(p.ts) or os.time()
p.g = tonumber(p.g)
if type(p.j) ~= "string" or #p.j > 50 or not p.j:match("^[%w%-]+$") then p.j = nil end
if p.sc ~= nil then
if type(p.sc) == "table" and type(p.sc.n) == "string" and type(p.sc.c) == "string" and #p.sc.c <= 1500 then
p.sc = {n = p.sc.n:sub(1, 30), c = p.sc.c}
else
p.sc = nil
end
end
if type(p.to) == "string" and not mine and p.to ~= LP.Name:lower() then return end
C.addLine(p)
if not mine and S.chatLang ~= "" and C.autoTranslate then C.autoTranslate(p) end
local away = selected ~= CP or minimized or not sg.Enabled
if not mine and primed and away and p.ts > os.time() - 90 then
if type(p.to) == "string" then
notify("" .. p.n:sub(1, 20), p.t:sub(1, 70), nil, 4)
elseif tostring(p.t):lower():find("@" .. LP.Name:lower(), 1, true) then
notify("" .. p.n:sub(1, 20) .. " mentioned you", p.t:sub(1, 70), nil, 4)
else
C.toast(p)
end
end
elseif (p.k == "a" or p.k == "p") and primed and tostring(p.u) ~= MYID then
local w = p.k == "a" and "feed" or tostring(p.w)
C.pingAt = C.pingAt or {}
if os.clock() - (C.pingAt[w] or -99) < 4 then return end
C.pingAt[w] = os.clock()
task.delay(math.random() * 0.8, function()
if w == "feed" and not isAdmin then refreshOnline(true) elseif w == "board" and L.commPull then L.commPull() end
end)
end
end
function C.get(url)
local ok, body = pcall(function() return game:HttpGet(url) end)
if ok and type(body) == "string" then return body end
if not ok and tostring(body):find("429", 1, true) then return nil, 429 end
if httpReq then
local ok2, res = pcall(httpReq, {Url = url, Method = "GET"})
if ok2 and type(res) == "table" then
if tonumber(res.StatusCode) == 429 then return nil, 429 end
if type(res.Body) == "string" and (tonumber(res.StatusCode) or 200) < 400 then return res.Body end
end
end
end
function C.poll()
if C.busy then return end
C.busy = true
if C.mode == "board" then
local url = L.boardOf()
local d = url and L.bRead(url)
C.busy = false
if d and type(d.chat) == "table" then
for _, p in ipairs(d.chat) do if type(p) == "table" then C.handle(p, false, C.primed) end end
end
if d then C.primed = true end
return
end
local body, code = C.get(BASE .. "/json?poll=1&since=" .. C.last)
C.busy = false
if not body then
if code == 429 then C.backoff = os.clock() + 20
else
C.fail = (C.fail or 0) + 1
if C.fail >= 3 and L.boardOf() then C.mode = "board" end
end
return
end
C.fail = 0
local newest = tonumber(C.last) or 0
for line in body:gmatch("[^\n]+") do
local ok, ev = pcall(function() return HttpService:JSONDecode(line) end)
if ok and type(ev) == "table" and ev.event == "message" then
newest = math.max(newest, tonumber(ev.time) or 0)
local ok2, p = pcall(function() return HttpService:JSONDecode(tostring(ev.message)) end)
if ok2 and type(p) == "table" then p.ts = tonumber(ev.time) or p.ts; C.handle(p, false, C.primed) end
end
end
C.last = tostring(newest)
C.primed = true
end
function C.feedLine(line)
local ok, ev = pcall(function() return HttpService:JSONDecode(line) end)
if not ok or type(ev) ~= "table" or ev.event ~= "message" then return end
local t = tonumber(ev.time) or 0
if t > (tonumber(C.last) or 0) then C.last = tostring(t) end
local ok2, p = pcall(function() return HttpService:JSONDecode(tostring(ev.message)) end)
if ok2 and type(p) == "table" then p.ts = tonumber(ev.time) or p.ts; C.handle(p, false, C.primed) end
end
function C.startWS()
local WSC = (typeof(WebSocket) == "table" and WebSocket.connect) or (typeof(websocket) == "table" and websocket.connect)
if not WSC then return end
while sg.Parent and not C.primed do task.wait(0.5) end
local fails = 0
while sg.Parent do
if C.mode ~= "board" then
local url = (BASE:gsub("^http", "ws")) .. "/ws?since=" .. tostring(C.last)
local ok, sock = pcall(WSC, url)
if ok and sock then
local closed, t0 = false, os.clock()
pcall(function() sock.OnMessage:Connect(function(m) pcall(C.feedLine, m) end) end)
pcall(function() sock.OnClose:Connect(function() closed = true end) end)
C.ws = true
while sg.Parent and not closed do task.wait(1) end
C.ws = false
pcall(function() sock:Close() end)
if os.clock() - t0 < 5 then fails = fails + 1 else fails = 0 end
else
fails = fails + 1
end
end
task.wait(math.min(2 + fails * 3, 30))
end
end
function C.publish(p)
if C.mode == "board" then
if p.k ~= "m" and p.k ~= "a" and p.k ~= "x" then return end
local url = L.boardOf()
if not url then return end
task.spawn(function()
for _ = 1, 3 do
local d = L.bRead(url)
if d then
if type(d.chat) ~= "table" then d.chat = {} end
table.insert(d.chat, p)
while #d.chat > 40 do table.remove(d.chat, 1) end
if L.bWrite(url, d) then return end
end
task.wait(0.4)
end
end)
return
end
task.spawn(function()
local body = HttpService:JSONEncode(p)
local sent = false
if httpReq then
local ok, res = pcall(httpReq, {Url = BASE, Method = "POST", Headers = {["Content-Type"] = "text/plain"}, Body = body})
sent = ok and type(res) == "table" and (tonumber(res.StatusCode) or 200) < 300
end
if not sent then pcall(function() game:HttpGet(BASE .. "/publish?message=" .. HttpService:UrlEncode(body)) end) end
end)
end
function L.ping(w) C.publish({k = "p", i = uid(), u = MYID, w = w}) end
function L.isAdminName(n)
n = tostring(n):lower()
for _, list in ipairs({rootAdmins, adminList}) do
for _, a in ipairs(list) do if tostring(a):lower() == n then return true end end
end
return false
end
function L.announceLive(t) C.publish({k = "a", i = uid(), u = MYID, n = verName or LP.Name, t = t}) end
function C.clearLines()
for _, ln in ipairs(C.lines) do C.lineData[ln] = nil; ln:Destroy() end
C.lines = {}
empty.Visible = true
end
function L.onClear(t)
t = tonumber(t) or 0
if L.clearApplied == nil then L.clearApplied = t return end
if t <= L.clearApplied then return end
L.clearApplied = t
local keep = {}
for _, ln in ipairs(C.lines) do
local d = C.lineData[ln]
if d and not d.sys and (tonumber(d.ts) or 0) > t then keep[#keep + 1] = ln else C.lineData[ln] = nil; ln:Destroy() end
end
C.lines = keep
if #keep == 0 then empty.Visible = true end
C.system("The chat was cleared by the owner.")
end
function L.applyMuted()
local clean, n = {}, 0
local function add(src)
for u, m in pairs(src) do
if n < 300 and type(m) == "table" then clean[tostring(u)] = {n = tostring(m.n or ""):sub(1, 20), e = tonumber(m.e) or 0}; n = n + 1 end
end
end
add(L.boardMuted or {})
add((isAdmin and readToken() and online.muted) or online.remoteMuted or {})
C.muted = clean
if C.purgeMuted then C.purgeMuted() end
end
if online.remoteClear then L.onClear(online.remoteClear) end
pcall(L.applyMuted)
function C.langCode(w)
w = tostring(w or ""):lower()
if w == "" then return nil end
for _, l in ipairs(C.LANGS) do
if l[2] ~= "" and (l[2]:lower() == w or l[1]:lower() == w) then return l[2], l[1] end
end
end
C.CMDS = {
{"help", "/help [command]", "Shows every command. Use /help followed by a command name to see how it works, for example /help tr.", nil, {"commands", "?"}},
{"clear", "/clear", "Clears the chat on your own screen. Nobody else is affected.", nil},
{"tr", "/tr [language] text", "Translates your text and sends it as your message. Example: /tr es hello everyone. Without a language code it translates to English. Type /lancodes for the codes.", nil, {"translate"}},
{"lancodes", "/lancodes", "Lists every language code (ES, PT, EN...) you can use with /tr and /autotr.", nil, {"langs"}},
{"autotr", "/autotr [code|off]", "Automatically translates other people's messages into your language, shown only to you. /autotr es turns it on, /autotr off turns it off.", nil},
{"find", "/find name", "Searches Share script & Find script and the whole hub for a script by name and lists the matches. In a message, type #name to attach one.", nil, {"search"}},
{"discord", "/discord", "Copies the Discord invite link to your clipboard.", nil},
{"ping", "/ping", "Shows how fast you can reach the chat server.", nil},
{"fps", "/fps", "Measures your FPS for one second.", nil},
{"lite", "/lite [on|off]", "Lite mode for less lag: turns off the falling particles. /lite off brings them back.", nil},
{"server", "/server", "Shows the game name, how many players are here and how long the server has been up, and copies the server id.", nil, {"jobid"}},
{"rejoin", "/rejoin", "Rejoins the server you are in right now.", nil},
{"time", "/time", "Shows your local time and how long you have had the hub open.", nil},
{"tips", "/tips [on|off]", "Turns the chat tips on or off.", nil},
{"games", "/games [on|off]", "Turns the games list (where people are playing) on or off.", nil},
{"myid", "/myid", "Shows your Roblox UserId.", nil},
{"board", "/board", "Tests the connection to the shared board. Useful when sharing or favorites don't work. The owner also gets a write test.", nil},
{"mute", "/mute name [minutes]", "Admins only. Mutes a player who has spoken in the chat. Without minutes, it lasts until you unmute them.", "admin"},
{"unmute", "/unmute name", "Admins only. Unmutes one player.", "admin"},
{"unmuteall", "/unmuteall", "Admins only. Unmutes everybody.", "admin"},
{"mutes", "/mutes", "Admins only. Lists who is muted and for how long.", "admin"},
{"clearall", "/clearall", "Owner only. Clears the chat for everyone (needs your GitHub token).", "owner"},
}
function C.permOk(perm) return perm == nil or (perm == "admin" and isAdmin) or (perm == "owner" and L.owner()) end
L.startT = L.startT or os.time()
function C.send(msg, sc)
msg = msg:gsub("%c", " "):match("^%s*(.-)%s*$"):sub(1, 200)
if msg == "" and not sc then return end
if msg == "" then msg = "shared a script" end
if msg:sub(1, 1) == "/" then
local c, rest = msg:match("^/(%a+)%s*(.*)$")
c = c and c:lower()
if c == "help" or c == "commands" or c == "?" then
local want = rest:lower():match("^/?(%S+)")
if want then
local found
for _, m in ipairs(C.CMDS) do
if m[1] == want then found = m else for _, al in ipairs(m[5] or {}) do if al == want then found = m end end end
end
if found and C.permOk(found[4]) then
C.system(found[2])
C.system(found[3])
else
C.system("There is no command called /" .. want .. ". Type /help to see them all.")
end
else
local names = {}
for _, m in ipairs(C.CMDS) do if C.permOk(m[4]) then names[#names + 1] = "/" .. m[1] end end
C.system("Commands: " .. table.concat(names, ", ") .. ".  Type /help and a command name to see how it works, like /help tr.  Type #name to attach a script from Share script & Find script.")
end
elseif c == "clear" then
C.clearLines()
elseif c == "myid" then
C.system("Your Roblox UserId: " .. tostring(LP.UserId))
elseif c == "clearall" then
if not (L.owner() and adminOk()) then C.system("Only the owner can use /clearall") return end
if not readToken() then C.system("/clearall needs your GitHub token saved (the same one used to publish)") return end
online.clearAt = tonumber(C.last) or os.time()
saveOnline()
L.clearApplied = online.clearAt
C.clearLines()
publishNow(true)
C.system("Chat cleared. Everyone gets it within a few seconds.")
elseif c == "board" then
local url = L.boardOf()
if not url then C.system("Board: no valid link set in L.DEFAULT_BOARD") return end
C.system("Board host: " .. tostring(url:match("^https://([^/]+)")) .. "  |  request(): " .. (httpReq and "yes" or "NO"))
task.spawn(function()
local d = L.bRead(url)
if not d then C.system("Board READ FAILED: " .. tostring(L.boardErr)) return end
local n, f = 0, 0
for _ in ipairs(type(d.shared) == "table" and d.shared or {}) do n = n + 1 end
for _ in pairs(d.users) do f = f + 1 end
C.system("Board READ OK: " .. n .. " shared scripts, " .. f .. " players with favorites")
if L.owner() then
local ok = L.bWrite(url, d)
C.system(ok and "Board WRITE OK" or ("Board WRITE FAILED: " .. tostring(L.boardErr)))
end
local su = L.shareBoardOf()
if su then
local sd = L.bRead(su)
if not sd then C.system("Share board READ FAILED: " .. tostring(L.boardErr))
else
local sn = 0
for _ in ipairs(type(sd.shared) == "table" and sd.shared or {}) do sn = sn + 1 end
C.system("Share board READ OK: " .. sn .. " shared scripts")
if L.owner() then
local ok2 = L.bWrite(su, sd)
C.system(ok2 and "Share board WRITE OK" or ("Share board WRITE FAILED: " .. tostring(L.boardErr)))
end
end
end
end)
elseif c == "tr" or c == "translate" then
local first, remain = rest:match("^(%S+)%s+(.+)$")
local code, name = C.langCode(first)
local txt = code and remain or rest
code, name = code or "en", name or "English"
if txt == "" then C.system("Usage: /tr es hello world   (or  /tr hello  to translate to English)") return end
C.translate(txt, code, function(res)
if res then
res = (res:gsub("^[/%s]+", ""))
if res ~= "" then C.send(res) end
else notify("Translate", "Couldn't translate right now", nil, 3) end
end)
elseif c == "lancodes" or c == "langs" then
local parts = {}
for _, l in ipairs(C.LANGS) do if l[2] ~= "" then parts[#parts + 1] = l[2]:upper() .. " = " .. l[1] end end
C.system("Language codes: " .. table.concat(parts, ", ") .. ".  Use /tr es hello  or  /autotr pt")
elseif c == "autotr" then
local arg = rest:lower():match("^(%S*)")
if arg == "" then
C.system("Auto-translate is " .. ((S.chatLang or "") ~= "" and C.langName(S.chatLang) or "off") .. ". Use /autotr es to turn it on, /autotr off to turn it off.")
return
end
if arg == "off" then
S.chatLang = ""
else
local code = C.langCode(arg)
if not code then C.system("I don't know that language. Type /lancodes") return end
S.chatLang = code
end
scheduleSave()
if C.updateCtl then C.updateCtl() end
C.system("Auto-translate: " .. ((S.chatLang or "") ~= "" and C.langName(S.chatLang) or "off"))
elseif c == "find" or c == "search" then
local q = rest:lower():match("^%s*(.-)%s*$")
if #q < 2 then C.system("Usage: /find name   (searches Share script & Find script and the hub)") return end
local res = {}
for _, e in ipairs(C.allScripts()) do
if e.name:lower():find(q, 1, true) then res[#res + 1] = e end
end
if #res == 0 then C.system("No script found for \"" .. q:sub(1, 30) .. "\"") return end
local out = {}
for i = 1, math.min(#res, 8) do
local e = res[i]
out[#out + 1] = e.name:sub(1, 30) .. ((e.comm and e.by) and (" (by " .. e.by .. ")") or "")
end
C.system(#res .. " found: " .. table.concat(out, ", ") .. (#res > 8 and ", ..." or "") .. ".  Type #name to attach one.")
elseif c == "discord" then
L.copyDiscord()
elseif c == "ping" then
task.spawn(function()
local t0 = os.clock()
local body = C.get("https://ntfy.sh/v1/health")
C.system(body and ("Chat server ping: " .. math.floor((os.clock() - t0) * 1000) .. " ms") or "Couldn't reach the chat server")
end)
elseif c == "fps" then
local n, t0 = 0, os.clock()
local conn
conn = RunService.Heartbeat:Connect(function()
n = n + 1
if os.clock() - t0 >= 1 then conn:Disconnect(); C.system("FPS: " .. n) end
end)
elseif c == "lite" then
local arg = rest:lower():match("^(%S*)")
local on = arg == "on" or (arg == "" and S.particlesOn)
if on then
L.liteSaved = L.liteSaved or S.particlesOn
S.particlesOn = false
else
S.particlesOn = true
end
if L.applyParticles then pcall(L.applyParticles) end
scheduleSave()
C.system(on and "Lite mode on: particles are off for less lag. Type /lite off to bring them back." or "Lite mode off: particles are back.")
elseif c == "server" or c == "jobid" then
local nm = "this game"
pcall(function() nm = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end)
local age = math.floor(workspace.DistributedGameTime)
C.system(("%s | %d/%d players | server up %dm %ds | place %d"):format(tostring(nm):sub(1, 40), #Players:GetPlayers(), Players.MaxPlayers, age // 60, age % 60, game.PlaceId))
if type(game.JobId) == "string" and game.JobId ~= "" then
pcall(function() setclipboard(game.JobId) end)
C.system("Server id copied: " .. game.JobId)
end
elseif c == "rejoin" then
C.system("Rejoining...")
local TS = game:GetService("TeleportService")
local ok = pcall(function() TS:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) end)
if not ok then pcall(function() TS:Teleport(game.PlaceId, LP) end) end
elseif c == "time" then
local up = os.time() - (L.startT or os.time())
C.system(os.date("%H:%M:%S") .. " your time | hub open for " .. (up // 3600) .. "h " .. (up % 3600 // 60) .. "m")
elseif c == "tips" or c == "games" then
local key = c == "tips" and "chatTips" or "chatGames"
local arg = rest:lower():match("^(%S*)")
if arg == "on" then S[key] = true elseif arg == "off" then S[key] = false else S[key] = not S[key] end
scheduleSave()
if C.updateCtl then C.updateCtl() end
C.system(c .. ": " .. (S[key] and "on" or "off"))
elseif c == "mutes" and isAdmin then
local list = {}
for u, m in pairs(C.muted or {}) do
local e = type(m) == "table" and tonumber(m.e) or 0
list[#list + 1] = tostring(type(m) == "table" and m.n or u) .. (e > 0 and (" (" .. math.max(1, math.ceil((e - os.time()) / 60)) .. " min)") or "")
end
C.system(#list == 0 and "Nobody is muted." or ("Muted: " .. table.concat(list, ", ")))
elseif c == "unmute" and isAdmin then
local who = rest:match("^(%S+)")
local id = who and C.uids[who:lower()]
if not id then return notify("Unmute", "Haven't seen " .. tostring(who) .. " in the chat", nil, 3) end
L.chatUnmute(id, who)
elseif c == "unmuteall" and isAdmin then
L.unmuteAll()
elseif c == "mute" and isAdmin then
local who, mins = rest:match("^(%S+)%s*(%d*)")
local id = who and C.uids[who:lower()]
if not id then return notify("Mute", "Haven't seen " .. tostring(who) .. " in the chat", nil, 3) end
if C.adminIds[id] then return notify("Mute", "You can't mute an admin", nil, 3) end
L.chatMute(id, who, (tonumber(mins) or 0) * 60)
else
C.system("Unknown command. Type /help")
end
return
end
if C.isHate(msg) or (sc and C.isHate(sc.n)) then
return notify("Message blocked", "Racist or hateful language isn't allowed in the chat", nil, 4)
end
if C.isMuted(MYID) then
local m = C.muted[MYID]
local e = type(m) == "table" and tonumber(m.e) or 0
return notify("Muted", e > 0 and ("An admin muted you for " .. math.max(1, math.ceil((e - os.time()) / 60)) .. " more min") or "An admin muted you in the chat", nil, 3)
end
if os.clock() - C.lastSend < 1.2 then return notify("Slow down", "One message every second or so", nil, 2) end
if msg:lower() == C.lastMsg and os.clock() - C.lastSend < 20 then return notify("Duplicate", "You just said that", nil, 2) end
C.lastSend, C.lastMsg = os.clock(), msg:lower()
local p = {k = "m", i = uid(), u = MYID, n = LP.Name, t = msg, sc = sc}
if S.shareGame then
p.g = tonumber(game.PlaceId)
if type(game.JobId) == "string" and game.JobId ~= "" then p.j = game.JobId end
end
local to = toBox.Text:match("^%s*(.-)%s*$"):lower()
if to ~= "" then p.to = to:sub(1, 20) end
C.handle(p, true)
C.publish(p)
end
function C.submit()
local t, at = box.Text, C.attach
if not at then
local tok = t:match("#([%w_][%w_ ]*)$")
if tok then
tok = tok:gsub("%s+$", ""):lower()
for _, e in ipairs(C.allScripts()) do
if e.name:lower() == tok and #e.code <= 1500 then
at = {n = e.name:sub(1, 30), c = e.code}
t = t:gsub("#[%w_ ]*$", "")
break
end
end
end
end
box.Text, C.attach = "", nil
C.send(t, at)
C.suggest()
end
send.MouseButton1Click:Connect(C.submit)
box.FocusLost:Connect(function(enter) if enter then C.submit() end end)
function C.boardEdit(fn)
local url = L.boardOf()
if not url then return notify("Chat", "No board is set up yet", nil, 3) end
task.spawn(function()
local d = L.bRead(url)
if not d then return notify("Chat", "Couldn't reach the board", nil, 3) end
fn(d)
if L.bWrite(url, d) then
L.commBusy = false
if L.commPull then L.commPull() end
L.ping("board")
end
end)
end
function L.chatMute(u, n, secs)
if isAdmin and not adminOk() then return end
secs = tonumber(secs) or 0
local entry = {n = n, e = secs > 0 and (os.time() + secs) or 0}
local label = n .. (secs > 0 and (" for " .. math.ceil(secs / 60) .. " min") or "")
if readToken() then
-- owner with token: secure mute through the GitHub feed
online.muted = online.muted or {}
online.muted[u] = entry
for k, v in pairs(online.muted) do
if type(v) == "table" and (tonumber(v.e) or 0) > 0 and v.e < os.time() then online.muted[k] = nil end
end
saveOnline()
L.applyMuted()
publishNow(true)
notify("Muted", label, nil, 2)
return
end
-- admin without token: mute through the shared board
L.boardMuted = L.boardMuted or {}
L.boardMuted[u] = entry
L.applyMuted()
C.boardEdit(function(d)
if type(d.muted) ~= "table" then d.muted = {} end
d.muted[u] = entry
for k, v in pairs(d.muted) do
if type(v) == "table" and (tonumber(v.e) or 0) > 0 and v.e < os.time() then d.muted[k] = nil end
end
end)
notify("Muted", label, nil, 2)
end
function L.unmuteAll()
if isAdmin and not adminOk() then return end
L.boardMuted = {}
C.boardEdit(function(d) d.muted = {} end)
if readToken() then
online.muted = {}
saveOnline()
publishNow(true)
end
L.applyMuted()
notify("Chat", "Everyone is unmuted", nil, 2)
end
function L.chatUnmute(u, n)
if isAdmin and not adminOk() then return end
if L.boardMuted then L.boardMuted[u] = nil end
C.boardEdit(function(d) if type(d.muted) == "table" then d.muted[u] = nil end end)
if readToken() then
online.muted = online.muted or {}
online.muted[u] = nil
saveOnline()
publishNow(true)
elseif type(online.remoteMuted) == "table" and online.remoteMuted[u] then
notify("Unmute", "The owner muted this player. Only the owner can unmute", nil, 4)
end
L.applyMuted()
notify("Unmuted", n, nil, 2)
end
if isAdmin then C.adminUI = function()
local um = button(host, 0, 0, 92, 26, "Unmute all", L.P.ctrl, 0, 23)
um.AnchorPoint, um.Position, um.TextSize = V2(1, 0), U2(1, -10, 0, 7), 12
um.MouseButton1Click:Connect(function()
if not adminOk() then return end
L.boardMuted = {}
C.boardEdit(function(d) d.muted = {} end)
if readToken() then
online.muted = {}
saveOnline()
publishNow(true)
end
L.applyMuted()
notify("Chat", "Everyone is unmuted", nil, 2)
end)
C.pickF = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0), Size = UO(268, 128), BackgroundColor3 = L.P.card,
BorderSizePixel = 0, Visible = false, ZIndex = 40,
}, host)
round(C.pickF, 10)
L.fitList[#L.fitList + 1] = {new("UIScale", {}, C.pickF), 268, 128, host}
outline(C.pickF, 2, 0.3)
C.pickT = text(C.pickF, {Position = UO(10, 8), Size = U2(1, -50, 0, 22), Text = "", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
local xb = button(C.pickF, 0, 0, 24, 24, "X", L.P.ctrl, 0, 41)
xb.AnchorPoint, xb.Position, xb.TextSize = V2(1, 0), U2(1, -8, 0, 8), 12
xb.MouseButton1Click:Connect(function() C.pickF.Visible = false end)
local opts = {{"5 min", 300}, {"30 min", 1800}, {"1 hour", 3600}, {"24 hours", 86400}, {"Forever", 0}, {"Unmute", -1}}
for i, o in ipairs(opts) do
local b2 = button(C.pickF, 0, 0, 78, 32, o[1], o[2] == -1 and L.P.ctrl or Color3.fromRGB(150, 50, 50), 0, 41)
b2.Position, b2.TextSize = UO(10 + ((i - 1) % 3) * 86, 40 + math.floor((i - 1) / 3) * 40), 12
b2.MouseButton1Click:Connect(function()
C.pickF.Visible = false
if o[2] == -1 then L.chatUnmute(C.pickU, C.pickN) else L.chatMute(C.pickU, C.pickN, o[2]) end
end)
end
local mb = button(host, 0, 0, 70, 26, "Mute", Color3.fromRGB(150, 50, 50), 0, 23)
mb.AnchorPoint, mb.Position, mb.TextSize = V2(1, 0), U2(1, -108, 0, 7), 12
mb.MouseButton1Click:Connect(function()
local who = toBox.Text:match("^%s*(.-)%s*$")
local id = who ~= "" and C.uids[who:lower()]
if not id then return notify("Mute", "Tap a player's name in the chat first, then press Mute", nil, 3) end
if C.adminIds[id] then return notify("Mute", "You can't mute an admin", nil, 3) end
C.pickU, C.pickN = id, who
C.pickT.Text = "Mute " .. who:sub(1, 16) .. " for..."
C.pickF.Visible = true
end)
end; C.adminUI() end
C.LANGS = {
{"Off", ""}, {"English", "en"}, {"Spanish", "es"}, {"Portuguese", "pt"}, {"French", "fr"}, {"German", "de"}, {"Russian", "ru"}, {"Arabic", "ar"},
{"Turkish", "tr"}, {"Indonesian", "id"}, {"Hindi", "hi"}, {"Japanese", "ja"}, {"Korean", "ko"}, {"Chinese", "zh-CN"}, {"Filipino", "tl"},
{"Vietnamese", "vi"}, {"Polish", "pl"}, {"Italian", "it"},
{"Dutch", "nl"}, {"Swedish", "sv"}, {"Ukrainian", "uk"}, {"Thai", "th"}, {"Greek", "el"}, {"Hebrew", "iw"}, {"Czech", "cs"},
{"Romanian", "ro"}, {"Bengali", "bn"}, {"Urdu", "ur"}, {"Persian", "fa"}, {"Malay", "ms"}, {"Trad. Chinese", "zh-TW"},
}
function C.langName(code)
for _, l in ipairs(C.LANGS) do if l[2] == code then return l[1] end end
return code
end
function C.gameName(id)
if C.gname[id] or C.gpend[id] then return end
C.gpend[id] = true
task.spawn(function()
local ok, info = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(id) end)
C.gname[id] = ok and type(info) == "table" and type(info.Name) == "string" and info.Name:sub(1, 40) or "Unknown game"
C.refreshBadges()
end)
end
function C.deco(ln, p)
ln.Text = C.fmt(p)
local jb, pad = ln:FindFirstChild("JoinBtn"), ln:FindFirstChild("PadR")
local show = S.chatGames and p.g and p.j and p.u ~= MYID and not (p.g == tonumber(game.PlaceId) and p.j == game.JobId) or false
if jb then jb.Visible = show end
if pad then pad.PaddingRight = UDim.new(0, show and 48 or 6) end
end
function C.join(p)
local name = C.gname[p.g] or "that game"
askConfirm("Join " .. tostring(p.n):sub(1, 20) .. " in " .. name .. "?", function()
local TS = game:GetService("TeleportService")
local link = ("roblox://experiences/start?placeId=%d&gameInstanceId=%s"):format(p.g, p.j)
local failed = false
local conn = TS.TeleportInitFailed:Connect(function(plr, result, msg)
if plr ~= LP or failed then return end
failed = true
pcall(function() setclipboard(link) end)
notify("Couldn't join", (tostring(msg) ~= "" and tostring(msg) or tostring(result)):sub(1, 70) .. " | join link copied, paste it in your browser", nil, 8)
end)
local ok, err = pcall(function() TS:TeleportToPlaceInstance(p.g, p.j, LP) end)
if not ok then
ok = pcall(function()
local opt = Instance.new("TeleportOptions")
opt.ServerInstanceId = p.j
TS:TeleportAsync(p.g, {LP}, opt)
end)
end
if not ok then
failed = true
pcall(function() setclipboard(link) end)
notify("Couldn't join", "Join link copied, paste it in your browser", nil, 6)
else
notify("Joining...", name, nil, 4)
task.delay(15, function()
conn:Disconnect()
if not failed and LP.Parent then
pcall(function() setclipboard(link) end)
notify("Still not joined", "The server may be full, closed or private. Join link copied, paste it in your browser", nil, 8)
end
end)
end
end, "Join")
end
function C.translate(textIn, tl, cb)
task.spawn(function()
tl = tostring(tl or "en")
local up = function(x) return tostring(x):upper() end
local function bad(x)
local u = up(x)
return u:find("PLEASE SELECT", 1, true) or u:find("MYMEMORY WARNING", 1, true) or u:find("INVALID LANGUAGE", 1, true) or u:find("QUERY LENGTH LIMIT", 1, true)
end
local out, same
-- 1) Google (auto-detects the source language)
local body = C.get("https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. tl .. "&dt=t&q=" .. HttpService:UrlEncode(textIn))
if body then
local ok, d = pcall(HttpService.JSONDecode, HttpService, body)
if ok and type(d) == "table" and type(d[1]) == "table" then
local parts = {}
for _, seg in ipairs(d[1]) do if type(seg) == "table" and type(seg[1]) == "string" then parts[#parts + 1] = seg[1] end end
out = table.concat(parts)
end
end
-- 2) second Google endpoint
if not out or out == "" then
local b = C.get("https://clients5.google.com/translate_a/t?client=dict-chrome-ex&sl=auto&tl=" .. tl .. "&q=" .. HttpService:UrlEncode(textIn))
if b then
local ok, d = pcall(HttpService.JSONDecode, HttpService, b)
if ok and type(d) == "table" then
local f = d[1]
if type(f) == "table" then f = f[1] end
if type(f) == "string" then out = f end
end
end
end
-- 3) MyMemory (source auto-detected; its error texts are never shown as a translation)
if not out or out == "" then
local b2 = C.get("https://api.mymemory.translated.net/get?q=" .. HttpService:UrlEncode(textIn) .. "&langpair=Autodetect|" .. tl)
local ok, d = pcall(HttpService.JSONDecode, HttpService, b2 or "")
if ok and type(d) == "table" and type(d.responseData) == "table" and type(d.responseData.translatedText) == "string" then
local t = d.responseData.translatedText
if bad(t) then
if up(t):find("PLEASE SELECT", 1, true) then same = true end
else
out = t
end
end
end
if same and (not out or out == "") then out = textIn end
cb(out and out ~= "" and out or nil)
end)
end
function C.autoTranslate(p)
if p.sys or type(p.t) ~= "string" or #p.t < 2 or os.clock() - (C.atLast or 0) < 0.8 then return end
C.atLast = os.clock()
C.translate(p.t, S.chatLang, function(res)
if res and res:lower() ~= p.t:lower() then C.addLine({sys = true, t = "" .. tostring(p.n):sub(1, 20) .. ": " .. res, copy = res, i = "tr" .. uid(), ts = os.time()}) end
end)
end
function C.copyText(t)
pcall(function() setclipboard(t) end)
notify("Copied", t:sub(1, 40), nil, 2)
end
function C.updateCtl()
C.bGames.Text = "Games: " .. (S.chatGames and "on" or "off")
C.bLang.Text = "Translate: " .. C.langName(S.chatLang)
C.bShare.Text = "Share mine: " .. (S.shareGame and "on" or "off")
C.bTips.Text = "Tips: " .. (S.chatTips and "on" or "off")
C.bRe.Text = "Auto re-open: " .. (S.reopen and "on" or "off")
C.bTips.BackgroundColor3 = S.chatTips and L.P.btn or L.P.ctrl
C.bRe.BackgroundColor3 = S.reopen and L.P.btn or L.P.ctrl
C.bGames.BackgroundColor3 = S.chatGames and L.P.btn or L.P.ctrl
C.bShare.BackgroundColor3 = S.shareGame and L.P.btn or L.P.ctrl
C.bLang.BackgroundColor3 = S.chatLang ~= "" and L.P.btn or L.P.ctrl
if C.paintLang then C.paintLang() end
end
function C.openMenu(p)
C.menuP = p
C.menuT.Text = p.sc and ("" .. p.sc.n) or tostring(p.n):sub(1, 18) .. ": " .. tostring(p.t):sub(1, 30)
C.menuS.Visible = p.sc ~= nil
C.menuF.Visible = true
end
function C.pageNo(name)
for i, it in ipairs(ITEMS) do if it.name == name then return i, #ITEMS end end
return nil, #ITEMS
end
function L.showWhere(name)
if not L.whereF then return end
local idx, total = C.pageNo(name)
local label = name == ADD_PAGE and "Share script & Find script" or name
local ui = pageUI[name]
if ui and ui.current and ui.current ~= name then label = label .. " › " .. tostring(ui.current) end
local cnt = ui and ui.count and ui.count.Text and ui.count.Text:match("^%d+ scripts?")
local t = "" .. label .. (idx and ("  ·  Page " .. idx .. "/" .. total) or "") .. (cnt and ("  ·  " .. cnt) or "")
L.whereT.Text = t
L.whereF.Size = UO(math.clamp(#t * 6 + 24, 190, 460), 24)
L.whereF.Visible = true
L.whereTok = (L.whereTok or 0) + 1
local tok = L.whereTok
task.delay(6, function() if tok == L.whereTok and L.whereF then L.whereF.Visible = false end end)
end
function C.jump(page)
selectItem(page)
L.showWhere(page)
end
function C.allScripts()
local out, seen = {}, {}
local function add(list)
for _, e in ipairs(list or {}) do
if type(e) == "table" and type(e.name) == "string" and type(e.code) == "string" then
local k = e.name .. "\0" .. e.code
if not seen[k] then seen[k] = true; out[#out + 1] = e end
end
end
end
local ok, l1 = pcall(shownEntries, L.ALL)
if ok then add(l1) end
add(adminPages[ADD_PAGE])
add(L.comm)
add(userScripts)
return out
end
function C.suggest()
local rawFrag = box.Text:match("#([%w_ ]*)$")
local stripped = rawFrag and (rawFrag:gsub("%s+$", ""))
local frag = stripped
if rawFrag and (rawFrag:sub(1, 1) == " " or (rawFrag:match("%s$") and not stripped:find(" ", 1, true))) then frag = nil end
for _, c in ipairs(C.sugF:GetChildren()) do
if c:IsA("TextButton") then c:Destroy() end
end
local function chip()
if not C.attach then return end
local cb = button(C.sugF, 0, 0, 120, 22, "" .. C.attach.n .. "  X", L.P.btn, 0, 31)
cb.LayoutOrder, cb.TextSize = 0, 11
cb.Size = UO(#cb.Text * 5 + 16, 22)
cb.MouseButton1Click:Connect(function() C.attach = nil; C.suggest() end)
end
chip()
if not frag then C.sugF.Visible = C.attach ~= nil return end
frag = frag:lower()
local shown = 0
if not frag:find(" ", 1, true) then
local keys = {}
for k in pairs(C.TAGS) do if k:sub(1, #frag) == frag then keys[#keys + 1] = k end end
table.sort(keys)
local seen = {}
for _, k in ipairs(keys) do
local pg = C.TAGS[k]
if pg and not seen[pg] and shown < 5 then
seen[pg], shown = true, shown + 1
local idx, total = C.pageNo(pg)
local b = button(C.sugF, 0, 0, 120, 22, "#" .. k .. (idx and ("  ·  " .. idx .. "/" .. total) or ""), L.P.ctrl, 0, 31)
b.LayoutOrder, b.TextSize = shown, 11
b.Size = UO(#b.Text * 6 + 16, 22)
b.MouseButton1Click:Connect(function()
box.Text = box.Text:gsub("#[%w_ ]*$", "#" .. k .. " ")
C.sugF.Visible = false
L.showWhere(pg)
end)
end
end
end
if #frag >= 1 then
local cand = {}
for _, e in ipairs(C.allScripts()) do
local at = e.name:lower():find(frag, 1, true)
if at then cand[#cand + 1] = {e = e, s = at == 1 and 1 or 2} end
end
table.sort(cand, function(x, y) if x.s ~= y.s then return x.s < y.s end return x.e.name < y.e.name end)
for n = 1, math.min(#cand, 6) do
local e = cand[n].e
shown = shown + 1
local big = #e.code > 1500
local b = button(C.sugF, 0, 0, 120, 22, (big and "" or "") .. e.name:sub(1, 26), L.P.btn, 0, 31)
b.LayoutOrder, b.TextSize = 100 + n, 11
b.Size = UO(#b.Text * 5 + 16, 22)
b.MouseButton1Click:Connect(function()
box.Text = box.Text:gsub("#[%w_ ]*$", "")
if big then openViewer(e) else C.attach = {n = e.name:sub(1, 30), c = e.code} end
C.suggest()
end)
end
end
C.sugF.Visible = shown > 0 or C.attach ~= nil
end
C.HATE = {
chink = 1, chinks = 1, chinky = 1, gook = 1, gooks = 1, spic = 1, spics = 1, wetback = 1, wetbacks = 1, beaner = 1, beaners = 1,
kike = 1, kikes = 1, towelhead = 1, towelheads = 1, raghead = 1, ragheads = 1, darkie = 1, darkies = 1, coon = 1, coons = 1,
faggot = 1, faggots = 1, tranny = 1, trannies = 1,
}
C.HATE_PHRASES = {"white power", "heil hitler", "sieg heil", "gas the jews", "go back to africa", "porch monkey", "jungle bunny", "sand monkey"}
C.LEET = {["0"] = "o", ["1"] = "i", ["3"] = "e", ["4"] = "a", ["5"] = "s", ["7"] = "t", ["8"] = "b", ["9"] = "g", ["@"] = "a", ["$"] = "s", ["!"] = "i", ["|"] = "i"}
function C.badWord(w)
w = w:gsub("(%a)%1%1+", "%1%1")
if w:find("n+i+[gq][gq]+") and not w:find("niggard", 1, true) and not w:find("snigg", 1, true) then return true end
return C.HATE[w] == 1 or C.HATE[(w:gsub("(%a)%1", "%1"))] == 1
end
function C.isHate(t)
t = tostring(t):lower():gsub("\226\128[\139-\141]", ""):gsub("\239\187\191", "")
t = t:gsub("[01345789@$!|]", C.LEET)
local run = {}
local function flush()
if #run >= 3 and C.badWord(table.concat(run)) then return true end
run = {}
end
for w in t:gmatch("%a+") do
if C.badWord(w) then return true end
if #w == 1 then run[#run + 1] = w else if flush() then return true end run = {} end
end
if flush() then return true end
local flat = " " .. t:gsub("[^%a]+", " ") .. " "
for _, ph in ipairs(C.HATE_PHRASES) do
if flat:find(" " .. ph .. " ", 1, true) then return true end
end
return false
end
C.build = function()
local row = new("ScrollingFrame", {
Position = UO(10, 46), Size = U2(1, -20, 0, 24), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X, ZIndex = 23,
}, host)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, row)
local function mk(order, w)
local b = button(row, 0, 0, w, 22, "", L.P.ctrl, 0, 24)
b.LayoutOrder, b.TextSize = order, 11
return b
end
C.bGames, C.bLang, C.bLangPick, C.bShare, C.bTips, C.bRe = mk(1, 112), mk(2, 150), mk(3, 30), mk(4, 124), mk(5, 92), mk(6, 168)
C.bLangPick.Text = "▼"
C.bGames.MouseButton1Click:Connect(function() S.chatGames = not S.chatGames; scheduleSave(); C.updateCtl(); C.refreshBadges() end)
C.bShare.MouseButton1Click:Connect(function() S.shareGame = not S.shareGame; scheduleSave(); C.updateCtl() end)
C.bTips.MouseButton1Click:Connect(function() S.chatTips = not S.chatTips; scheduleSave(); C.updateCtl() end)
C.bRe.MouseButton1Click:Connect(function()
S.reopen = not S.reopen
scheduleSave(); C.updateCtl()
for _, r in ipairs(refreshers) do pcall(r) end
if S.reopen and L.queueReopen then L.queueReopen() end
notify("Auto re-open", S.reopen and "On: the Hub reopens by itself after you rejoin" or "Off", nil, 3)
end)
C.bLang.MouseButton1Click:Connect(function()
if S.chatLang ~= "" then
S.chatLangLast, S.chatLang = S.chatLang, ""
elseif S.chatLangLast ~= "" then
S.chatLang = S.chatLangLast
else
C.langF.Visible = true
return
end
scheduleSave(); C.updateCtl()
end)
C.bLangPick.MouseButton1Click:Connect(function() C.langF.Visible = true end)
C.sugF = new("ScrollingFrame", {
AnchorPoint = V2(0, 1), Position = U2(0, 10, 1, -76), Size = U2(1, -20, 0, 24), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X, Visible = false, ZIndex = 30,
}, host)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, C.sugF)
box:GetPropertyChangedSignal("Text"):Connect(function() C.suggest() end)
L.whereF = new("Frame", {
AnchorPoint = V2(0.5, 1), Position = U2(0.5, 0, 1, -8), Size = UO(300, 24), BackgroundColor3 = Color3.fromRGB(10, 10, 16),
BackgroundTransparency = 0.1, BorderSizePixel = 0, Visible = false, ZIndex = 55,
}, content)
round(L.whereF, 12)
outline(L.whereF, 1.5, 0.4)
L.whereT = text(L.whereF, {Size = U2(1, 0, 1, 0), Text = "", TextSize = 12, ZIndex = 56})
C.updateCtl()
C.menuF = new("Frame", {AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0), Size = UO(290, 236), BackgroundColor3 = L.P.card, BorderSizePixel = 0, Visible = false, ZIndex = 40}, host)
L.fitList[#L.fitList + 1] = {new("UIScale", {}, C.menuF), 290, 236, host}
round(C.menuF, 10)
outline(C.menuF, 2, 0.3)
C.menuT = text(C.menuF, {Position = UO(10, 6), Size = U2(1, -20, 0, 20), Font = Enum.Font.Nunito, Text = "", TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
local function mb(x, y, label, color, fn, parent)
local b = button(parent or C.menuF, 0, 0, 86, 28, label, color, 0, 41)
b.Position, b.TextSize = UO(x, y), 12
b.MouseButton1Click:Connect(fn)
return b
end
local grey = L.P.ctrl
mb(10, 30, "Copy", grey, function()
local p = C.menuP
C.menuF.Visible = false
if p then C.copyText(p.sc and p.sc.c or tostring(p.t)) end
end)
mb(102, 30, "↩ Reply", grey, function()
local p = C.menuP
C.menuF.Visible = false
if p and p.u ~= MYID then toBox.Text = tostring(p.n):sub(1, 20) end
end)
mb(194, 30, "Close", grey, function() C.menuF.Visible = false end)
C.menuS = new("Frame", {Position = UO(0, 62), Size = U2(1, 0, 0, 30), BackgroundTransparency = 1, Visible = false, ZIndex = 41}, C.menuF)
mb(10, 0, "▶ Run", L.P.btn, function()
local p = C.menuP
C.menuF.Visible = false
if p and p.sc then
askConfirm('Run "' .. p.sc.n .. '" from ' .. tostring(p.n):sub(1, 20) .. "? Names and badges in chat can be faked. Only run scripts you trust.", function() runScript({name = p.sc.n, code = p.sc.c}) end, "Run")
end
end, C.menuS)
mb(102, 0, "View", grey, function()
local p = C.menuP
C.menuF.Visible = false
if p and p.sc then openViewer({name = p.sc.n, code = p.sc.c}) end
end, C.menuS)
mb(194, 0, "Save", grey, function()
local p = C.menuP
C.menuF.Visible = false
if p and p.sc then L.toggleFav({name = p.sc.n, code = p.sc.c}) end
end, C.menuS)
text(C.menuF, {Position = UO(10, 96), Size = U2(1, -20, 0, 16), Text = "Translate this message to:", TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
local lg = new("ScrollingFrame", {
Position = UO(10, 116), Size = U2(1, -20, 1, -124), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 41,
}, C.menuF)
new("UIGridLayout", {CellSize = UO(82, 26), CellPadding = UO(4, 4), SortOrder = Enum.SortOrder.LayoutOrder}, lg)
for i, l in ipairs(C.LANGS) do
if l[2] ~= "" then
local b = button(lg, 0, 0, 82, 26, l[1], grey, 0, 42)
b.LayoutOrder, b.TextSize = i, 11
b.MouseButton1Click:Connect(function()
local p = C.menuP
C.menuF.Visible = false
if not p then return end
C.translate(p.sc and (p.t .. " " .. p.sc.n) or tostring(p.t), l[2], function(res)
if res then C.addLine({sys = true, t = "" .. l[1] .. ": " .. res, copy = res, i = "tr" .. uid(), ts = os.time()})
else notify("Translate", "Couldn't translate right now", nil, 3) end
end)
end)
end
end
C.langF = new("Frame", {AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0), Size = UO(290, 236), BackgroundColor3 = L.P.card, BorderSizePixel = 0, Visible = false, ZIndex = 40}, host)
L.fitList[#L.fitList + 1] = {new("UIScale", {}, C.langF), 290, 236, host}
round(C.langF, 10)
outline(C.langF, 2, 0.3)
text(C.langF, {Position = UO(10, 6), Size = U2(1, -50, 0, 22), Text = "Translate chat to:", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
local lx = button(C.langF, 0, 0, 24, 24, "X", grey, 0, 41)
lx.AnchorPoint, lx.Position, lx.TextSize = V2(1, 0), U2(1, -8, 0, 6), 12
lx.MouseButton1Click:Connect(function() C.langF.Visible = false end)
local lgp = new("ScrollingFrame", {
Position = UO(10, 36), Size = U2(1, -20, 1, -44), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 41,
}, C.langF)
new("UIGridLayout", {CellSize = UO(82, 26), CellPadding = UO(4, 4), SortOrder = Enum.SortOrder.LayoutOrder}, lgp)
C.langBtns = {}
for i, l in ipairs(C.LANGS) do
local b = button(lgp, 0, 0, 82, 26, l[2] == "" and "Off" or l[1], grey, 0, 42)
b.LayoutOrder, b.TextSize = i, 11
C.langBtns[#C.langBtns + 1] = {b = b, code = l[2]}
b.MouseButton1Click:Connect(function()
S.chatLang = l[2]
if l[2] ~= "" then S.chatLangLast = l[2] end
scheduleSave(); C.updateCtl()
C.langF.Visible = false
end)
end
function C.paintLang()
for _, e in ipairs(C.langBtns) do
e.b.BackgroundColor3 = e.code == S.chatLang and L.P.btn or grey
end
end
C.paintLang()
local at = button(host, 0, 0, 34, 34, "+", L.P.ctrl, 0, 23)
at.AnchorPoint, at.Position, at.TextSize = V2(1, 1), U2(1, -94, 1, -18), 16
C.attF = new("Frame", {AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0), Size = UO(300, 224), BackgroundColor3 = L.P.card, BorderSizePixel = 0, Visible = false, ZIndex = 40}, host)
L.fitList[#L.fitList + 1] = {new("UIScale", {}, C.attF), 300, 224, host}
round(C.attF, 10)
outline(C.attF, 2, 0.3)
text(C.attF, {Position = UO(10, 6), Size = U2(1, -20, 0, 22), Text = "Link a script in the chat", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
local an = inputBox(C.attF, 10, 34, 280, 28, "Script name", false, 41)
local ac = inputBox(C.attF, 10, 68, 280, 100, "Paste the script or a loadstring (up to 1,500 characters). Players can run, view or save it.", true, 41)
mb(10, 180, "Send", L.P.btn, function()
local nm, code = an.Text:match("^%s*(.-)%s*$"):sub(1, 30), ac.Text:match("^%s*(.-)%s*$")
if nm == "" or code == "" then return notify("Script", "Add a name and the script", nil, 3) end
code = normalizeCode(code)
if #code > 1500 then return notify("Too long", "Chat scripts can be up to 1,500 characters. Share bigger ones on #Share script & Find script", nil, 5) end
C.attF.Visible = false
an.Text, ac.Text = "", ""
C.send(box.Text, {n = nm, c = code})
box.Text = ""
end, C.attF).Size = UO(130, 30)
mb(150, 180, "Cancel", grey, function() C.attF.Visible = false end, C.attF).Size = UO(130, 30)
at.MouseButton1Click:Connect(function() C.attF.Visible = true end)
end
C.build()
task.spawn(function()
task.wait(3)
while sg.Parent do
pcall(C.resolveAdmins)
task.wait(300)
end
end)
C.tips = {
{"Go to #Share script & Find script to share your own scripts", ADD_PAGE, "#Share script & Find script"},
{"Automatic re-open after rejoin is off by default. Turn it on with the button here or in #Settings", "Settings", "#Settings"},
{"Type # and part of a script name to link one of DuaKNo's scripts in your message"},
{"Hold a message to copy or translate it. links a script, Games shows where people are playing", nil, nil},
{"Change the theme, fonts, window style and particles in #Settings", "Settings", "#Settings"},
{"Fly, speed, ESP and more are in #Universal", "Universal", "#Universal"},
{"Heart a script to save it in #Favorited. The most favorited ones are shown on top", L.FAVP, "#Favorited"},
{"Want thousands more scripts? Try #ScriptBlox scripts", "ScriptBlox scripts", "#ScriptBlox scripts"},
{"Tap a name to message that player privately. Type /help to see chat commands"},
{"Need a specific script? Send a request from the inbox on #" .. tostring(L.DUA), L.DUA, "#" .. tostring(L.DUA)},
{"Type #share, #favorites, #scriptblox or #info in a message to link that page"},
{"Use /tr es hello to translate your phrase and send it. Type /lancodes to see every language code (ES, PT, EN...)"},
{"Type # and a script name, like #Infinite, to attach any script from Share script & Find script"},
{"Type /help to see every command, or /help tr to learn how one works"},
{"Laggy? Type /lite to turn off particles, and /fps to check your FPS"},
{"Type /find fly to search every script from the chat"},
{"Type /autotr es to automatically translate everyone's messages into Spanish for you, or /autotr off"},
{"Need the Discord? Type /discord to copy the invite"},
}
task.spawn(function()
task.wait(1)
local i = 0
while sg.Parent do
i = i % #C.tips + 1
local tp = C.tips[i]
if S.chatTips then pcall(C.system, tp[1], tp[2], tp[3]) end
task.wait(150)
end
end)
task.spawn(function()
while sg.Parent do
pcall(C.updateFoot)
task.wait(5)
end
end)
task.spawn(C.startWS)
task.spawn(function()
while sg.Parent do
C.poll()
task.wait(os.clock() < C.backoff and 10 or (C.ws and 20) or (C.mode == "board" and 4 or (selected == CP and 3 or 5)))
end
end)
task.spawn(function()
task.wait(10)
if isAdmin and L.owner and L.owner() and L.makeBoard and not L.boardOf() then L.makeBoard() end
end)
end
applyAll()
-- Dua's Library npoint feed: publishing and syncing
do
(function()
-- search the whole of Roblox by game name (used by Share script and Completed script request)
L.gsCache, L.gsCount = {}, 0
local gsSession = HttpService:GenerateGUID(false)
local function getJson(url)
if httpReq then
local ok, res = pcall(httpReq, {Url = url, Method = "GET", Headers = {Accept = "application/json"}})
local sc = ok and type(res) == "table" and tonumber(res.StatusCode or 200) or 0
if sc >= 200 and sc < 300 and type(res.Body) == "string" then
local ok2, d = pcall(HttpService.JSONDecode, HttpService, res.Body)
if ok2 and type(d) == "table" then return d end
end
end
local ok, body = pcall(function() return game:HttpGet(url) end)
if ok and type(body) == "string" then
local ok2, d = pcall(HttpService.JSONDecode, HttpService, body)
if ok2 and type(d) == "table" then return d end
end
end
local function cleanName(n) return (tostring(n):gsub("%c", " "):sub(1, 40)) end
local function parseSearch(d)
if type(d.searchResults) ~= "table" then return nil end
local out, ids = {}, {}
for _, g in ipairs(d.searchResults) do
if type(g) == "table" and type(g.contents) == "table" and (g.contentGroupType == nil or g.contentGroupType == "Game") then
for _, c in ipairs(g.contents) do
if type(c) == "table" and (c.contentType == nil or c.contentType == "Game") and #out + #ids < 8 then
if type(c.name) == "string" and tonumber(c.rootPlaceId) then
out[#out + 1] = {name = cleanName(c.name), gid = tostring(math.floor(tonumber(c.rootPlaceId)))}
elseif tonumber(c.contentId) then
ids[#ids + 1] = math.floor(tonumber(c.contentId))
end
end
end
end
end
if #out == 0 and #ids > 0 then
-- the search only gave universe ids: look up their names
local list = {}
for i = 1, math.min(#ids, 6) do list[i] = tostring(ids[i]) end
for _, host in ipairs({"https://games.roblox.com", "https://games.roproxy.com"}) do
local info = getJson(host .. "/v1/games?universeIds=" .. table.concat(list, ","))
if info and type(info.data) == "table" then
for _, g in ipairs(info.data) do
if type(g) == "table" and type(g.name) == "string" and tonumber(g.rootPlaceId) then
out[#out + 1] = {name = cleanName(g.name), gid = tostring(math.floor(tonumber(g.rootPlaceId)))}
end
end
break
end
end
end
return out
end
-- cb(list) gets {name, gid} entries, or nil if Roblox couldn't be reached
function L.robloxSearch(q, cb)
q = tostring(q or ""):match("^%s*(.-)%s*$")
if #q < 2 then return cb({}) end
local key = q:lower()
if L.gsCache[key] then return cb(L.gsCache[key]) end
task.spawn(function()
local out
for _, host in ipairs({"https://apis.roblox.com", "https://apis.roproxy.com"}) do
local d = getJson(host .. "/search-api/omni-search?searchQuery=" .. HttpService:UrlEncode(q) .. "&sessionId=" .. gsSession .. "&pageType=all")
if d then
out = parseSearch(d)
if out then break end
end
end
if out then
if L.gsCount > 80 then L.gsCache, L.gsCount = {}, 0 end
L.gsCache[key] = out
L.gsCount = L.gsCount + 1
end
cb(out)
end)
end
-- mix Roblox search results with the built-in matches
function L.mixGames(remote, localItems, n)
local out, seen = {}, {}
local function add(it)
if it and it.name and #out < n and not seen[it.name:lower()] then
seen[it.name:lower()] = true
out[#out + 1] = it
end
end
for i = 1, math.max(#remote, #localItems) do
local r = remote[i]
if r then add({label = "" .. r.name, name = r.name, gid = r.gid}) end
add(localItems[i])
end
return out
end
local function me() return verName or LP.Name end
local function keyOf(name, e) return name .. "\0" .. e.name .. "\0" .. e.code end
L.boardDel = {}
function L.boardMarkDel(name, e)
if L.BOARD_SECTIONS[name] then L.boardDel[keyOf(name, e)] = true end
end
local function pullBoardPages()
local url = L.boardUrlOf()
if not url then return nil, "no board link set" end
local d = L.bRead(url)
if not d then return nil, L.boardErr or "can't reach the board" end
local out = {}
if type(d.pages) == "table" then
for name, list in pairs(d.pages) do
if L.BOARD_SECTIONS[name] then out[name] = cleanList(list) end
end
end
return out
end
local busy = false
function L.boardPublish(manual)
if not (isAdmin and adminOk()) then return end
if not L.boardUrlOf() then
if manual then notify("Dua's Library board", "Paste your npoint link into L.DUA_BOARD first", nil, 4) end
return
end
if busy then return end
busy = true
task.spawn(function()
local url = L.boardUrlOf()
local cur, err = pullBoardPages()
if not cur then
busy = false
return notify("Dua's Library board", "Couldn't reach the board (" .. tostring(err) .. ")", nil, 4)
end
local out, seen = {}, {}
local function put(name, e)
local k = keyOf(name, e)
if seen[k] then return end
seen[k] = true
out[name] = out[name] or {}
table.insert(out[name], e)
end
local mine = me():lower()
for name in pairs(L.BOARD_SECTIONS) do
if L.owner() then
-- owner: own scripts from this device + everything already on the board (minus what the owner removed this session)
for _, e in ipairs(adminPages[name] or {}) do
if not L.isAdminPost(name, e) then put(name, e) end
end
for _, e in ipairs(cur[name] or {}) do
if not L.boardDel[keyOf(name, e)] then put(name, e) end
end
else
-- other admins: keep everything on the board that isn't theirs, then add their own scripts from this device
for _, e in ipairs(cur[name] or {}) do
if not (L.isAdminPost(name, e) and e.by:lower() == mine) then put(name, e) end
end
for _, e in ipairs(adminPages[name] or {}) do
if L.isAdminPost(name, e) and e.by:lower() == mine then put(name, e) end
end
end
end
local same, n, m = true, 0, 0
for name, list in pairs(cur) do
for _, e in ipairs(list) do
n = n + 1
if not seen[keyOf(name, e)] then same = false end
end
end
for _ in pairs(seen) do m = m + 1 end
if same and n == m then
busy = false
if manual then notify("Dua's Library board", "Already up to date", nil, 2) end
return
end
local ok = L.bWrite(url, {v = 1, pages = out})
busy = false
if not ok then
return notify("Dua's Library board", "Couldn't save (" .. tostring(L.boardErr) .. ")", nil, 4)
end
notify("Dua's Library board", "Saved, everyone will see it", nil, 3)
end)
end
-- admins pull the board now and then so they see each other's posts (and removals)
function L.boardPullAdmin()
if not isAdmin then return end
local bp = L.boardFetch()
if not bp then return end
local changed, mine = false, me():lower()
for name in pairs(L.BOARD_SECTIONS) do
local list = adminPages[name]
if list then
local inBin = {}
for _, e in ipairs(bp[name] or {}) do
local k = keyOf(name, e)
inBin[k] = true
local have = false
for _, x in ipairs(list) do
if x.name == e.name and x.code == e.code then have = true break end
end
if not have and not L.boardDel[k] then table.insert(list, e); changed = true end
end
for i = #list, 1, -1 do
local x = list[i]
if L.isAdminPost(name, x) and x.by:lower() ~= mine and not inBin[keyOf(name, x)] then
table.remove(list, i)
changed = true
end
end
end
end
if changed then
writeLocal()
for _, ui in pairs(pageUI) do renderPage(ui.current) end
end
end
if isAdmin and L.boardUrlOf() then
task.spawn(function()
while sg.Parent do
task.wait(60)
L.boardPullAdmin()
end
end)
end
end)()
end
selectItem(L.DUA)
playSound(SND.click)
if not isAdmin and feedUrl ~= "" then
task.spawn(function()
while sg.Parent do
task.wait(60)
refreshOnline(true)
end
end)
end
task.spawn(function()
local t0 = os.clock()
while not feedDone and os.clock() - t0 < 6 do task.wait(0.3) end
while sg.Parent do
if L.commPull then L.commPull() end
task.wait(60)
end
end)
if isAdmin then
task.spawn(function()
while sg.Parent and isAdmin do
task.wait(3)
adminOk()
end
end)
end
task.spawn(function()
local icon, done = nil, false
task.spawn(function()
local id = nil
if not id then
local ok, r = pcall(Players.GetUserIdFromNameAsync, Players, "DuaKNo")
if ok then id = r end
end
if id then
local ok, r = pcall(Players.GetUserThumbnailAsync, Players, id, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
if ok then icon = r end
end
done = true
end)
local t0 = os.clock()
while not done and os.clock() - t0 < 2 do task.wait(0.1) end
L.nolog[WINDOW_TITLE] = true
notify(WINDOW_TITLE, "Made By DuaKNo", icon)
task.wait(NOTIF_TIME + 0.4)
notify("Follow on Instagram", "Me_DuaKNo", icon)
task.wait(NOTIF_TIME + 0.4)
notify("Join our Discord", "discord.gg/empgqd5qpq", icon, 4)
if isAdmin then
task.wait(NOTIF_TIME + 0.4)
playSound(SND.ok)
notify("Welcome Admin", LP.DisplayName)
elseif tampered then
task.wait(NOTIF_TIME + 0.4)
notify("Admin check failed", "Your name doesn't match your account, so admin tools are off", nil, 3)
end
if not isAdmin and online.remote and online.remote.id ~= S.seenNotice then
task.wait(NOTIF_TIME + 0.4)
online.show()
end
L.checkMsgs()
task.delay(6, L.syncFavs)
end)
