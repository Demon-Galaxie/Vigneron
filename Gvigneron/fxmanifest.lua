fx_version('adamant')
games({ 'gta5' })
lua54 'yes'

author 'Galaxie Geek <Galaxie Geek#1486>'
description 'Job Vigneron'
version "1.0"


shared_script({
    'config/config.lua'
});



client_scripts {
    "src/RMenu.lua",
    "src/LiteMySQL.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    '@es_extended/locale.lua',
    'client/*.lua'
}


server_scripts {
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua'

}

export 'getSharedObject';
server_export 'getSharedObject';