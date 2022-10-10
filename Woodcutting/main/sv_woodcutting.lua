if Config.OldEsx == true then
   ESX = nil
   TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent('Woodcutting:Wood:Cut')
AddEventHandler('Woodcutting:Wood:Cut', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WoodCutQuantity = xPlayer.getInventoryItem('wood').count
	if WoodCutQuantity >= 15 then
	   	TriggerClientEvent("pNotify:SendNotification", source, {
          text = "You can carry only 15 wood logs, Please go to the process station and come back after.",
          type = "success",
          queue = "lmao",
          timeout = 7000,
          layout = "Centerleft"
        })
	elseif WoodCutQuantity then
        xPlayer.addInventoryItem('wood', 1)
	    TriggerClientEvent("pNotify:SendNotification", source, {
          text = "You harvested <b style=color:#8B4513> -> A wood log",
          type = "success",
          queue = "lmao",
          timeout = 7000,
          layout = "Centerleft"
        })
	end
end)

RegisterServerEvent('Woodcutting:Wood:Process')
AddEventHandler('Woodcutting:Wood:Process', function()
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   local WoodQuantity = xPlayer.getInventoryItem('wood').count
   if WoodQuantity >= 15 then
      TriggerClientEvent("pNotify:SendNotification", source, {
         text = "Your wood logs have been processed",
         type = "success",
         queue = "lmao",
         timeout = 7000,
         layout = "Centerleft"
      })
      xPlayer.removeInventoryItem('wood', 15)
      xPlayer.addInventoryItem('processed_wood', 15)
   elseif WoodQuantity then
      TriggerClientEvent("pNotify:SendNotification", source, {
         text = "<b style=color:#ff0000>error: <b style=color:#d1d1d1> You dont have enough Wood Logs, you have: <b style=color:#8B4513>"  .. WoodQuantity .." <b style=color:#d1d1d1> Wood Logs </b>",
         type = "success",
         queue = "lmao",
         timeout = 7000,
         layout = "Centerleft"
      })
      TriggerClientEvent("pNotify:SendNotification", source, {
         text = "15 of Wood Logs are needed for sale",
         type = "success",
         queue = "lmao",
         timeout = 7000,
         layout = "Centerleft"
      })
   end
end)

RegisterServerEvent('Woodcutting:Wood:Sell')
AddEventHandler('Woodcutting:Wood:Sell', function()
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   local processed_wood_Quantity = xPlayer.getInventoryItem('processed_wood').count
   local Addmoney = math.random (6000, 7000) -- change here the price of the wood sell
   if processed_wood_Quantity >= 15 then
       xPlayer.removeInventoryItem('processed_wood', 15)
       xPlayer.addMoney(Addmoney)
       TriggerClientEvent("pNotify:SendNotification", source, {
          text = "<b style=color:#d1d1d1> You sold processed wood for <b style=color:#1588d4>"  .. Addmoney .. " <b style=color:#d1d1d1> keep working</b>",
          type = "success",
          queue = "lmao",
          timeout = 7000,
          layout = "Centerleft"
       })
   elseif processed_wood_Quantity then
        TriggerClientEvent("pNotify:SendNotification", source, {
          text = "<b style=color:#ff0000>error: <b style=color:#d1d1d1> You dont have enough processed Wood, you have: <b style=color:#8B4513>"  .. processed_wood_Quantity .." <b style=color:#d1d1d1> processed Wood </b>",
          type = "success",
          queue = "lmao",
          timeout = 7000,
          layout = "Centerleft"
        })
      	TriggerClientEvent("pNotify:SendNotification", source, {
          text = "15 of processed Wood are needed for sale",
          type = "success",
          queue = "lmao",
          timeout = 7000,
          layout = "Centerleft"
        })
   end
end)
