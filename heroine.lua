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
-- Heroine --
----------

local J = GetPlayerPed(-1)
local Jid = PlayerPedId()

local ZoneH1 = false
local H1 = Config.Heroine.Champs

local Recolte = false

Citizen.CreateThread(function()

	debug('Heroine : Script Lancé')
	while true do Citizen.Wait(10) 
		
		local Jpos = GetEntityCoords(J)

		-- Dans la zone champs ?
		if ( GetDistanceBetweenCoords(Jpos, H1.x, H1.y, H1.z, true) < H1.taille ) then

			ZoneH1 = true
			HelpNotif(H1.notif)
			-- Si appuye lancer la recolte
			if IsControlJustPressed(0, H1.touche) then 
				Recolte = true 
				CommencerFabricationHeroine() 
			end

		end

	end

end)

-----------------------------
-- Lancement de la recolte --
-----------------------------
function CommencerFabricationHeroine()

	debug('Heroine : Commencer Recolte')
	while ZoneH1 and Recolte do Citizen.Wait(0) 
		debug('Heroine : Recolte')
		local Jpos = GetEntityCoords(J)
		-- Sortie de la zone ?
		if ( GetDistanceBetweenCoords(Jpos, H1.x, H1.y, H1.z, true) > H1.taille ) then 
			debug('Heroine : Sortie de la zone')
			ZoneH1 = false 
		end

		-- Recolter
		ESX.ShowNotification(H1.notif2)
		SetEntityHeading(J, H1.heading)
		SetEntityCoords(J, H1.x, H1.y, H1.z-1 )
		TaskStartScenarioInPlace(Jid, "PROP_HUMAN_BUM_BIN", 0, true) 	-- Animation
		Citizen.Wait(Config.Heroine.PauseFarm)								-- Pause

		
		if ZoneH1 then
			local xrandom = math.random(Config.Heroine.Recolte.min, Config.Heroine.Recolte.max)
			TriggerServerEvent('drogues:fabriquerheroine', Config.Heroine.Items.hero, xrandom, Config.Heroine.MiniFlics, 'drogues:stopH1' )		
		end


	end -- Citizen pour eviter de crash 
end

-----------------------------------
-- Stop si plein ou pas de flics --
-----------------------------------
RegisterNetEvent('drogues:stopH1')
AddEventHandler('drogues:stopH1', function() 
	debug('Heroine : Stopper par Serveur')
	
	ClearPedTasksImmediately(Jid)
	ClearPedTasks(Jid)
	ClearPedSecondaryTask(Jid)

	ZoneH1 = false 
	Recolte = false
end)

---------------
-- Stop si X --
---------------
Citizen.CreateThread(function()

	while true do Citizen.Wait(10) 
			if Recolte == true and ZoneH1 == true and IsControlJustPressed(0, H1.toucheX) then 
				ZoneH1 = false 
				Recolte = false

				ClearPedTasksImmediately()
				ClearPedTasks()
				ClearPedSecondaryTask()

				ESX.ShowNotification(H1.notif3)
			end
			
	end

end)
