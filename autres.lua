---------
-- ESX --
---------
ESX = nil
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)


---------------
-- Debugging --
---------------
function debug(texte)
	if Config.debug == true then print(texte) end
end

------------------
-- Notification --
------------------
function HelpNotif(texte)
	if Config.helpnotif == true then ESX.ShowAdvancedNotification(texte) end
end



-------------------
-- Ouvrir portes --
-------------------
local J = GetPlayerPed(-1)
Citizen.CreateThread(function()

    debug('Autres : Ouverture des Portes')

    local Porte1 = GetClosestObjectOfType(vector3(-45.93006, -1290.66666, 29.6724), 1.0, GetHashKey('v_ilev_gc_door01'), false, false, false) 
    local Porte2 = GetClosestObjectOfType(vector3(2728.8422, 4141.5083, 44.34224), 1.0, GetHashKey('prop_cs4_11_door'), false, false, false) 

    SetEntityHeading(Porte1, -4.0) 
    SetEntityHeading(Porte2, -185.5) 

	while true do 
	
		local Jpos = GetEntityCoords(J)

		-- Proche Porte 1?
		if ( GetDistanceBetweenCoords(Jpos, vector3(-45.93006, -1290.66666, 29.6724), true) < 50.0 ) then
            local Porte1 = GetClosestObjectOfType(vector3(-45.93006, -1290.66666, 29.6724), 1.0, GetHashKey('v_ilev_gc_door01'), false, false, false) 
            SetEntityHeading(Porte1, -4.0) 
        end

        -- Proche Porte 2
		if ( GetDistanceBetweenCoords(Jpos, vector3(2728.8422, 4141.5083, 44.34224), true) < 50.0 ) then
            local Porte2 = GetClosestObjectOfType(vector3(2728.8422, 4141.5083, 44.34224), 1.0, GetHashKey('prop_cs4_11_door'), false, false, false) 
            SetEntityHeading(Porte2, -185.5) 
        end


    Citizen.Wait(5000) end
end)



-----------------------
-- Braquage Chimique --
-----------------------









-----------------------
-- Traffic de Sac G6 --
-----------------------