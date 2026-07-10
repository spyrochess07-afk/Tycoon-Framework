-- Dependencies
local Tycoon = require(script.Parent.Tycoon) -- We require this module to obtain the type
type TycoonObject = Tycoon.TycoonObject

local Plot = {}
Plot.__index = Plot

function Plot.new() end

function Plot:destroy() end

return Plot
