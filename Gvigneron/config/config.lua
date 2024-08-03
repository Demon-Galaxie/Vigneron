-- Job Vigneron Job réaliser par _Artemys#9999

Config = {}

Config.ESX = {
    NewESX = false, -- Metter sur true si vous êtes sous une version récente de esx (ESX = exports["es_extended"]:getSharedObject())
  }

Config.Vigneron = {
    blip = true, -- Si vous souhaitez afficher les blips ou non
    BlipJob = {
        vector3(-1888.16, 2050.42, 140.98) -- Blips du job
    },

    RecolteR = {
        vector3(-1842.3376464844, 2110.4633789063, 135.56898498535) -- Récolte raisin rouge
    },
    RecolteB = {
        vector3(-1880.9638671875, 2242.3176269531, 84.798179626465) -- Récolte raisin blanc
    },
    TraitementR = {
        vector3(-1931.2790527344, 2055.232421875, 140.81350708008) -- Traitement de raisin rouge
    },
    TraitementB = {
        vector3(-1930.7501220703, 2057.8937988281, 140.81344604492) -- Traitement de raisin blanc
    },
    VignificationR = {
        vector3(-1867.3421630859, 2058.9167480469, 140.99789428711) -- Vignification de raisin rouge
    },
    VignificationB = {
        vector3(-1867.4444580078, 2055.994140625, 140.99952697754) -- Vignification de raisin blanc
    },
    VenteR = {
        vector3(379.75506591797,332.25003051758,104.56639099121) -- Vente de vin rouge
    },
    VenteB = {
        vector3(-3047.7951660156, 587.83239746094, 7.9089312553406) -- Vente de vin blanc
    },
    Coffre = {
        vector3(-1880.6922607422, 2070.2194824219, 141.00602722168) -- Coffre
    },
    Vestiaire = {
        vector3(-1874.9284667969, 2053.4826660156, 141.06910705566) -- Vestiaire
    },
    Patron = {
        vector3(-1897.890625, 2067.7739257813, 141.0206451416) -- Action Patron
    }
}

Config.Garage = {
    Menu = {
        vector3(-1913.0655517578, 2031.0786132813, 140.73873901367)
    },
    Ranger = {
        vector3(-1919.4587402344, 2052.2954101563, 140.73571777344)
    }
}

Config.Webhook = {
    ServiceON = 'https://discord.com/api/webhooks/1023623621316448397/xu887zy-btDS_-wBedaslTnrTr0deQXeEBZPH7intlIPPYletF2xd0VBT8_GdzTYcs0O',
    ServiceOFF = 'https://discord.com/api/webhooks/1023623621316448397/xu887zy-btDS_-wBedaslTnrTr0deQXeEBZPH7intlIPPYletF2xd0VBT8_GdzTYcs0O'
}

Config.Marker = {
    Type = 21, -- Le type de Marker
    ColorR = 160, -- La couleur du markeur (R)
    ColorG = 12, -- La couleur du markeur (G)
    ColorB = 140, -- La couleur du markeur (B)
    Opacite = 280, -- Opacité du marker
    Saute = true, -- Si le marqueur saute ou non (false = ne saute pas)
    Tourne = false -- Si le marqueur tourne ou non (true = markeur tourne)
}

Config.Param = {
    load = 0.0, -- Ne pas toucher cette ligne
    -- Attention cette partie est très sensible !!!
    attenter = 0.0035, -- Vitesse à laquel on récolte le raisin rouge
    attenteb = 0.0035, -- Vitesse à laquel on récolte le raisin blanc
    attentetr = 0.0030, -- Vitesse à laquel on traite le raisin rouge
    attentetb = 0.0030, -- Vitesse à laquel on traite le raisin blanc
    attentevir = 0.0025, -- Vitesse à laquel on vignifie le raisin rouge
    attentevib = 0.0025, -- Vitesse à laquel on vignifie le raisin blanc
    attentevr = 0.0032, -- Vitesse à laquel on vend le vin rouge
    attentevb = 0.0032 -- Vitesse à laquel on vend le vin blanc
}

Config.Item = {
    RecolteR = 'raisin_rouge', -- Item de récolte
    RecolteCountR = 1, -- Nombre d'item récolter à chaque fois que 100% est atteint
    RecolteB = 'raisin_blanc', -- Item de récolte
    RecolteCountB = 1, -- Nombre d'item récolter à chaque fois que 100% est atteint
    TraitementR = 'raisinr_trait', -- Item après le traitement (rouge)
    TraitementCountR = 3, -- Nombre d'item récolter après traitement à chaque fois que 100% est atteint
    TraitementB = 'raisinb_trait', -- Item après le traitement (blanc)
    TraitementCountB = 4, -- Nombre d'item récolter après traitement à chaque fois que 100% est atteint
    TraitementNeedR = 4, -- Nombre de raisin rouge qu'il faut pour traiter
    TraitementNeedB = 5, -- Nombre de raisin blanc qu'il faut pour traiter
    VignificationR = 'vin_rouge', -- Item après la vignification
    VignificationCountR = 1, -- Nombre d'item récolter après vignification à chaque fois que 100% est atteint
    VignificationB = 'vin_blanc', -- Item après la vignification
    VignificationCountB = 1, -- Nombre d'item récolter après vignification à chaque fois que 100% est atteint
    VignificationNeedR = 3, -- Nombre d'item qu'il faut pour vignifier (rouge)
    VignificationNeedB = 4, -- Nombre d'item qu'il faut pour vignifier (blanc)
}

Config.Vente = {
    -- Vin Rouge
    CountNeedR = 1, -- Nombre d'item que l'on a besoin pour vendre
    VenteMinR = 35, -- Argent reçus aléatoirement (Minimum) par le joueur lors de la vente
    VenteMaxR = 75, -- Argent reçus aléatoirement (Maximum) par le joueur lors de la vente
    VenteSocMinR = 135, -- Argent reçus aléatoirement (Minimum) par la société lors de la vente
    VenteSocMaxR = 200, -- Argent reçus aléatoirement Maximum) par la société lors de la vente
    --- Vin Blanc
    CountNeedB = 1, -- Nombre d'item que l'on a besoin pour vendre
    VenteMinB = 35, -- Argent reçus aléatoirement (Minimum) par le joueur lors de la vente
    VenteMaxB = 75, -- Argent reçus aléatoirement (Maximum) par le joueur lors de la vente
    VenteSocMinB = 135, -- Argent reçus aléatoirement (Minimum) par la société lors de la vente
    VenteSocMaxB = 200 -- Argent reçus aléatoirement Maximum) par la société lors de la vente
}