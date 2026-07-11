local ReplicatedStorage = game:GetService("ReplicatedStorage")
--Dependencies
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local DataManager = require(script.Parent.Parent.Data.DataManager)
local Plot = require(script.Parent.Plot)
local Types = require(ReplicatedStorage.Shared.Types)

--Types
type Janitor = Types.Janitor
type Slot = Types.Slot
type TycoonData = Types.TycoonData
type TycoonClass = Types.TycoonClass
type TycoonObject = Types.TycoonObject

--

local Tycoon = {} :: TycoonClass
Tycoon.__index = Tycoon

Tycoon.Slots = {
	[1] = { ["Available"] = true, ["Coordinates"] = Vector3.new() },
	[2] = { ["Available"] = true, ["Coordinates"] = Vector3.new() },
}

function Tycoon.new(player: Player): TycoonObject
	local self = setmetatable({} :: TycoonObject, Tycoon)

	self.Owner = player
	self.__janitor = Janitor.new()
	self.Money = DataManager.GetMoney(player)
	self.Unlocked = DataManager.GetUnlockedInstances(player)
	self.Slot = nil

	if self:PickSlot() then
		self.Plot = Plot.new(self)
	end


	return self
end

function Tycoon:PickSlot()
	for _, slot in pairs(Tycoon.Slots) do
		if slot.Available then
			self.Slot = slot
			slot.Available = false

			return true
		end
	end
	return false
end

function Tycoon:Destroy()
	self.Owner = nil
	self.Money = nil
	self.Unlocked = nil

	self.__janitor:Destroy()
end

return Tycoon
