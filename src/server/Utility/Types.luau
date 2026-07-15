-- Dependencies, required to get the types
local Janitor = require(game:GetService("ReplicatedStorage").Packages.Janitor)

local Types= {}

-- GC module
export type Janitor = typeof(Janitor.new())
--

-- Data
export type ProfileTemplate = {
	Money: number,
	Rebirths: number,
}
--


-- Tycoon class
export type Tycoon={
	-- Properties
	Owner:Player,
	_janitor:Janitor,
	Model:Model,
	Plot: {Available: boolean, Coordinates: CFrame },
	PlotId:number,

	--Methods, constructors...
	__index:Tycoon,
	new:(Player)->Tycoon,
	Initialize:(Tycoon)->(),
	Destroy:(Tycoon)->(),

}

-- Dropper class 
export type Dropper={
	-- Properties
	Tycoon:Tycoon,
	Rate:number,

	-- Methods,constructors...
	__index:Dropper,
	new:(Tycoon)->Dropper,
	Destroy:(Dropper)->(),
	Initialize:(Dropper)->(),
	Drop:(Dropper)->()

}

return Types
