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
   

    return profile 
end




DataManager.GetMoney=function(player:Player):number?
   local profile=Profile.Profiles[player]
    if not profile then return end 
   return profile.Data.Money
end

DataManager.GetUnlockedInstances=function(player:Player)
    local profile=Profile.Profiles[player]                          
    if not profile then return end   --Returns a table with all the unlocked instances                                           
    return profile.Data.Unlocked
end

DataManager.AddInstance=function(player:Player,instanceData:{Name:string,Attribute:string})
    local profile=Profile.Profiles[player]
    if not profile then return end 

    local attribute=instanceData.Attribute
    local name=instanceData.Name
    if not attribute or name then return end 

    local category=profile.Data.Unlocked[attribute]
    if not category then return end 

    category.name=true 
end

return DataManager
