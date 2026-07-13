-- Services;Folders;Signals
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local PlotAssets = ServerStorage:FindFirstChild("PlotAssets")

-- Dependencies
local DataManager = require(script.Parent.Parent.Data.DataManager)
local config=require(script.Parent.config)
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Types = require(ReplicatedStorage.Shared.Types)

-- Types
type PlotClass = Types.PlotClass
type Plot = Types.Plot

local Plot = {} :: Plot

Plot.Plots = {
	[1] = { Number=1,Coordinates = Vector3.new(0, 0, 100), Available = true},
	-- Same ahh logic you know
}


Plot.__index = Plot

function Plot.new(player: Player)
	local self = setmetatable({} :: Plot, Plot)
	self.Owner = player
	self.Unlocked = DataManager.GetUnlockedInstances(self.Owner)

	self.__janitor = Janitor.new()
	self.Plot = self:PickPlot()

	return self
end

function Plot:PickPlot()
	for _, plot in Plot.Plots do
		if plot.Available then
			plot.Available = false
			print("Available plot found")
			print(plot)
			return plot
		end
	end
end

function Plot:Init() -- When the player joins a server it loads each part of his plot
	if not self.Plot then
		warn("no plot")
		return
	end

	local model = PlotAssets:FindFirstChild("Plot")
	local clonedModel = model:Clone() :: Model
	clonedModel.Name = self.Owner.Name .. "'s plot"
	clonedModel.Parent = workspace.ActivePlots

	clonedModel:MoveTo(self.Plot.Coordinates)
	 

	self.__janitor:Add(clonedModel,"Destroy")

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
				

				local clonedAsset = asset:Clone()::BasePart
				clonedAsset.Parent = workspace 
			
				clonedAsset.CFrame=clonedModel:GetPivot() *config["First"]
				-- Temporary
				-- Here add the parent logic more extensively

				self.__janitor:Add(clonedAsset, "Destroy")
			end
		end
	end
end

function Plot:AddAsset(asset)
	local categoryName = asset.Attribute
	local category = PlotAssets:FindFirstChild(categoryName)

	if not category then
		warn("No category found!")
		return
	end

	local item = category:FindFirstChild(asset.Name)
	local clonedItem = item:Clone()
	-- Once again add parent logic right here ideally self.Plot -- parent smt like that

	self.__janitor:Add(clonedItem, "Destroy")
end

function Plot:Destroy()
	print("Destroying all plot data for " .. self.Owner.Name)
	Plot.Plots[self.Plot.Number].Available=true
	self.__janitor:Destroy()
end

return Plot
