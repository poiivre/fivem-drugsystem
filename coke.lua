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

---------------------
-- Coke sur tables --
---------------------


local startedcoke = false
local etapecoke1 = false
local etapecoke2 = false
local etapecoke3 = false
local etapecoke4 = false
local etapecoke5 = false
local etapecoke6 = false
local progresscoke = 0
local fini = 0
local started = false
local displayed = false
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0


Citizen.CreateThread(function()
    
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then 
				selection = 1
				if startedcoke == true then ESX.ShowNotification('~g~Q'..progresscoke..' : Vous avez repondu 1') end
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				if startedcoke == true then ESX.ShowNotification('~g~Q'..progresscoke..' : Vous avez repondu 2') end

			end
			if IsControlJustReleased(0, Keys['3']) then 
				selection = 3
				if startedcoke == true then ESX.ShowNotification('~g~Q'..progresscoke..' : Vous avez repondu 3') end

			end
		end

	end
end)

---------------------------------------------------
-------------- Client Coke Sur Table --------------
---------------------------------------------------

RegisterNetEvent('drogues:Cokestop')
AddEventHandler('drogues:Cokestop', function()
	startedcoke = false
	FreezeEntityPosition(GetPlayerPed(-1), false)
end)


RegisterNetEvent('drogues:Cokestartprod')
AddEventHandler('drogues:Cokestartprod', function()
    local C1 = Config.Coke
	SetEntityHeading(GetPlayerPed(-1), C1.zone.heading)   
	SetEntityCoords(GetPlayerPed(-1), C1.zone.x, C1.zone.y, C1.zone.z-1 )

	ESX.ShowNotification("~g~Debut de la Préparation")
	startedcoke = true
	FreezeEntityPosition(GetPlayerPed(-1),true)
	displayed = false
end)


Citizen.CreateThread(function()
    debug('Coke : Script Lancé')
    local C1 = Config.Coke
    playerPed = GetPlayerPed(-1)

	while true do
        Citizen.Wait(10)

		local pos = GetEntityCoords(GetPlayerPed(-1))	

		if (GetDistanceBetweenCoords(pos, C1.zone.x, C1.zone.y, C1.zone.z, true) < C1.zone.taille) then
			if startedcoke == false then
				if displayed == false then
					HelpNotif(C1.notif)
					displayed = true
				end
			end
		
			if IsControlJustReleased(0, C1.touche) then
				if (GetDistanceBetweenCoords(pos, C1.zone.x, C1.zone.y, C1.zone.z, true) < C1.zone.taille) then
					TriggerServerEvent('drogues:Cokestart')	
                    TaskStartScenarioInPlace(Jid, "PROP_HUMAN_BUM_BIN", 0, true)
					progress = 0
					pause = false
					selection = 0
					quality = 0
										
				end
			end		
								
		end
		if startedcoke == true then
			if fini < 6 then
				if not pause and (GetDistanceBetweenCoords(pos, C1.zone.x, C1.zone.y, C1.zone.z, true) < C1.zone.taille) then end
				--
				--   EVENT 1
				--
				if progresscoke == 1 and etapecoke1 == false then
					Citizen.Wait(1500)
					pause = true
					
					if selection == 0 then
						
						ESX.ShowNotification('~o~Que faut-il mélangé aux feuilles au d�but du proc�d� ?')
						ESX.ShowNotification('1. De l\'acetone~n~2. Du Polymere~n~3. De la Cocaine')
					end
					if selection == 1 then ESX.ShowNotification('Vous avez repondu 1')
						etapecoke1  = true
						quality = quality - 3
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etapecoke1  = true
						quality = quality + 5
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etapecoke1  = true
						quality = quality - 3
						pause = false
						fini = fini + 1

					end
				end
				--
				--   EVENT 2
				--
				if progresscoke == 2  and etapecoke2 == false then 
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Les feuilles ne sont pas assez malaxées, Que rajouter ?')
						ESX.ShowNotification('1. Du Ciment ~n~2. De la Boue~n~3. Des Serviettes Hygiennique')
	
					end
					if selection == 1 then 
						etapecoke2  = true
						quality = quality + 4
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etapecoke2  = true
						quality = quality + 0
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etapecoke2  = true
						quality = quality - 5
						pause = false
						fini = fini + 1

					end
				end
				--
				--   EVENT 3
				--
				if progresscoke == 3  and etapecoke3 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Ca Commence a etre un peu long, Comment accelerer le process ?')
						ESX.ShowNotification('1. Ajouter du Kérosene~n~2. Mettre plus d\'eau~n~3. En lui mettant la pression')
					end
					if selection == 1 then
						etapecoke3  = true
						quality = quality + 3
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etapecoke3  = true
						quality = quality - 4
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etapecoke3  = true
						quality = quality + 0
						pause = false
						fini = fini + 1

					end
				end
				--
				--   EVENT 4
				--
				if progresscoke == 4  and etapecoke4 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Vous trouvez un bidon d\'Acide Hydrochlorique, Que faire ?')
						ESX.ShowNotification('1. Gouter~n~2. Tremper les Feuilles avec~n~3. Ne pas y Toucher')
					end
					if selection == 1 then
						etapecoke4  = true
						quality = quality - 3
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						TriggerEvent('esx_methcar:drugged')
						ESX.ShowNotification('~o~ptdr t con')

						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etapecoke4  = true
						quality = quality + 3
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etapecoke4  = true
						quality = quality - 1
						pause = false
						fini = fini + 1

					end
				end
				--
				--   EVENT 5
				--
				if progresscoke == 5  and etapecoke5 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Le pH est insuffisant, Que faire ?')
						ESX.ShowNotification('1. Ajouter du Bicarbonate de Sodium~n~2. Ajouter du PolyHexaméthyl�ne~n~3. Augmenter la temperature')
					end
					if selection == 1 then
						etapecoke5  = true
						quality = quality + 3
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etapecoke5  = true
						quality = quality - 4
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etapecoke5  = true
						quality = quality - 2
						pause = false
						fini = fini + 1

					end
				end
				--
				--   EVENT 6
				--
				if progresscoke == 6  and etapecoke6 == false then
					Citizen.Wait(1500)
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~La recette dit le chauffer la substance, Que faire ?')
						ESX.ShowNotification('1. Y mettre au Soleil~n~2. Y Chauffer avec un Lampe~n~3. Verser l\'essence dessus pour y foutre feu')
					end
					if selection == 1 then
						etapecoke6  = true
						quality = quality - 3
						pause = false
						fini = fini + 1

					end
					if selection == 2 then
						etapecoke6  = true
						quality = quality + 5
						pause = false
						fini = fini + 1

					end
					if selection == 3 then
						etapecoke6  = true
						quality = quality - 15
						pause = false
						fini = fini + 1

					end
				end

				
					TriggerServerEvent('drogues:Cokemake', pos.x,pos.y,pos.z-1)
					if pause == false then
						selection = 0
						quality = quality + 1
						progresscoke = math.random(1,6)
						

					end

			else
                ClearPedTasksImmediately(Jid)
                ClearPedTasks(Jid)
                ClearPedSecondaryTask(Jid)

				TriggerEvent('drogues:Cokestop')
				fini = 0
				ESX.ShowNotification('~g~~h~Préparation Terminée')
				TriggerServerEvent('drogues:Cokefinish', quality)
				FreezeEntityPosition(PlayerPed, false)
				
				etapecoke1 = false
				etapecoke2 = false
				etapecoke3 = false
				etapecoke4 = false
				etapecoke5 = false
				etapecoke6 = false

			end	
			
		end
		
	end
end)

