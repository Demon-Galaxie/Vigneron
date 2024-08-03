local PlayerData = {}
local vigneronboss = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
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


function vigneronbossA()
    local boss_menu = RageUI.CreateMenu("Vigneron", "Action Patron")
    boss_menu:SetRectangleBanner(140, 38, 109)
      RageUI.Visible(boss_menu, not RageUI.Visible(boss_menu))
  
              while boss_menu do
                  Citizen.Wait(0)
                      RageUI.IsVisible(boss_menu, true, true, true, function()
  
            if vigneronboss ~= nil then
                RageUI.ButtonWithStyle("→ Argent société :", nil, {RightLabel = "$" .. vigneronboss}, true, function()
                end)
            end

            RageUI.Line()

            RageUI.ButtonWithStyle("→ Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    ExecuteCommand'e type'
                    local amount = KeyboardInput("Montant", "", 10) 
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant ~r~invalide~s~"})
                    else
                        TriggerServerEvent('esx_society:withdrawMoney', 'vigneron', amount)
                        RefreshvigneronbossA()
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end
            end)

            RageUI.ButtonWithStyle("→ Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    ExecuteCommand'e type'
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:depositMoney', 'vigneron', amount)
                        RefreshvigneronbossA()
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end
            end) 

           RageUI.ButtonWithStyle("→ Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    aboss()
                    RageUI.CloseAll()
                end
            end)

            RageUI.ButtonWithStyle("→ Fermer votre ~r~panel",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasksImmediately(GetPlayerPed(-1))
                RageUI.CloseAll()
                end
            end)


        end, function()
        end)
        if not RageUI.Visible(boss_menu) then
            boss_menu = RMenu:DeleteType("boss_menu", true)
    end
end
end

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Vigneron.Patron
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' and ESX.PlayerData.job.grade_name == 'boss' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour ouvrir le panel administratif", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    ExecuteCommand'e type'
                    RefreshvigneronbossA()           
                    vigneronbossA()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

function RefreshvigneronbossA()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdatevigneronbossA(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdatevigneronbossA(money)
    vigneronboss = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'vigneron', function(data, menu)
        menu.close()
    end, {wash = false})
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end