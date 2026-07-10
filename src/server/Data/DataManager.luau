-- Dependancies
local Profile = require(script.Parent.Profile)



-- Constants
local INIT_TIME=0.5
local MAX_ATTEMPTS=5

local DataManager = {}


DataManager.LoadProfile = function(player: Player)
	local attempts = 0
    local profile=Profile.Profiles[player]

	while not profile and attempts<MAX_ATTEMPTS do 
        attempts+=1
        task.wait(INIT_TIME*(2^(attempts-1))) -- 0.5 , 1 , 2 , 4, 8 
    end 
    print("Profile fetched for".. player.Name)
   

    return profile , "Profile loaded"
end




DataManager.GetMoney=function(player:Player):number?
   local profile=Profile.Profiles[player]
    if not profile then return end 
   return profile.Data.Money
end

DataManager.GetUnlockedInstances=function(player:Player):{string}? 
    local profile=Profile.Profiles[player]                          
    if not profile then return end   --Returns a table with all the unlocked instances                                           
    return profile.Data.Unlocked
end



return DataManager
