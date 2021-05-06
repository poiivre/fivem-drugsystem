---------
-- ESX --
---------

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-----------------------
-- Conteur de Pollos --
-----------------------
local Flics = 0
function CompteFlics()

	local xPlayers = ESX.GetPlayers()

	Flics = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			Flics = Flics + 1
		end
	end

	SetTimeout(120000, CompteFlics)
end
CompteFlics()

--------------------
-- Give Item Farm --
--------------------

RegisterServerEvent('drogues:recolteritem')
AddEventHandler('drogues:recolteritem', function(xitem, xnombre, xflics, xstop)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if Flics >= xflics then
		local xPlayer  = ESX.GetPlayerFromId(source)
		local item = xPlayer.getInventoryItem(xitem)

		if item.limit ~= -1 and item.count >= item.limit then
			TriggerClientEvent('esx:showNotification', source, Config.Notifs.pochespleines)
            TriggerClientEvent(xstop, source)
        else xPlayer.addInventoryItem(xitem, xnombre) end
    else
        TriggerClientEvent('esx:showNotification', source, Config.Notifs.pasdeflics)
        TriggerClientEvent(xstop, source)
    end

end)

----------------
-- Heroine --
----------------

RegisterServerEvent('drogues:fabriquerheroine')
AddEventHandler('drogues:fabriquerheroine', function(xitem, xnombre, xflics, xstop)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if Flics >= xflics then
		if xPlayer.getInventoryItem('meth').count >= 1 and xPlayer.getInventoryItem('coke').count >= 1 and xPlayer.getInventoryItem('seringue').count >= 1 then

			local item = xPlayer.getInventoryItem(xitem)
            if item.limit ~= -1 and item.count >= item.limit then
				TriggerClientEvent('esx:showNotification', _source, Config.Notifs.pochespleines)
                TriggerClientEvent(xstop, source)
                
            else
                xPlayer.removeInventoryItem('meth', 1)
				xPlayer.removeInventoryItem('coke', 1)
                xPlayer.removeInventoryItem('seringue', 1)
                xPlayer.addInventoryItem(xitem, xnombre)
            end

        else
            TriggerClientEvent('esx:showNotification', source, "~r~~h~Tu n\'as pas les materiaux suffisants")
			TriggerClientEvent(xstop, source)
        end
    else
        TriggerClientEvent('esx:showNotification', source, Config.Notifs.pasdeflics)
        TriggerClientEvent(xstop, source)
    end

end)

----------------
-- Pochonnage --
----------------

RegisterServerEvent('drogues:pochonnage')
AddEventHandler('drogues:pochonnage', function(xitem, xflics, xstop)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if Flics >= xflics then
		if xPlayer.getInventoryItem(xitem).count >= 5 and xPlayer.getInventoryItem('sachets').count >= 1 then

            if xPlayer.getInventoryItem(xitem..'_pooch').count >= 30 then
                TriggerClientEvent(xstop, source)
                TriggerClientEvent('esx:showNotification', _source, Config.Notifs.pochespleinespochons)
            else
                xPlayer.removeInventoryItem(xitem, 5)
                xPlayer.removeInventoryItem('sachets', 1)
                xPlayer.addInventoryItem(xitem..'_pooch', 1)
            end

        else
            TriggerClientEvent(xstop, source)
            TriggerClientEvent('esx:showNotification', source, "~r~~h~Tu n\'as pas les materiel suffisant")
        end
    else
        TriggerClientEvent('esx:showNotification', source, Config.Notifs.pasdeflics)
        TriggerClientEvent(xstop, source)
    end

end)


---------------------
-- Meth en Journey --
---------------------

RegisterServerEvent('drogues:Methstart')
AddEventHandler('drogues:Methstart', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
    if Flics >= Config.Meth.MiniFlics then

        if xPlayer.getInventoryItem('acetone').count >= 5 and xPlayer.getInventoryItem('lithium').count >= 2 then
            if xPlayer.getInventoryItem(Config.Meth.Items.meth).count >= 30 then
                TriggerClientEvent('drogues:Methnotify', _source, Config.Notifs.pochespleines)
            else
                TriggerClientEvent('drogues:Methstartprod', _source)
                xPlayer.removeInventoryItem('acetone', 5)
                xPlayer.removeInventoryItem('lithium', 2)
            end

        else
            TriggerClientEvent('esx:showNotification', source, "~r~~h~Tu n\'as pas les materiel suffisant")
        end

    else
        TriggerClientEvent('esx:showNotification', source, Config.Notifs.pasdeflics)
    end
	
end)


RegisterServerEvent('drogues:Methstopf')
AddEventHandler('drogues:Methstopf', function(id)
local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('drogues:Methstopfreeze', xPlayers[i], id)
	end
	
end)

RegisterServerEvent('drogues:Methmake')
AddEventHandler('drogues:Methmake', function(posx,posy,posz)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			TriggerClientEvent('drogues:Methsmoke',xPlayers[i],posx,posy,posz, 'a') 
		end

	
end)


RegisterServerEvent('drogues:Methfinish')
AddEventHandler('drogues:Methfinish', function(qualtiy)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addInventoryItem(Config.Meth.Items.meth, math.floor(qualtiy / 2) )
	
end)

RegisterServerEvent('drogues:Methblow')
AddEventHandler('drogues:Methblow', function(posx, posy, posz)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('drogues:Methblowup', xPlayers[i],posx, posy, posz)
	end
	xPlayer.removeInventoryItem('methlab', 1)
end)



----------------------------------------------------
-------------- Serveur Coke Sur Table --------------
----------------------------------------------------

RegisterServerEvent('drogues:Cokestart')
AddEventHandler('drogues:Cokestart', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('pot').count >= 2 then

		if xPlayer.getInventoryItem(Config.Coke.Items.coke).count >= 30 then
			TriggerClientEvent('drogues:Methnotify', _source, Config.Notifs.pochespleines)
		else
			TriggerClientEvent('drogues:Cokestartprod', _source)
			xPlayer.removeInventoryItem('pot', 2)
		end
	else
		TriggerClientEvent('drogues:Methnotify', _source, "~r~~h~Tu n\'as pas les materiel suffisant")
	end
	
end)

RegisterServerEvent('drogues:Cokemake')
AddEventHandler('drogues:Cokemake', function(posx,posy,posz)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			TriggerClientEvent('drogues:Cokesmoke',xPlayers[i],posx,posy,posz, 'a') 
		end
			
end)

RegisterServerEvent('drogues:Cokefinish')
AddEventHandler('drogues:Cokefinish', function(qualtiy)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addInventoryItem(Config.Coke.Items.coke, math.floor(qualtiy / 5) )
	
end)