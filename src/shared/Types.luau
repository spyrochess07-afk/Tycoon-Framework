local Types = {}

-- Dependencies, required to get the types
local Janitor = require(game:GetService("ReplicatedStorage").Packages.Janitor)

export type Janitor = typeof(Janitor.new())

export type Slot = {
	{
		Available: boolean,
		Coordinates: Vector3,
	}
}



export type TycoonData = {
	Owner: Player?,
	Money: number?,
	Unlocked: { string }?,
	__janitor: Janitor,
	Slot: { Available: boolean, Coordinates: Vector3 }?,
    Plot: 
}

export type TycoonClass = {
	__index: TycoonClass,
	new: (player: Player) -> TycoonObject,
	Destroy: (self: TycoonObject) -> (),
	Instantiate: (self: TycoonObject) -> (),
	Slots: Slot,
	PickSlot: (self: TycoonObject) -> boolean,
}

export type TycoonObject = TycoonData & TycoonClass 

export type Plot={
    new:(TycoonObject)->()
}

return Types
