-- Dependencies
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Types = require(ReplicatedStorage.Shared.Types)

local PlotAssets = ServerStorage:FindFirstChild("PlotAssets")
-- Types
type Janitor = Types.Janitor
type TycoonObject = Types.TycoonObject

local Plot = {}

-- We would need a folder with all instances , in different categories

Plot.__index = Plot

function Plot.new(tycoonInstance: TycoonObject)
	local self = setmetatable({}, Plot)

	if not tycoonInstance.Slot then
		return
	end

	self.Coordinates = tycoonInstance.Slot.Coordinates
	self.Owner = tycoonInstance.Owner
	self.UnlockedInstances = tycoonInstance.Unlocked
	self.__janitor = Janitor.new()
	return self
end


function Plot:Init()
	for categoryName, items in self.UnlockedInstances do
		local categoryFolder = PlotAssets:FindFirstChild(categoryName)

		if not categoryFolder then
			print("No category folder found")
			return
		end

		for _, item in items do
			local asset = categoryFolder:FindFirstChild(item)
			if asset then
				local clonedAsset = asset:Clone()
				-- Here we parent the asset to the plot which I have to find a way to create .
			else
				print("Item" .. item .. "is not found in the category folder")
			end
		end
	end
end

function Plot:destroy() end

return Plot
