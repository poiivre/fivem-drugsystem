local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


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


local etape1 = false
local etape2 = false
local etape3 = false
local etape4 = false
local etape5 = false
local etape6 = false
local etape7 = false
local etape8 = false
local etape9 = false
local etape10 = false
local etape12 = false
local etape13 = false
local fini = 0
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
local LastCar



---------------------------------------------------
---------- Client Meth En Journey -----------------
---------------------------------------------------

RegisterNetEvent('drogues:Methstop')
AddEventHandler('drogues:Methstop', function()
	started = false
	FreezeEntityPosition(LastCar, false)
end)

RegisterNetEvent('drogues:Methstopfreeze')
AddEventHandler('drogues:Methstopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)

RegisterNetEvent('drogues:Methnotify')
AddEventHandler('drogues:Methnotify', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('drogues:Methstartprod')
AddEventHandler('drogues:Methstartprod', function()
	debug('Meth : Debut de la Cuisson')
	ESX.ShowNotification("~g~Debut de la Cuisson")
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('drogues:Methblowup')
AddEventHandler('drogues:Methblowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 30.0, true, false, 10.0, true)
	--SetPedOnFire(GetPlayerPed(-1), true )
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('drogues:Methsmoke')
AddEventHandler('drogues:Methsmoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")

		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedColour(smoke, 19.0, 50.0, 100.0, 0) 
		SetParticleFxLoopedAlpha(smoke, 100.0)
		
		
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('drogues:Methdrugged')
AddEventHandler('drogues:Methdrugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetCamEffect(2)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(30000)
	SetCamEffect(0)
	ClearTimecycleModifier()
	SetPedMotionBlur(GetPlayerPed(-1), false)
	SetPedIsDrunk(GetPlayerPed(-1), false)
end)



Citizen.CreateThread(function()
	debug('Meth : Script Lancé')
	local M1 = Config.Meth
	playerPed = GetPlayerPed(-1)
	while true do
		Citizen.Wait(10)
		
		

		
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == M1.vehicule and car then 
				
				if GetPedInVehicleSeat(car, -1) == playerPed then
					if (GetDistanceBetweenCoords(pos, M1.zone.x, M1.zone.y, M1.zone.z, true) < M1.zone.taille) then
						
						if started == false then
							if displayed == false then
								HelpNotif(M1.notif)
								displayed = true
							end
						end
						
						if IsControlJustReleased(0, M1.touche) then
							debug('Meth : Appuye Touche')
							if (GetDistanceBetweenCoords(pos, M1.zone.x, M1.zone.y, M1.zone.z, true) < M1.zone.taille) then
								debug('Meth : Dans la zone')
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									debug('Meth : Siege Libre')
									TriggerServerEvent('drogues:Methstart')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
								end					
							end
						end
					end
				end
			end
		else
				if started == true then
					displayed = false
					TriggerEvent('drogues:Methstop')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then 
			if fini < 10 then
				if IsPedInAnyVehicle(playerPed) then --  not pause and
				
				end

				--
				--   EVENT 1
				--
				
				if progress == 1 and etape1 == false then
					Citizen.Wait(1500)
					pause = true
					
					if selection == 0 then
						
						ESX.ShowNotification('~o~De l\'Acetone coule d\'un tube, Que faire ?')
						ESX.ShowNotification('1. Skotcher le tube~n~2. Mettre un seau pour y recup~n~3. Remplacer le tube')
					end
					if selection == 1 then
						etape1  = true
						quality = quality - 3
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape1  = true
						TriggerServerEvent('drogues:Methblow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
					
						fini = 0

					end
					if selection == 3 then
						etape1  = true
						pause = false
						quality = quality + 5
						fini = fini + 1

					end
				end
				--
				--   EVENT 2
				--
				if progress == 2  and etape2 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Il reste un peu de l\'Acetone qui avait fuit au sol, que faire ?')
						ESX.ShowNotification('1. Ouvrir les fenetres pour l\'odeur~n~2. Y laisser Sécher~n~3. Mettre un Masque a Gaz')
	
					end
					if selection == 1 then
						etape2  = true
						quality = quality - 1
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape2  = true
						pause = false
						TriggerEvent('drogues:Methdrugged')
						fini = fini + 1

					end
					if selection == 3 then
						etape2  = true
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
						fini = fini + 1

					end
				end
				--
				--   EVENT 3
				--
				if progress == 3  and etape3 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~La Meth se solidifie trop rapidement, que faire ?')
						ESX.ShowNotification('1. Ajouter de l\'Air Liquide~n~2. Augmenter la Temperature~n~3. Baisser la Temperature')
					end
					if selection == 1 then
						etape3  = true
						pause = false
						quality = quality -2
						fini = fini + 1

					end
					if selection == 2 then
						etape3  = true
						quality = quality + 5
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etape3  = true
						pause = false
						quality = quality -4
						fini = fini + 1

					end
				end
				--
				--   EVENT 4
				--
				if progress == 4  and etape4 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tu a mis un trop d\'Acetone, que faire ?')
						ESX.ShowNotification('1. Retirer avec un Paille~n~2. Retirer avec une Seringue~n~3. Ajouter du Lithium pour équilibrer')
					end
					if selection == 1 then
						etape4  = true
						quality = quality - 3
						TriggerEvent('drogues:Methdrugged')
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape4  = true
						pause = false
						quality = quality - 1
						fini = fini + 1

					end
					if selection == 3 then
						etape4  = true
						pause = false
						quality = quality + 3
						fini = fini + 1

					end
				end
				--
				--   EVENT 5
				--
				if progress == 5  and etape5 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tu trouve de l\'Eau Colorée, que faire ?')
						ESX.ShowNotification('1. L\'ajouter � la Recette~n~2. La jeter~n~3. La Boire')
					end
					if selection == 1 then
						etape5  = true
						quality = quality + 4
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape5  = true
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etape5  = true
						TriggerEvent('drogues:Methdrugged')
						ESX.ShowNotification('~o~Cé supé bon , cé comm la 86')
						pause = false
						fini = fini + 1

					end
				end
				--
				--   EVENT 6
				--
				if progress == 6  and etape6 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Le Filtre il est v\'la Sale, que faire ?')	
						ESX.ShowNotification('1. Nettoyer avec de l\'Air Compresser~n~2. Remplacer le filtre~n~3. Récurer avec une Brosse � Dent')
					end
					if selection == 1 then
						etape6  = true
						quality = quality - 2
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape6  = true
						pause = false
						quality = quality + 3
						fini = fini + 1

					end
					if selection == 3 then
						etape6  = true
						pause = false
						quality = quality - 1
						fini = fini + 1

					end
				end
				--
				--   EVENT 7
				--
				if progress == 7  and etape7 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~L\'Erlenmeyer commence � fumer, que faire ?')
						ESX.ShowNotification('1. Y Mettre un Bouchon de Liege~n~2. Le Mettre dehors un intant~n~3. Baisser la temperature')	
					end
					if selection == 1 then
						etape7  = true
						quality = quality - 1
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape7  = true
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etape7  = true
						quality = quality - 5
						pause = false
						fini = fini + 1

					end
				end
				--
				--   EVENT 8
				--
				if progress == 8  and etape8 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Bon, bientot 11h, Apéro ?')
						ESX.ShowNotification('1. Logique~n~2. Bah Ouais fréro~n~3. Peut pas c\'est Ramadan')
					end
					if selection == 1 then
						etape8  = true
						quality = quality - 3
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape8  = true
						quality = quality - 2
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						ESX.ShowNotification('~o~Ah Merde, bon bah tu sais ce que tu rate..')
						etape8  = true
						pause = false
						quality = quality + 2
						fini = fini + 1

					end
				end
				--
				--   EVENT 9
				--
				if progress == 9  and etape9 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Ca sent l\'essence la, non ?')
						ESX.ShowNotification('1. Verifier au cas ou~n~2. Mais non t\'inquete pas~n~3. Nan faut juste que je prenne une douche')	
					end
					if selection == 1 then
						etape9  = true
						ESX.ShowNotification('~o~Ah super le reservoir fuit, [Réparation..]')
						Citizen.Wait(2000)
						ESX.ShowNotification('~o~Perdu du temps mais au moins c\'est fixé')
						quality = quality - 2
						pause = false
						fini = fini + 1

					end
					if selection == 2 then	
						fuite = math.random(1, 3)
						if fuite == 1 then SetVehiclePetrolTankHealth(CurrentVehicle, 550) end
						etape9  = true
						pause = false
						quality = quality + 2
						fini = fini + 1

					end
					if selection == 3 then
						fuite = math.random(1, 5)
						if fuite == 1 then SetVehiclePetrolTankHealth(CurrentVehicle, 649) end
						etape9  = true
						pause = false
						quality = quality - 1
						fini = fini + 1

					end
				end
				--
				--   EVENT 10
				--
				if progress == 10  and etape10 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Il vous reste du Lithium en plus, que faire ?')
						ESX.ShowNotification('1. Le Verser, ca feras plus de Meth~n~2. Le Garder pour la prochaine~n~3. Melanger tout, c fun')	
					end
					if selection == 1 then
						etape10  = true
						quality = quality - 3
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape10  = true
						pause = false
						quality = quality - 5
						fini = fini + 1

					end
					if selection == 3 then
						etape10  = true
						TriggerServerEvent('drogues:Methblow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						
						fini = 0
					end
				end
				--
				--   EVENT 11
				--
				if progress == 11  and etape11 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Vous avez envie de chier, que faire ?')
						ESX.ShowNotification('1. Ce Retenir~n~2. Faire ca dehors~n~3. Faire ca dedans dans le seau pour surveiller')
					end
					if selection == 1 then
						etape11  = true
						quality = quality + 1
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape11  = true
						pause = false
						ESX.ShowNotification('~o~Pas pour etre pesimiste mais la... bah ca brule enfaite')
						quality = quality - 3
						fini = fini + 1

					end
					if selection == 3 then
						etape11  = true
						pause = false
						quality = quality - 1
						fini = fini + 1

					end
				end
				--
				--   EVENT 12
				--
				if progress == 12  and etape12 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Il reste des bouts de verre, l\'ajouter � la recette ?')
						ESX.ShowNotification('1. Bah ouais!~n~2. Non~n~3. Crever un pneu avec')
					end
					if selection == 1 then
						etape12  = true
						quality = quality + 1
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etape12  = true
						pause = false
						quality = quality + 1
						fini = fini + 1

					end
					if selection == 3 then
						etape12  = true
						pause = false
						SetVehicleTyreBurst(CurrentVehicle, 0, true, 100 )
						quality = quality - 1
						fini = fini + 1
					end
				end
				

				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('drogues:Methmake', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = math.random(1,12)
					
						

					end
				else
					TriggerEvent('drogues:Methstop')
				end

			else
				TriggerEvent('drogues:Methstop')
				fini = 0
				SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
				SetVehicleDoorShut(CurrentVehicle, 2)
				ESX.ShowNotification('~g~~h~Cuisson Terminée')
				TriggerServerEvent('drogues:Methfinish', quality)
				FreezeEntityPosition(LastCar, false)
				
				etape1 = false
				etape2 = false
				etape3 = false
				etape4 = false
				etape5 = false
				etape6 = false
				etape7 = false
				etape8 = false
				etape9 = false
				etape10 = false
				etape12 = false
				etape13 = false


			end	
			
		else end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started == true then 
					started = false
					displayed = false
					TriggerEvent('drogues:Methstop')
					
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then 
				selection = 1
				if started == true then ESX.ShowNotification('~g~Q'..progress..' : Vous avez repondu 1') end
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				if started == true then ESX.ShowNotification('~g~Q'..progress..' : Vous avez repondu 2') end

			end
			if IsControlJustReleased(0, Keys['3']) then 
				selection = 3
				if started == true then ESX.ShowNotification('~g~Q'..progress..' : Vous avez repondu 3') end

			end
		end

	end
end)
