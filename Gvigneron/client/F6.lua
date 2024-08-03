-- Menu F6
local PlayerData = {}

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


function VigneF6()
    local VigneronF6 = RageUI.CreateMenu("Vigneron", "Action Vigneron", 1350, -5)
    VigneronF6:SetRectangleBanner(160, 12, 140)
    RageUI.Visible(VigneronF6, not RageUI.Visible(VigneronF6))
    while VigneronF6 do
        Citizen.Wait(0)
            RageUI.IsVisible(VigneronF6, true, true, true, function()
                RageUI.Checkbox("~h~→ Prendre son service",nil, service,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
    
                        service = Checked
    
    
                        if Checked then
                            onservice = true
                            TriggerServerEvent('webhook')
                            RageUI.Popup({
                                message = "Vous avez pris votre ~g~service !"})
    
                            
                        else
                            onservice = false
                            TriggerServerEvent('webhook_off')
                            RageUI.Popup({
                                message = "Vous n\'etes plus en ~r~service !"})
    
                        end
                    end
                end)

                RageUI.Line()
    
                if onservice then
    
                    RageUI.ButtonWithStyle("~h~→ Faire une facture",nil, {RightLabel = ""}, true, function(_,_,s)
                        local player, distance = ESX.Game.GetClosestPlayer()
                        local playerPed        = GetPlayerPed(-1)
                        if s then
                            local raison = ""
                            local montant = 0
                            AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            if player ~= -1 and distance <= 3.0 then
                                                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                                                Citizen.Wait(5000)
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_orpa', ('orpa'), montant)
                                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                                TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                            else
                                                ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)

                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        RageUI.Line()
                        RageUI.Separator("↓ ~o~     Lieux de travails    ~s~↓")
                        RageUI.ButtonWithStyle("~h~→ Placer le GPS sur la récolte de raisin rouge",nil, {RightLabel = ""}, true, function(h, a, s)

                            if s then       
                                SetNewWaypoint(-1842.2416992188, 2110.375, 135.63746643066)
                            end
                        end)
                    end
    
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        RageUI.ButtonWithStyle("~h~→ Placer le GPS sur la récolte de raisin blanc",nil, {RightLabel = ""}, true, function(h, a, s)

                            if s then       
                                SetNewWaypoint(-1880.8869628906, 2242.2463378906, 84.842864990234)
                            end
                        end)
                    end
                        
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            RageUI.ButtonWithStyle("~h~→ Placer le GPS sur la vente de vin rouge",nil, {RightLabel = ""}, true, function(h, a, s)
                            if s then      
                                SetNewWaypoint(379.75506591797,332.25003051758,104.56639099121)
                            end
                        end)
                    end

                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        RageUI.ButtonWithStyle("~h~→ Placer le GPS sur la vente de vin blanc",nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then      
                            SetNewWaypoint(-3047.7951660156, 587.83239746094, 7.9089312553406)
                        end
                    end)
                end
        
                if ESX.PlayerData.job.grade_name == 'expe' or ESX.PlayerData.job.grade_name == 'chfp' or ESX.PlayerData.job.grade_name == 'chfe' or ESX.PlayerData.job.grade_name == 'cop' or ESX.PlayerData.job.grade_name == 'boss' then 
                
                    RageUI.Line()

                    RageUI.Checkbox("~h~→ Activer les annonces",nil, annonce,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
        
                            annonce = Checked
        
        
                            if Checked then
                                ONannonce = true
        
                                
                            else
                                ONannonce = false
        
                            end
                        end
                    end)
        
                    RageUI.Line()

                    if ONannonce then
                        RageUI.Separator("↓ ~b~     Listes des annonces    ~s~↓")

                RageUI.ButtonWithStyle("~h~→ Annonces Ouvertures",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('OuvertVIGNE')
                    end
                end)
        
                RageUI.ButtonWithStyle("~h~→ Annonces Fermetures",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('FermerVIGNE')
                    end
                end)

                RageUI.ButtonWithStyle("~h~→ Annonces Recrutements",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('RecruVIGNE')
                    end
                end)
        
                RageUI.ButtonWithStyle("~h~→ Annonces Personnalisées",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local te = KeyboardInput("Message", "", 100)
                        ExecuteCommand("iuop " ..te)
                    end
                end)

            end
            end
            
            end
            
                end, function() 
                end)

                if not RageUI.Visible(VigneronF6) then
                    VigneronF6 = RMenu:DeleteType("VigneronF6", true)
        end
    end
end


Keys.Register('F6', 'Vigneron', 'Ouvrir le Menu Vigneron', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    	VigneF6()
	end
end)