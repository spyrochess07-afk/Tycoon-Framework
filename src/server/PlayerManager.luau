local Players = game:GetService("Players")

-- Dependancies

local Profile = require(script.Parent.Data.Profile)
local Tycoon=require(script.Parent.Tycoon)

local PlayerManager = {}

local activeTycoons:{[Player]:typeof(Tycoon)}={}

PlayerManager.Added = function(player: Player)
	Profile.PlayerAdded(player)
	
	
	local tycoon=Tycoon.new(player)
	activeTycoons[player]=tycoon
	tycoon:Initialize()
end

PlayerManager.Removed = function(player: Player)
	Profile.Removed(player)
	local tycoon=activeTycoons[player]
	tycoon:Destroy()
end




Players.PlayerAdded:Connect(function(player: Player)
	PlayerManager.Added(player)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	PlayerManager.Removed(player)
end)

for _, player in Players:GetPlayers() do
	task.spawn(PlayerManager.Added, player)
end

return PlayerManager
