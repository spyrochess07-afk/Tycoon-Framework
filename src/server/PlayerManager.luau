local Players = game:GetService("Players")

-- Dependancies
local Tycoon = require(script.Parent.Classes.Tycoon)
local Plot = require(script.Parent.Classes.Plot)
local Profile = require(script.Parent.Data.Profile)
local DataManager = require(script.Parent.Data.DataManager)
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)

-- Types
type TycoonObject = Types.TycoonObject
type Plot=Types.Plot
--

local PlayerManager = {}
local activeTycoons: { [Player]: TycoonObject } = {}
local activePlots:{[Player]:Plot}={}

PlayerManager.Added = function(player: Player)
	Profile.PlayerAdded(player)

	local profile = DataManager.LoadProfile(player)
	if not profile then
		player:Kick("Error connecting to player profile. Rejoin")
		return
	end

	if activeTycoons[player] or activePlots[player] then 
		warn("Ghost data commencing deletion:")	
		
		if activeTycoons[player] then 
			activeTycoons[player]:Destroy() 
			
		end 
		
		if activePlots[player] then 
			activePlots[player]:Destroy()
		end

		activeTycoons[player]=nil
		activePlots[player]=nil
	end


	local tycoon = Tycoon.new(player)
	local plot=Plot.new(player)::Plot
	
	if not tycoon or not plot then
		
		warn("No tycoon or no plot")
		if tycoon then 
			tycoon:Destroy() 
		end
		if plot then 
			plot:Destroy() 
		end
		
		player:Kick("Error loading data, rejoin shortly")
		return
	end
	
	activeTycoons[player] = tycoon
	activePlots[player]=plot

	plot:Init()
	
end

PlayerManager.Removed = function(player: Player)
	Profile.Removed(player)

	local tycoon = activeTycoons[player]
	local plot=activePlots[player]

	if tycoon then
		tycoon:Destroy()
		activeTycoons[player] = nil
	end
	if plot then 
		plot:Destroy()
		activePlots[player]=nil
	end 

	print(player.Name.. " left the game")
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
