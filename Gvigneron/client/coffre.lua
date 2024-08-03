local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

if Config.ESX.NewESX then
    ESX = exports["es_extended"]:getSharedObject()
else
local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



function CoffreVigne()
    local cvigne = RageUI.CreateMenu("Coffre", "Coffre de la société")
    cvigne:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(cvigne, not RageUI.Visible(cvigne))
            while cvigne do
                FreezeEntityPosition(PlayerPedId(), true)
            Citizen.Wait(0)
            RageUI.IsVisible(cvigne, true, true, true, function()

                    RageUI.ButtonWithStyle("→ Retirer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VigneRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("→ Déposer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VigneDeposeobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Line()

                    RageUI.ButtonWithStyle("→ Fermer le ~r~coffre",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                        FreezeEntityPosition(PlayerPedId(), false)
                        RageUI.CloseAll()
                        end
                    end)
                    
                end, function()
                end)
            if not RageUI.Visible(cvigne) then
            cvigne = RMenu:DeleteType("cvigne", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

local position = Config.Vigneron.Coffre

-- Marker
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour ouvrir le coffre de la société", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            CoffreVigne()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

itemstock = {}
function VigneRetirerobjet()
    local StockVigne = RageUI.CreateMenu("Coffre", "Le coffre de l\'entreprise")
    StockVigne:SetRectangleBanner(140, 38, 109)
    ESX.TriggerServerCallback('vigneron:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StockVigne, not RageUI.Visible(StockVigne))
        while StockVigne do
            Citizen.Wait(0)
                RageUI.IsVisible(StockVigne, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    ExecuteCommand'e pickup'
                                    TriggerServerEvent('vigneron:getStockItem', v.name, tonumber(count))
                                    VigneRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockVigne) then
            StockVigne = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function VigneDeposeobjet()
    local DeposerVigne = RageUI.CreateMenu("Coffre", "Le coffre de l\'entreprise")
    DeposerVigne:SetRectangleBanner(140, 38, 109)
    ESX.TriggerServerCallback('vigneron:getPlayerInventory', function(inventory)
        RageUI.Visible(DeposerVigne, not RageUI.Visible(DeposerVigne))
    while DeposerVigne do
        Citizen.Wait(0)
            RageUI.IsVisible(DeposerVigne, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            ExecuteCommand'e pickup'
                                            TriggerServerEvent('vigneron:putStockItems', item.name, tonumber(count))
                                            VigneDeposeobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DeposerVigne) then
                DeposerVigne = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end



function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end
