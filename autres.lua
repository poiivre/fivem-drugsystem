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

