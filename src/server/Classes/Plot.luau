-- Dependencies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager = require(script.Parent.Parent.Data.DataManager)
local ServerStorage = game:GetService("ServerStorage")
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Types = require(ReplicatedStorage.Shared.Types)

local PlotAssets = ServerStorage:FindFirstChild("PlotAssets")

-- Types
type PlotClass = Types.PlotClass
type Plot = Types.Plot

local Plot = {} :: PlotClass

Plot.__index = Plot

function Plot.new(player: Player)
	local self = setmetatable({} :: Plot, Plot)

	self.Owner = player
	self.__janitor = Janitor.new()

	return self
end

function Plot:Init()
	self.Unlocked = DataManager.GetUnlockedInstances(self.Owner)

	for categoryName, itemList in self.Unlocked do
		local category = PlotAssets:FindFirstChild(categoryName)

		if category then
			for itemName, owned in itemList do
				if not owned then
					return
				end
				local asset = category:FindFirstChild(itemName)
				if not asset then
					continue
				end

				local clonedAsset = asset:Clone()
				clonedAsset.Parent=workspace -- Temporary 
				-- Here add the parent logic more extensively 

				self.__janitor:Add(clonedAsset, "Destroy")
			end
		end
	end
end

function Plot:Destroy()
	print("Destroying all plot data for " .. self.Owner.Name)
	self.__janitor:Destroy()
end

return Plot
