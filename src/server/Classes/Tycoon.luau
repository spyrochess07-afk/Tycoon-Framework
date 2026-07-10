


local Tycoon = {} :: TycoonClass
Tycoon.__index = Tycoon

type TycoonData = {
	Owner: Player?,
	Money:number?,
	Unlocked:{string}?,
	__janitor:Janitor,
}

type TycoonClass = {
	__index: TycoonClass,
	new: (player:Player) -> TycoonObject,
    Destroy:(self:TycoonObject)->(),
	Instantiate:(self:TycoonObject)->(),
	
}

export type TycoonObject = TycoonData & typeof(Tycoon) -- Cyclic type dependency! Must modify


--Dependencies
local DataManager=require(script.Parent.Parent.Data.DataManager)
local Janitor=require(game:GetService("ReplicatedStorage").Packages.Janitor)
type Janitor=typeof(Janitor.new())
--


function Tycoon.new(player: Player): TycoonObject
	
	local self = setmetatable({} :: TycoonObject, Tycoon)

	self.Owner = player
	self.__janitor=Janitor.new()
	self.Money=DataManager.GetMoney(player)
	self.Unlocked=DataManager.GetUnlockedInstances(player)

	return self
end





function Tycoon:Destroy()
    self.Owner=nil
	self.Money=nil
	self.Unlocked=nil
	
	self.__janitor:Destroy()
end


return Tycoon
