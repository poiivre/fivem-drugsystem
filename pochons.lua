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

--------------
-- Pochons  --
--------------

local J = GetPlayerPed(-1)
local Jid = PlayerPedId()

local ZoneP = false
local P = Config.Pochons
local P1 = false

local Pochonnage = false

Citizen.CreateThread(function()

	debug('Pochons : Script Lancé')
	while true do Citizen.Wait(10) 
		
		local Jpos = GetEntityCoords(J)

		-- Dans la zone pochonnage ?

        for k,v in pairs(P.Zones) do
			
            if ( GetDistanceBetweenCoords(Jpos, v.x, v.y, v.z, true) < v.taille ) then

                ZoneP = true
                HelpNotif(P.notif)
                -- Si appuye lancer la recolte
                if IsControlJustPressed(0, P.touche) and GetDistanceBetweenCoords(Jpos, v.x, v.y, v.z, true) < v.taille then 
                    Pochonnage = true 
                    P1 = v
                    MenuPochonnage() 
                end

            end
        end
	end

end)

-----------------------------
-- Choisir quel Pochonnage --
-----------------------------
function MenuPochonnage()

    debug('Pochons : Menu Selection')
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pochonnage', {
        css = 'Hollidays', 
        title= "Pochonnage", align = 'right', 

        elements = {
            { label = 'Cocaine', value = 'coke' },
            { label = 'Weed', value = 'weed' },
            { label = 'Meth', value = 'meth' },
        }

    }, 	function(data, menu)
            
        
        menu.close()
        CommencerPochonnage(data.current.value)

        end,function(data, menu) 
    menu.close() 
        end)

end

--------------------------------
-- Lancement de le Pochonnage --
--------------------------------
function CommencerPochonnage(item)

	debug('Pochons : Commencer Pochonnage de '..item)

	while ZoneP and Pochonnage do Citizen.Wait(0) 
		debug('Pochons : Recolte')
		local Jpos = GetEntityCoords(J)
		-- Sortie de la zone ?
		if ( GetDistanceBetweenCoords(Jpos, P1.x, P1.y, P1.z, true) > P1.taille ) then
            debug('Pochons : Sortie de la zone')
            ZoneP = false
            P1 = false 
        end

		-- Recolter
		ESX.ShowNotification(P.notif2)
        SetEntityCoords(J, P1.x, P1.y, P1.z-1 )
        SetEntityHeading(J, P1.heading)
		TaskStartScenarioInPlace(Jid, "PROP_HUMAN_BUM_BIN", 0, true) 	-- Animation
		Citizen.Wait(Config.Pochons.PauseFarm)							-- Pause

		
		if ZoneP then
			TriggerServerEvent('drogues:pochonnage', item, Config.Pochons.MiniFlics, 'drogues:stopP' )		
		end


	end -- Citizen pour eviter de crash 

    
end

-----------------------------------
-- Stop si plein ou pas de flics --
-----------------------------------
RegisterNetEvent('drogues:stopP')
AddEventHandler('drogues:stopP', function() 
	debug('Pochons : Stopper par Serveur')
	
	ClearPedTasksImmediately(Jid)
	ClearPedTasks(Jid)
	ClearPedSecondaryTask(Jid)

	ZoneP = false 
    p1 = false
	Pochonnage = false
end)

---------------
-- Stop si X --
---------------
Citizen.CreateThread(function()

	while true do Citizen.Wait(10) 
			if ZoneP == true and IsControlJustPressed(0, P.toucheX) then 
				ZoneP = false 
				Recolte = false

				ClearPedTasksImmediately()
				ClearPedTasks()
				ClearPedSecondaryTask()

				ESX.ShowNotification(P.notif3)
			end
			
	end

end)
