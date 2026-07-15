-- Dependencies
local Types=require(script.Parent.Parent.Utility.Types)
local ServerStorage=game:GetService("ServerStorage")
local DropperModel=ServerStorage.DropperModel::Model
local Debris=game:GetService("Debris")

type Dropper=Types.Dropper


local Dropper={}::Dropper
Dropper.__index=Dropper




local function newModel(model: Model, cframe: CFrame)
	local clonedModel = model:Clone()
	clonedModel.Parent = workspace.ActivePlots
	clonedModel:PivotTo(cframe)
	return clonedModel
end

-- There are two main approaches , using attributes or using a config. I prefer the config approach. 
function Dropper.new(tycoon)
    local self=setmetatable({}::any, Dropper)
    self.Tycoon=tycoon
    self.Rate=DropperModel:GetAttribute("Rate")
    self._janitor=tycoon._janitor
    
    return self
end

function Dropper:Initialize()
    local dropper=newModel(DropperModel,self.Tycoon.Plot.Coordinates)
    
    self._janitor:Add(dropper)

end

function Dropper:Drop()
    
end


return Dropper