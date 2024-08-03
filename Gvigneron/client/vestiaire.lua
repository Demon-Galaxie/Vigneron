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


function VestiaireVigneron()
    local VestiaireVigneron = RageUI.CreateMenu("Vestiaire", "Le vestiaire de l\'entreprise")
    VestiaireVigneron:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(VestiaireVigneron, not RageUI.Visible(VestiaireVigneron))
            while VestiaireVigneron do
            Citizen.Wait(0)
            RageUI.IsVisible(VestiaireVigneron, true, true, true, function()

                RageUI.ButtonWithStyle("→ Reprendre ses vêtements",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand'e adjust'
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                    end
                end)

                RageUI.Line()
    
                RageUI.ButtonWithStyle("→ Tenue Vigneron",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand'e adjust'

                        SetPedComponentVariation(GetPlayerPed(-1) , 8, 22, 0) 
                        SetPedComponentVariation(GetPlayerPed(-1) , 11, 21, 2)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 3, 1, 0)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 4, 28, 0)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 6, 10, 0)   
                    end
                end)

                
                RageUI.ButtonWithStyle("→ Fermer ton ~r~casier",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                    FreezeEntityPosition(PlayerPedId(), false)
                    
                    RageUI.CloseAll()
                    end
                end)

    
            end, function()
            end, 1)

            if not RageUI.Visible(VestiaireVigneron) then
            VestiaireVigneron = RMenu:DeleteType("VestiaireVigneron", true)
        end
    end
end

local position = Config.Vigneron.Vestiaire

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
                        RageUI.Text({

                            message = "Appuyez sur [~r~E~w~] pour changer de vêtement",
                
                            time_display = 1
                
                        })
                            if IsControlJustPressed(1,51) then
                                FreezeEntityPosition(PlayerPedId(), true)
                                RageUI.Text({
            
                                    message = "[~b~Vous~w~] Hop, on change de vêtement, c\'est l\'heure de travailler !",
                        
                                    time_display = 10000
                        
                                })
                                ExecuteCommand'e adjust'
                                Citizen.Wait(2000)
                                VestiaireVigneron()
                                FreezeEntityPosition(PlayerPedId(), false)
                        end
            end
        end
    end
    end
    Citizen.Wait(interval)
end
end)

function SeMettreNu()
    SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0) --tshirt 
     SetPedComponentVariation(GetPlayerPed(-1) , 11, 91, 0)  --torse
     SetPedComponentVariation(GetPlayerPed(-1) , 3, 15, 0)  -- bras
    SetPedComponentVariation(GetPlayerPed(-1) , 4, 14, 1)   --pants
    SetPedComponentVariation(GetPlayerPed(-1) , 6, 6, 0)   --shoes
    end


