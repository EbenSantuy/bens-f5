local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('smerfikubrania:koszulka')
AddEventHandler('smerfikubrania:koszulka', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:spodnie')
AddEventHandler('smerfikubrania:spodnie', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['pants_1'] = 21, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:buty')
AddEventHandler('smerfikubrania:buty', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

function openMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'person_menu',
        {
            title    = 'Meny',
            elements = {
                {label = 'ID-Card', value = 'id-card'},
                {label = 'Put Off/Put On Clothes', value = 'clothes-off'},
                {label = 'Blindfold', value = 'blindfold'},
                {label = 'Kencing', value = 'pee'},
                {label = 'Berak', value = 'poop'},
            }
        },
        function(data, menu)
            if data.current.value == 'id-card' then
                ESX.UI.Menu.Open(
                    'default', GetCurrentResourceName(), 'id_card_menu',
                    {
                        title    = 'ID menu',
                        elements = {
                            {label = 'Mengecek KTP', value = 'checkID'},
                            {label = 'Memperlihatkan KTP', value = 'showID'},
                            {label = 'Mengecek SIM Kendaraan', value = 'checkDriver'},
                            {label = 'Memperlihatkan SIM Kendaraan', value = 'showDriver'},
                            {label = 'Mengecek Lisensi Senjata', value = 'checkFirearms'},
                            {label = 'Memperlihatkan Lisensi Senjata', value = 'showFirearms'},
                        }
                    },
                    function(data, menu)
                        local val = data.current.value
                        
                        if val == 'checkID' then
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                        elseif val == 'checkDriver' then
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                        elseif val == 'checkFirearms' then
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                        else
                            local player, distance = ESX.Game.GetClosestPlayer()
                            
                            if distance ~= -1 and distance <= 3.0 then
                                if val == 'showID' then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                                elseif val == 'showDriver' then
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                                elseif val == 'showFirearms' then
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
                                end
                            else
                              ESX.ShowNotification('No players nearby')
                            end
                        end
                    end,
                    function(data, menu)
                        menu.close()
                    end
                )
            elseif data.current.value == 'clothes-off' then
                    ESX.UI.Menu.Open(
                        'default', GetCurrentResourceName(), 'clothes-off-menus',
                        {
                            title    = 'Put On / Put Off Clothes',
                            elements = {
                                {label = 'Pakai Pakaian', value = 'ubie'},
                                {label = 'Lepas Baju', value = 'tul'},
                                {label = 'Lepas Celana', value = 'spo'},
                                {label = 'Lepas Sepatu', value = 'buty'},
                            }
                        },
                        function(data, menu)	
                            if data.current.value == 'ubie' then			
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                            ESX.UI.Menu.CloseAll()	
                            elseif data.current.value == 'tul' then
                            TriggerEvent('smerfikubrania:koszulka')
                            ESX.UI.Menu.CloseAll()	
                            elseif data.current.value == 'spo' then
                            TriggerEvent('smerfikubrania:spodnie')
                            ESX.UI.Menu.CloseAll()	
                            elseif data.current.value == 'buty' then
                            TriggerEvent('smerfikubrania:buty')
                            ESX.UI.Menu.CloseAll()		
                          end	  
                        end,
                        function(data, menu)
                            menu.close()
                        end
                    )
            elseif data.current.value == 'pee' then
                 TriggerEvent('pee')
            elseif data.current.value == 'poop' then
                 TriggerEvent('poop')
            elseif data.current.value == 'blindfold' then
                    local player, distance = ESX.Game.GetClosestPlayer()

                    if distance ~= -1 and distance <= 3.0 then
                       ESX.TriggerServerCallback('jsfour-blindfold:itemCheck', function( hasItem )
                          TriggerServerEvent('jsfour-blindfold', GetPlayerServerId(player), hasItem)
                        end)
                    else
                       ESX.ShowNotification('Tidak Ada Orang Di Sekitar')        
                    end    

            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(0, Keys['F5']) then
			openMenu()
		end
	end
end)