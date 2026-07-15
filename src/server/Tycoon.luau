-- Dependencies/Types
local Types = require(script.Parent.Utility.Types)
local Janitor = require(game:GetService("ReplicatedStorage").Packages.Janitor)
local ServerStorage = game:GetService("ServerStorage")

local PlotModel = ServerStorage.PlotModel

type Tycoon = Types.Tycoon

local Tycoon = {} :: Tycoon
Tycoon.__index = Tycoon

local plots = {
	[1] = { Available = true, Coordinates = CFrame.new(0, 1, 0) },
	[2] = { Available = true, Coordinates = CFrame.new(100, 1, 0) },
	[3] = { Available = true, Coordinates = CFrame.new(-100, 1, 0) },
	[4] = { Available = true, Coordinates = CFrame.new(0, 1, 100) },
	[5] = { Available = true, Coordinates = CFrame.new(0, 1, -100) },
	[6] = { Available = true, Coordinates = CFrame.new(100, 1, 100) },
	[7] = { Available = true, Coordinates = CFrame.new(-100, 1, -100) },
	[8] = { Available = true, Coordinates = CFrame.new(100, 1, -100) },
}

local pickingPlot = false

local function pickPlot(): ({ Available: boolean, Coordinates: CFrame }, number)
	while pickingPlot do
		task.wait()
	end

	pickingPlot = true
	for index, plot in plots do
		if plot.Available then
			plot.Available = false
			pickingPlot = false
			return plot, index
		end
	end
	pickingPlot = false
	warn({ "No plot found" })
	return { Available = false, Coordinates = CFrame.new(0, 0, 0) }, 0
end

local function newModel(model: Model, cframe: CFrame)
	local clonedModel = model:Clone()
	clonedModel.Parent = workspace.ActivePlots
	clonedModel:PivotTo(cframe)
	return clonedModel
end

function Tycoon.new(player: Player)
	local self = setmetatable({} :: any, Tycoon)

	self.Owner = player
	self._janitor = Janitor.new()

	return self
end

function Tycoon:Initialize()
	self.Plot, self.PlotId = pickPlot()

	if self.Plot then
		self.Model = newModel(PlotModel, self.Plot.Coordinates)
		self._janitor:Add(self.Model,"Destroy")
	else
		warn("No plot found")
	end

	print("Tycoon has been initialized")
end

function Tycoon:Destroy()
	local _self = self :: any
	_self.Owner = nil
	_self.Plot = nil
	_self.Model = nil
	
	plots[_self.PlotId].Available = true
	_self.PlotId = nil

	_self._janitor:Destroy()

	print("Tycoon has been destroyed")
end

return Tycoon
