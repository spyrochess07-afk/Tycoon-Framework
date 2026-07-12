local Players = game:GetService("Players")
local ProfileStore = require(game.ServerScriptService.ServerPackages.ProfileStore)
local Types=require(game:GetService("ReplicatedStorage").Shared.Types)

type Template=Types.Template

local TEMPLATE: Template = {
	Money = 0,
	Unlocked = {
		["Generators"] = {["First"]=true}  ,
		["Buttons"] = {["Hi"]=true},
	},
}



local PlayerStore = ProfileStore.New("PlayerData", TEMPLATE)

local Profile = {}

Profile.Profiles = {} :: { [Player]: typeof(PlayerStore:StartSessionAsync()) }

Profile.PlayerAdded = function(player: Player)
	local profile = PlayerStore:StartSessionAsync(`{player.UserId}`, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	if profile ~= nil then
		profile:AddUserId(player.UserId)
		profile:Reconcile()

		profile.OnSessionEnd:Connect(function()
			Profile.Profiles[player] = nil
			player:Kick(`Profile session end - Please rejoin`)
		end)

		if player.Parent == Players then
			Profile.Profiles[player] = profile
			print(`Profile loaded for {player.DisplayName}!`)
		else
			profile:EndSession()
		end
	else
		player:Kick(`Profile load fail - Please rejoin`)
	end
end

Profile.Removed = function(player: Player)
	local profile = Profile.Profiles[player]
	if profile ~= nil then
		profile:EndSession()
	end
end

return Profile
