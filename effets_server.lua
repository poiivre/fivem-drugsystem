ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



-----------------------
-- Effet avec Skills --
-----------------------
function effetdrogueskills(source)

	TriggerClientEvent('ExportServerSkill', source, "Endurance", -0.5)
	TriggerClientEvent('ExportServerSkill', source, "Force", -0.5)
	TriggerClientEvent('ExportServerSkill', source, "Conduite", -1.0)
	TriggerClientEvent('ExportServerSkill', source, "Wheeling", -1.0)

end


----------
-- Weed --
----------
ESX.RegisterUsableItem('splif', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('splif', 1)
    effetdrogueskills(source)
	TriggerClientEvent('drogues:prendresplif', source)
    TriggerClientEvent('esx:showAdvancedNotification', source, '~o~[ Utilisation d\'Item ]', '[ Fume un Splif ]', nil, 'CHAR_ABIGAIL', 0)

end)


----------
-- Coke --
----------
function prendrecoke(source)

    effetdrogueskills(source)
	TriggerClientEvent('drogues:prendrecoke', source)
    TriggerClientEvent('esx:showAdvancedNotification', source, '~o~[ Utilisation d\'Item ]', '[ Prend de la Coke ]', nil, 'CHAR_ABIGAIL', 0)

end

ESX.RegisterUsableItem('coke', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke', 1)
    prendrecoke(source)

end)

ESX.RegisterUsableItem('coke_pooch', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke_pooch', 1)
    prendrecoke(source)

end)


----------
-- Meth --
----------
function prendremeth(source)

    effetdrogueskills(source)
	TriggerClientEvent('drogues:prendremeth', source)
    TriggerClientEvent('esx:showAdvancedNotification', source, '~o~[ Utilisation d\'Item ]', '[ Prend de la Meth ]', nil, 'CHAR_ABIGAIL', 0)

end

ESX.RegisterUsableItem('meth', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth', 1)
    prendremeth(source)

end)

ESX.RegisterUsableItem('meth_pooch', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth_pooch', 1)
    prendremeth(source)

end)


-------------
-- Heroine --
-------------
function prendrehero(source)

    effetdrogueskills(source)
	TriggerClientEvent('drogues:prendrehero', source)
    TriggerClientEvent('esx:showAdvancedNotification', source, '~o~[ Utilisation d\'Item ]', '[ Prend de la Heroine ]', nil, 'CHAR_ABIGAIL', 0)

end

ESX.RegisterUsableItem('opium', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('opium', 1)
    prendrehero(source)

end)

ESX.RegisterUsableItem('opium_pooch', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('opium_pooch', 1)
    prendrehero(source)

end)