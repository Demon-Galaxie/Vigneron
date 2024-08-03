local PlayerData = {}

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

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	ESX.PlayerData.job = job  
end)


-- Blips Vigneron
Citizen.CreateThread(function()
    if Config.Vigneron.blip then
        for _, blip in pairs(Config.Vigneron.BlipJob) do
            local blip = AddBlipForCoord(blip)
            SetBlipSprite(blip, 85)
            SetBlipScale(blip, 0.9)
            SetBlipColour(blip, 7)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Vigneron")
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Marker Récolte raisin rouge

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Vigneron.RecolteR
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour récolter du raisin rouge", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
                            OpenRecolteR()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Récolte de raisin rouge

function OpenRecolteR()
    local recolter = RageUI.CreateMenu("Récolte", "Récolte de raisin rouge")    

    RageUI.Visible(recolter, not RageUI.Visible(recolter))
        while recolter do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(recolter, true, false, true, function()

            RageUI.PercentagePanel(Config.Param.load, "Récolte de raisin rouge en cours (~p~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + Config.Param.attenter
                else
                    Config.Param.load = 0
                    TriggerServerEvent('vigneron:recolter')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(recolter) then
            recolter = RMenu:DeleteType("recolter", true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Marker Récolte raisin blanc

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Vigneron.RecolteB
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour récolter du raisin blanc", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
                            OpenRecolteB()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Récolte de raisin blanc

function OpenRecolteB()
    local recolteb = RageUI.CreateMenu("Récolte", "Récolte de raisin blanc")    

    RageUI.Visible(recolteb, not RageUI.Visible(recolteb))
        while recolteb do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(recolteb, true, false, true, function()

            RageUI.PercentagePanel(Config.Param.load, "Récolte de raisin blanc en cours (~p~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + Config.Param.attenteb
                else
                    Config.Param.load = 0
                    TriggerServerEvent('vigneron:recolteb')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(recolteb) then
            recolteb = RMenu:DeleteType("recolteb", true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Traitement raisin rouge
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Vigneron.TraitementR
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour traiter le raisin rouge", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
                            OpenTraitR()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Traitement de raisin rouge
function OpenTraitR()
    local traitr = RageUI.CreateMenu("Traitement", "Traitement de Raisin rouge")    

    RageUI.Visible(traitr, not RageUI.Visible(traitr))
        while traitr do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(traitr, true, false, true, function()

            RageUI.PercentagePanel(Config.Param.load, "Traitement des raisins rouge en cours (~p~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + Config.Param.attentetr
                else
                    Config.Param.load = 0
                    TriggerServerEvent('vigneron:traitr')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(traitr) then
            traitr = RMenu:DeleteType("traitr", true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Traitement raisin blanc
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Vigneron.TraitementB
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour traiter le raisin blanc", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
                            OpenTraitB()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Traitement de raisin blanc
function OpenTraitB()
    local traitb = RageUI.CreateMenu("Traitement", "Traitement de raisin blanc")    

    RageUI.Visible(traitb, not RageUI.Visible(traitb))
        while traitb do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(traitb, true, false, true, function()

            RageUI.PercentagePanel(Config.Param.load, "Traitement des raisins blanc en cours (~p~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + Config.Param.attentetb
                else
                    Config.Param.load = 0
                    TriggerServerEvent('vigneron:traitb')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(traitb) then
            traitb = RMenu:DeleteType("traitb", true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Vignification raisin rouge
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Vigneron.VignificationR
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour vignifier le raisin rouge", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
                            OpenVignR()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Vignification de raisin rouge
function OpenVignR()
    local vignr = RageUI.CreateMenu("Vignification", "Vignification de raisin rouge")    

    RageUI.Visible(vignr, not RageUI.Visible(vignr))
        while vignr do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(vignr, true, false, true, function()

            RageUI.PercentagePanel(Config.Param.load, "Vignification raisins rouges en cours (~p~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + Config.Param.attentevir
                else
                    Config.Param.load = 0
                    TriggerServerEvent('vigneron:vignr')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(vignr) then
            vignr = RMenu:DeleteType("vignr", true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Vignification raisin blanc
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Vigneron.VignificationB
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour vignifier le raisin blanc", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
                            OpenVignB()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Vignification de raisin blanc
function OpenVignB()
    local vignb = RageUI.CreateMenu("Vignification", "Vignification de raisin blanc")    

    RageUI.Visible(vignb, not RageUI.Visible(vignb))
        while vignb do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(vignb, true, false, true, function()

            RageUI.PercentagePanel(Config.Param.load, "Vignification raisins blanc en cours (~p~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + Config.Param.attentevib
                else
                    Config.Param.load = 0
                    TriggerServerEvent('vigneron:vignb')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(vignb) then
            vignb = RMenu:DeleteType("vignb", true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Fonction pour l'animation de la vente
function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

-- Vente vin rouge
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local wait = 2000
        local displ = 3000
        local attente = 2500
        local position = Config.Vigneron.VenteR
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(29, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 200, 17, 17, 280, false, true, 2, false, false, false, false)
                    if distance <= 3.5 then
                        RageUI.Text({
                            
                            message = "Appuyez sur ~b~[E]~s~ pour parler à Cécile", 
                            
                            time_display = 1
                        })

                        if IsControlJustPressed(0, 51) then
                            RageUI.Text({

                                message = "[~b~Vous~w~] Salut, j'ai du vin rouge à vendre !",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            RageUI.Text({

                                message = "[~y~Cécile~w~] Bonjour, j\'espère que la bouteille n\'est pas bouchonnée !",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            RageUI.Text({

                                message = "[~b~Vous~w~] Tu peux m\'en donner combien ?",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            RageUI.Text({

                                message = "[~y~Cécile~w~] Ça dépend, fais voir et je te dirais",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            RageUI.Text({

                                message = "[~b~Vous~w~] Nickel merci !",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            -- Play Animation
                            playAnim('mp_common', 'givetake1_a', 2500)
                            Citizen.Wait(attente)
                            ---
                            OpenVenteR()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Vente vin rouge
function OpenVenteR()
    local venter = RageUI.CreateMenu("Vente", "Vendre vin rouge")    

    RageUI.Visible(venter, not RageUI.Visible(venter))
        while venter do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(venter, true, false, true, function()

            RageUI.PercentagePanel(Config.Param.load, "Vente du vin rouge en cours (~o~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + Config.Param.attentevr
                else
                    Config.Param.load = 0
                    TriggerServerEvent('vigneron:venter')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(venter) then
            venter = RMenu:DeleteType("venter", true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Ped Vente vin rouge 
Citizen.CreateThread(function()
    local hash = GetHashKey("a_f_y_business_02")
    local yes = true
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(2000)
    end 
    ped = CreatePed("PED_TYPE_CIVFEMALE", "a_f_y_business_02", 379.75506591797,332.25003051758,103.56639099121 - 1.0, 73.74604034423828, false, true) 
    SetBlockingOfNonTemporaryEvents(ped, yes) 
    FreezeEntityPosition(ped, yes)
    SetEntityInvincible(ped, yes)
  end)

  -- Vente vin blanc
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Vigneron.VenteB
        local wait = 2000
        local displ = 3000
        local attente = 2500
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(29, v.x, v.y, v.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 200, 17, 17, 280, false, true, 2, false, false, false, false)
                    if distance <= 3.5 then
                        RageUI.Text({
                            
                            message = "Appuyez sur ~b~[E]~s~ pour parler à Pierre", 
                            
                            time_display = 1
                        })

                        if IsControlJustPressed(0, 51) then
                            RageUI.Text({

                                message = "[~b~Vous~w~] Salut, j'ai du vin blanc à vendre !",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            RageUI.Text({

                                message = "[~y~Pierre~w~] Bonjour, j\'espère que la bouteille n\'est pas bouchonnée !",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            RageUI.Text({

                                message = "[~b~Vous~w~] Tu peux m\'en donner combien ?",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            RageUI.Text({

                                message = "[~y~Pierre~w~] Ça dépend, fais voir et je te dirais",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            RageUI.Text({

                                message = "[~b~Vous~w~] Nickel merci !",
                    
                                time_display = displ
                    
                            })
                            Citizen.Wait(wait)
                            -- Play Animation
                            playAnim('mp_common', 'givetake1_a', 2500)
                            Citizen.Wait(attente)
                            ---
                            OpenVenteB()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Vente vin rouge
function OpenVenteB()
    local venteb = RageUI.CreateMenu("Vente", "Vendre vin blanc")    

    RageUI.Visible(venteb, not RageUI.Visible(venteb))
        while venteb do
            FreezeEntityPosition(PlayerPedId(), true)
        Wait(0)
        RageUI.IsVisible(venteb, true, false, true, function()

            RageUI.PercentagePanel(Config.Param.load, "Vente du vin blanc en cours (~o~" .. math.floor(Config.Param.load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Param.load < 1.0 then
                    Config.Param.load = Config.Param.load + Config.Param.attentevb
                else
                    Config.Param.load = 0
                    TriggerServerEvent('vigneron:venteb')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(venteb) then
            venteb = RMenu:DeleteType("venteb", true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Ped Vente vin blanc 
Citizen.CreateThread(function()
    local hash = GetHashKey("a_m_o_genstreet_01")
    local yes = true
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(2000)
    end 
    ped = CreatePed("PED_TYPE_CIVMALE", "a_m_o_genstreet_01", -3047.7951660156,587.83239746094,7.9089312553406 - 1.0, 195.3637237548828, false, true) 
    SetBlockingOfNonTemporaryEvents(ped, yes) 
    FreezeEntityPosition(ped, yes)
    SetEntityInvincible(ped, yes)
  end)