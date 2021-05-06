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

----------
-- Weed --
----------

local J = GetPlayerPed(-1)
local Jid = PlayerPedId()

local ZoneW1 = false
local W1 = Config.Weed.Champs

local Recolte = false

Citizen.CreateThread(function()

	debug('Weed : Script Lancé')
	while true do Citizen.Wait(10) 
		
		local Jpos = GetEntityCoords(J)

		-- Dans la zone champs ?
		if ( GetDistanceBetweenCoords(Jpos, W1.x, W1.y, W1.z, true) < W1.taille ) then

			ZoneW1 = true
			HelpNotif(W1.notif)
			-- Si appuye lancer la recolte
			if IsControlJustPressed(0, W1.touche) then 
				Recolte = true 
				CommencerRecolteWeed() 
			end

		end

	end

end)

-----------------------------
-- Lancement de la recolte --
-----------------------------
function CommencerRecolteWeed()

	debug('Weed : Commencer Recolte')
	while ZoneW1 and Recolte do Citizen.Wait(0) 
		debug('Weed : Recolte')
		local Jpos = GetEntityCoords(J)
		-- Sortie de la zone ?
		if ( GetDistanceBetweenCoords(Jpos, W1.x, W1.y, W1.z, true) > W1.taille ) then 
			debug('Weed : Sortie de la zone')
			ZoneW1 = false 
		end

		-- Recolter
		ESX.ShowNotification(W1.notif2)
		SetEntityCoords(J, Jpos.x, Jpos.y, Jpos.z-1 )
		TaskStartScenarioInPlace(Jid, "PROP_HUMAN_BUM_BIN", 0, true) 	-- Animation
		Citizen.Wait(Config.Weed.PauseFarm)								-- Pause

		
		if ZoneW1 then
			local xrandom = math.random(Config.Weed.Recolte.min, Config.Weed.Recolte.max)
			TriggerServerEvent('drogues:recolteritem', Config.Weed.Items.feuilles, xrandom, Config.Weed.MiniFlics, 'drogues:stopW1' )		
		end


	end -- Citizen pour eviter de crash 
end

-----------------------------------
-- Stop si plein ou pas de flics --
-----------------------------------
RegisterNetEvent('drogues:stopW1')
AddEventHandler('drogues:stopW1', function() 
	debug('Weed : Stopper par Serveur')
	
	ClearPedTasksImmediately(Jid)
	ClearPedTasks(Jid)
	ClearPedSecondaryTask(Jid)

	ZoneW1 = false 
	Recolte = false
end)

---------------
-- Stop si X --
---------------
Citizen.CreateThread(function()

	while true do Citizen.Wait(10) 
			if Recolte == true and ZoneW1 == true and IsControlJustPressed(0, W1.toucheX) then 
				ZoneW1 = false 
				Recolte = false

				ClearPedTasksImmediately()
				ClearPedTasks()
				ClearPedSecondaryTask()

				ESX.ShowNotification(W1.notif3)
			end
			
	end

end)
