local Types = {}

-- Dependencies, required to get the types
local Janitor = require(game:GetService("ReplicatedStorage").Packages.Janitor)

export type Janitor = typeof(Janitor.new())

export type Template = {
	Money: number,
	Unlocked: Unlocked,
}

export type Unlocked = { [string]: { [string]: boolean } }

export type TycoonObject = TycoonData & TycoonClass

export type TycoonData = {
	Owner: Player?,
	Money: number?,
	Unlocked: Unlocked?,
	__janitor: Janitor,
}

export type TycoonClass = {
	__index: TycoonClass,
	new: (player: Player) -> TycoonObject,
	Destroy: (self: TycoonObject) -> (),
	Instantiate: (self: TycoonObject) -> (),
	PickSlot: (self: TycoonObject) -> boolean,
}

export type PlotClass = {

	__index: PlotClass,
	new: (Player) -> PlotClass,
	Destroy:(Plot)->(),
	Init:(Plot)->()
	
}

export type PlotData={
	__janitor:Janitor,
	Owner:Player,
	Unlocked:Unlocked
}

export type Plot= PlotClass & PlotData


return Types
