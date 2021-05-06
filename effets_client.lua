---------
-- ESX --
---------
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)    
    end
end)

function missionstexte(texte, temps)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(texte)
    DrawSubtitleTimed(temps, 1)
end

local J = GetPlayerPed(-1)
local Jid = PlayerId()

---------------
-- Pour Spam --
---------------

local cokedejaencours = false
local tempscoke = 0

local weeddejaencours = false
local tempsweed = 0

local methdejaencours = false
local tempsmeth = 0

local herodejaencours = false
local tempshero= 0


function od()   debug('OD : Check OD')

    if tempscoke >= 270 then 
        SetEntityHealth(J, 0) 
        tempscoke = 0
    end
    if tempsweed >= 750 then 
        SetEntityHealth(J, 0) 
        tempsweed = 0
    end
    if tempsmeth >= 300 then 
        SetEntityHealth(J, 0) 
        tempsmeth = 0
    end
    if tempshero >= 290 then 
        SetEntityHealth(J, 0) 
        tempshero = 0
    end
    SetTimeout(5000, od)
end
od()


-------------
-- Cocaine --
-------------

RegisterNetEvent('drogues:prendrecoke')
AddEventHandler('drogues:prendrecoke', function()

	tempscoke = tempscoke + 80 -- en secondes approximatives
    debug('Coke : Prend de la coke')
    debug('Coke : Temps effet : '..tempscoke)
    local pasfini = true

	Citizen.CreateThread( function()
        if cokedejaencours == false then 
            cokedejaencours = true
            while pasfini do
                if(tempscoke > 0) then tempscoke =  tempscoke - 1
                    missionstexte('~o~Vous etes sous cocaine [ '..tempscoke..'s ]', 1000)
                    SetTimecycleModifier("spectator5")
                    SetPedMovementClipset(J, "move_m@quick", true)     -- Animation
                    ResetPlayerStamina(Jid)                              -- Stamina a fond ( peut courrir )
                    SetPedAccuracy(J, 100)                               -- Stabilitée tir arme
                    SetPedArmour(J, 25)                                  -- Armure 25%
                    SetPlayerHealthRechargeMultiplier(J, 2.5)            -- Heal
                else 
                    pasfini = false 
                    SetPedArmour(J, 0)
                    SetPedAccuracy(J, 10)
                    ClearTimecycleModifier()
                    ResetPedMovementClipset(J, 0)
                    SetPlayerHealthRechargeMultiplier(J, 0.0)
                end
                Citizen.Wait(1000)
            end
        end
	end)
end)


----------
-- Meth --
----------

RegisterNetEvent('drogues:prendremeth')
AddEventHandler('drogues:prendremeth', function()

	tempsmeth = tempsmeth + 120 -- en secondes approximatives
    debug('Meth : Prend de la meth')
    debug('Meth : Temps effet : '..tempsmeth)
    local pasfini = true

	Citizen.CreateThread( function()
        if methdejaencours == false then 
            methdejaencours = true
            while pasfini do
                if(tempsmeth > 0) then tempsmeth =  tempsmeth - 1
                    missionstexte('~o~Vous etes sous meth [ '..tempsmeth..'s ]', 1000)
                    ResetPlayerStamina(Jid)                              -- Stamina a fond ( peut courrir )
                    SetPlayerHealthRechargeMultiplier(J, 2.0)            -- Heal
                    -- Defoncer
                    SetTimecycleModifier("spectator5")
                    SetPedMotionBlur(J, true)                        
                    SetPedMovementClipset(J, "MOVE_M@BRAVE@A", true)
                else 
                    pasfini = false 
                    ResetPedMovementClipset(J, 0)
                    SetPlayerHealthRechargeMultiplier(J, 0.0)
                    ClearTimecycleModifier()
                    ResetScenarioTypesEnabled()
                    SetPedMotionBlur(J, false)
                end
                Citizen.Wait(1000)
            end
        end
	end)
end)


-------------
-- Heroine --
-------------

RegisterNetEvent('drogues:prendrehero')
AddEventHandler('drogues:prendrehero', function()

	tempshero = tempshero + 150 -- en secondes approximatives
    debug('Hero : Prend de la hero')
    debug('Hero : Temps effet : '..tempshero)
    local pasfini = true

	Citizen.CreateThread( function()
        if herodejaencours == false then 
            herodejaencours = true
            while pasfini do
                if(tempshero > 0) then tempshero =  tempshero - 1
                    missionstexte('~o~Vous etes sous heroine [ '..tempshero..'s ]', 1000)
                    ResetPlayerStamina(Jid)                              -- Stamina a fond ( peut courrir )
                    SetPedAccuracy(J, 100)                               -- Stabilitée tir arme
                    SetPedArmour(J, 60)                                  -- Armure 25%
                    SetPlayerHealthRechargeMultiplier(J, 10.0)            -- Heal
                    -- Defoncer
                    SetTimecycleModifier("spectator5")
                    SetPedMotionBlur(J, true)                        
                    SetPedMovementClipset(J, "MOVE_M@DRUNK@VERYDRUNK", true)
                    SetPedIsDrunk(J, true)
                else 
                    pasfini = false 
                    SetPedArmour(J, 0)
                    SetPedAccuracy(J, 10)
                    ResetPedMovementClipset(J, 0)
                    SetPlayerHealthRechargeMultiplier(J, 0.0)
                    ClearTimecycleModifier()
                    ResetScenarioTypesEnabled()
                    SetPedIsDrunk(J, false)
                    SetPedMotionBlur(J, false)
                end
                Citizen.Wait(1000)
            end
        end
	end)
end)

----------
-- Weed --
----------

RegisterNetEvent('drogues:prendresplif')
AddEventHandler('drogues:prendresplif', function()

    tempsweed = tempsweed + 100 -- en secondes approximatives
    debug('Weed : Fume un splif')
    debug('Weed : Temps effet : '..tempsweed)
    local pasfini = true
        
    Citizen.CreateThread( function()

        RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
        while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do Citizen.Wait(0) end
        TaskStartScenarioInPlace(J, "WORLD_HUMAN_SMOKING_POT", 0, true)
        Citizen.Wait(5000)
        if weeddejaencours == false then 
            weeddejaencours = true
            while pasfini do 
                if(tempsweed > 0) then 
                    tempsweed = tempsweed - 1
                    missionstexte('~o~Vous etes sous marijuana [ '..tempsweed..'s ]', 1000)
                    
                    --Defoncer
                    SetTimecycleModifier("spectator5")
                    SetPedMotionBlur(J, true)
                    SetPedMovementClipset(J, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
                    SetPedIsDrunk(J, true)
                else 
                    weeddejaencours = false
                    pasfini = false 
                    ClearTimecycleModifier()
                    ResetScenarioTypesEnabled()
                    ResetPedMovementClipset(J, 0)
                    SetPedIsDrunk(J, false)
                    SetPedMotionBlur(J, false)
                end
                Citizen.Wait(1000)
            end
            
        end
    end)
end)

