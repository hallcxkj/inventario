--  ____    ______   _____  
-- |  _ \  |  ____| |  __ \ 
-- | |_) | | |__    | |__) |
-- |  _ <  |  __|   |  _  / 
-- | |_) | | |____  | | \ \ 
-- |____/  |______| |_|  \_\
-----------------------------------------------------------------------------------------------------------------------------------------
local screenW, screenH = guiGetScreenSize()
local isPanelVisible = false

function renderFabricWeapon()
	dxDrawRectangle(screenW * 0.3843, screenH * 0.0800, screenW * 0.2313, screenH * 0.7670, tocolor(19, 19, 19, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.6107, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.3763, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.4544, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.5326, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.2982, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.2201, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.6888, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.1419, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.3931, screenH * 0.7669, screenW * 0.0366, screenH * 0.0651, tocolor(50, 50, 50, 255), false)
	dxDrawRectangle(screenW * 0.4290, screenH * 0.1419, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--1
	dxDrawRectangle(screenW * 0.4290, screenH * 0.2201, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--2
	dxDrawRectangle(screenW * 0.4290, screenH * 0.2982, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--3
	dxDrawRectangle(screenW * 0.4290, screenH * 0.3763, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--4
	dxDrawRectangle(screenW * 0.4290, screenH * 0.4544, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--5
	dxDrawRectangle(screenW * 0.4290, screenH * 0.5326, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--6
	dxDrawRectangle(screenW * 0.4290, screenH * 0.6107, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--7
	dxDrawRectangle(screenW * 0.4290, screenH * 0.6888, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--8
	dxDrawRectangle(screenW * 0.4290, screenH * 0.7669, screenW * 0.1794, screenH * 0.0651, tocolor(35, 35, 35, 255), false)--9
	dxDrawImage(screenW * 0.3931, screenH * 0.1419, screenW * 0.0366, screenH * 0.0651, "gfx/itens/9mm.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.3931, screenH * 0.2201, screenW * 0.0366, screenH * 0.0651, "gfx/itens/12.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.3931, screenH * 0.2982, screenW * 0.0366, screenH * 0.0651, "gfx/itens/.45.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.3931, screenH * 0.3763, screenW * 0.0366, screenH * 0.0651, "gfx/itens/762.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.3931, screenH * 0.4544, screenW * 0.0366, screenH * 0.0651, "gfx/itens/colete.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.3931, screenH * 0.5326, screenW * 0.0366, screenH * 0.0651, "gfx/itens/glock.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.3931, screenH * 0.6107, screenW * 0.0366, screenH * 0.0651, "gfx/itens/deagle.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.3931, screenH * 0.6888, screenW * 0.0366, screenH * 0.0651, "gfx/itens/ak47.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
--	dxDrawImage(screenW * 0.3931, screenH * 0.7669, screenW * 0.0366, screenH * 0.0651, "gfx/itens/ak47.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawText("9mm  •  Tempo: "..(weaponsFabInfos["9mm"][2]/1000).." segundos", screenW * 0.4363, screenH * 0.1419, screenW * 0.6083, screenH * 0.2070, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	dxDrawText("12  •  Tempo: "..(weaponsFabInfos["12"][2]/1000).." segundos", screenW * 0.4363, screenH * 0.2201, screenW * 0.6083, screenH * 0.2852, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	dxDrawText(".45  •  Tempo: "..(weaponsFabInfos[".45"][2]/1000).." segundos", screenW * 0.4363, screenH * 0.2982, screenW * 0.6083, screenH * 0.3633, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	dxDrawText("762  •  Tempo: "..(weaponsFabInfos["762"][2]/1000).." segundos", screenW * 0.4363, screenH * 0.3763, screenW * 0.6083, screenH * 0.4414, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	dxDrawText("Colete  •  Tempo: "..(weaponsFabInfos["colete"][2]/60000).." minutos", screenW * 0.4363, screenH * 0.4544, screenW * 0.6083, screenH * 0.5195, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	dxDrawText("Glock  •  Tempo: "..(weaponsFabInfos["glock"][2]/60000).." minuto", screenW * 0.4363, screenH * 0.5326, screenW * 0.6083, screenH * 0.5977, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	dxDrawText("Revolver  •  Tempo: "..(weaponsFabInfos["deagle"][2]/60000).." minutos", screenW * 0.4363, screenH * 0.6107, screenW * 0.6083, screenH * 0.6758, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	dxDrawText("ParaFAL  •  Tempo: "..(weaponsFabInfos["ak47"][2]/60000).." minutos", screenW * 0.4363, screenH * 0.6888, screenW * 0.6083, screenH * 0.7539, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	--dxDrawText("ParaFAL  •  Tempo: "..(weaponsFabInfos["ak47"][2]/60000).." minutos", screenW * 0.4363, screenH * 0.7669, screenW * 0.6083, screenH * 0.8320, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.5805, screenH * 0.0800, screenW * 0.0351, screenH * 0.0495, tocolor(155, 0, 0, 255), false)
	dxDrawText("X", screenW * 0.5805, screenH * 0.0800, screenW * 0.6157, screenH * 0.1295, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
	dxDrawText("   Montagem de Armas", screenW * 0.3924, screenH * 0.0800, screenW * 0.5805, screenH * 0.1295, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
end
-------------------------------------------------------------------------------------------------------------------------------------------------
function toggle()
	if not (isPanelVisible) then
		isPanelVisible = true
		addEventHandler("onClientRender", root, renderFabricWeapon)
		showCursor(true)
	end
end
addEvent("toggleFabricPanel", true)
addEventHandler("toggleFabricPanel", resourceRoot, toggle)
-------------------------------------------------------------------------------------------------------------------------------------------------
function click(button, state)
	if (isPanelVisible) then
		if (button == "left" and state == "down") then
			if isCursorOnElement(screenW * 0.5805, screenH * 0.0800, screenW * 0.0351, screenH * 0.0495) then
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false)
			elseif isCursorOnElement(screenW * 0.4290, screenH * 0.1419, screenW * 0.1794, screenH * 0.0651) then
				triggerServerEvent("startFabric", resourceRoot, localPlayer, "9mm")
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false)
			elseif isCursorOnElement(screenW * 0.4290, screenH * 0.2201, screenW * 0.1794, screenH * 0.0651) then
				triggerServerEvent("startFabric", resourceRoot, localPlayer, "12")
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false)
			elseif isCursorOnElement(screenW * 0.4290, screenH * 0.2982, screenW * 0.1794, screenH * 0.0651) then
				--[[	triggerServerEvent("startFabric", resourceRoot, localPlayer, ".45")
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false) --]]
			elseif isCursorOnElement(screenW * 0.4290, screenH * 0.3763, screenW * 0.1794, screenH * 0.0651) then
				triggerServerEvent("startFabric", resourceRoot, localPlayer, "762")
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false)
			elseif isCursorOnElement(screenW * 0.4290, screenH * 0.4544, screenW * 0.1794, screenH * 0.0651) then
				triggerServerEvent("startFabric", resourceRoot, localPlayer, "colete")
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false) 
			elseif isCursorOnElement(screenW * 0.4290, screenH * 0.5326, screenW * 0.1794, screenH * 0.0651) then
				triggerServerEvent("startFabric", resourceRoot, localPlayer, "glock")
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false)
			elseif isCursorOnElement(screenW * 0.4290, screenH * 0.6107, screenW * 0.1794, screenH * 0.0651) then
				triggerServerEvent("startFabric", resourceRoot, localPlayer, "deagle")
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false)
			elseif isCursorOnElement(screenW * 0.4290, screenH * 0.6888, screenW * 0.1794, screenH * 0.0651) then
				triggerServerEvent("startFabric", resourceRoot, localPlayer, "ak47")
				isPanelVisible = false
				removeEventHandler("onClientRender", root, renderFabricWeapon)
				showCursor(false)

			end
		end
	end
end
addEventHandler("onClientClick", root, click)
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
function isCursorOnElement ( x, y, w, h )
local mx, my = getCursorPosition ()
 local fullx, fully = guiGetScreenSize ()
  local cursorx, cursory = mx*fullx, my*fully
   if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
    return true
   else
  return false
 end
end
-------------------------------------------------------------------------------------------------------------------------------------------------