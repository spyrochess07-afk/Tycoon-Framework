local ReplicatedStorage = game:GetService("ReplicatedStorage")

--Dependencies
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local DataManager = require(script.Parent.Parent.Data.DataManager)
local Types = require(ReplicatedStorage.Shared.Types)
--

--Types
type Janitor = Types.Janitor
type TycoonData = Types.TycoonData
type TycoonClass = Types.TycoonClass
type TycoonObject = Types.TycoonObject
--

local Tycoon = {} :: TycoonClass
Tycoon.__index = Tycoon

function Tycoon.new(player: Player): TycoonObject
	local self = setmetatable({} :: TycoonObject, Tycoon)

	self.Owner = player
	self.__janitor = Janitor.new()
	self.Money = DataManager.GetMoney(player)
	self.Unlocked = DataManager.GetUnlockedInstances(player)

	return self
end

function Tycoon:Destroy()
	self.Owner = nil
	self.Money = nil
	self.Unlocked = nil

	self.__janitor:Destroy()
end

return Tycoon
