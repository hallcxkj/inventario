--  ____    ______   _____  
-- |  _ \  |  ____| |  __ \ 
-- | |_) | | |__    | |__) |
-- |  _ <  |  __|   |  _  / 
-- | |_) | | |____  | | \ \ 
-- |____/  |______| |_|  \_\
-----------------------------------------------------------------------------------------------------------------------------------------
local screenW, screenH = guiGetScreenSize()
local isInventoryVisible = false
local isTradeVisible = false
local isReceivingTrade = false
local assassino = nil
local tableTrade = nil
local loggedIn = false
local peso = 0
local itemMoving = nil
local actionBarItemMoving = nil
local cacheSlotActionBar = nil
local itemTrade = nil
local playerTrade = nil
local gangBox = nil
local isDocVisible = false
local document = nil
local color1 = nil
local color2 = nil
local alpha1 = 0
local alpha2 = 0
local actionbarColor1 = tocolor(44, 44, 44, 255)
local actionbarColor2 = tocolor(36, 36, 36, 255)
local editQuantidade = guiCreateEdit(0.51, 0.485, 0.05, 0.03, "1", true)
local editValor = guiCreateEdit(0.51, 0.525, 0.05, 0.03, "0", true)
guiSetVisible(editQuantidade, false)
guiSetVisible(editValor, false)
guiEditSetMaxLength(editQuantidade, 6)
guiEditSetMaxLength(editValor, 6)
guiSetAlpha(editQuantidade, 0)
guiSetAlpha(editValor, 0)
local editQuantidade2 = guiCreateEdit(0.51, 0.485, 0.05, 0.03, "1", true)
guiSetVisible(editQuantidade2, false)
guiEditSetMaxLength(editQuantidade2, 6)
guiSetAlpha(editQuantidade2, 0)
local editQuantidade3 = guiCreateEdit(0.51, 0.485, 0.05, 0.03, "1", true)
guiSetVisible(editQuantidade3, false)
guiEditSetMaxLength(editQuantidade3, 6)
guiSetAlpha(editQuantidade3, 0)
local windowBau = guiCreateWindow(0.40, 0.24, 0.20, 0.52, "BAÚ", true)
guiSetVisible(windowBau, false)
guiWindowSetSizable(windowBau, false)
local quantidadeBau = guiCreateEdit(0.04, 0.78, 0.93, 0.07, "Quantidade", true, windowBau)
local pegarBau = guiCreateButton(0.04, 0.88, 0.43, 0.09, "PEGAR", true, windowBau)
guiSetFont(pegarBau, "default-bold")
fecharBau = guiCreateButton(0.53, 0.88, 0.43, 0.09, "FECHAR", true, windowBau)
guiSetFont(fecharBau, "default-bold")
trashs = {}
function onStart()
    font1 = dxCreateFont("fontes/Roboto.ttf", 9)
    font2 = dxCreateFont("fontes/RobotoBold.ttf", 10)
    font3 = dxCreateFont("fontes/Roboto.ttf", 10)
	for i, v in pairs(TrashPositions) do
		trashs[i] = createObject(1359, TrashPositions[i][1], TrashPositions[i][2], TrashPositions[i][3] - 0.3)
		createBlipAttachedTo(trashs[i], 61)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)
-----------------------------------------------------------------------------------------------------------------------------------------
trade = {}
inventario = {}
actionbar = {
    {},
    {},
    {},
    {},
    {},
    {},
}
slotAlpha = {
    {0},
    {0},
    {0},
    {0},
    {0},
    {0},
}
slotsPosition = {
    {screenW * 0.4026, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4422, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4817, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5212, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5608, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4026, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4422, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4817, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5212, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5608, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4026, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4422, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4817, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5212, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5608, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4026, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4422, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4817, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5212, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5608, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4026, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4422, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4817, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5212, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5608, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4026, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4422, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.4817, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5212, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651},
    {screenW * 0.5608, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651},
}
actionBarSlotPosition = {
    {screenW * 0.4026, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521},
    {screenW * 0.4348, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521},
    {screenW * 0.4671, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521},
    {screenW * 0.4993, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521},
    {screenW * 0.5315, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521},
    {screenW * 0.5637, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521},
}
-----------------------------------------------------------------------------------------------------------------------------------------
function refreshInv(tableInv)
	inventario = {}
	peso = 0
	if (tableInv) then
		for i, v in pairs(tableInv) do
    		if tableInv[i][1] == "identidade" then
        		table.insert(inventario, v)
        	end
		end
		for i, v in pairs(tableInv) do
    		if tableInv[i][1] == "cnh" then
        		table.insert(inventario, v)
        	end
		end
        for i, v in pairs(tableInv) do
    		if tableInv[i][1] == "cnh2" then
        		table.insert(inventario, v)
        	end
		end
        for i, v in pairs(tableInv) do
    		if tableInv[i][1] == "cnh3" then
        		table.insert(inventario, v)
        	end
		end
        for i, v in pairs(tableInv) do
    		if tableInv[i][1] == "cnh4" then
        		table.insert(inventario, v)
        	end
		end
		for i, v in pairs(tableInv) do
    		if tableInv[i][1] == "porte" then
        		table.insert(inventario, v)
       		end
		end
   		for i, v in pairs(tableInv) do
    		if tableInv[i][1] ~= "identidade" and tableInv[i][1] ~= "cnh" and tableInv[i][1] ~= "porte" and tableInv[i][1] ~= "cnh2" and tableInv[i][1] ~= "cnh3" and tableInv[i][1] ~= "cnh4" then
        		table.insert(inventario, v)
        	end
    	end
    	for i, v in pairs(pesoItens) do
        	for index, value in pairs(inventario) do
           		if inventario[index][1] == i then
                	peso = peso + (pesoItens[i][1] * inventario[index][2])
            	end
        	end
    	end
    end
    for i, v in pairs(actionbar) do
        local count = false
        for index, value in pairs(inventario) do
            if inventario[index][1] == actionbar[i][1] then
                count = true
            end
        end
        if not count then
            actionbar[i][1] = nil
        end
    end
    if not loggedIn then
    	loggedIn = true
    	addEventHandler("onClientRender", root, actionBar)
    end
end
addEvent("refresh", true)
addEventHandler("refresh", resourceRoot, refreshInv)
-----------------------------------------------------------------------------------------------------------------------------------------
function renderInv()
    dxDrawRectangle(screenW * 0.3997, screenH * 0.2474, screenW * 0.2006, screenH * 0.4920, tocolor(44, 44, 44, alpha), false)--background inv
    dxDrawText("Mochila", screenW * 0.3997, screenH * 0.2474, screenW * 0.6003, screenH * 0.2891, tocolor(200, 200, 200, alpha), 1.00, font2, "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4026, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--1
    dxDrawRectangle(screenW * 0.4422, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--2
    dxDrawRectangle(screenW * 0.4817, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--3
    dxDrawRectangle(screenW * 0.5212, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--4
    dxDrawRectangle(screenW * 0.5608, screenH * 0.2891, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--5
    dxDrawRectangle(screenW * 0.4026, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--6
    dxDrawRectangle(screenW * 0.4422, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--7
    dxDrawRectangle(screenW * 0.4817, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--8
    dxDrawRectangle(screenW * 0.5212, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--9
    dxDrawRectangle(screenW * 0.5608, screenH * 0.3594, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--10
    dxDrawRectangle(screenW * 0.4026, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--11
    dxDrawRectangle(screenW * 0.4422, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--12
    dxDrawRectangle(screenW * 0.4817, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--13
    dxDrawRectangle(screenW * 0.5212, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--14
    dxDrawRectangle(screenW * 0.5608, screenH * 0.4297, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--15
    dxDrawRectangle(screenW * 0.4026, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--16
    dxDrawRectangle(screenW * 0.4422, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--17
    dxDrawRectangle(screenW * 0.4817, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--18
    dxDrawRectangle(screenW * 0.5212, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--19
    dxDrawRectangle(screenW * 0.5608, screenH * 0.5000, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--20
    dxDrawRectangle(screenW * 0.4026, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--21
    dxDrawRectangle(screenW * 0.4422, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--22
    dxDrawRectangle(screenW * 0.4817, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--23
    dxDrawRectangle(screenW * 0.5212, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--24
    dxDrawRectangle(screenW * 0.5608, screenH * 0.5703, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--25
    dxDrawRectangle(screenW * 0.4026, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--26
    dxDrawRectangle(screenW * 0.4422, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--27
    dxDrawRectangle(screenW * 0.4817, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--28
    dxDrawRectangle(screenW * 0.5212, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--29
    dxDrawRectangle(screenW * 0.5608, screenH * 0.6406, screenW * 0.0366, screenH * 0.0651, tocolor(36, 36, 36, alpha), false)--30
    dxDrawRectangle(screenW * 0.4300, screenH * 0.7215, screenW * 0.1400, screenH * 0.0075, tocolor(35, 35, 35, alpha), false)--background capacity
    if getElementData(localPlayer, "VIP") or getElementData(localPlayer, "Staff") then
        pesoMax = 50
    else
        pesoMax = 30
    end
    dxDrawRectangle(screenW * 0.4300, screenH * 0.7215, screenW * (peso / pesoMax * 0.1400), screenH * 0.0075, tocolor(200, 200, 200, alpha), false)
    for i, v in pairs(slotsPosition) do
        for index, value in pairs(inventario) do
            if i == index then
                if itemMoving ~= inventario[index][1] then
                    dxDrawImage(slotsPosition[i][1], slotsPosition[i][2], slotsPosition[i][3], slotsPosition[i][4], "gfx/itens/"..inventario[index][1]..".png", 0, 0, 0, tocolor(255, 255, 255, alpha))
                end
            end
        end
    end
    if isCursorShowing() and not isTradeVisible and not isReceivingTrade then
        for i, v in pairs(slotsPosition) do
            if isCursorOnElement(slotsPosition[i][1], slotsPosition[i][2], slotsPosition[i][3], slotsPosition[i][4]) then
                for index, value in pairs(pesoItens) do
                    if inventario[i] ~= nil then
                        if inventario[i][1] == index then
                            if not itemMoving then
                                local y = slotsPosition[i][2] + slotsPosition[i][4] + (screenH/200)
                                local size = 0
                                local cX, cY = getCursorPosition()
                                local cachePeso = string.format("%.1f", tostring(pesoItens[index][1] * inventario[i][2]))
                                if dxGetTextWidth(realName[inventario[i][1]][1], 1.00, font1) > dxGetTextWidth("Quantidade: "..inventario[i][2], 1.00, font1) then
                                    size = dxGetTextWidth(realName[inventario[i][1]][1], 1.00, font1) + (screenW/55)
                                else
                                    size = dxGetTextWidth("Quantidade: "..inventario[i][2], 1.00, font1) + (screenW/55)
                                end
                                dxDrawRectangle(screenW*cX-(size/2), y, size, screenH * 0.0800, tocolor(28, 28, 28, alpha), false)
                                dxDrawText(realName[inventario[i][1]][1].."\nQuantidade: "..inventario[i][2].."\nPeso: "..cachePeso.."kg", screenW*cX-(size/2), y, screenW*cX-(size/2)+size, y+screenH * 0.0800, tocolor(255, 255, 255, alpha), 1.00, font1, "center", "center", false, false, false, false, false)
                            end
                        end
                    end
                end
            end
        end
    end
    if (itemMoving) and isCursorShowing() then
        local cX, cY = getCursorPosition()
        dxDrawImage(screenW*cX-(screenW * 0.0366/2), screenH*cY-(screenH * 0.0651/2), screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..itemMoving..".png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
    end
    if (actionBarItemMoving) and isCursorShowing() then
        local cX, cY = getCursorPosition();
        dxDrawImage(screenW*cX-(screenW * 0.0366/2), screenH*cY-(screenH * 0.0651/2), screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..actionBarItemMoving..".png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
    end
    if isReceivingTrade then
    	if isCursorShowing() and isCursorOnElement(screenW * 0.4641, screenH * 0.1914, screenW * 0.0739, screenH * 0.0430) then
        	color2 = tocolor(80, 80, 80, 255)
    	else
        	color2 = tocolor(38, 38, 38, 255)
    	end
    	if isCursorShowing() and isCursorOnElement(screenW * 0.5556, screenH * 0.0195, screenW * 0.0293, screenH * 0.0430) then
        	alpha2 = 255
    	else
        	alpha2 = 175
    	end
    	local player = getPlayerName(tableTrade[1][1])
    	local id = getElementData(tableTrade[1][1], "ID") or "N/A"
    	local item = realName[tableTrade[2][1]][1]
    	local quantidade = tableTrade[3][1]
    	local valor = tableTrade[4][1]
		dxDrawRectangle(screenW * 0.4158, screenH * 0.0195, screenW * 0.1691, screenH * 0.2240, tocolor(20, 20, 20, 255), false)
		dxDrawImage(screenW * 0.4246, screenH * 0.1042, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..tableTrade[2][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText("    Proposta de venda", screenW * 0.4158, screenH * 0.0195, screenW * 0.5359, screenH * 0.0625, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, true, false)
		dxDrawRectangle(screenW * 0.5556, screenH * 0.0195, screenW * 0.0293, screenH * 0.0430, tocolor(200, 20, 20, alpha2), false)
		dxDrawText("X", screenW * 0.5556, screenH * 0.0195, screenW * 0.5849, screenH * 0.0625, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, true, false)
		dxDrawRectangle(screenW * 0.4641, screenH * 0.1914, screenW * 0.0739, screenH * 0.0430, color2, false)
		dxDrawText("Aceitar", screenW * 0.4641, screenH * 0.1914, screenW * 0.5381, screenH * 0.2344, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, true, false)
		dxDrawText(player.." ("..id..")", screenW * 0.4158, screenH * 0.0625, screenW * 0.5849, screenH * 0.1042, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, true, false)
		dxDrawText(item.." (#FFFF00"..quantidade.."x#FFFFFF)", screenW * 0.4714, screenH * 0.1042, screenW * 0.5849, screenH * 0.1380, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, true, false)
		dxDrawText("Valor: #00FF00$"..valor, screenW * 0.4714, screenH * 0.1380, screenW * 0.5849, screenH * 0.1693, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, true, false)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
function actionBar()
    dxDrawRectangle(screenW * 0.3997, screenH * 0.9245, screenW * 0.1962, screenH * 0.0625, actionbarColor1, false)--background action-bar
    dxDrawRectangle(screenW * 0.4026, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, actionbarColor2, false)--1
    dxDrawRectangle(screenW * 0.4348, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, actionbarColor2, false)--2
    dxDrawRectangle(screenW * 0.4671, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, actionbarColor2, false)--3
    dxDrawRectangle(screenW * 0.4993, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, actionbarColor2, false)--4
    dxDrawRectangle(screenW * 0.5315, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, actionbarColor2, false)--5
    dxDrawRectangle(screenW * 0.5637, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, actionbarColor2, false)--6
    for i, v in ipairs(actionbar) do
        if actionbar[i][1] ~= nil then
            if actionBarItemMoving ~= actionbar[i][1] then
                dxDrawImage(actionBarSlotPosition[i][1], actionBarSlotPosition[i][2], actionBarSlotPosition[i][3], actionBarSlotPosition[i][4], "gfx/itens/"..actionbar[i][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
    end
    dxDrawRectangle(screenW * 0.4026, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, tocolor(255, 255, 255, slotAlpha[1][1]), false)--1
    dxDrawRectangle(screenW * 0.4348, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, tocolor(255, 255, 255, slotAlpha[2][1]), false)--2
    dxDrawRectangle(screenW * 0.4671, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, tocolor(255, 255, 255, slotAlpha[3][1]), false)--3
    dxDrawRectangle(screenW * 0.4993, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, tocolor(255, 255, 255, slotAlpha[4][1]), false)--4
    dxDrawRectangle(screenW * 0.5315, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, tocolor(255, 255, 255, slotAlpha[5][1]), false)--5
    dxDrawRectangle(screenW * 0.5637, screenH * 0.9297, screenW * 0.0293, screenH * 0.0521, tocolor(255, 255, 255, slotAlpha[6][1]), false)--6
end
-----------------------------------------------------------------------------------------------------------------------------------------
function renderTrade()
    local name = getPlayerName(playerTrade)
    local id = getElementData(playerTrade, "ID") or "N/A"
    if isCursorShowing() and isCursorOnElement(screenW * 0.4356, screenH * 0.5664, screenW * 0.1281, screenH * 0.0456) then
        color1 = tocolor(80, 80, 80, 255)
    else
        color1 = tocolor(38, 38, 38, 255)
    end
    if isCursorShowing() and isCursorOnElement(screenW * 0.5461, screenH * 0.3750, screenW * 0.0307, screenH * 0.0430) then
        alpha1 = 255
    else
        alpha1 = 175
    end
    dxDrawRectangle(screenW * 0.4231, screenH * 0.3750, screenW * 0.1537, screenH * 0.2500, tocolor(20, 20, 20, 255), false)
    dxDrawRectangle(screenW * 0.4356, screenH * 0.5664, screenW * 0.1281, screenH * 0.0456, color1, false)
    dxDrawText("        Vender item", screenW * 0.4231, screenH * 0.3750, screenW * 0.5461, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
    dxDrawText("Enviar Proposta", screenW * 0.4356, screenH * 0.5664, screenW * 0.5637, screenH * 0.6120, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.5461, screenH * 0.3750, screenW * 0.0307, screenH * 0.0430, tocolor(200, 20, 20, alpha1), false)
    dxDrawText("X", screenW * 0.5461, screenH * 0.3750, screenW * 0.5769, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    dxDrawText(name.." ("..id..")", screenW * 0.4356, screenH * 0.4232, screenW * 0.5637, screenH * 0.4688, tocolor(255, 255, 255, 255), 1.00, font3, "center", "center", false, false, false, false, false)
    dxDrawImage(screenW * 0.4356, screenH * 0.4844, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..itemTrade..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawRectangle(screenW * 0.5095, screenH * 0.4844, screenW * 0.0542, screenH * 0.0273, tocolor(38, 38, 38, 255), false)
    dxDrawText("Qntd:", screenW * 0.4795, screenH * 0.4844, screenW * 0.5095, screenH * 0.5117, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.5095, screenH * 0.5247, screenW * 0.0542, screenH * 0.0273, tocolor(38, 38, 38, 255), false)
    dxDrawText("Valor:", screenW * 0.4795, screenH * 0.5247, screenW * 0.5095, screenH * 0.5521, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.5095, screenH * 0.5117, screenW * 0.5630, screenH * 0.5117, tocolor(90, 90, 90, 255), 1, false)
    dxDrawLine(screenW * 0.5095, screenH * 0.5521, screenW * 0.5630, screenH * 0.5521, tocolor(90, 90, 90, 255), 1, false)
    dxDrawText(guiGetText(editQuantidade), screenW * 0.5120, screenH * 0.4844, screenW * 0.5630, screenH * 0.5117, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
    dxDrawText(guiGetText(editValor), screenW * 0.5120, screenH * 0.5247, screenW * 0.5630, screenH * 0.5521, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
function renderTrash()
    if isCursorShowing() and isCursorOnElement(screenW * 0.4356, screenH * 0.5664, screenW * 0.1281, screenH * 0.0456) then
        color1 = tocolor(80, 80, 80, 255)
    else
        color1 = tocolor(38, 38, 38, 255)
    end
    if isCursorShowing() and isCursorOnElement(screenW * 0.5461, screenH * 0.3750, screenW * 0.0307, screenH * 0.0430) then
        alpha1 = 255
    else
        alpha1 = 175
    end
    dxDrawRectangle(screenW * 0.4231, screenH * 0.3750, screenW * 0.1537, screenH * 0.2500, tocolor(20, 20, 20, 255), false)
    dxDrawRectangle(screenW * 0.4356, screenH * 0.5664, screenW * 0.1281, screenH * 0.0456, color1, false)
    dxDrawText("       Descartar item", screenW * 0.4231, screenH * 0.3750, screenW * 0.5461, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
    dxDrawText("Descartar", screenW * 0.4356, screenH * 0.5664, screenW * 0.5637, screenH * 0.6120, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.5461, screenH * 0.3750, screenW * 0.0307, screenH * 0.0430, tocolor(200, 20, 20, alpha1), false)
    dxDrawText("X", screenW * 0.5461, screenH * 0.3750, screenW * 0.5769, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    dxDrawImage(screenW * 0.4356, screenH * 0.4844, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..itemTrade..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawRectangle(screenW * 0.5095, screenH * 0.4844, screenW * 0.0542, screenH * 0.0273, tocolor(38, 38, 38, 255), false)
    dxDrawText("Qntd:", screenW * 0.4795, screenH * 0.4844, screenW * 0.5095, screenH * 0.5117, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.5095, screenH * 0.5117, screenW * 0.5630, screenH * 0.5117, tocolor(90, 90, 90, 255), 1, false)
    dxDrawText(guiGetText(editQuantidade2), screenW * 0.5120, screenH * 0.4844, screenW * 0.5630, screenH * 0.5117, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
function renderBox()
    if isCursorShowing() and isCursorOnElement(screenW * 0.4356, screenH * 0.5664, screenW * 0.1281, screenH * 0.0456) then
        color1 = tocolor(80, 80, 80, 255)
    else
        color1 = tocolor(38, 38, 38, 255)
    end
    if isCursorShowing() and isCursorOnElement(screenW * 0.5461, screenH * 0.3750, screenW * 0.0307, screenH * 0.0430) then
        alpha1 = 255
    else
        alpha1 = 175
    end
    dxDrawRectangle(screenW * 0.4231, screenH * 0.3750, screenW * 0.1537, screenH * 0.2500, tocolor(20, 20, 20, 255), false)
    dxDrawRectangle(screenW * 0.4356, screenH * 0.5664, screenW * 0.1281, screenH * 0.0456, color1, false)
    dxDrawText("       Guardar item", screenW * 0.4231, screenH * 0.3750, screenW * 0.5461, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)
    dxDrawText("Guardar", screenW * 0.4356, screenH * 0.5664, screenW * 0.5637, screenH * 0.6120, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.5461, screenH * 0.3750, screenW * 0.0307, screenH * 0.0430, tocolor(200, 20, 20, alpha1), false)
    dxDrawText("X", screenW * 0.5461, screenH * 0.3750, screenW * 0.5769, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    dxDrawImage(screenW * 0.4356, screenH * 0.4844, screenW * 0.0366, screenH * 0.0651, "gfx/itens/"..itemTrade..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawRectangle(screenW * 0.5095, screenH * 0.4844, screenW * 0.0542, screenH * 0.0273, tocolor(38, 38, 38, 255), false)
    dxDrawText("Qntd:", screenW * 0.4795, screenH * 0.4844, screenW * 0.5095, screenH * 0.5117, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.5095, screenH * 0.5117, screenW * 0.5630, screenH * 0.5117, tocolor(90, 90, 90, 255), 1, false)
    dxDrawText(guiGetText(editQuantidade3), screenW * 0.5120, screenH * 0.4844, screenW * 0.5630, screenH * 0.5117, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, false, false, false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
function toggleInv()
    if loggedIn then
    	if not isTradeVisible then
        	if not isInventoryVisible then
            	if not isTimer(timerOpen) and not isTimer(timerClose) then
                	PlaySound("open")
                	timerOpen = setTimer(function() end, 1500, 1)
                	isInventoryVisible = true
                	addEventHandler("onClientRender", root, renderInv)
                    AlphaFade(true)
            	end
       		else
                if not isTimer(timerOpen) and not isTimer(timerClose) then
                    PlaySound("close")
                    isInventoryVisible = false
                    isTradeVisible = false
                    itemMoving = nil
                    actionBarItemMoving = nil
                    cacheSlotActionBar = nil
                    itemTrade = nil
                    playerTrade = nil
                    AlphaFade(false)
                    timerClose = setTimer(function()
                        removeEventHandler("onClientRender", root, renderInv)
                    end, 1500, 1)
                end
            end
        end
    else
    	outputChatBox("[SERVER]:#FFFFFF Aguarde, estamos carregando seus itens...", 30, 144, 255, true)
    end
end
bindKey("i", "down", toggleInv)
-----------------------------------------------------------------------------------------------------------------------------------------
function click(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
    if isInventoryVisible and not isTradeVisible and not isReceivingTrade then
        if button == "left" and state == "down" then
            for i, v in pairs(slotsPosition) do
                if isCursorOnElement(slotsPosition[i][1], slotsPosition[i][2], slotsPosition[i][3], slotsPosition[i][4]) then
                    if inventario[i] then
                        itemMoving = inventario[i][1]
                    end
                end
            end
            for i, v in pairs(actionBarSlotPosition) do
                if isCursorOnElement(actionBarSlotPosition[i][1], actionBarSlotPosition[i][2], actionBarSlotPosition[i][3], actionBarSlotPosition[i][4]) then
                    if actionbar[i] then
                        actionBarItemMoving = actionbar[i][1]
                        cacheSlotActionBar = i
                    end
                end
            end
        elseif button == "left" and state == "up" then
            for i, v in pairs(actionBarSlotPosition) do
                if isCursorOnElement(actionBarSlotPosition[i][1], actionBarSlotPosition[i][2], actionBarSlotPosition[i][3], actionBarSlotPosition[i][4]) then
                    if itemMoving then
                        if not actionbar[i][1] then
                            if itemMoving ~= actionbar[1][1] and itemMoving ~= actionbar[2][1] and itemMoving ~= actionbar[3][1] and itemMoving ~= actionbar[4][1] and itemMoving ~= actionbar[5][1] and itemMoving ~= actionbar[6][1] then
                                table.insert(actionbar[i], itemMoving)
                                PlaySound("release")
                                itemMoving = nil
                            end
                        end
                    elseif actionBarItemMoving then
                        if actionbar[i][1] == nil then
                            table.insert(actionbar[i], actionBarItemMoving)
                            table.remove(actionbar[cacheSlotActionBar])
                            PlaySound("release")
                            actionBarItemMoving = nil
                        end
                    end
                end
            end
            if isElement(clickedWorld) then
            	if not isCursorOnElement(screenW * 0.3997, screenH * 0.2474, screenW * 0.2006, screenH * 0.4987) and not isCursorOnElement(screenW * 0.3997, screenH * 0.9245, screenW * 0.1962, screenH * 0.0625) then
                	if (itemMoving) then
                    	if clickedWorld ~= localPlayer then
                    		if getElementType(clickedWorld) == "player" then
                                if (action["player"][itemMoving]) then
                                    triggerServerEvent("Action", resourceRoot, localPlayer, clickedWorld, itemMoving)
                                else
                                   	playerTrade = clickedWorld
                                    itemTrade = itemMoving
                                    isTradeVisible = true
                                    addEventHandler("onClientRender", root, renderTrade)
                                    guiSetVisible(editQuantidade, true)
                                    guiSetVisible(editValor, true)
                                end
                            elseif getElementType(clickedWorld) == "object" then
                            	if getElementModel(clickedWorld) == 1359 then
                            		if not (itensCantRemoved[itemMoving]) then
                                		for i, v in pairs(trashs) do
                                			if v == clickedWorld then
												local x, y, z = getElementPosition(localPlayer)
												local ex, ey, ez = getElementPosition(clickedWorld)
												if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
                                   					playerTrade = "Lixeira"
                                    				itemTrade = itemMoving
                                    				isTradeVisible = true
                                    				addEventHandler("onClientRender", root, renderTrash)
                                    				guiSetVisible(editQuantidade2, true)
                                    			end
                                    		end
                                    	end
                                	end
                                elseif getElementModel(clickedWorld) == 1227 then
                                    if (ilegalItens[itemMoving]) then
                                        if getElementData(clickedWorld, "IsBox") then
                                            local x, y, z = getElementPosition(localPlayer)
                                            local ex, ey, ez = getElementPosition(clickedWorld)
                                            if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
                                                playerTrade = getElementData(clickedWorld, "IsBox")
                                                itemTrade = itemMoving
                                                isTradeVisible = true
                                                addEventHandler("onClientRender", root, renderBox)
                                                guiSetVisible(editQuantidade3, true)
                                            end
                                        end
                                    end
                                else
                                    if (action["object"][itemMoving]) then
                                	   triggerServerEvent("Action", resourceRoot, localPlayer, clickedWorld, itemMoving)
                                    end
                                end
                            elseif getElementType(clickedWorld) == "vehicle" then
                                if (action["vehicle"][itemMoving]) then
                                    triggerServerEvent("Action", resourceRoot, localPlayer, clickedWorld, itemMoving)
                                end
                            end
                        end
                    end
                end
            end
            cacheSlotActionBar = nil
            actionBarItemMoving = nil
            itemMoving = nil
        elseif button == "right" and state == "down" then
            for i, v in pairs(actionBarSlotPosition) do
                if isCursorOnElement(actionBarSlotPosition[i][1], actionBarSlotPosition[i][2], actionBarSlotPosition[i][3], actionBarSlotPosition[i][4]) then
                    if actionbar[i] then
                        table.remove(actionbar[i])
                    end
                end
            end
            for i, v in pairs(slotsPosition) do
                if isCursorOnElement(slotsPosition[i][1], slotsPosition[i][2], slotsPosition[i][3], slotsPosition[i][4]) then
                    if inventario[i] then
                        if not isTimer(timerUse) then
                            timerUse = setTimer(function() end, 2500, 1)
                            triggerServerEvent("Use", resourceRoot, localPlayer, inventario[i][1])
                        end
                    end
                end
            end
        end
    elseif isInventoryVisible and isTradeVisible then
        if button == "left" and state == "down" then
            if isCursorOnElement(screenW * 0.5461, screenH * 0.3750, screenW * 0.0307, screenH * 0.0430) then
            	if isElement(playerTrade) and getElementType(playerTrade) == "player" then
                	playerTrade = nil
                	itemTrade = nil
                	isTradeVisible = false
                	removeEventHandler("onClientRender", root, renderTrade)
                	guiSetVisible(editQuantidade, false)
                	guiSetVisible(editValor, false)
                	guiSetText(editQuantidade, "1")
                	guiSetText(editValor, "0")
                else 
                    if playerTrade == "Lixeira" then
                	   playerTrade = nil
                	   itemTrade = nil
                	   isTradeVisible = false
                	   removeEventHandler("onClientRender", root, renderTrash)
                	   guiSetVisible(editQuantidade2, false)
                	   guiSetText(editQuantidade2, "1")
                    elseif GangsHaveBox[playerTrade] then
                       playerTrade = nil
                       itemTrade = nil
                       isTradeVisible = false
                       removeEventHandler("onClientRender", root, renderBox)
                       guiSetVisible(editQuantidade3, false)
                       guiSetText(editQuantidade3, "1")
                    end
                end
            elseif isCursorOnElement(screenW * 0.4356, screenH * 0.5664, screenW * 0.1281, screenH * 0.0456) then
            	if isElement(playerTrade) and getElementType(playerTrade) == "player" then
                	local getQuantidade = tonumber(guiGetText(editQuantidade))
                	local getValor = tonumber(guiGetText(editValor))
                	if tonumber(getQuantidade) and tonumber(getValor) and getQuantidade > 0 and getValor >= 0 then
                		if not getElementData(playerTrade, "Trading") then
                    		for i, v in pairs(inventario) do
                        		if inventario[i][1] == itemTrade then
                            		if inventario[i][2] >= getQuantidade then
                                		local troca = {
                                			{localPlayer},
                                			{itemTrade},
                                			{tonumber(getQuantidade)},
                                			{tonumber(getValor)},
                                		}
                                		triggerServerEvent("Trade", resourceRoot, "make", localPlayer, playerTrade, troca)
                                		exports._infobox:addNotification("Você enviou uma proposta de venda", "success")
                                		troca = {}
                                		playerTrade = nil
                                		itemTrade = nil
                						isTradeVisible = false
                						removeEventHandler("onClientRender", root, renderTrade)
                						guiSetVisible(editQuantidade, false)
                						guiSetVisible(editValor, false)
                						guiSetText(editQuantidade, "1")
                						guiSetText(editValor, "0")
                            		else
                                		exports._infobox:addNotification("Você não possui a quantidade indicada deste item", "error")
                            		end
                            	end
                        	end
                    	else
                    		exports._infobox:addNotification("Este(a) cidadão(ã) já está realizando uma troca", "error")
                   	 end
               		else
                    	exports._infobox:addNotification("Insira apenas números nos campos de 'Quantidade' e 'Valor'", "error")
                	end
                else
                    if playerTrade == "Lixeira" then
                        local getQuantidade = tonumber(guiGetText(editQuantidade2))
                        if tonumber(getQuantidade) and getQuantidade > 0 then
                         	for i, v in pairs(inventario) do
                             	if inventario[i][1] == itemTrade then
                                 	if inventario[i][2] >= getQuantidade then
                                     	triggerServerEvent("Trash", resourceRoot, localPlayer, itemTrade, getQuantidade)
                                     	playerTrade = nil
                                     	itemTrade = nil
                        				isTradeVisible = false
                        				removeEventHandler("onClientRender", root, renderTrash)
                        				guiSetVisible(editQuantidade2, false)
                        				guiSetText(editQuantidade2, "1")
                                 	else
                                     	exports._infobox:addNotification("Você não possui a quantidade indicada deste item", "error")
                                 	end
                                end
                            end
                        else
                         	exports._infobox:addNotification("Insira apenas números no campo 'Quantidade'", "error")
                        end
                    elseif GangsHaveBox[playerTrade] then
                        local getQuantidade = tonumber(guiGetText(editQuantidade3))
                        if tonumber(getQuantidade) and getQuantidade > 0 then
                            for i, v in pairs(inventario) do
                                if inventario[i][1] == itemTrade then
                                    if inventario[i][2] >= getQuantidade then
                                        triggerServerEvent("Box", resourceRoot, "guardar", localPlayer, playerTrade, itemTrade, getQuantidade)
                                        playerTrade = nil
                                        itemTrade = nil
                                        isTradeVisible = false
                                        removeEventHandler("onClientRender", root, renderBox)
                                        guiSetVisible(editQuantidade3, false)
                                        guiSetText(editQuantidade3, "1")
                                    else
                                        exports._infobox:addNotification("Você não possui a quantidade indicada deste item", "error")
                                    end
                                end
                            end
                        else
                            exports._infobox:addNotification("Insira apenas números no campo 'Quantidade'", "error")
                        end
                    end
                end
            end
        end
    elseif isInventoryVisible and isReceivingTrade then
        if button == "left" and state == "down" then
            if isCursorOnElement(screenW * 0.4641, screenH * 0.1914, screenW * 0.0739, screenH * 0.0430) then
				local x, y, z = getElementPosition(localPlayer)
				local ex, ey, ez = getElementPosition(tableTrade[1][1])
				if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 2 then
					triggerServerEvent("Trade", resourceRoot, "accept", localPlayer, tableTrade)
					isReceivingTrade = false
					tableTrade = {}
				else
					triggerServerEvent("Trade", resourceRoot, "distance", localPlayer, tableTrade)
					isReceivingTrade = false
					tableTrade = {}
				end
			elseif isCursorOnElement(screenW * 0.5556, screenH * 0.0195, screenW * 0.0293, screenH * 0.0430) then
				triggerServerEvent("Trade", resourceRoot, "decline", localPlayer, tableTrade)
				isReceivingTrade = false
				tableTrade = {}
			end
		end
    end
end
addEventHandler("onClientClick", root, click)
-----------------------------------------------------------------------------------------------------------------------------------------
function renderBox2(tabela, gang)
	if not isInventoryVisible then
        if not guiGetVisible(windowBau) then
        	gangBox = gang
        	guiSetVisible(windowBau, true)
			gridlistBau = guiCreateGridList(0.04, 0.06, 0.93, 0.70, true, windowBau)
			guiGridListAddColumn(gridlistBau, "Item", 0.75)
			guiGridListAddColumn(gridlistBau, "Qntd", 0.15)
			for i, v in pairs(tabela) do
				guiGridListAddRow(gridlistBau, realName[i][1], tabela[i][1])
			end
			addEventHandler("onClientGUIClick", pegarBau, click2)
			addEventHandler("onClientGUIClick", fecharBau, click2)
        end
    end
end
addEvent("RenderBox", true)
addEventHandler("RenderBox", resourceRoot, renderBox2)
-----------------------------------------------------------------------------------------------------------------------------------------
function click2(button)
    if button == "left" then
    	if source == pegarBau then
    		if guiGridListGetSelectedItem(gridlistBau) >= 0 then
    			local item = guiGridListGetItemText(gridlistBau, guiGridListGetSelectedItem(gridlistBau), 1)
    			local quantidade = guiGetText(quantidadeBau)
    			if tonumber(quantidade) and tonumber(quantidade) > 0 then
    				for i, v in pairs(realName) do
    					if realName[i][1] == item then
    						item = i
    					end
    				end
    				triggerServerEvent("Box", resourceRoot, "pegar", localPlayer, gangBox, item, tonumber(quantidade))
        			guiSetText(quantidadeBau, "Quantidade")
        			guiSetVisible(windowBau, false)
        			destroyElement(gridlistBau)
        			gangBox = nil
					removeEventHandler("onClientGUIClick", pegarBau, click2)
					removeEventHandler("onClientGUIClick", fecharBau, click2)
    			else
    				exports._infobox:addNotification("Insira uma quantidade válida", "error")
    			end
    		else
    			exports._infobox:addNotification("Selecione um item da lista para pegá-lo", "error")
    		end
        elseif source == fecharBau then
        	guiSetText(quantidadeBau, "Quantidade")
        	guiSetVisible(windowBau, false)
        	destroyElement(gridlistBau)
        	gangBox = nil
			removeEventHandler("onClientGUIClick", pegarBau, click2)
			removeEventHandler("onClientGUIClick", fecharBau, click2)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
function useActionBar(key)
    if not isCursorShowing() then
        for i, v in pairs(actionbar) do
            if i == tonumber(key) then
                if actionbar[i][1] ~= nil then
                    if not isTimer(timerUse) then
                        timerUse = setTimer(function() end, 2500, 1)
                        triggerServerEvent("Use", resourceRoot, localPlayer, actionbar[i][1])
                        slotAlpha[i][1] = 50
                        setTimer(function()
                            slotAlpha[i][1] = 0
                        end, 250, 1)
                    end
                end
            end
        end
    end
end
bindKey("1", "down", useActionBar)
bindKey("2", "down", useActionBar)
bindKey("3", "down", useActionBar)
bindKey("4", "down", useActionBar)
bindKey("5", "down", useActionBar)
bindKey("6", "down", useActionBar)
-----------------------------------------------------------------------------------------------------------------------------------------
function changeInvColor(commandName, color)
	if loggedIn then
		if getElementData(localPlayer, "VIP") then
			if corActionBar[color] then
				actionbarColor1 = tocolor(corActionBar[color][1], corActionBar[color][2], corActionBar[color][3], 255)
				actionbarColor2 = tocolor(corActionBar[color][4], corActionBar[color][5], corActionBar[color][6], 255)
			else
				exports._infobox:addNotification("Cores disponíveis: preto - vermelho - azul - verde - amarelo - rosa - branco - roxo - laranja", "error")
			end
		else
			exports._infobox:addNotification("Apenas VIPs podem utilizar este comando", "error")
		end
	end
end
addCommandHandler("cor", changeInvColor)
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function AlphaFade(state)
    if state == true then
        if isTimer(timerAlpha) then killTimer(timerAlpha) timerAlpha = nil end
        alpha = 0
        timerAlpha = setTimer(function()
            alpha = alpha + 15
        end, 1, 17)
    elseif state == false then
        if isTimer(timerAlpha) then killTimer(timerAlpha) timerAlpha = nil end
        alpha = 255
        timerAlpha = setTimer(function()
            alpha = alpha - 15
        end, 1, 17)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
function attTrade()
	isReceivingTrade = true
	tableTrade = getElementData(localPlayer, "Trading")
end
addEvent("refreshTrading", true)
addEventHandler("refreshTrading", resourceRoot, attTrade)
-----------------------------------------------------------------------------------------------------------------------------------------
function cancelShoot(weapon)
	if weapon ~= 28 then
		if (weaponsCancelShootOneBullet[weapon]) then
			if getPedTotalAmmo(localPlayer, currentWeaponSlot) < 2 then
				toggleControl("action", false)
				toggleControl("fire", false)
                toggleControl("vehicle_fire", false)
			else
				toggleControl("action", true)
				toggleControl("fire", true)
                toggleControl("vehicle_fire", true)
			end
		else
			toggleControl("action", true)
			toggleControl("fire", true)
            toggleControl("vehicle_fire", true)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, cancelShoot)
-----------------------------------------------------------------------------------------------------------------------------------------
function cancelShoot2()
   local weapon = getPedWeapon(localPlayer, current)
   if weapon ~= 28 then
       if (weaponsCancelShootOneBullet[weapon]) then
           if getPedTotalAmmo(localPlayer, currentWeaponSlot) == 1 then
               toggleControl("action", false)
               toggleControl("fire", false)
               toggleControl("vehicle_fire", false)
           end
       end
   end
end
bindKey("fire", "down", cancelShoot2)
bindKey("action", "down", cancelShoot2)
-----------------------------------------------------------------------------------------------------------------------------------------
function onlyGuard(_, currentWeaponSlot)
    local weapon = getPedWeapon(localPlayer, currentWeaponSlot)
    if weapon ~= 28 then
    	if not (weaponsCancelShootOneBullet[weapon]) then
    	    toggleControl("action", true)
    	    toggleControl("fire", true)
            toggleControl("vehicle_fire", true)
    	else
    	    if getPedTotalAmmo(localPlayer, currentWeaponSlot) > 1 then
    	        toggleControl("action", true)
    	        toggleControl("fire", true)
                toggleControl("vehicle_fire", true)
    	    else
				toggleControl("action", false)
				toggleControl("fire", false)
                toggleControl("vehicle_fire", false)
    	    end
    	end
    end
end
addEventHandler("onClientPlayerWeaponSwitch", localPlayer, onlyGuard)
-----------------------------------------------------------------------------------------------------------------------------------------
function antiBug()
    local text = guiGetText(source) or ""
    if not tonumber(text) then
        guiSetText(source, string.gsub(text, "%a", ""))
    end
end
addEventHandler("onClientGUIChanged", editValor, antiBug)
addEventHandler("onClientGUIChanged", editQuantidade, antiBug)
-----------------------------------------------------------------------------------------------------------------------------------------
function soundRadinho(key, pressed)
	if (pressed) then
		local keys = getBoundKeys("voiceptt")
		for i, v in pairs(keys) do
			if i == key then
				if getElementData(localPlayer, "Radinho") then
					for index, value in pairs(inventario) do
						if inventario[index][1] == "radinho" then
							if not isTimer(timerRadinho) then
								timerRadinho = setTimer(function() end, 1500, 1)
								local sound = playSound("sfx/radio-beep.mp3")
								setSoundVolume(sound, 5)
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientKey", root, soundRadinho)
-----------------------------------------------------------------------------------------------------------------------------------------
function GetItemClient(item)
    if realName[item] then
        local count = false
        for i, v in pairs(inventario) do
            if inventario[i][1] == item then
                if inventario[i][2] > 0 then
                    return tonumber(inventario[i][2])
                else
                    return 0
                end
            end
        end
        if count == false then
            return 0
        end
    else
        return 0
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
function PlaySound(som, player)
    if som == "open" or som == "close" or som == "select" then
        local sound = playSound("sfx/"..som..".mp3")
        setSoundVolume(sound, 0.5)
    elseif som == "release" then
        local sound = playSound("sfx/"..som..".mp3")
        setSoundVolume(sound, 0.25)
    elseif som == "eat" or som == "drink" or som == "pick" or som == "put" or som == "radio-toggle" or som == "repair" then
    	local x, y, z = getElementPosition(player)
    	local sound = playSound3D("sfx/"..som..".mp3", x, y, z)
        local dim = getElementDimension(player)
        local int = getElementInterior(player)
        setElementDimension(sound, dim)
        setElementInterior(sound, int)
    	attachElements(sound, player)
        setSoundVolume(sound, 0.05)
    elseif som == "trash" then
    	local x, y, z = getElementPosition(player)
    	local sound = playSound3D("sfx/"..som..".mp3", x, y, z)
    	setSoundVolume(sound, 0.5)
    elseif som == "vehicle-alarm" then
        local x, y, z = getElementPosition(player)
        local sound = playSound3D("sfx/"..som..".mp3", x, y, z, true)
        local dim = getElementDimension(player)
        local int = getElementInterior(player)
        setElementDimension(sound, dim)
        setElementInterior(sound, int)
        attachElements(sound, player)
        setTimer(function()
            stopSound(sound)
        end, 150000, 1)
    end
end
addEvent("playSound", true)
addEventHandler("playSound", resourceRoot, PlaySound)
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------