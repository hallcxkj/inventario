--  ____    ______   _____  
-- |  _ \  |  ____| |  __ \ 
-- | |_) | | |__    | |__) |
-- |  _ <  |  __|   |  _  / 
-- | |_) | | |____  | | \ \ 
-- |____/  |______| |_|  \_\
-----------------------------------------------------------------------------------------------------------------------------------------
local screenW, screenH = guiGetScreenSize()
local selecionado = 1
local shop = nil
local qntd = nil
local shop = nil
local isShopVisible = false
local labelQuantidade = guiCreateEdit(0.40, 0.5675, 0.12, 0.04, "Quantidade", true)
guiSetAlpha(labelQuantidade, 0)
guiSetVisible(labelQuantidade, false)
guiEditSetMaxLength(labelQuantidade, 3)
function onStart()
    font1 = dxCreateFont("fontes/Roboto.ttf", 9)
    font2 = dxCreateFont("fontes/RobotoBold.ttf", 10)
    font3 = dxCreateFont("fontes/Roboto.ttf", 10)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)
Food = {}
Guns = {}
Utility = {}
Utility2 = {}
Bar = {}
Ilegal = {}
Ferramentas = {}
-------------------------------------------------------------------------------------------------------------------------------------------------
function renderShop()
	editQuantidade = guiGetText(labelQuantidade)
	if isCursorShowing() then
		if isCursorOnElement(screenW * 0.5717, screenH * 0.3164, screenW * 0.0344, screenH * 0.0456) then
			closeColor = 255
		else
			closeColor = 0
		end
		if isCursorOnElement(screenW * 0.4019, screenH * 0.6237, screenW * 0.1969, screenH * 0.0469) then
			buyColor = tocolor(70, 70, 70, 255)
		else
			buyColor = tocolor(45, 45, 45, 255)
		end
	end
	dxDrawRectangle(screenW * 0.3946, screenH * 0.3164, screenW * 0.2116, screenH * 0.3672, tocolor(25, 25, 25, 254), false)--background
	dxDrawRectangle(screenW * 0.5717, screenH * 0.3164, screenW * 0.0344, screenH * 0.0456, tocolor(190, 0, 0, closeColor), false)--close
	dxDrawRectangle(screenW * 0.4510, screenH * 0.3737, screenW * 0.0988, screenH * 0.1497, tocolor(45, 45, 45, 255), false)--slotitemselected
	dxDrawRectangle(screenW * 0.4019, screenH * 0.4141, screenW * 0.0439, screenH * 0.0677, tocolor(45, 45, 45, 255), false)--slot1
	dxDrawRectangle(screenW * 0.5549, screenH * 0.4141, screenW * 0.0439, screenH * 0.0677, tocolor(45, 45, 45, 255), false)--slot2
	dxDrawRectangle(screenW * 0.4019, screenH * 0.5677, screenW * 0.1171, screenH * 0.0391, tocolor(45, 45, 45, 255), false)--background qntd
	dxDrawLine(screenW * 0.4019, screenH * 0.6055, screenW * 0.5185, screenH * 0.6055, tocolor(68, 68, 68, 255), 2, false)--line qntd
	dxDrawRectangle(screenW * 0.4019, screenH * 0.6237, screenW * 0.1969, screenH * 0.0469, buyColor, false)--buy
	dxDrawText("X", screenW * 0.5717, screenH * 0.3164, screenW * 0.6061, screenH * 0.3620, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
	dxDrawText("Comprar", screenW * 0.4019, screenH * 0.6237, screenW * 0.5988, screenH * 0.6706, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
	dxDrawText("  "..editQuantidade, screenW * 0.4026, screenH * 0.5677, screenW * 0.5183, screenH * 0.6068, tocolor(110, 110, 110, 255), 1.00, font3, "left", "center", false, false, false, false, false)
	if shop == "food" then
		dxDrawText(realName[FoodShopItems[selecionado][1]][1], screenW * 0.4510, screenH * 0.4896, screenW * 0.5498, screenH * 0.5234, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		dxDrawText("    Loja de Alimentos", screenW * 0.3946, screenH * 0.3164, screenW * 0.5717, screenH * 0.3620, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
		dxDrawImage(screenW * 0.4729, screenH * 0.3919, screenW * 0.0549, screenH * 0.0977, "gfx/itens/"..FoodShopItems[selecionado][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if tonumber(editQuantidade) then
			dxDrawText("Total: $"..FoodShopItems[selecionado][2]*editQuantidade, screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		else
			dxDrawText("Total: $"..FoodShopItems[selecionado][2], screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		end
		if selecionado > 1 then
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..FoodShopItems[selecionado-1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..FoodShopItems[qntd][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if selecionado < qntd then
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..FoodShopItems[selecionado+1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..FoodShopItems[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
	elseif shop == "guns" then
		dxDrawText(realName[GunShopItems[selecionado][1]][1], screenW * 0.4510, screenH * 0.4896, screenW * 0.5498, screenH * 0.5234, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		dxDrawText("    Loja de Armas", screenW * 0.3946, screenH * 0.3164, screenW * 0.5717, screenH * 0.3620, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
		dxDrawImage(screenW * 0.4729, screenH * 0.3919, screenW * 0.0549, screenH * 0.0977, "gfx/itens/"..GunShopItems[selecionado][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if tonumber(editQuantidade) then
			dxDrawText("Total: $"..GunShopItems[selecionado][2]*editQuantidade, screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		else
			dxDrawText("Total: $"..GunShopItems[selecionado][2], screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		end
		if selecionado > 1 then
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..GunShopItems[selecionado-1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..GunShopItems[qntd][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if selecionado < qntd then
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..GunShopItems[selecionado+1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..GunShopItems[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
	elseif shop == "utility" then
		dxDrawText(realName[UtilityShopItems[selecionado][1]][1], screenW * 0.4510, screenH * 0.4896, screenW * 0.5498, screenH * 0.5234, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		dxDrawText("    Loja de Utilitários", screenW * 0.3946, screenH * 0.3164, screenW * 0.5717, screenH * 0.3620, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
		dxDrawImage(screenW * 0.4729, screenH * 0.3919, screenW * 0.0549, screenH * 0.0977, "gfx/itens/"..UtilityShopItems[selecionado][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if tonumber(editQuantidade) then
			dxDrawText("Total: $"..UtilityShopItems[selecionado][2]*editQuantidade, screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		else
			dxDrawText("Total: $"..UtilityShopItems[selecionado][2], screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		end
		if selecionado > 1 then
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..UtilityShopItems[selecionado-1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..UtilityShopItems[qntd][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if selecionado < qntd then
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..UtilityShopItems[selecionado+1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..UtilityShopItems[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end






	elseif shop == "utility2" then
		dxDrawText(realName[UtilityShopItems2[selecionado][1]][1], screenW * 0.4510, screenH * 0.4896, screenW * 0.5498, screenH * 0.5234, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		dxDrawText("    Loja de Utilitários", screenW * 0.3946, screenH * 0.3164, screenW * 0.5717, screenH * 0.3620, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
		dxDrawImage(screenW * 0.4729, screenH * 0.3919, screenW * 0.0549, screenH * 0.0977, "gfx/itens/"..UtilityShopItems2[selecionado][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if tonumber(editQuantidade) then
			dxDrawText("Total: $"..UtilityShopItems2[selecionado][2]*editQuantidade, screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		else
			dxDrawText("Total: $"..UtilityShopItems2[selecionado][2], screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		end
		if selecionado > 1 then
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..UtilityShopItems2[selecionado-1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..UtilityShopItems2[qntd][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if selecionado < qntd then
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..UtilityShopItems2[selecionado+1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..UtilityShopItems2[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end











	elseif shop == "bar" then
		dxDrawText(realName[BarShopItems[selecionado][1]][1], screenW * 0.4510, screenH * 0.4896, screenW * 0.5498, screenH * 0.5234, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		dxDrawText("    Bar", screenW * 0.3946, screenH * 0.3164, screenW * 0.5717, screenH * 0.3620, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
		dxDrawImage(screenW * 0.4729, screenH * 0.3919, screenW * 0.0549, screenH * 0.0977, "gfx/itens/"..BarShopItems[selecionado][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if tonumber(editQuantidade) then
			dxDrawText("Total: $"..BarShopItems[selecionado][2]*editQuantidade, screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		else
			dxDrawText("Total: $"..BarShopItems[selecionado][2], screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		end
		if selecionado > 1 then
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..BarShopItems[selecionado-1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..BarShopItems[qntd][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if selecionado < qntd then
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..BarShopItems[selecionado+1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..BarShopItems[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
	elseif shop == "ilegal" then
		dxDrawText(realName[IlegalShopItems[selecionado][1]][1], screenW * 0.4510, screenH * 0.4896, screenW * 0.5498, screenH * 0.5234, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		dxDrawText("    Vendedor de Ilícitos", screenW * 0.3946, screenH * 0.3164, screenW * 0.5717, screenH * 0.3620, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
		dxDrawImage(screenW * 0.4729, screenH * 0.3919, screenW * 0.0549, screenH * 0.0977, "gfx/itens/"..IlegalShopItems[selecionado][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if tonumber(editQuantidade) then
			dxDrawText("Total: $"..IlegalShopItems[selecionado][2]*editQuantidade, screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		else
			dxDrawText("Total: $"..IlegalShopItems[selecionado][2], screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		end
		if selecionado > 1 then
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..IlegalShopItems[selecionado-1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..IlegalShopItems[qntd][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if selecionado < qntd then
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..IlegalShopItems[selecionado+1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..IlegalShopItems[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
	elseif shop == "ferramentas" then
		dxDrawText(realName[FerramentasShopItems[selecionado][1]][1], screenW * 0.4510, screenH * 0.4896, screenW * 0.5498, screenH * 0.5234, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		dxDrawText("    Vendedor de Ferramentas", screenW * 0.3946, screenH * 0.3164, screenW * 0.5717, screenH * 0.3620, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
		dxDrawImage(screenW * 0.4729, screenH * 0.3919, screenW * 0.0549, screenH * 0.0977, "gfx/itens/"..FerramentasShopItems[selecionado][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if tonumber(editQuantidade) then
			dxDrawText("Total: $"..FerramentasShopItems[selecionado][2]*editQuantidade, screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		else
			dxDrawText("Total: $"..FerramentasShopItems[selecionado][2], screenW * 0.5256, screenH * 0.5677, screenW * 0.5981, screenH * 0.6068, tocolor(255, 255, 255, 255), 1.00, font3, "right", "center", false, false, false, false, false)
		end
		if selecionado > 1 then
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..FerramentasShopItems[selecionado-1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.4056, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..FerramentasShopItems[qntd][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if selecionado < qntd then
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..FerramentasShopItems[selecionado+1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.5586, screenH * 0.4141, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..FerramentasShopItems[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------------------------------
function onClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
	if (button == "left" and state == "down") then
    	if not isShopVisible then
    		if isElement(clickedWorld) then
    			if getElementType(clickedWorld) == "ped" then
    				local x, y, z = getElementPosition(localPlayer)
    				local x2, y2, z2 = getElementPosition(clickedWorld)
    				if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 3 then
        				for i, v in pairs(Food) do
           					if v == clickedWorld then
           						qntd = #FoodShopItems
           						shop = "food"
           						ped = clickedWorld
                				addEventHandler("onClientRender", root, renderShop)
                				guiSetVisible(labelQuantidade, true)
                				guiSetText(labelQuantidade, "Quantidade")
                				isShopVisible = true
                			end
            			end
        				for i, v in pairs(Guns) do
           					if v == clickedWorld then
           						qntd = #GunShopItems
           						shop = "guns"
           						ped = clickedWorld
                				addEventHandler("onClientRender", root, renderShop)
                				guiSetVisible(labelQuantidade, true)
                				guiSetText(labelQuantidade, "Quantidade")
                				isShopVisible = true
                			end
            			end
        				for i, v in pairs(Utility) do
           					if v == clickedWorld then
           						qntd = #UtilityShopItems
           						shop = "utility"
           						ped = clickedWorld
                				addEventHandler("onClientRender", root, renderShop)
                				guiSetVisible(labelQuantidade, true)
                				guiSetText(labelQuantidade, "Quantidade")
                				isShopVisible = true
                			end
            			end




						for i, v in pairs(Utility2) do
							if v == clickedWorld then
								qntd = #UtilityShopItems2
								shop = "utility2"
								ped = clickedWorld
							 addEventHandler("onClientRender", root, renderShop)
							 guiSetVisible(labelQuantidade, true)
							 guiSetText(labelQuantidade, "Quantidade")
							 isShopVisible = true
						 end
					 end






        				for i, v in pairs(Bar) do
           					if v == clickedWorld then
           						qntd = #BarShopItems
           						shop = "bar"
           						ped = clickedWorld
                				addEventHandler("onClientRender", root, renderShop)
                				guiSetVisible(labelQuantidade, true)
                				guiSetText(labelQuantidade, "Quantidade")
                				isShopVisible = true
               				end
            			end
        				for i, v in pairs(Ilegal) do
           					if v == clickedWorld then
           						qntd = #IlegalShopItems
           						shop = "ilegal"
           						ped = clickedWorld
                				addEventHandler("onClientRender", root, renderShop)
                				guiSetVisible(labelQuantidade, true)
                				guiSetText(labelQuantidade, "Quantidade")
                				isShopVisible = true
                			end
                		end
        				for i, v in pairs(Ferramentas) do
           					if v == clickedWorld then
           						qntd = #FerramentasShopItems
           						shop = "ferramentas"
           						ped = clickedWorld
                				addEventHandler("onClientRender", root, renderShop)
                				guiSetVisible(labelQuantidade, true)
                				guiSetText(labelQuantidade, "Quantidade")
                				isShopVisible = true
                			end
                		end
            		end
            	end
            end
		else
    		if isCursorOnElement(screenW * 0.5717, screenH * 0.3164, screenW * 0.0344, screenH * 0.0456) then
				removeEventHandler("onClientRender", root, renderShop)
				guiSetVisible(labelQuantidade, false)
				selecionado = 1
				shop = nil
				qntd = nil
				ped = nil
				isShopVisible = false
			elseif isCursorOnElement(screenW * 0.4019, screenH * 0.4141, screenW * 0.0439, screenH * 0.0677) then
				if selecionado > 1 then
					selecionado = selecionado -1
				else
					selecionado = qntd
				end
			elseif isCursorOnElement(screenW * 0.5549, screenH * 0.4141, screenW * 0.0439, screenH * 0.0677) then
				if selecionado < qntd then
					selecionado = selecionado +1
				else
					selecionado = 1
				end
			elseif isCursorOnElement(screenW * 0.4019, screenH * 0.5677, screenW * 0.1171, screenH * 0.0391) then
				if not tonumber(editQuantidade) then
					guiSetText(labelQuantidade, "")
				end
			elseif isCursorOnElement(screenW * 0.4019, screenH * 0.6237, screenW * 0.1969, screenH * 0.0469) then
				if tonumber(editQuantidade) and tonumber(editQuantidade) > 0 then
					if not isTimer(TempoBuy) then
    					local x, y, z = getElementPosition(localPlayer)
    					local x2, y2, z2 = getElementPosition(ped)
    					if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 3 then
							TempoBuy = setTimer(function() end, 1000, 1)
							triggerServerEvent("BuyItem", resourceRoot, localPlayer, selecionado, shop, tonumber(editQuantidade))
						end
					end
				else
					exports._infobox:addNotification("Digite um número válido no campo 'Quantidade'", "error")
				end
			end
		end
    end
end
addEventHandler("onClientClick", root, onClick)
-------------------------------------------------------------------------------------------------------------------------------------------------
for i, v in pairs(FoodShopSpawns) do
    Food[i] = createPed(FoodShopSpawns[i][1], FoodShopSpawns[i][2], FoodShopSpawns[i][3], FoodShopSpawns[i][4], FoodShopSpawns[i][5])
    setElementInterior(Food[i], FoodShopSpawns[i][6])
    setElementDimension(Food[i], FoodShopSpawns[i][7])
    createBlipAttachedTo(Food[i], 17)
    setElementFrozen(Food[i], true)
end
for i, v in pairs(GunShopSpawns) do
    Guns[i] = createPed(GunShopSpawns[i][1], GunShopSpawns[i][2], GunShopSpawns[i][3], GunShopSpawns[i][4], GunShopSpawns[i][5])
    setElementInterior(Guns[i], GunShopSpawns[i][6])
    setElementDimension(Guns[i], GunShopSpawns[i][7])
    createBlipAttachedTo(Guns[i], 6)
    setElementFrozen(Guns[i], true)
end
for i, v in pairs(UtilityShopSpawns) do
    Utility[i] = createPed(UtilityShopSpawns[i][1], UtilityShopSpawns[i][2], UtilityShopSpawns[i][3], UtilityShopSpawns[i][4], UtilityShopSpawns[i][5])
    setElementInterior(Utility[i], UtilityShopSpawns[i][6])
    setElementDimension(Utility[i], UtilityShopSpawns[i][7])
    createBlipAttachedTo(Utility[i], 47)
    setElementFrozen(Utility[i], true)
end


for i, v in pairs(UtilityShopSpawns2) do
    Utility2[i] = createPed(UtilityShopSpawns2[i][1], UtilityShopSpawns2[i][2], UtilityShopSpawns2[i][3], UtilityShopSpawns2[i][4], UtilityShopSpawns2[i][5])
    setElementInterior(Utility2[i], UtilityShopSpawns2[i][6])
    setElementDimension(Utility2[i], UtilityShopSpawns2[i][7])
    createBlipAttachedTo(Utility2[i], 47)
    setElementFrozen(Utility2[i], true)
end






for i, v in pairs(BarShopSpawns) do
    Bar[i] = createPed(BarShopSpawns[i][1], BarShopSpawns[i][2], BarShopSpawns[i][3], BarShopSpawns[i][4], BarShopSpawns[i][5])
    setElementInterior(Bar[i], BarShopSpawns[i][6])
    setElementDimension(Bar[i], BarShopSpawns[i][7])
    createBlipAttachedTo(Bar[i], 49)
    setElementFrozen(Bar[i], true)
end
for i, v in pairs(IlegalShopSpawns) do
    Ilegal[i] = createPed(IlegalShopSpawns[i][1], IlegalShopSpawns[i][2], IlegalShopSpawns[i][3], IlegalShopSpawns[i][4], IlegalShopSpawns[i][5])
    setElementInterior(Ilegal[i], IlegalShopSpawns[i][6])
    setElementDimension(Ilegal[i], IlegalShopSpawns[i][7])
    createBlipAttachedTo(Ilegal[i], 37)
    setElementFrozen(Ilegal[i], true)
end
for i, v in pairs(FerramentasShopSpawns) do
    Ferramentas[i] = createPed(FerramentasShopSpawns[i][1], FerramentasShopSpawns[i][2], FerramentasShopSpawns[i][3], FerramentasShopSpawns[i][4], FerramentasShopSpawns[i][5])
    setElementInterior(Ferramentas[i], FerramentasShopSpawns[i][6])
    setElementDimension(Ferramentas[i], FerramentasShopSpawns[i][7])
    setElementFrozen(Ferramentas[i], true)
end

addEventHandler("onClientRender", root, function()
    for i, v in pairs(Food) do
        dxDrawTextOnElement(v, "Vendedor de#1E90FF Alimentos", 1.05, 15, 255, 255, 255, 255, 1.3, font2)
    end
    for i, v in pairs(Guns) do
        dxDrawTextOnElement(v, "Vendedor de#1E90FF Armas", 1.05, 15, 255, 255, 255, 255, 1.3, font2)
    end
    for i, v in pairs(Utility) do
        dxDrawTextOnElement(v, "Vendedor de#1E90FF Utilitários", 1.05, 15, 255, 255, 255, 255, 1.3, font2)
    end



	for i, v in pairs(Utility2) do
        dxDrawTextOnElement(v, "Vendedor de#1E90FF Utilitários", 1.05, 15, 255, 255, 255, 255, 1.3, font2)
    end






    for i, v in pairs(Bar) do
        dxDrawTextOnElement(v, "Atendente#1E90FF Bar", 1.05, 15, 255, 255, 255, 255, 1.3, font2)
    end
    for i, v in pairs(Ilegal) do
        dxDrawTextOnElement(v, "?", 1.05, 15, 255, 255, 255, 255, 1.3, font2)
    end
    for i, v in pairs(Ferramentas) do
        dxDrawTextOnElement(v, "Vendedor de#1E90FF Ferramentas", 1.05, 15, 255, 255, 255, 255, 1.3, font2)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
    local x, y, z = getElementPosition(TheElement)
    local x2, y2, z2 = getCameraMatrix()
    local distance = distance or 20
    local height = height or 1
    local sx, sy = getScreenFromWorldPosition(x, y, z+height)
     if(sx) and (sy) then
        local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
        if(distanceBetweenPoints < distance) then
			dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", _, _, _, true)
        end
    end
end
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