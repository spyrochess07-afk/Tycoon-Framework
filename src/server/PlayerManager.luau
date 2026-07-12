local Players = game:GetService("Players")

-- Dependancies
local Tycoon = require(script.Parent.Classes.Tycoon)
local Profile=require(script.Parent.Data.Profile)
local _DataManager=require(script.Parent.Data.DataManager)

-- Types
type TycoonObject=Tycoon.TycoonObject
--

local PlayerManager = {}
local activeTycoons: { [Player]: TycoonObject } = {}

PlayerManager.Added = function(player: Player)
	
	Profile.PlayerAdded(player)
	if activeTycoons[player] then -- This should be impossible because of the nil clear on remove
		return
	end

	local tycoon = Tycoon.new(player)
	activeTycoons[player] = tycoon
end

PlayerManager.Removed = function(player: Player)
	
	Profile.Removed(player)
	
	local tycoon = activeTycoons[player]
	if tycoon then
		tycoon:Destroy()
        activeTycoons[player]=nil
	end

end









Players.PlayerAdded:Connect(function(player: Player)
	PlayerManager.Added(player)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	PlayerManager.Removed(player)
end)

for _,player in Players:GetPlayers() do
	task.spawn(PlayerManager.Added,player)
end 


return PlayerManager
