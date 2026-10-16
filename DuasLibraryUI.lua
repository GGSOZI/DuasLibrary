local Players, TweenService, UIS, RunService, StarterGui, HttpService =
game:GetService("Players"), game:GetService("TweenService"), game:GetService("UserInputService"),
game:GetService("RunService"), game:GetService("StarterGui"), game:GetService("HttpService")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
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
local TITLE_H, PAD = 36, 10
local PARTICLE_MAX = 150
local WINDOW_TITLE = "Dua's Library"
local SB_CLOSED, SB_OPEN = 36, 140
local SB_TWEEN = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
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
font = "Nunito", style = "Shatter", bold = true,
walkSpeed = 16, jumpPower = 50, gravity = 196.2, fov = 70, flySpeed = 60, infJump = false, noclip = false, fly = false,
winW = 560, winH = 350,
chatGames = false, shareGame = true, chatLang = "", chatLangLast = "", helpSeen = "",
shareAdd = true, dmSeen = "", shareSort = "new", bgUrl = "", bgVis = 0.75, bgOn = true, bgMig = false, bgMig2 = false, bgPreset = 1,
}
local LIMITS = {
hue = {0, 1}, sat = {0.05, 1}, winTrans = {0, 0.6},
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
local FAM = "rbxasset://fonts/families/"
local function new(class, props, parent)
local o = Instance.new(class)
for k, v in pairs(props) do o[k] = v end
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
local themedFill = setmetatable({}, {__mode = "k"})
local function outline(o, thick, trans)
local st = new("UIStroke", {Thickness = thick * (L.ss or 1), Transparency = trans, Color = themeStroke}, o)
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
local function button(parent, x, y, w, h, label, color, trans, z)
local b = new("TextButton", {
Position = UO(x, y), Size = UO(w, h), BackgroundColor3 = color or WHITE, BackgroundTransparency = trans or 0,
BorderSizePixel = 0, AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 14,
Text = label, TextColor3 = WHITE, ZIndex = z,
}, parent)
round(b, 8)
local base = b.BackgroundTransparency
b.MouseEnter:Connect(function() tween(b, FAST, {BackgroundTransparency = math.max(base - 0.15, 0)}) end)
b.MouseLeave:Connect(function() tween(b, FAST, {BackgroundTransparency = base}) end)
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
table.insert(L.log, 1, {t = tostring(t), m = tostring(msg), at = os.date("%H:%M")})
if #L.log > 60 then table.remove(L.log) end
L.unread = L.unread + 1
if L.badge then L.badge() end
end
local function notify(t, msg, icon, dur)
pcall(StarterGui.SetCore, StarterGui, "SendNotification",
{Title = t, Text = msg, Icon = icon, Duration = dur or NOTIF_TIME})
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
{name = "Shatter", r = 1.2, stroke = 1.1, tile = Color3.fromRGB(11, 11, 24), hot = Color3.fromRGB(40, 38, 74), tileT = 0, plus = Color3.fromRGB(34, 160, 72), plusHot = Color3.fromRGB(46, 190, 90), plusT = 0, wt = 0, pm = 1, hv = 1.05, tf = "FredokaOne", ab = 3, img = true, barT = 0.38, sbT = 0.3},
{name = "Solid", r = 1, stroke = 1, tile = Color3.fromRGB(10, 10, 14), hot = Color3.fromRGB(34, 34, 44), tileT = 0, plus = Color3.fromRGB(34, 160, 72), plusHot = Color3.fromRGB(46, 190, 90), plusT = 0, wt = 0, pm = 1, hv = 1.04, tf = "FredokaOne", ab = 3},
{name = "Glass", r = 1.4, stroke = 0.8, tile = Color3.fromRGB(58, 58, 84), hot = Color3.fromRGB(84, 84, 116), tileT = 0, plus = Color3.fromRGB(80, 220, 130), plusHot = Color3.fromRGB(120, 255, 170), plusT = 0, wt = 0.22, pm = 0.8, hv = 1.06, tf = "Gotham", ab = 3, pcol = {Color3.fromRGB(255,255,255), Color3.fromRGB(190,225,255), Color3.fromRGB(220,200,255), Color3.fromRGB(200,255,240)}},
{name = "Sharp", r = 0.15, stroke = 1.6, tile = Color3.fromRGB(22, 22, 22), hot = Color3.fromRGB(48, 48, 48), tileT = 0, plus = Color3.fromRGB(40, 150, 60), plusHot = Color3.fromRGB(60, 190, 80), plusT = 0, wt = 0, pm = 1.3, hv = 1, tf = "GothamBlack", ab = 2},
{name = "Neon", r = 0.8, stroke = 2.4, tile = Color3.fromRGB(4, 4, 8), hot = Color3.fromRGB(22, 14, 36), tileT = 0, plus = Color3.fromRGB(0, 190, 110), plusHot = Color3.fromRGB(30, 240, 150), plusT = 0, wt = 0, pm = 1.9, hv = 1.09, tf = "GothamBlack", ab = 5, pcol = {Color3.fromRGB(0,255,255), Color3.fromRGB(255,0,200), Color3.fromRGB(120,255,80), Color3.fromRGB(255,255,0)}},
{name = "Soft", r = 1.8, stroke = 0.5, tile = Color3.fromRGB(46, 40, 66), hot = Color3.fromRGB(70, 60, 98), tileT = 0, plus = Color3.fromRGB(70, 190, 110), plusHot = Color3.fromRGB(90, 215, 130), plusT = 0, wt = 0.08, pm = 0.55, hv = 1.07, tf = "Cartoon", ab = 4, pcol = {Color3.fromRGB(255,255,255), Color3.fromRGB(255,200,225), Color3.fromRGB(255,230,200), Color3.fromRGB(210,255,225)}},
{name = "Terminal", r = 0, stroke = 1.4, tile = Color3.fromRGB(0, 14, 0), hot = Color3.fromRGB(0, 40, 6), tileT = 0, plus = Color3.fromRGB(0, 120, 30), plusHot = Color3.fromRGB(0, 160, 44), plusT = 0, wt = 0, pm = 0.45, hv = 1, tf = "Code", ab = 2, pcol = {Color3.fromRGB(0,255,70), Color3.fromRGB(0,200,50), Color3.fromRGB(120,255,120), Color3.fromRGB(0,150,40)}},
}
function L.cur()
for _, st in ipairs(L.styles) do if st.name == S.style then return st end end
return L.styles[1]
end
L.rs, L.ss = L.cur().r, L.cur().stroke
L.pm, L.hv = L.cur().pm or 1, L.cur().hv or 1.04
local scheduleSave = debounce(0.4, function() writeJson(FILE.SETTINGS, S) end)
if not S.reopenMig then S.reopenMig, S.reopen = true, false; scheduleSave() end
if not S.bgMig then S.bgMig, S.style = true, "Shatter"; scheduleSave() end
if not S.bgMig2 then S.bgMig2, S.bgVis, S.winTrans, S.bgPreset = true, 0.75, 0.6, 1; scheduleSave() end
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
notify("📢 " .. tostring(from):sub(1, 24), tostring(msg):sub(1, 140), nil, 6)
local old = PG:FindFirstChild("DuaKNoMsg")
if old then old:Destroy() end
local gui = new("ScreenGui", {Name = "DuaKNoMsg", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999}, PG)
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
for _, x in ipairs(out[to]) do if x.name == e.name and x.code == e.code then dup = true end end
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
if x.name == e.name and x.code == e.code then dup = true end
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
{name = "Dua's favorites", icon = "⭐"}, {name = "NPCs", icon = "🧍"},
{name = "Weapons", icon = "⚔️"}, {name = "Utility", icon = "🛠"},
}
local ITEMS = {
{name = L.DUA, icon = "📜"},
{name = "Completed script request", icon = "✅", custom = true, sub = "Scripts Dua finished for players' requests"},
{name = L.FAVP, icon = "❤️"},
{name = ADD_PAGE, icon = "➕"},
{name = "ScriptBlox scripts", icon = "🌐", custom = true, sub = "Live from scriptblox.com, nothing saved on your device"},
{name = "Global chat", icon = "💬", custom = true, sub = "Live chat with everyone using Dua's Library"},
{name = "Universal", icon = "⚡", custom = true, sub = "Speed, jump, fly and more"},
{name = "Info", icon = "ℹ️", custom = true, sub = "What you should know about this library"},
}
if isAdmin then table.insert(ITEMS, {name = "Admin", icon = "🛡", custom = true, sub = "Admin tools"}) end
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
[L.DUA] = {{name = L.ALL, icon = "📚", label = "All"}},
[L.FAVP] = {{name = L.FAVL, icon = "🤍", label = "Favorite"}, {name = L.FAVD, icon = "❤️", label = "Favorited by Dua"}},
}
for _, sec in ipairs(SECTIONS) do table.insert(L.tabs[L.DUA], sec) end
if isAdmin then table.insert(L.tabs[L.FAVP], {name = L.CHK, icon = "🔍", label = "Check favoritisms"}) end
for page, list in pairs(L.tabs) do
for _, t in ipairs(list) do L.uiOf[t.name] = page end
end
function L.favList() return isAdmin and adminPages[L.FAVD] or L.favs end
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
local old = PG:FindFirstChild("DuaKNoUI")
if old then old:Destroy() end
end
local sg = new("ScreenGui", {Name = "DuaKNoUI", ResetOnSpawn = false, IgnoreGuiInset = true}, PG)
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
BackgroundColor3 = Color3.fromRGB(10, 0, 25), BackgroundTransparency = 0.35,
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
local winStroke = outline(win, 2, 0.25)
new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.7),
})}, winStroke)
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
local shapes = {"circle", "square", "triangle"}
for i = 1, PARTICLE_MAX do
local kind, sz = shapes[math.random(3)], math.random(4, 13)
local o
if kind == "triangle" then
o = new("TextLabel", {
Text = "▲", Font = Enum.Font.Nunito, TextSize = math.max(8, math.floor(sz * 1.9)),
BackgroundTransparency = 1, Size = UO(sz * 2, sz * 2),
})
else
o = new("Frame", {BorderSizePixel = 0, Size = UO(sz, sz)})
round(o, kind == "circle" and 99 or 3)
end
o.AnchorPoint, o.ZIndex, o.Parent = V2(0.5, 0.5), 2, layer
parts[i] = {
o = o, s = sz, kind = kind, ci = math.random(4),
baseTrans = 0.55 + (1 - (sz - 4) / 9) * 0.3,
x = math.random(X_MIN, math.max(layerW - sz, X_MIN + 1)),
y = math.random(-20, layerH + 30),
vy = math.random(16, 24),
rot = math.random(0, 360),
spin = math.random(10, 28) * (math.random(2) == 1 and 1 or -1),
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
for i = 1, count do
local p = parts[i]
p.y = p.y + p.vy * speed * dt
if p.y > layerH + p.s then
p.y = -math.random(0, 20)
p.x = math.random(X_MIN, math.max(layerW - p.s, X_MIN + 1))
p.spin = math.random(10, 28) * (math.random(2) == 1 and 1 or -1)
end
p.rot = (p.rot + p.spin * speed * dt) % 360
local alpha = 1
if p.y > layerH - 55 then alpha = math.clamp((layerH + p.s - p.y) / 55, 0, 1) end
if p.y < 45 then alpha = math.min(alpha, math.clamp(p.y / 45, 0, 1)) end
local tr = p.baseTrans + (1 - p.baseTrans) * (1 - alpha)
if p.kind == "triangle" then p.o.TextTransparency = tr else p.o.BackgroundTransparency = tr end
p.o.Position = U2(0, p.x, 1, -p.y)
p.o.Rotation = p.rot
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
Position = UO(SB_CLOSED + 10, 0), Size = U2(1, -(SB_CLOSED + 142), 1, 0),
Text = WINDOW_TITLE, TextSize = 19, Font = Enum.Font.FredokaOne, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4,
})
fit(title, 17, 10)
local minBtn = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -10, 0.5, 0), Size = UO(24, 24),
BackgroundColor3 = WHITE, BackgroundTransparency = 0.7, BorderSizePixel = 0,
Font = Enum.Font.Nunito, TextSize = 20, Text = "-", TextColor3 = WHITE,
AutoButtonColor = false, ZIndex = 4,
}, bar)
round(minBtn, 6)
L.miniImg = new("ImageLabel", {AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, Visible = false, ZIndex = 5}, minBtn)
minBtn.MouseEnter:Connect(function() if minimized then return end tween(minBtn, FAST, {BackgroundTransparency = 0.4}) end)
minBtn.MouseLeave:Connect(function() if minimized then return end tween(minBtn, FAST, {BackgroundTransparency = 0.7}) end)
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
local sbEdge = new("Frame", {AnchorPoint = V2(1, 0), Position = U2(1, 0, 0, 0), Size = U2(0, 2, 1, 0), BackgroundTransparency = 0.15, BorderSizePixel = 0, ZIndex = 7}, sidebar)
local sbDivider = new("Frame", {Position = UO(0, TITLE_H - 2), Size = U2(1, 0, 0, 2), BackgroundTransparency = 0.15, BorderSizePixel = 0, ZIndex = 7}, sidebar)
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
Position = UO(8, 0), Size = U2(1, -8, 1, 0), Text = "Settings", TextSize = 15,
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
AnchorPoint = V2(0, 1), Position = U2(0, 5, 1, -22), Size = UO(26, 26), BackgroundColor3 = Color3.fromRGB(30, 30, 40),
BorderSizePixel = 0, Image = "", ZIndex = 10,
}, sidebar)
round(avatar, 99)
outline(avatar, 1.5, 0.2)
local nm = text(sidebar, {
AnchorPoint = V2(0, 1), Position = U2(0, 38, 1, -22), Size = U2(1, -44, 0, 26), Text = LP.DisplayName, TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1, ZIndex = 10,
})
fit(nm, 13, 8)
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
tween(row, FAST, {BackgroundTransparency = (n == name) and 0.5 or 1})
end
for n, b in pairs(bars) do tween(b, FAST, {BackgroundTransparency = (n == name) and 0 or 1}) end
tween(headHL, FAST, {BackgroundTransparency = (name == "Settings") and 0.5 or 1})
for n, page in pairs(pages) do page.Visible = (n == name) end
if L.renderDirty then L.renderDirty(name) end
end
function setOpen(state)
opened = state
local w = state and SB_OPEN or SB_CLOSED
tween(sidebar, SB_TWEEN, {Size = U2(0, w, 1, 0)})
tween(content, SB_TWEEN, {Position = UO(w, TITLE_H), Size = U2(1, -w, 1, -TITLE_H)})
tween(title, SB_TWEEN, {Position = UO(w + 10, 0), Size = U2(1, -(w + 142), 1, 0)})
local fade = TweenInfo.new(0.2)
local tr = state and 0 or 1
tween(menuLabel, fade, {TextTransparency = tr})
for _, l in ipairs(labels) do tween(l, fade, {TextTransparency = tr}) end
bump()
end
local function makeSwitch(parent, anchor, pos, key, apply, guard)
local btn = new("TextButton", {
AnchorPoint = anchor, Position = pos, Size = UO(42, 22),
Text = "", AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 21,
}, parent)
round(btn, 11)
local knob = new("Frame", {AnchorPoint = V2(0, 0.5), Size = UO(16, 16), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 22}, btn)
round(knob, 8)
local function refresh()
local on = S[key]
tween(knob, FAST, {Position = U2(0, on and 23 or 3, 0.5, 0)})
tween(btn, FAST, {BackgroundColor3 = on and accentColor or Color3.fromRGB(90, 90, 105)})
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
playSound(SND.run)
task.spawn(function()
local setId = setthreadidentity or set_thread_identity or setidentity or (syn and syn.set_thread_identity)
if setId then pcall(setId, 8) end
local fn, err = loadstring(entry.code)
if not fn then notify("Script error: " .. entry.name, tostring(err):sub(1, 120), nil, 3) return end
local ok, e = pcall(fn)
if not ok then notify("Error in " .. entry.name, tostring(e):sub(1, 120), nil, 3) end
end)
end
local function overlay(name, z)
local f = new("Frame", {
Name = name, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0),
BackgroundTransparency = 0.4, BorderSizePixel = 0, Active = true, Visible = false, ZIndex = z,
}, win)
round(f, 12)
return f
end
local function card(parent, w, h, z)
local c = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UO(w, h),
BorderSizePixel = 0, ZIndex = z,
}, parent)
round(c, 12)
outline(c, 2, 0.2)
return c
end
local modal = overlay("AddMenu", 40)
local modalCard = card(modal, 500, 322, 41)
local modalTitle = text(modalCard, {
Position = UO(18, 10), Size = U2(1, -36, 0, 26), Text = "Add script", TextSize = 18,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42,
})
fit(modalTitle, 18, 9)
function L.modalLabel(x, y, w, t)
text(modalCard, {Position = UO(x, y), Size = UO(w, 14), Text = t, TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42})
end
L.modalLabel(18, 40, 200, "NAME")
L.modalLabel(18, 90, 230, "SCRIPT OR LINK")
L.modalLabel(18, 198, 230, "ADD A DESCRIPTION (optional)")
L.modalLabel(262, 40, 220, "WHAT GAME IS IT FOR? (name or game ID)")
L.modalLabel(262, 190, 220, "TYPE (tick all that apply)")
local function inputBox(parent, x, y, w, h, placeholder, multi, z)
local tb = new("TextBox", {
Position = UO(x, y), Size = UO(w, h), BackgroundColor3 = Color3.new(0, 0, 0),
BackgroundTransparency = 0.45, BorderSizePixel = 0, ZIndex = z,
Font = multi and Enum.Font.RobotoMono or Enum.Font.Nunito, TextSize = 13,
TextColor3 = WHITE, PlaceholderColor3 = Color3.fromRGB(170, 160, 190), PlaceholderText = placeholder,
Text = "", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = multi and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
MultiLine = multi, TextWrapped = multi, ClipsDescendants = true,
}, parent)
round(tb, 8)
new("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, multi and 6 or 0)}, tb)
return tb, outline(tb, 1.5, 0.5)
end
local nameBox, nameStroke = inputBox(modalCard, 18, 55, 232, 30, "Name your script", false, 42)
local codeBox, codeStroke = inputBox(modalCard, 18, 105, 232, 86, "Paste the script, or a pastebin link", true, 42)
local descBox = inputBox(modalCard, 18, 214, 232, 50, "What does it do? (optional)", true, 42)
descBox.Font = Enum.Font.Nunito
local modalAdd = button(modalCard, 18, 276, 300, 34, "Add script", Color3.fromRGB(34, 160, 72), 0, 42)
local modalCancel = button(modalCard, 326, 276, 156, 34, "Cancel", WHITE, 0.85, 42)
-- game picker: closest matches while typing, game id lookup, Keyless / Universal / FE
L.m = {kinds = {}}
do
local M2 = L.m
M2.gameBox, M2.gameStroke = inputBox(modalCard, 262, 55, 220, 30, "Type a game, e.g. B  or a game ID", false, 42)
local sugBtns, sugData, sugTok, setting = {}, {}, 0, false
for i = 1, 3 do
local b = new("TextButton", {
Position = UO(262, 90 + (i - 1) * 27), Size = UO(220, 24), BackgroundColor3 = Color3.fromRGB(58, 58, 84), BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = "", TextColor3 = WHITE,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Visible = false, ZIndex = 43,
}, modalCard)
round(b, 6)
new("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 6)}, b)
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
text(modalCard, {Position = UO(262, 172), Size = UO(220, 14), Font = Enum.Font.Nunito, Text = "Tap a match, or type your own. Universal needs no game.", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42})
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
setSug({{label = "🔎 Looking up game ID " .. idq .. "..."}})
L.gameFromId(idq, function(nm)
if my ~= sugTok then return end
if nm then setSug({{label = "🎮 " .. nm .. "  (ID " .. idq .. ")", name = nm, gid = idq}})
else setSug({{label = "No game found for " .. idq .. ", tap to use the ID", name = "Game ID " .. idq, gid = idq}}) end
end)
return
end
local items = {}
for _, nm in ipairs(L.matchGames(q, 3)) do
items[#items + 1] = {label = "🎮 " .. nm .. (nm == L.curGame and "  (this game)" or ""), name = nm}
end
local qt = q:match("^%s*(.-)%s*$")
if #qt >= 2 and L.robloxSearch then
if #items == 0 then items[1] = {label = "🔎 Searching all of Roblox..."} end
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
local chips = {}
local function recolor()
for i, kd in ipairs(L.KINDS) do
local on = M2.kinds[kd[1]]
chips[i].BackgroundColor3 = on and kd[3] or Color3.fromRGB(40, 40, 56)
chips[i].Text = (on and "✔ " or "") .. kd[2]
end
end
for i, kd in ipairs(L.KINDS) do
local b = button(modalCard, 262 + (i - 1) * 74, 206, 70, 28, kd[2], Color3.fromRGB(40, 40, 56), 0, 42)
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
setting = true
M2.gameBox.Text = ""
setting = false
M2.gid, M2.kinds = nil, {}
recolor()
refreshSug()
end
-- the card keeps fitting when the window is small
local mScale = new("UIScale", {}, modalCard)
local function fitCard()
local a = win.AbsoluteSize
if a.X > 0 and a.Y > 0 then mScale.Scale = math.clamp(math.min((a.X - 12) / 500, (a.Y - 12) / 322), 0.5, 1) end
end
win:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitCard)
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
local openViewer, viewer, viewCard
do
viewer = overlay("Viewer", 45)
viewCard = card(viewer, 420, 316, 46)
local vTitle = text(viewCard, {
Position = UO(16, 10), Size = U2(1, -32, 0, 24), TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 47,
})
fit(vTitle, 16, 9)
local vInfo = text(viewCard, {
Position = UO(16, 34), Size = U2(1, -32, 0, 16), Font = Enum.Font.Nunito, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
TextTransparency = 0, Text = "", ZIndex = 47,
})
local vDesc = text(viewCard, {
Position = UO(16, 52), Size = U2(1, -32, 0, 44), Font = Enum.Font.Nunito, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, TextTransparency = 0.2, Text = "", ZIndex = 47,
})
local vNote = text(viewCard, {
Position = UO(16, 98), Size = U2(1, -32, 0, 22), Font = Enum.Font.Nunito, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
TextTransparency = 0.1, Text = "", ZIndex = 47,
})
local vBox = inputBox(viewCard, 16, 118, 388, 144, "", true, 47)
vBox.TextEditable = false
local vCopy = button(viewCard, 16, 270, 126, 34, "Copy script", Color3.fromRGB(34, 160, 72), 0, 47)
local vNoteB = button(viewCard, 150, 270, 126, 34, "📝 Note", Color3.fromRGB(58, 58, 78), 0, 47)
local vClose = button(viewCard, 284, 270, 120, 34, "Close", WHITE, 0.85, 47)
local vPin = button(viewCard, 176, 270, 76, 34, "📌 Note", Color3.fromRGB(150, 100, 30), 0, 47)
local vMsg = button(viewCard, 260, 270, 76, 34, "✉ Message", Color3.fromRGB(60, 110, 200), 0, 47)
fit(vPin, 13, 8)
fit(vMsg, 13, 8)
vPin.Visible, vMsg.Visible = false, false
vInfo.TextTruncate = Enum.TextTruncate.AtEnd
local current, shownCode
local function showNote()
local parts = {}
if current and current.an then parts[#parts + 1] = "📌 " .. tostring(current.anb or "Admin") .. ": " .. current.an end
local n = current and L.notes[L.noteKey(current)]
if n then parts[#parts + 1] = "📝 " .. n end
local txt = table.concat(parts, "   "):gsub("%s+", " ")
vNote.Text = txt:sub(1, 120)
end
openViewer = function(entry, shown)
current, shownCode = entry, shown or entry.code
vTitle.Text, vBox.Text = entry.name, shownCode
local who = type(entry.by) == "string" and entry.by ~= "" and entry.by or nil
local info = {}
if who then info[#info + 1] = "Shared by " .. who .. ((isAdmin and type(entry.uid) == "string" and entry.uid ~= "") and ("   (ID " .. entry.uid .. ")") or "") end
if entry.game then info[#info + 1] = "🎮 " .. entry.game .. (entry.gid and (" (ID " .. entry.gid .. ")") or "") end
if entry.kinds then info[#info + 1] = L.kindWords(entry.kinds) end
local onShare = entry.comm or table.find(adminPages[ADD_PAGE], entry) ~= nil
if onShare then info[#info + 1] = "❤ " .. ((L.favCount or {})[entry.name] or 0) end
vInfo.Text = table.concat(info, "  ·  ")
local adminHere = isAdmin and onShare
vPin.Visible = adminHere
vMsg.Visible = adminHere and (entry.comm or who) and true or false
if vMsg.Visible then
vCopy.Position, vCopy.Size, vNoteB.Position, vNoteB.Size, vClose.Position, vClose.Size = UO(16, 270), UO(78, 34), UO(102, 270), UO(66, 34), UO(344, 270), UO(60, 34)
elseif adminHere then
vCopy.Position, vCopy.Size, vNoteB.Position, vNoteB.Size, vPin.Position, vClose.Position, vClose.Size = UO(16, 270), UO(96, 34), UO(120, 270), UO(86, 34), UO(214, 270), UO(304, 270), UO(100, 34)
vPin.Size = UO(82, 34)
else
vCopy.Position, vCopy.Size, vNoteB.Position, vNoteB.Size, vClose.Position, vClose.Size = UO(16, 270), UO(126, 34), UO(150, 270), UO(126, 34), UO(284, 270), UO(120, 34)
end
if vMsg.Visible then vPin.Position, vPin.Size = UO(176, 270), UO(76, 34) end
vDesc.Text = (type(entry.desc) == "string" and entry.desc ~= "") and entry.desc or (who and "No description." or "")
showNote()
viewer.Visible = true
local slug = not shown and L.sbSlug(entry.code)
if slug then
vBox.Text = "Loading from scriptblox.com..."
L.sbFetch(slug, function(code)
if current == entry then shownCode, vBox.Text = code, code end
end)
end
end
do
local ed = overlay("NoteEditor", 50)
local ec = card(ed, 340, 214, 51)
L.cards[#L.cards + 1] = ec
text(ec, {Position = UO(16, 10), Size = U2(1, -32, 0, 24), Text = "📝 Your note", TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
text(ec, {Position = UO(16, 34), Size = U2(1, -32, 0, 14), Font = Enum.Font.Nunito, Text = "Only saved on this device.", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
local eb = inputBox(ec, 16, 54, 308, 100, "Write a note about this script...", true, 52)
local save = button(ec, 16, 166, 120, 32, "Save", Color3.fromRGB(34, 160, 72), 0, 52)
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
text(ac, {Position = UO(16, 10), Size = U2(1, -32, 0, 24), Text = "📌 Admin note", TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
text(ac, {Position = UO(16, 34), Size = U2(1, -32, 0, 14), Font = Enum.Font.Nunito, Text = "Everyone sees this on the script. Only owner and admins can write it.", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
local ab = inputBox(ac, 16, 54, 308, 100, "e.g. Tested today, works on mobile", true, 52)
local save = button(ac, 16, 166, 120, 32, "Save note", Color3.fromRGB(34, 160, 72), 0, 52)
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
local mt = text(mc, {Position = UO(16, 10), Size = U2(1, -32, 0, 24), Text = "✉ Message the sharer", TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
fit(mt, 16, 9)
text(mc, {Position = UO(16, 34), Size = U2(1, -32, 0, 14), Font = Enum.Font.Nunito, Text = "They get it in their Messages, with this script's name.", TextSize = 10, TextTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52})
local mb = inputBox(mc, 16, 54, 308, 100, "Write your message...", true, 52)
local send = button(mc, 16, 166, 150, 32, "Send", Color3.fromRGB(34, 160, 72), 0, 52)
local cancel = button(mc, 174, 166, 150, 32, "Cancel", WHITE, 0.85, 52)
vMsg.MouseButton1Click:Connect(function()
if not current or not isAdmin then return end
mt.Text = "✉ Message " .. tostring(current.by or "the sharer"):sub(1, 18)
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
notify("Can't copy", "Select the text in the box and copy it", nil, 3)
end
end)
vClose.MouseButton1Click:Connect(function() viewer.Visible = false end)
end
local pageUI = {}
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
return out, shared
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
local q = (ui.query or ""):lower()
if q ~= "" then
local f = {}
for _, e in ipairs(entries) do
local hay = (e.name .. " " .. (e.game or "") .. " " .. (e.by or "") .. " " .. L.kindWords(e.kinds) .. " " .. (e.gid or "")):lower()
if hay:find(q, 1, true) then f[#f + 1] = e end
end
entries = f
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
local pageIcon = name == ADD_PAGE and "➕" or "📜"
for _, it in ipairs(SECTIONS) do if it.name == name then pageIcon = it.icon end end
for _, c in ipairs(ui.grid:GetChildren()) do
if c.Name == "ScriptTile" then c:Destroy() end
end
ui.hint.Visible = #entries == 0 and not (ui.plus and ui.plus.Visible)
ui.hint.Text = q ~= "" and "No match." or (name == L.FAVL and "Nothing favorited yet. Tap the heart on a script.")
or (name == L.FAVD and "DuaKNo hasn't favorited anything yet.") or "No scripts here yet."
ui.count.Text = #entries .. (#entries == 1 and " script" or " scripts")
if name == ADD_PAGE and L.commStatusText then ui.count.Text = ui.count.Text .. "  ·  " .. L.commStatusText() end
for i, entry in ipairs(entries) do
local isShared = shared[entry] == true
local tile = new("TextButton", {
Name = "ScriptTile", LayoutOrder = i, BackgroundColor3 = TILE, BackgroundTransparency = TILE_T,
BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 21,
})
round(tile, 10)
local tStroke = outline(tile, 1.5, 0.4)
local scale = new("UIScale", {}, tile)
local accentBar = new("Frame", {
Position = UO(10, 0), Size = UO(26, 3), BackgroundColor3 = accentColor, BorderSizePixel = 0, ZIndex = 23,
}, tile)
round(accentBar, 2)
themedFill[accentBar] = "hi"
text(tile, {
Position = UO(8, 12), Size = UO(30, 24), Text = pageIcon, TextSize = 18,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22,
})
local nm = text(tile, {
Position = UO(10, 38), Size = U2(1, -20, 0, 30), Text = entry.name, TextSize = 14,
TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 22,
})
fit(nm, 14, 8)
if L.hasNote(entry) then
text(tile, {Position = UO(32, 15), Size = UO(14, 14), Text = "📝", TextSize = 12, ZIndex = 24})
end
if entry.an then
text(tile, {Position = UO(L.hasNote(entry) and 48 or 32, 15), Size = UO(14, 14), Text = "📌", TextSize = 12, ZIndex = 24})
end
local byName = entry.comm and entry.by or (isShared and (entry.by or "admin")) or nil
if byName then
local byLbl = text(tile, {
Position = UO(10, 70), Size = U2(1, -20, 0, 12), Text = "by " .. byName .. (entry.pending and "  ⏳ sending" or ""), TextSize = 10,
Font = Enum.Font.Nunito, TextXAlignment = Enum.TextXAlignment.Left, TextScaled = true,
TextTransparency = 0.1, ZIndex = 23,
})
new("UITextSizeConstraint", {MaxTextSize = 10, MinTextSize = 6}, byLbl)
end
if entry.game then
local gl = text(tile, {
Position = UO(10, 84), Size = U2(1, -20, 0, 12), Text = "🎮 " .. entry.game, TextSize = 10,
Font = Enum.Font.Nunito, TextXAlignment = Enum.TextXAlignment.Left, TextScaled = true, ZIndex = 23,
})
new("UITextSizeConstraint", {MaxTextSize = 10, MinTextSize = 6}, gl)
end
if entry.kinds then
local cx = 10
for _, kd in ipairs(L.KINDS) do
if entry.kinds:find(kd[1], 1, true) then
local w = kd[1] == "K" and 38 or (kd[1] == "U" and 46 or 22)
local chip = new("TextLabel", {
Position = UO(cx, 99), Size = UO(w, 14), BackgroundColor3 = kd[3], BorderSizePixel = 0, Text = kd[2],
Font = Enum.Font.Nunito, TextSize = 9, TextColor3 = WHITE, TextScaled = true, ZIndex = 23,
}, tile)
round(chip, 4)
new("UITextSizeConstraint", {MaxTextSize = 9, MinTextSize = 6}, chip)
cx = cx + w + 3
end
end
end
if name == ADD_PAGE then
text(tile, {
AnchorPoint = V2(1, 0), Position = U2(1, -5, 0, 25), Size = UO(46, 12), Text = "❤ " .. ((L.favCount or {})[entry.name] or 0),
TextSize = 10, Font = Enum.Font.Nunito, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 24,
})
end
local heart = new("TextButton", {
AnchorPoint = V2(1, 0), Position = U2(1, -4, 0, 5), Size = UO(22, 20), BackgroundTransparency = 1,
BorderSizePixel = 0, AutoButtonColor = false, Text = L.isFav(entry) and "❤️" or "🤍", TextSize = 15, ZIndex = 24,
}, tile)
heart.MouseButton1Click:Connect(function() L.toggleFav(entry) end)
local runBtn = new("TextButton", {
AnchorPoint = V2(0, 1), Position = U2(0, 8, 1, -7), Size = U2(0.5, -11, 0, 22),
BackgroundColor3 = Color3.fromRGB(34, 160, 72), BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "Run", TextColor3 = WHITE, ZIndex = 23,
}, tile)
round(runBtn, 6)
local viewBtn = new("TextButton", {
AnchorPoint = V2(1, 1), Position = U2(1, -8, 1, -7), Size = U2(0.5, -11, 0, 22),
BackgroundColor3 = Color3.fromRGB(58, 58, 78), BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "View", TextColor3 = WHITE, ZIndex = 23,
}, tile)
round(viewBtn, 6)
local function go()
if entry.comm then
askConfirm('Run "' .. entry.name:sub(1, 40) .. '" shared by ' .. tostring(entry.by):sub(1, 20) .. "? Scripts from players are not checked. Only run ones you trust.", function() runScript(entry) end, "Run")
else
runScript(entry)
end
end
runBtn.MouseButton1Click:Connect(go)
viewBtn.MouseButton1Click:Connect(function() openViewer(entry) end)
local restScale = UIS.MouseEnabled and L.hv or 1
tile.MouseEnter:Connect(function()
tween(scale, FAST, {Scale = L.hv})
tween(tile, FAST, {BackgroundColor3 = TILE_HOT})
tween(tStroke, FAST, {Transparency = 0.05})
end)
tile.MouseLeave:Connect(function()
tween(scale, FAST, {Scale = 1})
tween(tile, FAST, {BackgroundColor3 = TILE})
tween(tStroke, FAST, {Transparency = 0.4})
end)
tile.MouseButton1Down:Connect(function() tween(scale, TweenInfo.new(0.08), {Scale = 0.95}) end)
tile.MouseButton1Up:Connect(function() tween(scale, FAST, {Scale = restScale}) end)
tile.MouseButton1Click:Connect(function()
go()
tween(tile, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 78)})
task.delay(0.14, function()
if tile.Parent then tween(tile, FAST, {BackgroundColor3 = TILE}) end
end)
end)
if (name == ADD_PAGE and (not entry.comm or isAdmin or entry.uid == tostring(LP.UserId))) or (L.isSection[name] and (L.owner() or (isAdmin and verName and type(entry.by) == "string" and entry.by:lower() == verName:lower()))) then
local del = new("TextButton", {
AnchorPoint = V2(1, 0), Position = U2(1, -28, 0, 5), Size = UO(18, 18),
BackgroundColor3 = RED, BackgroundTransparency = 0.15, BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = "X",
TextColor3 = WHITE, ZIndex = 23,
}, tile)
round(del, 9)
del.MouseButton1Click:Connect(function()
askConfirm('Are you sure you want to remove "' .. entry.name .. '" from the list?', function()
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
tile.Parent = ui.grid
end
end
function L.renderDirty(name)
local u = pageUI[name]
if u and u.dirty then renderPage(u.current) end
end
local modalPage
local function openAddMenu(name)
if not (name == ADD_PAGE or L.isSection[name]) then return end
modalPage = name
modalTitle.Text = (name == ADD_PAGE) and "Add your script" or ("Add script to " .. name)
nameBox.Text, codeBox.Text, descBox.Text = "", "", ""
L.m.reset()
modal.Visible = true
end
local function flashRed(st)
st.Color, st.Transparency = Color3.fromRGB(255, 90, 100), 0
task.delay(0.6, function() st.Color, st.Transparency = themeStroke, 0.5 end)
end
modalCancel.MouseButton1Click:Connect(function() modal.Visible = false end)
modalAdd.MouseButton1Click:Connect(function()
local nm = nameBox.Text:match("^%s*(.-)%s*$"):sub(1, 40)
local code = codeBox.Text
if nm == "" then return flashRed(nameStroke) end
if code:match("^%s*$") then return flashRed(codeStroke) end
if #code > 30000 then notify("Too long", "Scripts can be up to 30,000 characters (yours is " .. #code .. ")", nil, 4) return flashRed(codeStroke) end
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
local entry = {name = nm, code = normalizeCode(code), desc = desc ~= "" and desc or nil, by = (modalPage == ADD_PAGE) and (verName or LP.Name) or nil,
game = gname ~= "" and gname or nil, gid = gid and tostring(gid):sub(1, 15) or nil, kinds = kinds ~= "" and kinds or nil, t = os.time()}
if modalPage ~= ADD_PAGE and isAdmin and not L.owner() then entry.by = verName or LP.Name end
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
Name = name, LayoutOrder = i, Size = U2(1, -8, 0, 30), BackgroundTransparency = 1,
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
AnchorPoint = V2(0.5, 0.5), Position = U2(0, 14, 0.5, 0), Size = UO(18, 18),
BackgroundTransparency = 1, Image = item.image, ZIndex = 10,
}, row)
else
text(row, {
AnchorPoint = V2(0.5, 0.5), Position = U2(0, 14, 0.5, 0), Size = UO(24, 24),
Text = item.icon or "•", TextSize = 18, ZIndex = 10,
})
end
local lbl = text(row, {
Position = UO(32, 0), Size = U2(1, -34, 1, 0), Text = (name == ADD_PAGE) and "Share script & Find script" or name, TextSize = 14,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1, ZIndex = 10,
})
fit(lbl, 14, 9)
labels[#labels + 1] = lbl
row.MouseMoved:Connect(bump)
row.MouseEnter:Connect(function()
bump()
if selected ~= name then tween(row, TweenInfo.new(0.12), {BackgroundTransparency = 0.7}) end
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
Position = UO(12, 3), Size = U2(1, -24, 0, 22), Text = (name == ADD_PAGE) and "Share script & Find script" or name, TextSize = 17,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
})
fit(pt, 17, 9)
local count = text(page, {
Position = UO(12, 25), Size = U2(1, -24, 0, 14), Font = Enum.Font.Nunito, Text = "",
TextSize = 11, TextTransparency = 0.35, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
})
new("Frame", {
Position = UO(10, 42), Size = U2(1, -20, 0, 1), BackgroundColor3 = WHITE,
BackgroundTransparency = 0.85, BorderSizePixel = 0, ZIndex = 21,
}, page)
if item.custom then count.Text = item.sub or "" end
if not item.custom then
if name == ADD_PAGE then
pt.Size = U2(1, -190, 0, 22)
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
CellSize = U2(0.25, -11, 0, 146), CellPadding = UO(8, 8),
SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Left,
}, grid)
L.cellH[L.grids[#L.grids]] = 146
new("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8)}, grid)
local plusTile
if name == ADD_PAGE or (name == L.DUA and isAdmin) then
local plus = new("TextButton", {
Name = "PlusTile", LayoutOrder = 0, BackgroundColor3 = Color3.fromRGB(34, 160, 72), BackgroundTransparency = 0,
BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 21,
}, grid)
round(plus, 12)
local pStroke = outline(plus, 2, 0.15)
local pScale = new("UIScale", {}, plus)
text(plus, {Position = UO(0, 10), Size = U2(1, 0, 0, 46), Text = "+", TextSize = 40, ZIndex = 22})
text(plus, {
Position = UO(0, 60), Size = U2(1, 0, 0, 18), Font = Enum.Font.Nunito, Text = "New script",
TextSize = 13, ZIndex = 22,
})
plus.BackgroundColor3, plus.BackgroundTransparency = L.cur().plus, L.cur().plusT
L.plus[#L.plus + 1] = plus
plusTile = plus
plus.MouseEnter:Connect(function()
tween(pScale, FAST, {Scale = 1.04}); tween(plus, FAST, {BackgroundColor3 = L.cur().plusHot}); tween(pStroke, FAST, {Transparency = 0})
end)
plus.MouseLeave:Connect(function()
tween(pScale, FAST, {Scale = 1}); tween(plus, FAST, {BackgroundColor3 = L.cur().plus}); tween(pStroke, FAST, {Transparency = 0.15})
end)
plus.MouseButton1Click:Connect(function() openAddMenu(pageUI[name].current) end)
end
local hint = text(page, {
Position = UO(0, 46), Size = U2(1, 0, 1, -46), Font = Enum.Font.Nunito, TextSize = 13,
Text = "No scripts here yet.", TextTransparency = 0.4, Visible = false, ZIndex = 21,
})
hint.Position, hint.Size = UO(0, top), U2(1, 0, 1, -top)
pageUI[name] = {grid = grid, hint = hint, count = count, current = name, plus = plusTile}
if name == L.DUA or name == ADD_PAGE then
local box = inputBox(page, 0, 0, 10, 26, "Search...", false, 22)
if name == L.DUA then
box.AnchorPoint, box.Position, box.Size = V2(1, 0), U2(1, -84, 0, 7), U2(0.34, 0, 0, 26)
new("UISizeConstraint", {MinSize = Vector2.new(60, 26), MaxSize = Vector2.new(150, 26)}, box)
pt.Size = U2(0.4, 0, 0, 22)
local rq = button(page, 0, 0, 68, 26, "Request", Color3.fromRGB(34, 160, 72), 0, 22)
rq.AnchorPoint, rq.Position, rq.TextSize = V2(1, 0), U2(1, -10, 0, 7), 12
fit(rq, 12, 8)
rq.MouseButton1Click:Connect(function() L.openCompose() end)
else
box.Position, box.Size = UO(10, 46), U2(1, -216, 0, 26)
local sortB = button(page, 0, 0, 104, 26, "", Color3.fromRGB(58, 58, 90), 0, 22)
sortB.AnchorPoint, sortB.Position, sortB.TextSize = V2(1, 0), U2(1, -96, 0, 46), 12
local SORT_NAMES = {new = "Sort: Newest", fav = "Sort: Most ❤", old = "Sort: Oldest", az = "Sort: A-Z"}
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
L.rf = button(page, 0, 0, 80, 26, "Refresh", Color3.fromRGB(58, 58, 90), 0, 22)
L.rf.AnchorPoint, L.rf.Position, L.rf.TextSize = V2(1, 0), U2(1, -10, 0, 46), 12
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
local function recolor()
for k, b in ipairs(tbtn) do
local on = tabs[k].name == pageUI[name].current
b.BackgroundColor3 = on and accentColor or Color3.fromRGB(40, 40, 52)
b.BackgroundTransparency = on and 0.1 or 0.2
end
end
for k, sec in ipairs(tabs) do
local b = new("TextButton", {
LayoutOrder = k, Size = U2(1 / #tabs, -3, 1, 0), BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = sec.icon .. " " .. (sec.label or sec.name), TextColor3 = WHITE, ZIndex = 22,
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
local function themeColors(h, s)
local function c(sat, val) return Color3.fromHSV(h, math.clamp(sat * s, 0, 1), val) end
return {
winBase = c(0.81, 0.31),
bg = ColorSequence.new({
ColorSequenceKeypoint.new(0, c(0.87, 0.24)), ColorSequenceKeypoint.new(0.5, c(0.80, 0.35)),
ColorSequenceKeypoint.new(1, c(0.85, 0.27)),
}),
stroke = c(0.40, 1),
barBase = c(0.60, 0.08),
bar = ColorSequence.new({ColorSequenceKeypoint.new(0, c(0.66, 0.14)), ColorSequenceKeypoint.new(1, c(0.64, 0.055))}),
barMask = c(0.64, 0.055),
accent = ColorSequence.new({
ColorSequenceKeypoint.new(0, c(0.65, 0.90)), ColorSequenceKeypoint.new(0.5, c(0.41, 1)),
ColorSequenceKeypoint.new(1, c(0.65, 0.90)),
}),
sb = c(0.69, 0.10),
hi = c(0.53, 1),
btn = c(0.60, 0.75),
pal = {WHITE, c(0.12, 1), c(0.29, 1), c(0.06, 1)},
}
end
local function applyTheme()
local th = themeColors(S.hue, S.sat)
accentColor, themeStroke, themeBtn = th.hi, th.stroke, th.btn
win.BackgroundColor3, bgGrad.Color = th.winBase, th.bg
bar.BackgroundColor3, barGrad.Color, mask.BackgroundColor3 = th.barBase, th.bar, th.barMask
accentGrad.Color = th.accent
sidebar.BackgroundColor3, sbMask.BackgroundColor3 = th.sb, th.sb
sbEdge.BackgroundColor3, sbDivider.BackgroundColor3 = th.stroke, th.stroke
headHL.BackgroundColor3 = th.hi
modalCard.BackgroundColor3, confirmCard.BackgroundColor3 = th.sb, th.sb
viewCard.BackgroundColor3 = th.sb
for _, c in ipairs(L.cards) do c.BackgroundColor3 = th.sb end
for _, row in pairs(rows) do row.BackgroundColor3 = th.hi end
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
end
local function applyWindow() win.BackgroundTransparency = minimized and 1 or math.min(0.92, S.winTrans + (L.cur().wt or 0)) end
L.BGS = {
"https://i.postimg.cc/FRbJj5dM/file-00000000c52c81f7b9ac5699e070f818.png",
"https://i.postimg.cc/KjSXnt2D/a2c1d8b9a752a25fb26be505dcdb954b.jpg",
"https://i.postimg.cc/sXDfD3RG/0d1984a0e2894f4eb79332c20b1f8e45.jpg",
}
-- background image: translucent so text stays readable; bars and sidebar become see-through over it
function L.applyBg()
local st = L.cur()
local img = S.bgOn and (st.img or S.bgUrl ~= "") and true or false
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
accent.Size = U2(1, 0, 0, st.ab or 3)
title:SetAttribute("FixedFont", true)
pcall(function() title.Font = Enum.Font[st.tf or "FredokaOne"] end)
local th = themeColors(S.hue, S.sat)
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
local function sectionHeader(txt)
local l = text(sPage, {
Size = U2(1, 0, 0, 20), Text = txt, TextSize = 14, TextTransparency = 0.15,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20, LayoutOrder = nextOrder(),
})
new("UIPadding", {PaddingLeft = UDim.new(0, 4)}, l)
end
local function makeRow(name, tall)
local row = new("Frame", {
Size = U2(1, 0, 0, tall and 64 or 34), BackgroundColor3 = WHITE, BackgroundTransparency = 0.9,
BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder(),
}, sPage)
round(row, 8)
local l = text(row, {
Position = UO(10, tall and 4 or 0), Size = tall and U2(1, -20, 0, 24) or U2(1, -146, 1, 0),
Text = name, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
})
fit(l, 13, 8)
return row, l
end
local function sliderRow(name, key, min, max, fmt, apply, step, rainbow)
local row, lbl = makeRow(name)
local hit = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -6, 0.5, 0), Size = UO(130, 28),
BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 21,
}, row)
local track = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = U2(1, -16, 0, 6),
BackgroundColor3 = WHITE, BackgroundTransparency = rainbow and 0 or 0.7, BorderSizePixel = 0, ZIndex = 22,
}, hit)
round(track, 3)
local fill = new("Frame", {Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, Visible = not rainbow, ZIndex = 23}, track)
round(fill, 3)
local knob = new("Frame", {AnchorPoint = V2(0.5, 0.5), Size = UO(14, 14), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 24}, track)
round(knob, 7)
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
fill.BackgroundColor3 = accentColor
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
dragging = false; host.ScrollingEnabled = true
if cm then cm:Disconnect() cm = nil end
if ce then ce:Disconnect() ce = nil end
end
hit.InputBegan:Connect(function(i)
if isPress(i) then
dragging = true; host.ScrollingEnabled = false; fromInput(i)
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
local b = new("TextButton", {
Size = U2(1, 0, 0, 34), BackgroundColor3 = color, BackgroundTransparency = trans, BorderSizePixel = 0,
AutoButtonColor = false, ZIndex = 20, LayoutOrder = nextOrder(),
Font = Enum.Font.Nunito, TextSize = 13, Text = label, TextColor3 = WHITE,
}, sPage)
round(b, 8)
return b
end
sectionHeader("Appearance")
do
local PRESETS = {{0.75, 1}, {0.60, 1}, {0.50, 1}, {0.38, 1}, {0.07, 1}, {0.0, 1}, {0.90, 1}, {0.75, 0.1}}
local row = makeRow("Theme color", true)
local holder = new("Frame", {Position = UO(10, 34), Size = U2(1, -20, 0, 24), BackgroundTransparency = 1, ZIndex = 21}, row)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8)}, holder)
for _, pr in ipairs(PRESETS) do
local h, s = pr[1], pr[2]
local b = new("TextButton", {
Size = UO(24, 24), Text = "", AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 22,
BackgroundColor3 = Color3.fromHSV(h, math.clamp(s * 0.75, 0.08, 1), 0.95),
}, holder)
round(b, 12)
local st = new("UIStroke", {Thickness = 2, Color = WHITE, Transparency = 1}, b)
b.MouseButton1Click:Connect(function()
S.hue, S.sat = h, s
applyTheme(); scheduleSave()
end)
refreshers[#refreshers + 1] = function()
st.Transparency = (math.abs(S.hue - h) < 0.01 and math.abs(S.sat - s) < 0.01) and 0 or 1
end
end
end
sliderRow("Custom hue", "hue", 0, 1, function(v) return math.floor(v * 360) .. "°" end, applyTheme, nil, true)
sliderRow("Color strength", "sat", 0.05, 1, function(v) return math.floor(v * 100 + 0.5) .. "%" end, applyTheme)
sliderRow("Window see-through", "winTrans", 0, 0.6, function(v) return math.floor(v / 0.6 * 100 + 0.5) .. "%" end, applyWindow)
sectionHeader("Background")
toggleRow("Background image", "bgOn", function() L.applyBg() end)
sliderRow("Background visibility", "bgVis", 0.05, 0.9, function(v) return math.floor(v * 100 + 0.5) .. "%" end, function() L.applyBg() end)
do
local box
local prow = new("Frame", {Size = U2(1, 0, 0, 34), BackgroundTransparency = 1, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
new("UIGridLayout", {CellSize = U2(1 / 3, -4, 0, 30), CellPadding = UO(4, 4), SortOrder = Enum.SortOrder.LayoutOrder}, prow)
local pbtn = {}
local function recolor()
for i, b in ipairs(pbtn) do
local on = S.bgUrl == "" and S.bgPreset == i
b.BackgroundColor3 = on and accentColor or Color3.fromRGB(70, 70, 88)
b.BackgroundTransparency = on and 0.05 or 0.45
end
end
for i = 1, 3 do
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
local row = new("Frame", {Size = U2(1, 0, 0, 34), BackgroundColor3 = WHITE, BackgroundTransparency = 0.9, BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
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
Size = U2(1, 0, 0, math.ceil(#items / 3) * 30), BackgroundTransparency = 1, ZIndex = 20, LayoutOrder = nextOrder(),
}, sPage)
new("UIGridLayout", {CellSize = U2(1 / 3, -4, 0, 26), CellPadding = UO(4, 4), SortOrder = Enum.SortOrder.LayoutOrder}, box)
local btns = {}
local function recolor()
for i, b in ipairs(btns) do
local on = items[i][1] == S[key]
b.BackgroundColor3 = on and accentColor or Color3.fromRGB(70, 70, 88)
b.BackgroundTransparency = on and 0.05 or 0.45
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
pickGrid(names, "style", L.applyStyle, false)
end
do
sectionHeader("Teleport and rejoin")
toggleRow("Re-open this GUI after teleport / rejoin", "reopen", function() if L.queueReopen then L.queueReopen() end end)
local row = new("Frame", {Size = U2(1, 0, 0, 34), BackgroundColor3 = WHITE, BackgroundTransparency = 0.9, BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
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
Size = U2(1, 0, 0, 34), BackgroundColor3 = WHITE, BackgroundTransparency = 0.9,
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
LayoutOrder = i, Size = U2(1, 0, 0, 30), BackgroundColor3 = WHITE,
BackgroundTransparency = 0.9, BorderSizePixel = 0, ZIndex = 20,
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
Size = U2(1, 0, 0, 34), BackgroundColor3 = WHITE, BackgroundTransparency = 0.9,
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
elseif not e.busy and e.tries < 6 then
e.busy, e.tries = true, e.tries + 1
task.spawn(function()
if L.commWrite(e) then
if not e.sent then notify("Shared", "Your script is now on the board", nil, 3) end
e.sent = true
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
if type(x) == "table" and tostring(x.u) == e.u and tonumber(x.t) == e.t and x.n == e.n then return true end
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
notify("📩 " .. from .. ' about "' .. sc .. '"', m.t:sub(1, 80), nil, 6)
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
table.insert(L.sent, {to = who, text = '✉ About "' .. entry.name:sub(1, 30) .. '": ' .. msg:sub(1, 200), at = os.date("%H:%M")})
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
if #code > 30000 then notify("Too long", "Shared scripts can be up to 30,000 characters", nil, 3) return true end
local e = {n = nm, c = code, d = (type(desc) == "string" and desc ~= "") and desc:sub(1, 300) or nil, u = tostring(LP.UserId), a = LP.Name, t = os.time(), tries = 1,
g = gameName, gi = gameId, k = kinds}
table.insert(L.pending, e)
renderPage(ADD_PAGE)
task.spawn(function()
e.busy = true
local ok = L.commWrite(e)
e.busy = false
if ok then
e.sent = true
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
local row = new("Frame", {Size = U2(1, 0, 0, 112), BackgroundColor3 = WHITE, BackgroundTransparency = 0.9, BorderSizePixel = 0, ZIndex = 20, LayoutOrder = n}, box)
round(row, 8)
text(row, {Position = UO(10, 4), Size = U2(1, -50, 0, 16), Text = "❓ " .. tostring(h.n):sub(1, 20) .. (h.r and "  ✔ replied" or ""), TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21})
text(row, {
Position = UO(10, 22), Size = U2(1, -20, 0, 42), Font = Enum.Font.Nunito, Text = h.t:sub(1, 300), TextSize = 12, TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextTransparency = 0.1, ZIndex = 21,
})
local rb = inputBox(row, 8, 74, 190, 28, "Reply to " .. tostring(h.n):sub(1, 16) .. "...", false, 21)
rb.Size = U2(1, -100, 0, 28)
local sb = button(row, 0, 0, 80, 28, "Reply", Color3.fromRGB(34, 160, 72), 0, 21)
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
Position = UO(10, 76), Size = U2(1, -20, 0, 90), BackgroundColor3 = Color3.fromRGB(10, 10, 14), BorderSizePixel = 0, ZIndex = 21,
}, pages[L.FAVP])
round(top, 8)
outline(top, 1.5, 0.5)
text(top, {Position = UO(10, 4), Size = U2(1, -20, 0, 16), Text = "🔥 Most favorited by players", TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22})
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
local b = button(row(32), 0, 0, 200, 30, "Create favorites board", Color3.fromRGB(34, 160, 72), 0, 22)
b.MouseButton1Click:Connect(function() L.makeBoard() end)
text(row(34), {
Size = UDim2.fromScale(1, 1), Font = Enum.Font.Nunito, TextSize = 11, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 22, TextTransparency = 0.3,
Text = "If that fails: open jsonblob.com, paste {\"v\":1,\"users\":{}} in the box, press Save, and paste the page link here.",
})
local lr = row(34)
local lb = inputBox(lr, 0, 2, 250, 30, "https://jsonblob.com/...", false, 22)
local ub = button(lr, 258, 2, 90, 30, "Use link", Color3.fromRGB(34, 160, 72), 0, 22)
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
head("🔥 Top 5 favorited")
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
head("👥 Players' favorites (" .. (q == "" and tostring(#users) or (#shown .. " of " .. #users)) .. ")")
for i, sh in ipairs(shown) do
if i > 300 then break end
local e, pname = sh.e, sh.pname
local open = q ~= "" or L.chkOpen[e.uid] == true
local hr = row(22)
hr.BackgroundTransparency, hr.BackgroundColor3 = 0, Color3.fromRGB(24, 24, 32)
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
f.BackgroundTransparency, f.BackgroundColor3 = 0, Color3.fromRGB(10, 10, 14)
round(f, 6)
text(f, {Position = UO(14, 0), Size = U2(1, -124, 1, 0), Font = Enum.Font.Nunito, TextSize = 12, Text = fav, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22})
local fcode = type(e.u.fc) == "table" and type(e.u.fc[fav]) == "string" and e.u.fc[fav] or nil
if fcode then
local vw = mk("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -64, 0.5, 0), Size = UO(46, 18), BackgroundColor3 = Color3.fromRGB(58, 58, 78),
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
c.b.BackgroundColor3 = on and accentColor or Color3.fromRGB(30, 26, 44)
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
outline(tile, 1.5, 0.4)
local bar = new("Frame", {Position = UO(10, 0), Size = UO(26, 3), BackgroundColor3 = accentColor, BorderSizePixel = 0, ZIndex = 23}, tile)
round(bar, 2)
themedFill[bar] = "hi"
local tag = s.isPatched and "PATCHED" or (s.key and "KEY") or (s.verified and "VERIFIED") or "KEYLESS"
text(tile, {Position = UO(10, 4), Size = UO(60, 9), Text = tag, TextSize = 8, Font = Enum.Font.Nunito,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 0.2, ZIndex = 23})
text(tile, {Position = UO(10, 15), Size = U2(1, -34, 0, 12), Text = "👁 " .. X.short(s.views), TextSize = 10, Font = Enum.Font.Nunito,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 0.15, ZIndex = 22})
local gm = X.gameOf(s)
text(tile, {Position = UO(10, 28), Size = U2(1, -16, 0, 12), Text = (gm == "Universal" and "🌐 " or "🎮 ") .. gm, TextSize = 10, Font = Enum.Font.Nunito,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, TextColor3 = gm == "Universal" and Color3.fromRGB(150, 220, 255) or Color3.fromRGB(255, 215, 120), ZIndex = 22})
local heart = new("TextButton", {
AnchorPoint = V2(1, 0), Position = U2(1, -4, 0, 5), Size = UO(22, 20), BackgroundTransparency = 1,
BorderSizePixel = 0, AutoButtonColor = false, TextSize = 15, ZIndex = 24,
Text = L.isFav(id) and "❤️" or "🤍",
}, tile)
X.hearts[#X.hearts + 1] = {h = heart, id = id}
if L.hasNote(id) then
text(tile, {Position = U2(1, -40, 0, 8), Size = UO(14, 14), Text = "📝", TextSize = 12, ZIndex = 24})
end
heart.MouseButton1Click:Connect(function() L.toggleFav(id) end)
local nm = text(tile, {
Position = UO(10, 42), Size = U2(1, -20, 0, 26), Text = title, TextSize = 12, TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 22,
})
fit(nm, 12, 8)
local run = new("TextButton", {
AnchorPoint = V2(0, 1), Position = U2(0, 8, 1, -7), Size = U2(0.5, -11, 0, 22),
BackgroundColor3 = Color3.fromRGB(34, 160, 72), BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "Run", TextColor3 = WHITE, ZIndex = 23,
}, tile)
run.Size = U2(0.34, -6, 0, 22)
round(run, 6)
local viewB = new("TextButton", {
AnchorPoint = V2(0, 1), Position = U2(0.34, 4, 1, -7), Size = U2(0.34, -6, 0, 22),
BackgroundColor3 = Color3.fromRGB(58, 58, 78), BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "View", TextColor3 = WHITE, ZIndex = 23,
}, tile)
round(viewB, 6)
local chatB = new("TextButton", {
AnchorPoint = V2(0, 1), Position = U2(0.68, 4, 1, -7), Size = U2(0.32, -12, 0, 22),
BackgroundColor3 = Color3.fromRGB(70, 110, 200), BorderSizePixel = 0, AutoButtonColor = false,
Font = Enum.Font.Nunito, TextSize = 12, Text = "💬", TextColor3 = WHITE, ZIndex = 23,
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
if e.h.Parent then e.h.Text = L.isFav(e.id) and "❤️" or "🤍" end
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
withHost("Info", function()
note("Account check", "Account: " .. (verName or (LP.Name .. " (not verified)")) .. ".  Admin: " .. (isAdmin and "yes" or "no") .. ".  Online admin list: "
.. (online.remoteAdmins and (#online.remoteAdmins .. " names loaded") or (feedUrl == "" and "no online list set up" or "not loaded (offline, or not published yet)")) .. ".", 48)
note("Discord", "Join the community: discord.gg/empgqd5qpq. Tap the 💬 button at the top of the window to copy the link.", 34)
wideButton("Copy Discord link", Color3.fromRGB(88, 101, 242), 0).MouseButton1Click:Connect(function() L.copyDiscord() end)
note("About", "Dua's Library is made by DuaKNo. It's a script hub: tap a tile to run a script. Everything runs in your own executor, on your own device.", 34)
note("Dua's script", "Scripts picked by DuaKNo, sorted in tabs at the top: Dua's favorites, NPCs, Weapons and Utility. Tap View script on a tile to read the code or copy it before you run it.", 48)
note("Share script & Find script", "Add your own scripts with the + tile. Paste code or a link (pastebin links turn into loadstring by themselves). With Share globally on (the default), they are posted for every player, with your name on them. You can remove your own, admins can remove any. Scripts from players are not checked, so only run ones you trust. Off = only this device.", 78)
note("ScriptBlox scripts", "Browse scripts from scriptblox.com live, 30 per page, with views, hearts, Prev / Next and a search bar. They are loaded when you open the page and are never saved on your device. Always tap View first: these scripts are made by other people.", 62)
note("Favorited", "Tap the heart on any script. Favorite = yours only, saved on this device (it also shows the 5 most favorited scripts), but DuaKNo can see the names of what players favorite and can remove inappropriate ones. Favorited by Dua = the scripts DuaKNo hearted, everyone sees them.", 48)
note("Inbox and requests", "Tap the envelope at the top right. Notifications keeps a list of what happened (scripts you ran, favorites). Messages lets you request a script from DuaKNo and shows replies to you.", 48)
note("Online scripts", "Scripts DuaKNo publishes show up for everyone on their own, nothing to set up. Settings > Refresh online scripts updates right away, and announcements from DuaKNo pop up once as a notification.", 48)
note("Sharing the library", "To give it to a friend, send them your copy of DuasLibraryUI.lua. It already contains the shared scripts. Never share a GitHub token: it stays only on your device.", 48)
note("Notes and shortcuts", "Tap View on any script, then Note, to write yourself a note (saved on this device, a 📝 shows on the tile). Press Right Ctrl to hide or show this window.", 48)
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
local row = new("Frame", {Size = U2(1, 0, 0, 34), BackgroundColor3 = WHITE, BackgroundTransparency = 0.9, BorderSizePixel = 0, ZIndex = 20, LayoutOrder = nextOrder()}, sPage)
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
wideButton("Server hop", Color3.fromRGB(34, 160, 72), 0.4).MouseButton1Click:Connect(function()
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
if g.Parent then g.CellSize = U2(1 / cols, -(cols * 8 + 12) / cols, 0, L.cellH[g] or 100) else table.remove(L.grids, i) end
end
end
content:GetPropertyChangedSignal("AbsoluteSize"):Connect(L.relayout)
L.relayout()
UIS.InputBegan:Connect(function(i, gp)
if not gp and sg.Parent and i.KeyCode == Enum.KeyCode.RightControl then sg.Enabled = not sg.Enabled end
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
M.mail = new("TextButton", {
AnchorPoint = V2(1, 0.5), Position = U2(1, -66, 0.5, 0), Size = UO(28, 24), BackgroundTransparency = 1,
BorderSizePixel = 0, AutoButtonColor = false, Text = "📧", TextSize = 18, ZIndex = 5,
}, bar)
M.dot = new("TextLabel", {
AnchorPoint = V2(1, 0), Position = U2(1, 2, 0, -2), Size = UO(15, 15), BackgroundColor3 = RED, BorderSizePixel = 0,
Text = "", TextColor3 = WHITE, TextSize = 10, Font = Enum.Font.Nunito, Visible = false, ZIndex = 6,
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
AnchorPoint = V2(1, 0.5), Position = U2(1, -98, 0.5, 0), Size = UO(28, 24), BackgroundTransparency = 1,
BorderSizePixel = 0, AutoButtonColor = false, Text = "💬", TextSize = 18, ZIndex = 5,
}, bar)
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
M.card = card(M.inbox, 470, 296, 61)
L.cards[#L.cards + 1] = M.card
do
local head = new("Frame", {Size = U2(1, 0, 0, 46), BackgroundColor3 = accentColor, BorderSizePixel = 0, ZIndex = 62}, M.card)
round(head, 12)
local fill = new("Frame", {AnchorPoint = V2(0, 1), Position = U2(0, 0, 1, 0), Size = U2(1, 0, 0, 12), BackgroundColor3 = accentColor, BorderSizePixel = 0, ZIndex = 62}, head)
themedFill[head], themedFill[fill] = "hi", "hi"
new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.05), NumberSequenceKeypoint.new(1, 0.45)})}, head)
text(M.card, {Position = UO(16, 0), Size = UO(120, 46), Text = "📬 Inbox", TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 64})
local dc = button(M.card, 0, 0, 118, 28, "💬 Join Discord", Color3.fromRGB(88, 101, 242), 0, 64)
dc.AnchorPoint, dc.Position, dc.TextSize = V2(1, 0), U2(1, -46, 0, 9), 12
dc.MouseButton1Click:Connect(function() L.copyDiscord() end)
local closeB = button(M.card, 0, 0, 28, 28, "X", Color3.fromRGB(0, 0, 0), 0.6, 64)
closeB.AnchorPoint, closeB.Position = V2(1, 0), U2(1, -10, 0, 9)
closeB.MouseButton1Click:Connect(function() M.inbox.Visible = false end)
end
M.tabN = button(M.card, 12, 54, 200, 28, "🔔 Notifications", WHITE, 0.5, 62)
M.tabM = button(M.card, 218, 54, 200, 28, "💬 Messages", WHITE, 0.5, 62)
M.tabN.Size, M.tabM.Size = U2(0.5, -17, 0, 28), U2(0.5, -17, 0, 28)
M.tabM.Position = U2(0.5, 5, 0, 54)
M.body = new("ScrollingFrame", {
Position = UO(10, 90), Size = U2(1, -20, 1, -100), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 3, ScrollBarImageColor3 = WHITE, ZIndex = 62,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, M.card)
new("UIListLayout", {Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, M.body)
local function nextOrd() M.ord = M.ord + 1 return M.ord end
local KIND = {n = accentColor, m = Color3.fromRGB(34, 160, 72), s = Color3.fromRGB(70, 130, 255)}
local function line(kind, head, body, when)
local r = new("Frame", {
Size = U2(1, -4, 0, body and 52 or 36), BackgroundColor3 = Color3.fromRGB(10, 10, 14), BorderSizePixel = 0,
ZIndex = 63, LayoutOrder = nextOrd(),
}, M.body)
round(r, 8)
local stripe = new("Frame", {Size = UO(4, 52), BackgroundColor3 = KIND[kind] or accentColor, BorderSizePixel = 0, ZIndex = 64}, r)
stripe.Size = U2(0, 4, 1, 0)
round(stripe, 2)
local h = text(r, {
Position = UO(14, body and 5 or 0), Size = U2(1, -78, 0, body and 16 or 36), Text = head, TextSize = 12,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 64,
})
fit(h, 12, 8)
if body then
text(r, {
Position = UO(14, 22), Size = U2(1, -78, 0, 26), Font = Enum.Font.Nunito, Text = body, TextSize = 11, TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextTransparency = 0.25, ZIndex = 64,
})
end
if when then
text(r, {AnchorPoint = V2(1, 0), Position = U2(1, -8, 0, 6), Size = UO(54, 14), Text = when, TextSize = 10, TextTransparency = 0.45, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 64})
end
end
local function render()
for _, c in ipairs(M.body:GetChildren()) do
if not c:IsA("UIListLayout") then c:Destroy() end
end
M.ord = 0
local on, off = accentColor, Color3.fromRGB(30, 26, 44)
M.tabN.BackgroundColor3, M.tabN.BackgroundTransparency = M.tab == "n" and on or off, 0
M.tabM.BackgroundColor3, M.tabM.BackgroundTransparency = M.tab == "m" and on or off, 0
M.tabN.Text = "🔔 Notifications" .. (#L.log > 0 and (" (" .. #L.log .. ")") or "")
if M.tab == "n" then
if #L.log > 0 then
local c = button(M.body, 0, 0, 100, 26, "Clear all", WHITE, 0.8, 63)
c.Size, c.LayoutOrder = U2(1, -4, 0, 26), nextOrd()
c.MouseButton1Click:Connect(function() L.log = {}; render() end)
else
line("n", "✨ All clear", "Nothing new. What happens in the library shows up here.")
end
for _, e in ipairs(L.log) do line("n", e.t, e.m, e.at) end
else
local rq = button(M.body, 0, 0, 100, 30, "✉ Request a script", Color3.fromRGB(34, 160, 72), 0, 63)
rq.Size, rq.LayoutOrder = U2(1, -4, 0, 30), nextOrd()
rq.MouseButton1Click:Connect(function() L.openCompose("req") end)
local hb = button(M.body, 0, 0, 100, 30, "❓ Help", Color3.fromRGB(70, 110, 200), 0, 63)
hb.Size, hb.LayoutOrder = U2(1, -4, 0, 30), nextOrd()
hb.MouseButton1Click:Connect(function() L.openCompose("help") end)
local msgs = L.myMsgs()
for _, hr in ipairs(L.helpReplies or {}) do line("m", "❓ Help reply from " .. hr.from, hr.text, hr.at) end
for _, dm in ipairs(L.dmMine or {}) do line("m", "📩 " .. dm.from .. ' about "' .. dm.script .. '"', dm.text, dm.at) end
for _, m in ipairs(msgs) do line("m", isAdmin and ("To " .. (m.to == "all" and "everyone" or (m.toName or L.nameOf(m.to)))) or ("From " .. m.from), m.text) end
for i = #L.sent, 1, -1 do line("s", "You to " .. (L.sent[i].to or "DuaKNo"), L.sent[i].text, L.sent[i].at) end
if #msgs == 0 and #L.sent == 0 and #(L.helpReplies or {}) == 0 and #(L.dmMine or {}) == 0 then line("m", "💬 No messages yet", "Replies from DuaKNo appear here.") end
end
end
L.inboxRender = function() if M.inbox.Visible then render() end end
local function showTab(t)
M.tab = t
if t == "n" then L.unread = 0 else
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
if M.inbox.Visible then showTab(M.tab) end
end)
M.compose = overlay("Compose", 70)
M.ccard = card(M.compose, 360, 262, 71)
L.cards[#L.cards + 1] = M.ccard
M.mode = "req"
M.title = text(M.ccard, {Position = UO(18, 8), Size = U2(1, -36, 0, 24), Text = "Request a script", TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 72})
M.tabReq = button(M.ccard, 18, 36, 150, 26, "✉ Script request", WHITE, 0.5, 72)
M.tabHelp = button(M.ccard, 174, 36, 150, 26, "❓ Help", WHITE, 0.5, 72)
M.hint = text(M.ccard, {Position = UO(18, 66), Size = U2(1, -36, 0, 30), Font = Enum.Font.Nunito, Text = "", TextSize = 11, TextTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 72})
M.box = inputBox(M.ccard, 18, 100, 324, 100, "Type what script you want...", true, 72)
local send = button(M.ccard, 18, 212, 196, 34, "Send request", Color3.fromRGB(34, 160, 72), 0, 72)
local cancel = button(M.ccard, 222, 212, 120, 34, "Cancel", WHITE, 0.85, 72)
cancel.MouseButton1Click:Connect(function() M.compose.Visible = false end)
function M.setMode(m)
M.mode = m
local on, off = accentColor, Color3.fromRGB(30, 26, 44)
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
local top = PG:GetGuiObjectsAtPosition(i.Position.X, i.Position.Y)[1]
if not top then return true end
if top:IsA("TextButton") or top:IsA("TextBox") or top:GetAttribute("NoDrag") then return false end
if top:IsA("ScrollingFrame") and i.UserInputType == Enum.UserInputType.Touch then return false end
return true
end
handle.InputBegan:Connect(function(i)
if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and canStart(i) then
dragging, L.moved = not S.lockDrag, false
dStart, sPos = i.Position, win.Position
if mv then mv:Disconnect() end
mv = UIS.InputChanged:Connect(function(i2)
if i2 == dInput and dragging then
local d = i2.Position - dStart
if math.abs(d.X) > 4 or math.abs(d.Y) > 4 then L.moved = true end
win.Position = U2(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
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
win.Position = U2(rPos.X.Scale, rPos.X.Offset + (w - rSize.X) / 2, rPos.Y.Scale, rPos.Y.Offset + (h - rSize.Y) / 2)
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
AnchorPoint = V2(1, 0.5), Position = U2(1, -38, 0.5, 0), Size = UO(24, 24), BackgroundColor3 = RED, BackgroundTransparency = 0.45, BorderSizePixel = 0,
Font = Enum.Font.Nunito, TextSize = 15, Text = "X", TextColor3 = WHITE, AutoButtonColor = false, ZIndex = 5,
}, bar)
round(L.closeBtn, 6)
L.closeBtn.MouseButton1Click:Connect(function()
askConfirm("Are you sure you want to close the Hub?", function() sg:Destroy() end, "Confirm")
end)
minBtn.MouseButton1Click:Connect(function()
if L.moved then L.moved = false return end
minimized = not minimized
tween(win, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
Size = minimized and UO(32, 32) or SIZE,
})
local show = not minimized
content.Visible, layer.Visible, sidebar.Visible = show, show, show
title.Visible, accent.Visible, mask.Visible = show, show, show
L.mail.Visible = show
L.disc.Visible = show
L.closeBtn.Visible = show
if minimized then modal.Visible, confirm.Visible, viewer.Visible = false, false, false; L.hideMail() end
minBtn.AnchorPoint = minimized and V2(0.5, 0.5) or V2(1, 0.5)
minBtn.Position = minimized and UO(16, 16) or U2(1, -10, 0.5, 0)
minBtn.Size = minimized and UO(32, 32) or UO(24, 24)
minBtn.BackgroundColor3 = minimized and Color3.new(0, 0, 0) or WHITE
minBtn.BackgroundTransparency = minimized and 0 or 0.7
applyWindow()
L.applyBg()
L.grip.Visible = not minimized
inner.Visible = not minimized
L.miniImg.Visible = minimized and L.iconOK == true
minBtn.Text = minimized and (L.iconOK and "" or "+") or "-"
end)
-- ✅ Completed script request page
-- Everyone can see the finished scripts. Only admins/owner can add or delete them.
do
(function()
local CSR = "Completed script request"
-- PASTE YOUR NEW npoint.io LINK HERE, e.g. "https://api.npoint.io/xxxxxxxxxxxxxxxxxxxx"
L.COMPLETED_BOARD = "https://api.npoint.io/045e748727605bd85fd9"
local host = pages[CSR]
local MAXLIST, MAXCODE = 100, 30000
local GREEN = Color3.fromRGB(34, 160, 72)
local R = {list = {}, busy = false, busyAt = 0, saving = false, at = nil, err = nil}
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
R.SORTS = {"Newest", "Oldest", "A-Z", "Most ❤"}
local chipRow = new("ScrollingFrame", {
Position = UO(10, 68), Size = U2(1, -20, 0, 26), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X, ZIndex = 21,
}, host)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, chipRow)
local function paintChips()
for _, c in ipairs(R.chips) do
c.b.BackgroundColor3 = c.isOn() and accentColor or Color3.fromRGB(30, 26, 44)
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
chip("🌐 Universal", function() return R.f.U end, function() R.f.U = not R.f.U end)
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
Size = U2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = WHITE,
BackgroundTransparency = 0.9, BorderSizePixel = 0, ZIndex = 21, LayoutOrder = i,
}, scroll)
round(c, 8)
new("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder}, c)
new("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)}, c)
lbl(c, "✅ " .. clip(e.name, 60), 15, 0, 1)
local kw = L.kindWords((tostring(e.kinds or ""):gsub("U", "")))
local info = "For " .. clip(e.player or "?", 40)
if hasKind(e, "U") then
info = info .. "   •   🌐 Universal"
elseif type(e.game) == "string" and e.game ~= "" then
info = info .. "   •   🎮 " .. clip(e.game, 60)
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
local favB = button(row, 0, 0, 104, 26, L.isFav(e) and "❤️ Favorited" or "🤍 Favorite", Color3.fromRGB(58, 58, 90), 0, 23)
favB.MouseButton1Click:Connect(function()
L.toggleFav(e)
L.csrRender()
end)
if isAdmin then
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
Size = U2(1, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(24, 24, 30), BackgroundTransparency = 0.05,
BorderSizePixel = 0, Active = true, Visible = false, ZIndex = 30,
}, host)
round(form, 10)
text(form, {
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
Size = U2(1, 0, 0, 24), LayoutOrder = i, BackgroundColor3 = Color3.fromRGB(58, 58, 84), BorderSizePixel = 0,
AutoButtonColor = false, Font = Enum.Font.Nunito, TextSize = 12, Text = "", TextColor3 = WHITE,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Visible = false, ZIndex = 33,
}, holder)
round(b, 6)
new("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 6)}, b)
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
local lab = "👤 " .. m.name
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
kbtn[i].BackgroundColor3 = on and kd[3] or Color3.fromRGB(40, 40, 56)
kbtn[i].Text = (on and "✔ " or "") .. kd[2]
end
end
for i, kd in ipairs(L.KINDS) do
local b = button(krow, 0, 0, 96, 26, kd[2], Color3.fromRGB(40, 40, 56), 0, 33)
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
gSug.set({{label = "🔎 Looking up game ID " .. idq .. "..."}})
L.gameFromId(idq, function(nm)
if my ~= gtok then return end
if nm then
gSug.set({{label = "🎮 " .. nm .. "  (ID " .. idq .. ")", name = nm, gid = idq}})
else
gSug.set({{label = "No game found for " .. idq .. ", tap to use the ID", name = "Game ID " .. idq, gid = idq}})
end
end)
return
end
local items = {}
for _, nm in ipairs(L.matchGames(q, 4)) do
items[#items + 1] = {label = "🎮 " .. nm .. (nm == L.curGame and "  (this game)" or ""), name = nm}
end
local qt = trim(q)
if #qt >= 2 and L.robloxSearch then
if #items == 0 then items[1] = {label = "🔎 Searching all of Roblox..."} end
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
addBtn.MouseButton1Click:Connect(function()
if not adminOk() then return end
form.Visible = true
refreshPlayers()
if not kinds.U then refreshGames() end
end)
cancel.MouseButton1Click:Connect(function() form.Visible = false end)
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
R.saving = true
task.spawn(function()
local list, err = pull()
if not list then
R.saving = false
return notify("Completed requests", "Couldn't reach the board (" .. tostring(err) .. ")", nil, 4)
end
while #list >= MAXLIST do table.remove(list, 1) end
list[#list + 1] = {
id = tostring(os.time()) .. tostring(math.random(100, 999)), player = player, name = sname,
game = gname ~= "" and gname or nil, gid = gid2 and tostring(gid2):sub(1, 15) or nil,
kinds = kindStr() ~= "" and kindStr() or nil,
desc = desc ~= "" and desc or nil, code = code, by = verName or LP.Name, t = os.time(),
}
local ok = L.bWrite(url, {requests = list})
R.saving = false
if not ok then return notify("Completed requests", "Couldn't save (" .. tostring(L.boardErr) .. ")", nil, 4) end
f.player.Text, f.name.Text, f.desc.Text, f.code.Text = "", "", "", ""
for k in pairs(kinds) do kinds[k] = nil end
recolorK()
gset = true
f.game.Text = ""
gset = false
gid = nil
applyUni()
form.Visible = false
sortList(list)
R.list, R.err, R.at = list, nil, os.time()
L.csrRender()
notify("Added", sname, nil, 2)
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
local function esc(x) return (tostring(x):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")) end
local function uid() return string.format("%x%x%x", os.time(), math.random(0, 65535), math.random(0, 65535)) end
local GRAY = Color3.fromRGB(38, 38, 42)
round(new("Frame", {Size = U2(1, 0, 1, 0), BackgroundColor3 = GRAY, BorderSizePixel = 0, ZIndex = 20}, host), 10)
local scroll = new("ScrollingFrame", {
Position = UO(10, 72), Size = U2(1, -20, 1, -152), BackgroundColor3 = GRAY, BackgroundTransparency = 0,
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
toBox.AnchorPoint, toBox.Position = V2(0, 1), U2(0, 10, 1, -18)
local box = inputBox(host, 0, 0, 10, 34, "Say something...", false, 23)
box.AnchorPoint, box.Position, box.Size = V2(0, 1), U2(0, 100, 1, -18), U2(1, -224, 0, 34)
local send = button(host, 0, 0, 76, 34, "Send", Color3.fromRGB(34, 160, 72), 0, 23)
send.AnchorPoint, send.Position = V2(1, 1), U2(1, -10, 1, -18)
local function colorOf(name)
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
local t = esc(tostring(p.t):sub(1, 200))
if p.hl then
local h = esc(p.hl)
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
if p.sys then return '<font color="rgb(150,150,168)"><i>📢 ' .. C.body(p) .. "</i></font>" end
local mine = p.u == MYID
local rank = C.rankOf(p)
local badge = rank == "owner" and '<font color="rgb(255,200,60)"><b>[👑 OWNER]</b></font> '
or rank == "admin" and '<font color="rgb(110,200,255)"><b>[🛡 ADMIN]</b></font> ' or ""
local ok, tm = pcall(os.date, "%H:%M", tonumber(p.ts) or os.time())
local gtag = ""
if S.chatGames and p.g then
local gn = C.gname[p.g]
if not gn then C.gameName(p.g) end
gtag = '  <font color="rgb(120,175,140)">🎮 ' .. esc(gn or "...") .. "</font>"
end
local tag = ""
if type(p.to) == "string" then
tag = '<font color="rgb(255,170,60)">[private' .. (mine and (" to " .. esc(p.to:sub(1, 20))) or "") .. "]</font> "
end
return '<font color="rgb(120,120,132)">' .. (ok and tm or "--:--") .. "</font>  " .. badge
.. '<b><font color="' .. (mine and "rgb(255,215,90)" or colorOf(tostring(p.n))) .. '">' .. esc(tostring(p.n):sub(1, 20)) .. "</font></b>  " .. tag .. C.body(p)
.. (p.sc and ('  <font color="rgb(110,220,140)"><b>📎 ' .. esc(p.sc.n) .. "</b> (tap)</font>") or "") .. gtag
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
Name = "JoinBtn", AnchorPoint = V2(1, 0), Position = U2(1, 0, 0, 0), Size = UO(40, 16), BackgroundColor3 = Color3.fromRGB(34, 160, 72), BackgroundTransparency = 0.1,
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
C.foot.Text = "👥 " .. n .. " chatting  ·  Tap a name to message them privately  ·  #page links  ·  /help" .. (isAdmin and "  ·  Admins: tap a name, then Mute" or "")
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
notify("💬 " .. tostring(last.n):sub(1, 20), tostring(last.t):sub(1, 70), nil, 4)
else
notify("💬 " .. n .. " new messages", tostring(last.n):sub(1, 20) .. ": " .. tostring(last.t):sub(1, 60), nil, 4)
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
notify("🔒 " .. p.n:sub(1, 20), p.t:sub(1, 70), nil, 4)
elseif tostring(p.t):lower():find("@" .. LP.Name:lower(), 1, true) then
notify("📣 " .. p.n:sub(1, 20) .. " mentioned you", p.t:sub(1, 70), nil, 4)
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
local function get(url)
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
local body, code = get(BASE .. "/json?poll=1&since=" .. C.last)
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
local body = get("https://ntfy.sh/v1/health")
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
local function submit()
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
send.MouseButton1Click:Connect(submit)
box.FocusLost:Connect(function(enter) if enter then submit() end end)
local function boardEdit(fn)
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
boardEdit(function(d)
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
boardEdit(function(d) d.muted = {} end)
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
boardEdit(function(d) if type(d.muted) == "table" then d.muted[u] = nil end end)
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
local um = button(host, 0, 0, 92, 26, "Unmute all", Color3.fromRGB(58, 58, 78), 0, 23)
um.AnchorPoint, um.Position, um.TextSize = V2(1, 0), U2(1, -10, 0, 7), 12
um.MouseButton1Click:Connect(function()
if not adminOk() then return end
L.boardMuted = {}
boardEdit(function(d) d.muted = {} end)
if readToken() then
online.muted = {}
saveOnline()
publishNow(true)
end
L.applyMuted()
notify("Chat", "Everyone is unmuted", nil, 2)
end)
C.pickF = new("Frame", {
AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0), Size = UO(268, 128), BackgroundColor3 = Color3.fromRGB(24, 24, 30),
BorderSizePixel = 0, Visible = false, ZIndex = 40,
}, host)
round(C.pickF, 10)
outline(C.pickF, 2, 0.3)
C.pickT = text(C.pickF, {Position = UO(10, 8), Size = U2(1, -50, 0, 22), Text = "", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
local xb = button(C.pickF, 0, 0, 24, 24, "X", Color3.fromRGB(58, 58, 78), 0, 41)
xb.AnchorPoint, xb.Position, xb.TextSize = V2(1, 0), U2(1, -8, 0, 8), 12
xb.MouseButton1Click:Connect(function() C.pickF.Visible = false end)
local opts = {{"5 min", 300}, {"30 min", 1800}, {"1 hour", 3600}, {"24 hours", 86400}, {"Forever", 0}, {"Unmute", -1}}
for i, o in ipairs(opts) do
local b2 = button(C.pickF, 0, 0, 78, 32, o[1], o[2] == -1 and Color3.fromRGB(58, 58, 78) or Color3.fromRGB(150, 50, 50), 0, 41)
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
local body = get("https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. tl .. "&dt=t&q=" .. HttpService:UrlEncode(textIn))
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
local b = get("https://clients5.google.com/translate_a/t?client=dict-chrome-ex&sl=auto&tl=" .. tl .. "&q=" .. HttpService:UrlEncode(textIn))
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
local b2 = get("https://api.mymemory.translated.net/get?q=" .. HttpService:UrlEncode(textIn) .. "&langpair=Autodetect|" .. tl)
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
if res and res:lower() ~= p.t:lower() then C.addLine({sys = true, t = "🌐 " .. tostring(p.n):sub(1, 20) .. ": " .. res, copy = res, i = "tr" .. uid(), ts = os.time()}) end
end)
end
function C.copyText(t)
pcall(function() setclipboard(t) end)
notify("Copied", t:sub(1, 40), nil, 2)
end
function C.updateCtl()
C.bGames.Text = "🎮 Games: " .. (S.chatGames and "on" or "off")
C.bLang.Text = "🌐 Translate: " .. C.langName(S.chatLang)
C.bShare.Text = "📍 Share mine: " .. (S.shareGame and "on" or "off")
C.bTips.Text = "💡 Tips: " .. (S.chatTips and "on" or "off")
C.bRe.Text = "🔁 Auto re-open: " .. (S.reopen and "on" or "off")
C.bTips.BackgroundColor3 = S.chatTips and Color3.fromRGB(34, 140, 70) or Color3.fromRGB(58, 58, 78)
C.bRe.BackgroundColor3 = S.reopen and Color3.fromRGB(34, 140, 70) or Color3.fromRGB(58, 58, 78)
C.bGames.BackgroundColor3 = S.chatGames and Color3.fromRGB(34, 140, 70) or Color3.fromRGB(58, 58, 78)
C.bShare.BackgroundColor3 = S.shareGame and Color3.fromRGB(34, 140, 70) or Color3.fromRGB(58, 58, 78)
C.bLang.BackgroundColor3 = S.chatLang ~= "" and Color3.fromRGB(34, 140, 70) or Color3.fromRGB(58, 58, 78)
if C.paintLang then C.paintLang() end
end
function C.openMenu(p)
C.menuP = p
C.menuT.Text = p.sc and ("📎 " .. p.sc.n) or tostring(p.n):sub(1, 18) .. ": " .. tostring(p.t):sub(1, 30)
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
local t = "📍 " .. label .. (idx and ("  ·  Page " .. idx .. "/" .. total) or "") .. (cnt and ("  ·  " .. cnt) or "")
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
local cb = button(C.sugF, 0, 0, 120, 22, "📎 " .. C.attach.n .. "  X", Color3.fromRGB(34, 140, 70), 0, 31)
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
local b = button(C.sugF, 0, 0, 120, 22, "#" .. k .. (idx and ("  ·  " .. idx .. "/" .. total) or ""), Color3.fromRGB(58, 58, 90), 0, 31)
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
local b = button(C.sugF, 0, 0, 120, 22, (big and "👁 " or "📜 ") .. e.name:sub(1, 26), Color3.fromRGB(80, 60, 140), 0, 31)
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
local b = button(row, 0, 0, w, 22, "", Color3.fromRGB(58, 58, 78), 0, 24)
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
C.menuF = new("Frame", {AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0), Size = UO(290, 236), BackgroundColor3 = Color3.fromRGB(24, 24, 30), BorderSizePixel = 0, Visible = false, ZIndex = 40}, host)
round(C.menuF, 10)
outline(C.menuF, 2, 0.3)
C.menuT = text(C.menuF, {Position = UO(10, 6), Size = U2(1, -20, 0, 20), Font = Enum.Font.Nunito, Text = "", TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
local function mb(x, y, label, color, fn, parent)
local b = button(parent or C.menuF, 0, 0, 86, 28, label, color, 0, 41)
b.Position, b.TextSize = UO(x, y), 12
b.MouseButton1Click:Connect(fn)
return b
end
local grey = Color3.fromRGB(58, 58, 78)
mb(10, 30, "📋 Copy", grey, function()
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
mb(10, 0, "▶ Run", Color3.fromRGB(34, 140, 70), function()
local p = C.menuP
C.menuF.Visible = false
if p and p.sc then
askConfirm('Run "' .. p.sc.n .. '" from ' .. tostring(p.n):sub(1, 20) .. "? Names and badges in chat can be faked. Only run scripts you trust.", function() runScript({name = p.sc.n, code = p.sc.c}) end, "Run")
end
end, C.menuS)
mb(102, 0, "👁 View", grey, function()
local p = C.menuP
C.menuF.Visible = false
if p and p.sc then openViewer({name = p.sc.n, code = p.sc.c}) end
end, C.menuS)
mb(194, 0, "⭐ Save", grey, function()
local p = C.menuP
C.menuF.Visible = false
if p and p.sc then L.toggleFav({name = p.sc.n, code = p.sc.c}) end
end, C.menuS)
text(C.menuF, {Position = UO(10, 96), Size = U2(1, -20, 0, 16), Text = "🌐 Translate this message to:", TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
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
if res then C.addLine({sys = true, t = "🌐 " .. l[1] .. ": " .. res, copy = res, i = "tr" .. uid(), ts = os.time()})
else notify("Translate", "Couldn't translate right now", nil, 3) end
end)
end)
end
end
C.langF = new("Frame", {AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0), Size = UO(290, 236), BackgroundColor3 = Color3.fromRGB(24, 24, 30), BorderSizePixel = 0, Visible = false, ZIndex = 40}, host)
round(C.langF, 10)
outline(C.langF, 2, 0.3)
text(C.langF, {Position = UO(10, 6), Size = U2(1, -50, 0, 22), Text = "🌐 Translate chat to:", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
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
local b = button(lgp, 0, 0, 82, 26, l[2] == "" and "🚫 Off" or l[1], grey, 0, 42)
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
e.b.BackgroundColor3 = e.code == S.chatLang and Color3.fromRGB(34, 140, 70) or grey
end
end
C.paintLang()
local at = button(host, 0, 0, 34, 34, "📎", Color3.fromRGB(58, 58, 78), 0, 23)
at.AnchorPoint, at.Position, at.TextSize = V2(1, 1), U2(1, -94, 1, -18), 16
C.attF = new("Frame", {AnchorPoint = V2(0.5, 0.5), Position = U2(0.5, 0, 0.5, 0), Size = UO(300, 224), BackgroundColor3 = Color3.fromRGB(24, 24, 30), BorderSizePixel = 0, Visible = false, ZIndex = 40}, host)
round(C.attF, 10)
outline(C.attF, 2, 0.3)
text(C.attF, {Position = UO(10, 6), Size = U2(1, -20, 0, 22), Text = "📎 Link a script in the chat", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41})
local an = inputBox(C.attF, 10, 34, 280, 28, "Script name", false, 41)
local ac = inputBox(C.attF, 10, 68, 280, 100, "Paste the script or a loadstring (up to 1,500 characters). Players can run, view or save it.", true, 41)
mb(10, 180, "Send", Color3.fromRGB(34, 160, 72), function()
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
{"Automatic re-open after rejoin is off by default. Turn it on with the 🔁 button here or in #Settings", "Settings", "#Settings"},
{"Type # and part of a script name to link one of DuaKNo's scripts in your message"},
{"Hold a message to copy or translate it. 📎 links a script, 🎮 Games shows where people are playing", nil, nil},
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
if r then add({label = "🌐 " .. r.name, name = r.name, gid = r.gid}) end
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
selectItem(ITEMS[1].name)
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
