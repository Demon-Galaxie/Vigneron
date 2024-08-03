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


function OpenGarage()
    local Garage = RageUI.CreateMenu("Garage", "Véhicule")
    Garage:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(Garage, not RageUI.Visible(Garage))
            while Garage do
            Citizen.Wait(0)
            RageUI.IsVisible(Garage, true, true, true, function()

                RageUI.Separator("↓ ~b~ Véhicules Vigneron ~s~ ↓")
                RageUI.ButtonWithStyle("→ Sortir un Guardian",nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                    if (Selected) then  
                    local model = GetHashKey("guardian")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, -1912.5334472656,2037.1134033203,140.73735046387, 344.1539001464844, true, true)
                    RageUI.CloseAll()
                    FreezeEntityPosition(PlayerPedId(), false)
                    end
                end)

                RageUI.ButtonWithStyle("→ Sortir un Bison",nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                    if (Selected) then  
                    local model = GetHashKey("Bison3")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, -1912.5334472656,2037.1134033203,140.73735046387, 344.1539001464844, true, true)
                    RageUI.CloseAll()
                    FreezeEntityPosition(PlayerPedId(), false)
                    end
                end)
                RageUI.Separator("↓ ~b~ Véhicule Patron ~s~ ↓")
                RageUI.ButtonWithStyle("→ Sortir une Bestia",nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                    if (Selected) then  
                    local model = GetHashKey("BestiaGTS")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, -1912.5334472656,2037.1134033203,140.73735046387, 344.1539001464844, true, true)
                    RageUI.CloseAll()
                    FreezeEntityPosition(PlayerPedId(), false)
                    end
                end)

    
            end, function()
            end, 1)

            if not RageUI.Visible(Garage) then
                Garage = RMenu:DeleteType("Garage", true)
        end
    end
end

local position = Config.Garage.Menu

Citizen.CreateThread(function()
    while true do

      local wait = 750
      local interval = 2000
      local attend = 3000

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.5 then
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~p~E~w~] pour ouvrir le garage de la société",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Salut Artemys !",
            
                        time_display = attend
            
                    })
                    Citizen.Wait(interval)
                    RageUI.Text({

                        message = "[~o~Artemys~w~] Bonjour, tu veux quoi aujourd\'hui ?",
            
                        time_display = attend
            
                    })
                    Citizen.Wait(interval)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Il va me falloir un véhicule",
            
                        time_display = attend
            
                    })
                    Citizen.Wait(interval)
                    RageUI.Text({

                        message = "[~o~Artemys~w~] Ok attends, je regarde ce qu\'on a",
            
                        time_display = attend
            
                    })

                    Citizen.Wait(interval)
                    RageUI.Text({

                        message = "[~o~Artemys~w~] Nickel, je peux te proposer tout ça:",
            
                        time_display = attend
            
                    })
                    Citizen.Wait(interval)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Nice, merci !",
            
                        time_display = attend
            
                    })
                    Citizen.Wait(interval)
                    RageUI.Text({

                        message = "[~o~Artemys~w~] Tu les abimes pas hein !",
            
                        time_display = attend
            
                    })
                    Citizen.Wait(interval)
                    OpenGarage()

        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)



local npc2 = {
	{hash="s_m_m_cntrybar_01", x = -1913.0655517578, y = 2031.0786132813, z = 140.73873901367, a=350.6746215820313}, 
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npc2) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        TaskStartScenarioInPlace(ped2, 'WORLD_HUMAN_CLIPBOARD_FACILITY', 0, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
	end
end)

------------- RANGER VOITURE ----------------
local Ranger = Config.Garage.Ranger

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Garage.Ranger
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour ranger votre véhicule", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            DoScreenFadeOut(3000)
                            Citizen.Wait(3000)
                            DoScreenFadeIn(3000)
                            OpenRanger()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function OpenRanger(vehicle)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local props = ESX.Game.GetVehicleProperties(vehicle)
    local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
    local engineHealth = GetVehicleEngineHealth(current)

    if IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
        if engineHealth < 890 then
            ESX.ShowNotification("Votre véhicule est trop abimé, vous ne pouvez pas le ranger.")
        else
            ESX.Game.DeleteVehicle(vehicle)
            ESX.ShowNotification("~g~Le Véhicule a été rangé dans le garage.")
        end
    end
end