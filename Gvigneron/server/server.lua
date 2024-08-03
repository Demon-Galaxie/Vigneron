local notif = 'esx:showNotification'

if Config.ESX.NewESX then
    ESX = exports["es_extended"]:getSharedObject()
else
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

TriggerEvent('esx_phone:registerNumber', 'vigneron', 'Alerte vigneron', true, true) --- Si vous avez un GCPHONE
TriggerEvent('esx_society:registerSociety', 'vigneron', 'vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', {type = 'public'})

-- Recolte raisin rouge
RegisterServerEvent("vigneron:recolter")
AddEventHandler("vigneron:recolter", function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local item = Config.Item.RecolteR
  local raisin = xPlayer.getInventoryItem(item).count
  local count = Config.Item.RecolteCountR

  if raisin > 50 then
    TriggerClientEvent(notif, _source, '~r~Vous n\'avez plus assez de place pour ceci')
  else
  xPlayer.addInventoryItem(item, count)
  TriggerClientEvent(notif, _source, 'Vous avez récolter ~g~' .. count .. '~s~ ~o~raisin rouge~s~' )
  end
end)

-- Recolte raisin blanc
RegisterServerEvent("vigneron:recolteb")
AddEventHandler("vigneron:recolteb", function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local item = Config.Item.RecolteB
  local raisin = xPlayer.getInventoryItem(item).count
  local count = Config.Item.RecolteCountB

  if raisin > 50 then
    TriggerClientEvent(notif, _source, '~r~Vous n\'avez plus assez de place pour ceci')
  else
  xPlayer.addInventoryItem(item, count)
  TriggerClientEvent(notif, _source, 'Vous avez récolter ~g~' .. count .. '~s~ ~o~raisin blanc~s~' )
  end
end)

-- Traitement raisin rouge
RegisterNetEvent('vigneron:traitr')
AddEventHandler('vigneron:traitr', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local item_need = Config.Item.RecolteR
    local raisinr = xPlayer.getInventoryItem(Config.Item.RecolteR).count
    local item_give = xPlayer.getInventoryItem(Config.Item.TraitementR).count
    local count_need = Config.Item.TraitementNeedR
    local trait_give = Config.Item.TraitementR
    local count_give = Config.Item.TraitementCountR

    if item_give > 35 then
        TriggerClientEvent(notif, _source, 'Vous n\'avez pas assez de place pour porter ceci')
    elseif raisinr < count_need then
        TriggerClientEvent(notif, _source, 'Vous n\'avez pas assez de ~p~raisin rouge~s~')
    else
        xPlayer.removeInventoryItem(item_need, count_need)
        xPlayer.addInventoryItem(trait_give, count_give)   
        TriggerClientEvent(notif, _source, 'Vous avez traité ~p~' .. count_need .. " ~s~ raisin rouge")
    end
end)

-- Traitement raisin blanc
RegisterNetEvent('vigneron:traitb')
AddEventHandler('vigneron:traitb', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local item_need = Config.Item.RecolteB
    local raisinb = xPlayer.getInventoryItem(Config.Item.RecolteB).count
    local item_give = xPlayer.getInventoryItem(Config.Item.TraitementB).count
    local count_need = Config.Item.TraitementNeedB
    local trait_give = Config.Item.TraitementB
    local count_give = Config.Item.TraitementCountB

    if item_give > 35 then
        TriggerClientEvent(notif, _source, 'Vous n\'avez pas assez de place pour porter ceci')
    elseif raisinb < count_need then
        TriggerClientEvent(notif, _source, 'Vous n\'avez pas assez de ~p~raisin blanc~s~')
    else
        xPlayer.removeInventoryItem(item_need, count_need)
        xPlayer.addInventoryItem(trait_give, count_give)   
        TriggerClientEvent(notif, _source, 'Vous avez traité ~p~' .. count_need .. " ~s~ raisin blanc")
    end
end)

-- Vignification raisin rouge
RegisterNetEvent('vigneron:vignr')
AddEventHandler('vigneron:vignr', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local item_need = Config.Item.TraitementR
    local raisinb = xPlayer.getInventoryItem(Config.Item.TraitementR).count
    local item_give = xPlayer.getInventoryItem(Config.Item.VignificationR).count
    local count_need = Config.Item.VignificationNeedR
    local trait_give = Config.Item.VignificationR
    local count_give = Config.Item.VignificationCountR

    if item_give > 12 then
        TriggerClientEvent(notif, _source, 'Vous n\'avez pas assez de place pour porter ceci')
    elseif raisinb < count_need then
        TriggerClientEvent(notif, _source, 'Vous n\'avez pas assez de ~p~raisin rouge traité~s~')
    else
        xPlayer.removeInventoryItem(item_need, count_need)
        xPlayer.addInventoryItem(trait_give, count_give)   
        TriggerClientEvent(notif, _source, 'Vous avez vignifié ~p~' .. count_need .. " ~s~ raisin rouges traité")
    end
end)

-- Vignification raisin blanc
RegisterNetEvent('vigneron:vignb')
AddEventHandler('vigneron:vignb', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local item_need = Config.Item.TraitementB
    local raisinb = xPlayer.getInventoryItem(Config.Item.TraitementB).count
    local item_give = xPlayer.getInventoryItem(Config.Item.VignificationB).count
    local count_need = Config.Item.VignificationNeedB
    local trait_give = Config.Item.VignificationB
    local count_give = Config.Item.VignificationCountB

    if item_give > 12 then
        TriggerClientEvent(notif, _source, 'Vous n\'avez pas assez de place pour porter ceci')
    elseif raisinb < count_need then
        TriggerClientEvent(notif, _source, 'Vous n\'avez pas assez de ~p~raisins blanc traité~s~')
    else
        xPlayer.removeInventoryItem(item_need, count_need)
        xPlayer.addInventoryItem(trait_give, count_give)   
        TriggerClientEvent(notif, _source, 'Vous avez vignifié ~p~' .. count_need .. " ~s~ raisins blanc traité")
    end
end)

-- Vente vin rouge 
RegisterNetEvent('vigneron:venter')
AddEventHandler('vigneron:venter', function()

    local _source = source
    local item_need = Config.Item.VignificationR
    local count_need = Config.Vente.CountNeedR
    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil
    local count_item = xPlayer.getInventoryItem(item_need).count
    local vente_item = 1
    local bank = 'bank'

    if count_item >= count_need then
            local money = math.random(Config.Vente.VenteSocMinR, Config.Vente.VenteSocMaxR)
			      local playerMoney  = math.random(Config.Vente.VenteMinR, Config.Vente.VenteMaxR)
            xPlayer.removeInventoryItem(item_need, vente_item)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)
                societyAccount = account
            end)
            if societyAccount ~= nil then
                societyAccount.addMoney(money)
                xPlayer.addAccountMoney(bank, playerMoney)
                        TriggerClientEvent(notif, _source, '~g~Argent reçus~s~, pour votre travail, un pourboire a été créditer sur votre compte bancaire')
                        TriggerClientEvent(notif, _source, '~r~INFO MAZEBANK~s~, la société à reçus un ~g~payement~s~')
          end
        end
        end) 

-- Vente vin blanc 
RegisterNetEvent('vigneron:venteb')
AddEventHandler('vigneron:venteb', function()

    local _source = source
    local item_need = Config.Item.VignificationB
    local count_need = Config.Vente.CountNeedB
    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil
    local count_item = xPlayer.getInventoryItem(item_need).count
    local vente_item = 1
    local bank = 'bank'

    if count_item >= count_need then
            local money = math.random(Config.Vente.VenteSocMinB, Config.Vente.VenteSocMaxB)
			      local playerMoney  = math.random(Config.Vente.VenteMinB, Config.Vente.VenteMaxB)
            xPlayer.removeInventoryItem(item_need, vente_item)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)
                societyAccount = account
            end)
            if societyAccount ~= nil then
                societyAccount.addMoney(money)
                xPlayer.addAccountMoney(bank, playerMoney)
                TriggerClientEvent(notif, _source, '~g~Argent reçus~s~, pour votre travail, un pourboire a été créditer sur votre compte bancaire')
                TriggerClientEvent(notif, _source, '~r~INFO MAZEBANK~s~, la société à reçus un ~g~payement~s~')
          end
        end
        end)

-- Coffre 
ESX.RegisterServerCallback('vigneron:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('vigneron:getStockItem')
AddEventHandler('vigneron:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent(notif, _source, '~g~Objet retiré', count, inventoryItem.label)
		else
			TriggerClientEvent(notif, _source, "~r~Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('vigneron:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('vigneron:putStockItems')
AddEventHandler('vigneron:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent(notif, _source, "~r~Quantité invalide")
		end
	end)
end)

-- F6
-- Webhook
RegisterServerEvent('webhook')
AddEventHandler('webhook', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    PerformHttpRequest(Config.Webhook.ServiceON, function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a pris son service "}), { ['Content-Type'] = 'application/json' })
    end)

RegisterServerEvent('webhook_off')
AddEventHandler('webhook_off', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    PerformHttpRequest(Config.Webhook.ServiceOFF, function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a quitter son service "}), { ['Content-Type'] = 'application/json' })
    end)
    -----
    RegisterServerEvent('OuvertVIGNE')
    AddEventHandler('OuvertVIGNE', function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Vigneron', '~b~Annonce', 'Le vignoble est ouvert, venez achetez nos bouteilles !', 'CHAR_MARTIN', 8)
        end
    end)
    
    RegisterServerEvent('FermerVIGNE')
    AddEventHandler('FermerVIGNE', function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Vigneron', '~b~Annonce', 'Le vignoble est fermer, repassez plus tard', 'CHAR_BLOCKED', 8)
        end
    end)
    
    RegisterServerEvent('RecruVIGNE')
    AddEventHandler('RecruVIGNE', function (target)
    
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Vigneron', '~b~Annonce', 'Recrutement en cours, rendez-vous au vignoble!', 'CHAR_MARTIN', 8)
    
        end
    end)
    
    
    RegisterCommand('iuop', function(source, args, rawCommand)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer.job.name == "vigneron" then
            local src = source
            local msg = rawCommand:sub(5)
            local args = msg
            if player ~= false then
                local name = GetPlayerName(source)
                local xPlayers	= ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Vigneron', '~b~Annonce', ''..msg..'', 'CHAR_MARTIN', 0)
            end
        else
            TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_BLOCKED', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_BLOCKED', 0)
    end
    end, false)