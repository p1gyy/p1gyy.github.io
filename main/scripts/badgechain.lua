local gameNum = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name

local httpService = game:GetService("HttpService")
local badgeService = game:GetService("BadgeService")

--do httpservice stuff

for i,v in ipairs(game.Players:GetPlayers()) do
    local gui = v.PlayerGui:WaitForChild("MainGUI"):WaitForChild("Background")
    gui.badgeCount.Text = "Waiting for server..."
end

local places = httpService:GetAsync("https://pastebin.com/raw/CUbumpNi")
local placesDecoded = httpService:JSONDecode(places)

local badges = httpService:GetAsync("https://badgechain.piggygaming.repl.co/getbadges?id=" .. tostring(game.GameId))
local badgesDecoded = httpService:JSONDecode(badges)

local badgeCount = 0
for i = 1, #badgesDecoded do
	badgeCount = badgeCount + 1
end

function awardbadges(plr)
	--award badges
	print("awarding badges")
	local gui = plr.PlayerGui:WaitForChild("MainGUI"):WaitForChild("Background")
	gui.gameCount.Text = "Chain: " .. gameNum

	for i = 1, #badgesDecoded do
		local badgeid = badgesDecoded[i]
		badgeService:AwardBadge(plr.UserId, badgeid)
		gui.badgeCount.Text = "Awarding badge: " .. i .. "/" .. badgeCount
		wait()
	end
    print("teleporting player")
	--teleport plr
	gui.badgeCount.Text = "Teleporting..."
	local nextgame = placesDecoded[tostring(tonumber(gameNum) + 1)]
	
	print("Teleporting to placeid " .. nextgame)
	game:GetService("TeleportService"):Teleport(nextgame, plr)
end
for i,v in ipairs(game.Players:GetPlayers()) do
	awardbadges(v)
end
game.Players.PlayerAdded:Connect(awardbadges)
print("script loaded")