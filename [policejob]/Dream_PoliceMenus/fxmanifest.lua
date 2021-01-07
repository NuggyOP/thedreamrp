-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'Nuggy'
description 'Police menu'
version '0.5'

-- What to run
client_scripts {
    '@NativeUI/NativeUI.lua',
    'client.lua',
}

server_scripts {
    'server.lua'
}