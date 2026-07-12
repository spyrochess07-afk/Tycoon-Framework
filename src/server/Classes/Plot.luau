-- Dependencies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Types = require(ReplicatedStorage.Shared.Types)

local PlotAssets = ServerStorage:FindFirstChild("PlotAssets")

-- Types
type Janitor = Types.Janitor
type TycoonObject = Types.TycoonObject
type PlotData = Types.PlotData
type PlotObject = Types.PlotObject
local Plot = {} :: PlotObject


Plot.__index = Plot

function Plot.new(tycoonInstance: TycoonObject): PlotObject
	local self = setmetatable({} :: PlotObject, Plot)
	
	self.Coordinates = tycoonInstance.Slot.Coordinates
	self.Owner = tycoonInstance.Owner
	self.UnlockedInstances = tycoonInstance.Unlocked
	self.__janitor = Janitor.new()
	self:Init()
	print("Plot object created")
	return self
end

function Plot:Init()
	print("Initializing!")
	
	for categoryName, items in pairs(self.UnlockedInstances) do
		local categoryFolder = PlotAssets:FindFirstChild(categoryName)

		if not categoryFolder then
			warn("No category folder found for: " .. tostring(categoryName))
			continue
		end

		for item, owned in items do
			if not owned then continue end 
			local asset = categoryFolder:FindFirstChild(item)
			if asset then
				local clonedAsset = asset:Clone()
				clonedAsset.Parent=workspace
				-- Parent the asset
				self.__janitor:Add(clonedAsset)
			else
				warn("Item " .. tostring(item) .. " is not found in the category folder")
			end
		end
	end
end




function Plot:Destroy() 

	self.Coordinates=nil
	self.Owner=nil
	self.UnlockedInstances=nil
	self.__janitor:Destroy()
end

return Plot
