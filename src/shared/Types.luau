local Types = {}

-- Dependencies, required to get the types
local Janitor = require(game:GetService("ReplicatedStorage").Packages.Janitor)

export type Janitor = typeof(Janitor.new())

export type Template = {
	Money: number,
	Unlocked: Unlocked,
}

	
export type Unlocked=  { [string]: { [string]:boolean } 
}

export type Slot = {
	{
		Available: boolean,
		Coordinates: Vector3,
	}
}

export type TycoonObject = TycoonData & TycoonClass 

export type TycoonData = {
	Owner: Player?,
	Money: number?,
	Unlocked: Unlocked?,
	__janitor: Janitor,
	Slot: { Available: boolean, Coordinates: Vector3 }?,
    Plot: PlotObject
}

export type TycoonClass = {
	__index: TycoonClass,
	new: (player: Player) -> TycoonObject,
	Destroy: (self: TycoonObject) -> (),
	Instantiate: (self: TycoonObject) -> (),
	Slots: Slot,
	PickSlot: (self: TycoonObject) -> boolean,
}

export type PlotData = {	
	UnlockedInstances:Unlocked?,
	Owner:Player?,
	Coordinates:Vector3?,
	__janitor:Janitor,
}

export type PlotClass={
	__index:PlotClass,
	new:(TycoonObject)->PlotObject,
	Init:(PlotObject)->(),
	Destroy:(PlotObject)->(),
	
}

export type PlotObject= PlotData & PlotClass 

return Types
