--  ____    ______   _____  
-- |  _ \  |  ____| |  __ \ 
-- | |_) | | |__    | |__) |
-- |  _ <  |  __|   |  _  / 
-- | |_) | | |____  | | \ \ 
-- |____/  |______| |_|  \_\
-----------------------------------------------------------------------------------------------------------------------------------------
inventario = {}
timerStart = {}
gates = {}
boxes = {}
acao = {}
item = {}
arma = {}
capacete = {}
maleta = {}
mascara = {}
som = {}
flor = {}
tempo = {}
cigarro = {}
algemado = {}
algemando = {}
blip = {}
curado = {}
timerAlgema = {}
bau = {}
-----------------------------------------------------------------------------------------------------------------------------------------
for i, v in pairs(GatePositions) do
	gates[i] = createObject(GatePositions[i][2], GatePositions[i][3], GatePositions[i][4], GatePositions[i][5], 0, 0, GatePositions[i][11])
end
for i, v in pairs(BoxPositions) do
    boxes[i] = createObject(1227, BoxPositions[i][3], BoxPositions[i][4], BoxPositions[i][5]-0.2, BoxPositions[i][6], BoxPositions[i][7], BoxPositions[i][8])
    setElementData(boxes[i], "IsBox", BoxPositions[i][1])
    bau[BoxPositions[i][1]] = {}
    setElementInterior(boxes[i], BoxPositions[i][9])
    setElementDimension(boxes[i], BoxPositions[i][10])
end
-----------------------------------------------------------------------------------------------------------------------------------------
function giveItem(playerSource, commandName, id, item, qntd)
	if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Admin")) or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Vice-Presidente")) then
		if not qntd then return exports._infobox:addNotification(playerSource, "Utilize: /giveitem ID ITEM QUANTIDADE", "error") end
		for i, v in pairs(getElementsByType("player")) do
			if getElementData(v, "ID") == tonumber(id) then
				if GiveAndTakeAndGetItem("give", v, item, qntd) then
					exports._infobox:addNotification(playerSource, "Você deu "..qntd.."x '"..(realName[item][1]).."' para o jogador "..getPlayerName(v), "success")
					exports._infobox:addNotification(v, "Você recebeu "..qntd.."x '"..(realName[item][1]).."' do Deus "..getPlayerName(playerSource), "info")
					local name = getPlayerName(playerSource)
					local ID1 = getElementData(playerSource, "ID") or "N/A"
					local name2 = getPlayerName(v)
					local ID2 = getElementData(v, "ID") or "N/A"
					exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nStaff: "..name.." ["..ID1.."]\nJogador: "..name2.." ["..ID2.."]\nItem: "..item.."\nQuantidade: "..qntd.."\nOperação: Give")
				else
					exports._infobox:addNotification(playerSource, "O jogador não possui espaço em sua mochila ou o item informado não existe", "error")
				end
			end
		end
	end
end
addCommandHandler("giveitem", giveItem)
-----------------------------------------------------------------------------------------------------------------------------------------
function takeItem(playerSource, commandName, id, item, qntd)
	if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Admin")) or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Vice-Presidente")) then
		if not id then return exports._infobox:addNotification(playerSource, "Utilize: /takeitem ID ITEM", "error") end
		for i, v in pairs(getElementsByType("player")) do
			if getElementData(v, "ID") == tonumber(id) then
				if (qntd) then
					if GiveAndTakeAndGetItem("take", v, item, tonumber(qntd)) then
						exports._infobox:addNotification(playerSource, "Você removeu "..qntd.."x '"..(realName[item][1]).."' do inventário do jogador "..getPlayerName(v), "success")
						exports._infobox:addNotification(v, "O Deus "..getPlayerName(playerSource).." removeu "..qntd.."x '"..(realName[item][1]).."' do seu inventário", "warning")
						local name = getPlayerName(playerSource)
						local ID1 = getElementData(playerSource, "ID") or "N/A"
						local name2 = getPlayerName(v)
						local ID2 = getElementData(v, "ID") or "N/A"
						exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nStaff: "..name.." ["..ID1.."]\nJogador: "..name2.." ["..ID2.."]\nItem: "..item.."\nQuantidade: "..qntd.."\nOperação: Take")
					else
						exports._infobox:addNotification(playerSource, "O jogador não possui "..qntd.."x deste item em sua mochila ou o item informado não existe", "error")
					end
				else
					if GiveAndTakeAndGetItem("take", v, item, "all") then
						exports._infobox:addNotification(playerSource, "Você removeu todos os(as) '"..(realName[item][1]).."' do inventário do jogador "..getPlayerName(v), "success")
						exports._infobox:addNotification(v, "O Deus "..getPlayerName(playerSource).." removeu o item '"..(realName[item][1]).."' do seu inventário", "warning")
						local name = getPlayerName(playerSource)
						local ID1 = getElementData(playerSource, "ID") or "N/A"
						local name2 = getPlayerName(v)
						local ID2 = getElementData(v, "ID") or "N/A"
						exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nStaff: "..name.." ["..ID1.."]\nJogador: "..name2.." ["..ID2.."]\nItem: "..item.."\nQuantidade: All\nOperação: Take")
					else
						exports._infobox:addNotification(playerSource, "O jogador não possui este item em sua mochila ou o item informado não existe", "error")
					end
				end
			end
		end
	end
end
addCommandHandler("takeitem", takeItem)
-----------------------------------------------------------------------------------------------------------------------------------------
function resetInv(playerSource, commandName, id)
	if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Admin")) or isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Vice-Presidente")) then
		if not id then return exports._infobox:addNotification(playerSource, "Utilize: /takeitem ID ITEM", "error") end
		for i, v in pairs(getElementsByType("player")) do
			if getElementData(v, "ID") == tonumber(id) then
				for index = #inventario[v], 1, -1 do
					local item = inventario[v][index][1]
					if not itensCantRemoved[item] then
						GiveAndTakeAndGetItem("take", v, item, "all")
					end
				end
				exports._infobox:addNotification(playerSource, "Você resetou o inventário do jogador "..getPlayerName(v), "success")
				exports._infobox:addNotification(v, "O Deus "..getPlayerName(playerSource).." resetou seu inventário", "warning")
				local name = getPlayerName(playerSource)
				local ID1 = getElementData(playerSource, "ID") or "N/A"
				local name2 = getPlayerName(v)
				local ID2 = getElementData(v, "ID") or "N/A"
				exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nStaff: "..name.." ["..ID1.."]\nJogador: "..name2.." ["..ID2.."]\nOperação: Reset")
			end
		end
	end
end
addCommandHandler("resetinv", resetInv)
-----------------------------------------------------------------------------------------------------------------------------------------
function GiveAndTakeAndGetItem(tipo, playerSource, item, qntd)
	if realName[item] then
		if tipo == "give" then
    		local peso = 0
    		local maxPeso = 30
    		for i, v in pairs(pesoItens) do
        		for index, value in pairs(inventario[playerSource]) do
            		if inventario[playerSource][index][1] == i then
                		peso = peso + (pesoItens[i][1] * inventario[playerSource][index][2])
            		end
        		end
    		end
    		if getElementData(playerSource, "VIP") or getElementData(playerSource, "Staff") then
    			maxPeso = 50
    		end
    		if (peso + (pesoItens[item][1] * qntd)) <= maxPeso then
				local count = false
				for i, v in pairs(inventario[playerSource]) do
					if inventario[playerSource][i][1] == item then
						count = true
					end
				end
				if count then
					for i, v in pairs(inventario[playerSource]) do
						if inventario[playerSource][i][1] == item then
							inventario[playerSource][i][2] = inventario[playerSource][i][2] + tonumber(qntd)
							triggerClientEvent(playerSource, "refresh", resourceRoot, inventario[playerSource])
							return true
						end
					end
				else
					if #inventario[playerSource] < 30 then
						local edit = {item, tonumber(qntd)}
						table.insert(inventario[playerSource], edit)
						triggerClientEvent(playerSource, "refresh", resourceRoot, inventario[playerSource])
						return true
					else
						return false
					end
				end
			else
				return false
			end
		elseif tipo == "take" then
			for i, v in pairs(inventario[playerSource]) do
				if inventario[playerSource][i][1] == item then
					if tostring(qntd) == "all" then
						table.remove(inventario[playerSource], i)
						removeItem(playerSource, item)
					else
						if inventario[playerSource][i][2] >= tonumber(qntd) then
							inventario[playerSource][i][2] = inventario[playerSource][i][2] - tonumber(qntd)
						else
							return false
						end
					end
					if inventario[playerSource][i] then
						if inventario[playerSource][i][2] <= 0 then
							table.remove(inventario[playerSource], i)
                    		removeItem(playerSource, item)
						end
					end
					triggerClientEvent(playerSource, "refresh", resourceRoot, inventario[playerSource])
					return true
				end
			end
		elseif tipo == "get" then
			for i, v in pairs(inventario[playerSource]) do
				if inventario[playerSource][i][1] == item then
					if inventario[playerSource][i][2] > 0 then
						return inventario[playerSource][i][2]
					else
						return 0
					end
				end
			end
			return 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
function use(playerSource, itemUsed)
    if itemUsed == "suco" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
      			local x, y, z = getElementPosition(playerSource)
				item[playerSource] = createObject(1544, x, y, z)
				acao[playerSource] = setTimer(function() end, 3000, 1)
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      			local dim = getElementDimension(playerSource)
      			local int = getElementInterior(playerSource)
      			setElementDimension(item[playerSource], dim)
      			setElementInterior(item[playerSource], int)
      			setPedAnimation(playerSource, "VENDING", "VEND_Drink2_P", 3000, false, true, false, false, _, true)
      			PlaySound3D(playerSource, "drink", 15)
      			exports.bone_attach:attachElementToBone(item[playerSource], playerSource, 11, -0.26, -0.05, 0.14, 34, 108, 4)
      			setTimer(function()
      				destroyElement(item[playerSource])
      				item[playerSource] = nil
      				local random = math.random(5, 10)
      				local sede = getElementData(playerSource, "sede") or 0
					setElementData(playerSource, "sede", sede + random)
					if getElementData(playerSource, "sede") > 100 then
						setElementData(playerSource, "sede", 100)
					end
      			end, 3000, 1)
      		end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "refrigerante" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
				local x, y, z = getElementPosition(playerSource)
				item[playerSource] = createObject(2601, x, y, z)
				acao[playerSource] = setTimer(function() end, 3000, 1)
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      			local dim = getElementDimension(playerSource)
      			local int = getElementInterior(playerSource)
				setObjectScale(item[playerSource], 0.9)
      			setElementDimension(item[playerSource], dim)
      			setElementInterior(item[playerSource], int)
      			setPedAnimation(playerSource, "VENDING", "VEND_Drink2_P", 3000, false, true, false, false, _, true)
      			PlaySound3D(playerSource, "drink", 15)
      			exports.bone_attach:attachElementToBone(item[playerSource], playerSource, 11, -0.01, 0.04, 0.06, 46, 110, -14)
      			setTimer(function()
      				destroyElement(item[playerSource])
      				item[playerSource] = nil
      				local random = math.random(10, 15)
      				local sede = getElementData(playerSource, "sede") or 0
					setElementData(playerSource, "sede", sede + random)
					if getElementData(playerSource, "sede") > 100 then
						setElementData(playerSource, "sede", 100)
					end
      			end, 3000, 1)
      		end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "whisky" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
      			local x, y, z = getElementPosition(playerSource)
				item[playerSource] = createObject(1520, x, y, z)
				acao[playerSource] = setTimer(function() end, 3000, 1)
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      			local dim = getElementDimension(playerSource)
      			local int = getElementInterior(playerSource)
      			setElementDimension(item[playerSource], dim)
      			setElementInterior(item[playerSource], int)
      			setPedAnimation(playerSource, "VENDING", "VEND_Drink2_P", 3000, false, true, false, false, _, true)
      			PlaySound3D(playerSource, "drink", 15)
      			exports.bone_attach:attachElementToBone(item[playerSource], playerSource, 11, -0.25, 0.01, 0.11, 44, 100, -4)
      			setTimer(function()
      				destroyElement(item[playerSource])
      				item[playerSource] = nil
      				local random = math.random(15, 20)
      				local sede = getElementData(playerSource, "sede") or 0
					setElementData(playerSource, "sede", sede + random)
					if getElementData(playerSource, "sede") > 100 then
						setElementData(playerSource, "sede", 100)
					end
      			end, 3000, 1)
      		end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "leite2" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
      			local x, y, z = getElementPosition(playerSource)
				item[playerSource] = createObject(1484, x, y, z)
				acao[playerSource] = setTimer(function() end, 3000, 1)
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      			local dim = getElementDimension(playerSource)
      			local int = getElementInterior(playerSource)
      			setElementDimension(item[playerSource], dim)
      			setElementInterior(item[playerSource], int)
      			setPedAnimation(playerSource, "VENDING", "VEND_Drink2_P", 3000, false, true, false, false, _, true)
      			PlaySound3D(playerSource, "drink", 15)
      			exports.bone_attach:attachElementToBone(item[playerSource], playerSource, 11, -0.01, -0.02, 0.13, 22, 132, 12)
      			setTimer(function()
      				destroyElement(item[playerSource])
      				item[playerSource] = nil
      				local sede = getElementData(playerSource, "sede") or 0
					setElementData(playerSource, "sede", sede + 50)
					if getElementData(playerSource, "sede") > 100 then
						setElementData(playerSource, "sede", 100)
					end
      			end, 3000, 1)
      		end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "burrito" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
      			local x, y, z = getElementPosition(playerSource)
				item[playerSource] = createObject(2769, x, y, z)
				acao[playerSource] = setTimer(function() end, 5000, 1)
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      			local dim = getElementDimension(playerSource)
      			local int = getElementInterior(playerSource)
      			setElementDimension(item[playerSource], dim)
      			setElementInterior(item[playerSource], int)
      			setPedAnimation(playerSource, "FOOD", "EAT_Burger", 5000, false, true, false, false, _, true)
      			PlaySound3D(playerSource, "eat", 15)
      			exports.bone_attach:attachElementToBone(item[playerSource], playerSource, 12, 0.06, 0.03, 0.02, 50, 74, -88)
      			setTimer(function()
      				destroyElement(item[playerSource])
      				item[playerSource] = nil
      				local random = math.random(5, 10)
      				local hunger = getElementData(playerSource, "hunger") or 0
      				local fezes = getElementData(playerSource, "fezes") or 0
					setElementData(playerSource, "hunger", hunger + random)
					setElementData(playerSource, "fezes", fezes + random)
					if getElementData(playerSource, "fezes") > 100 then
						setElementData(playerSource, "fezes", 100)
					end
					if getElementData(playerSource, "hunger") > 100 then
						setElementData(playerSource, "hunger", 100)
						setPedStat(playerSource, 21, getPedStat(playerSource, 21) + 100)
					end
      			end, 5000, 1)
      		end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "pizza" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
      			local x, y, z = getElementPosition(playerSource)
				item[playerSource] = createObject(2702, x, y, z)
				acao[playerSource] = setTimer(function() end, 5000, 1)
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      			local dim = getElementDimension(playerSource)
      			local int = getElementInterior(playerSource)
				setObjectScale(item[playerSource], 0.8)
      			setElementDimension(item[playerSource], dim)
      			setElementInterior(item[playerSource], int)
      			setPedAnimation(playerSource, "FOOD", "EAT_Pizza", 5000, false, true, false, false, _, true)
      			PlaySound3D(playerSource, "eat", 15)
      			exports.bone_attach:attachElementToBone(item[playerSource], playerSource, 12, -3.4694469519536e-18, 0.08, 0.05, -6, 251.5, 10)
      			setTimer(function()
      				destroyElement(item[playerSource])
      				item[playerSource] = nil
      				local random = math.random(10, 15)
      				local hunger = getElementData(playerSource, "hunger") or 0
      				local fezes = getElementData(playerSource, "fezes") or 0
					setElementData(playerSource, "hunger", hunger + random)
					setElementData(playerSource, "fezes", fezes + random)
					if getElementData(playerSource, "fezes") > 100 then
						setElementData(playerSource, "fezes", 100)
					end
					if getElementData(playerSource, "hunger") > 100 then
						setElementData(playerSource, "hunger", 100)
						setPedStat(playerSource, 21, getPedStat(playerSource, 21) + 150)
					end
      			end, 5000, 1)
      		end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "hamburguer" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
				local x, y, z = getElementPosition(playerSource)
				item[playerSource] = createObject(2703, x, y, z)
				acao[playerSource] = setTimer(function() end, 5000, 1)
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      			local dim = getElementDimension(playerSource)
      			local int = getElementInterior(playerSource)
      			setElementDimension(item[playerSource], dim)
      			setElementInterior(item[playerSource], int)
      			setPedAnimation(playerSource, "FOOD", "EAT_Burger", 5000, false, true, false, false, _, true)
      			PlaySound3D(playerSource, "eat", 15)
      			exports.bone_attach:attachElementToBone(item[playerSource], playerSource, 12, -0.02, 0.06, 0.05, -14, 8, -18)
      			setTimer(function()
      				destroyElement(item[playerSource])
      				item[playerSource] = nil
      				local random = math.random(15, 20)
      				local hunger = getElementData(playerSource, "hunger") or 0
      				local fezes = getElementData(playerSource, "fezes") or 0
					setElementData(playerSource, "hunger", hunger + random)
					setElementData(playerSource, "fezes", fezes + random)
					if getElementData(playerSource, "fezes") > 100 then
						setElementData(playerSource, "fezes", 100)
					end
					if getElementData(playerSource, "hunger") > 100 then
						setElementData(playerSource, "hunger", 100)
						setPedStat(playerSource, 21, getPedStat(playerSource, 21) + 200)
					end
      			end, 5000, 1)
      		end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "colete" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if getPedArmor(playerSource) < 100 then
					acao[playerSource] = setTimer(function() end, 2300, 1)
					GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      				setPedAnimation(playerSource, "POLICE", "plc_drgbst_01", 2300, false, true, false, false, _, true)
      				setTimer(function()
      					setPedArmor(playerSource, 100)
      				end, 2300, 1)
      			else
      				exports._infobox:addNotification(playerSource, "Você já está usando um '"..realName[itemUsed][1].."'", "error")
      			end
      		end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "faca" or itemUsed == "picareta" or itemUsed == "cutelo" or itemUsed == "taco" or itemUsed == "cassetete" or itemUsed == "pa" then
    	if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
    		if not isTimer(acao[playerSource]) then
    			if not arma[playerSource] then
    				setPedAnimation(playerSource, "BUDDY", "buddy_reload", 500, false, true, false, false, _, true)
    				arma[playerSource] = itemUsed
    				giveWeapon(playerSource, weapons[itemUsed][1], 1, true)
    				PlaySound3D(playerSource, "put", 15)
					toggleControl(playerSource, "next_weapon", false)
					toggleControl(playerSource, "previous_weapon", false)
    			else
    				if arma[playerSource] == itemUsed then
    					arma[playerSource] = nil
    					takeWeapon(playerSource, weapons[itemUsed][1])
    					PlaySound3D(playerSource, "put", 15)
						toggleControl(playerSource, "next_weapon", true)
						toggleControl(playerSource, "previous_weapon", true)
    				else
    					exports._infobox:addNotification(playerSource, "Você já está com uma arma em mãos", "error")
    				end
    			end
    		end
    	else
    		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
    	end
    elseif itemUsed == "taser" then
    	if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
    		if not isTimer(acao[playerSource]) then
    			if not arma[playerSource] then
    				arma[playerSource] = itemUsed
    				giveWeapon(playerSource, weapons[itemUsed][1], 30, true)
    				PlaySound3D(playerSource, "pick", 15)
					setPedAnimation(playerSource, "BUDDY", "buddy_reload", 1300, false, true, false, false, _, true)
					toggleControl(playerSource, "next_weapon", false)
					toggleControl(playerSource, "previous_weapon", false)
    			else
    				if arma[playerSource] == itemUsed then
    					arma[playerSource] = nil
    					takeWeapon(playerSource, weapons[itemUsed][1])
    					PlaySound3D(playerSource, "put", 15)
						toggleControl(playerSource, "next_weapon", true)
						toggleControl(playerSource, "previous_weapon", true)
    				else
    					exports._infobox:addNotification(playerSource, "Você já está com uma arma em mãos", "error")
    				end
    			end
    		end
    	else
    		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
    	end
    elseif itemUsed == "glock" or itemUsed == "deagle" or itemUsed == "escopeta" or itemUsed == "tec9" or itemUsed == "mp5" or itemUsed == "ak47" or itemUsed == "m4a1" or itemUsed == "awm" then
    	if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
    		if not isTimer(acao[playerSource]) then
    			if not arma[playerSource] then
    				local ammo = GiveAndTakeAndGetItem("get", playerSource, weapons[itemUsed][2]) or 0
    				if ammo > 0 then
    					giveWeapon(playerSource, weapons[itemUsed][1], ammo + 1, true)
    					GiveAndTakeAndGetItem("take", playerSource, weapons[itemUsed][2], "all")
    				else
    					giveWeapon(playerSource, weapons[itemUsed][1], 1, true)
    				end
    				setControlState(playerSource, "fire", false)
    				setControlState(playerSource, "action", false)
    				PlaySound3D(playerSource, "pick", 15)
    				arma[playerSource] = itemUsed
					setPedAnimation(playerSource, "BUDDY", "buddy_reload", 1300, false, true, false, false, _, true)
					toggleControl(playerSource, "next_weapon", false)
					toggleControl(playerSource, "previous_weapon", false)
    			else
    				if arma[playerSource] == itemUsed then
    					local ammo = getPedTotalAmmo(playerSource, weapons[itemUsed][3]) or 0
    					if ammo > 1 then
    						GiveAndTakeAndGetItem("give", playerSource, weapons[itemUsed][2], ammo - 1)
    					end
    					PlaySound3D(playerSource, "put", 15)
    					takeWeapon(playerSource, weapons[itemUsed][1])
    					arma[playerSource] = nil
						toggleControl(playerSource, "next_weapon", true)
						toggleControl(playerSource, "previous_weapon", true)
    				else
    					exports._infobox:addNotification(playerSource, "Você já está com uma arma em mãos", "error")
    				end
    			end
    		end
    	else
    		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
    	end
	elseif itemUsed == "kit_reparo" or itemUsed == "gasolina" or itemUsed == "pneu" or itemUsed == "lockpick" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			exports._infobox:addNotification(playerSource, "Clique e arraste o '"..realName[itemUsed][1].."' em um veículo próximo de você para usá-lo.", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "algema" or itemUsed == "kitmedico" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			exports._infobox:addNotification(playerSource, "Clique e arraste o '"..realName[itemUsed][1].."' em um jogador próximo de você para usá-lo.", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "chaves" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			exports._infobox:addNotification(playerSource, "Clique e arraste as '"..realName[itemUsed][1].."' em um portão próximo de você para usá-lo.", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "drill" or itemUsed == "dinamite" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			exports._infobox:addNotification(playerSource, "Clique e arraste o '"..realName[itemUsed][1].."' em uma porta próxima de você para usá-lo.", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "pendrive" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			exports._infobox:addNotification(playerSource, "Clique e arraste o '"..realName[itemUsed][1].."' em um painel de controle próximo de você para usá-lo.", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "celular" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			exports._infobox:addNotification(playerSource, "Pressione a tecla 'B' para usar o '"..realName[itemUsed][1].."'", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "dado" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			local random = math.random(1, 4)
			if random ~= 2 then
				local random2 = math.random(1, 6)
				for i, v in pairs(getElementsByType("player")) do
					local x1, y1, z1 = getElementPosition(playerSource)
					local x2, y2, z2 = getElementPosition(v)
					if getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2) <= 10 then
						outputChatBox("[DADO]:#FFFFFF "..random2, v, 30, 144, 255, true)
					end
				end
			else
				exports._infobox:addNotification(playerSource, "O dado caiu longe e você o perdeu", "error")
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
			end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "radinho" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				PlaySound3D(playerSource, "radio-toggle", 15)
				if not getElementData(playerSource, "Radinho") then
					setElementData(playerSource, "Radinho", true)
				else
					setElementData(playerSource, "Radinho", false)
				end
			end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "presente" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
				local random = math.random(1, 6)
				for i, v in ipairs(tablePresente) do
					if i == random then
						if tablePresente[i][1] ~= 5000 and tablePresente[i][1] ~= 20000 then
							GiveAndTakeAndGetItem("give", playerSource, tablePresente[i][1], 1)
							exports._infobox:addNotification(playerSource, "Você abriu o presente VIP e ganhou um '"..realName[tablePresente[i][1]][1].."'", "success")
						else
							givePlayerMoney(playerSource, tablePresente[i][1])
							exports._infobox:addNotification(playerSource, "Você abriu o presente VIP e ganhou $"..tablePresente[i][1], "money")
						end
					end
				end
			end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "capacete" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				acao[playerSource] = setTimer(function() end, 800, 1)
				if isElement(capacete[playerSource]) then
        			setPedAnimation(playerSource, "goggles", "goggles_put_on", 800, false, true, false, false, _, true)
        			setTimer(function()
            			destroyElement(capacete[playerSource])
            			capacete[playerSource] = nil
            			setElementData(playerSource, "Capacete", false)
        			end, 800, 1)
        		else
        			setPedAnimation(playerSource, "goggles", "goggles_put_on", 800, false, true, false, false, _, true)
        			setTimer(function()
        				local x, y, z = getElementPosition(playerSource)
        				capacete[playerSource] = createObject(1937, x, y, z)
        				local dim = getElementDimension(playerSource)
        				local int = getElementInterior(playerSource)
            			setElementInterior(capacete[playerSource], int)
            			setElementDimension(capacete[playerSource], dim)
            			setElementData(playerSource, "Capacete", true)
            			exports.bone_attach:attachElementToBone(capacete[playerSource], playerSource, 1, 0, 0.026, 0, 0, 270, 0)
        			end, 800, 1)
        		end
        	end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "porco" or itemUsed == "criatura" or itemUsed == "capeta" or itemUsed == "caveira" or itemUsed == "macaco" or itemUsed == "cavalo" or itemUsed == "touro" or itemUsed == "sacola" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				acao[playerSource] = setTimer(function() end, 800, 1)
				if isElement(mascara[playerSource]) then
        			setPedAnimation(playerSource, "goggles", "goggles_put_on", 800, false, true, false, false, _, true)
        			setTimer(function()
            			destroyElement(mascara[playerSource])
            			mascara[playerSource] = nil
        			end, 800, 1)
        		else
        			setPedAnimation(playerSource, "goggles", "goggles_put_on", 800, false, true, false, false, _, true)
        			setTimer(function()
        				local x, y, z = getElementPosition(playerSource)
        				mascara[playerSource] = createObject(masks[itemUsed][1], x, y, z +1)
        				local dim = getElementDimension(playerSource)
        				local int = getElementInterior(playerSource)
            			setElementInterior(mascara[playerSource], int)
            			setElementDimension(mascara[playerSource], dim)
            			exports.bone_attach:attachElementToBone(mascara[playerSource], playerSource, 1, -0.003, 0, 1, 0, 0, 90)
        			end, 800, 1)
        		end
        	end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "som" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(som[playerSource]) then
            		destroyElement(som[playerSource])
            		som[playerSource] = nil
        		else
        			setPedAnimation(playerSource, "BUDDY", "buddy_reload", 500, false, true, false, false, _, true)
        			setTimer(function()
        				local x, y, z = getElementPosition(playerSource)
        				som[playerSource] = createObject(2226, x, y, z)
        				local dim = getElementDimension(playerSource)
        				local int = getElementInterior(playerSource)
            			setElementInterior(som[playerSource], int)
            			setElementDimension(som[playerSource], dim)
            			exports.bone_attach:attachElementToBone(som[playerSource], playerSource, 11, 0, 0, 0.4, 180, 0, 180)
            		end, 500, 1)
        		end
        	end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "maleta" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(maleta[playerSource]) then
            		destroyElement(maleta[playerSource])
            		maleta[playerSource] = nil
        		else
        			setPedAnimation(playerSource, "BUDDY", "buddy_reload", 500, false, true, false, false, _, true)
        			setTimer(function()
        				local x, y, z = getElementPosition(playerSource)
        				maleta[playerSource] = createObject(1210, x, y, z)
        				local dim = getElementDimension(playerSource)
        				local int = getElementInterior(playerSource)
            			setElementInterior(maleta[playerSource], int)
            			setElementDimension(maleta[playerSource], dim)
            			exports.bone_attach:attachElementToBone(maleta[playerSource], playerSource, 11, -3.4694469519536e-18, 0.095, 0.3, -6, -184, 0)
            		end, 500, 1)
        		end
        	end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	elseif itemUsed == "flor" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				if isElement(flor[playerSource]) then
            		destroyElement(flor[playerSource])
            		flor[playerSource] = nil
        		else
        			setPedAnimation(playerSource, "BUDDY", "buddy_reload", 500, false, true, false, false, _, true)
        			setTimer(function()
        				local x, y, z = getElementPosition(playerSource)
        				local dim = getElementDimension(playerSource)
        				local int = getElementInterior(playerSource)
            			flor[playerSource] = createObject(325, x, y, z)
            			setElementInterior(flor[playerSource], int)
            			setElementDimension(flor[playerSource], dim)
            			exports.bone_attach:attachElementToBone(flor[playerSource], playerSource, 12, 0, 0, 0, 0, 270, 0)
            		end, 500, 1)
        		end
        	end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "bandagem" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if not isTimer(acao[playerSource]) then
				acao[playerSource] = setTimer(function() end, 5000, 1)
				GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
      			setPedAnimation(playerSource, "BOMBER", "BOM_Plant_Loop", 5000, true, false, false, false, _, true)
            	setTimer(function()
            		local health = getElementHealth(playerSource)
            		setElementHealth(playerSource, health + 20)
            		setPedAnimation(playerSource, nil)
            	end, 5000, 1)
			end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "cigarro" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			if GiveAndTakeAndGetItem("get", playerSource, "isqueiro") >= 1 then
				if not isTimer(acao[playerSource]) then
					if not isElement(cigarro[playerSource]) then
						local x, y, z = getElementPosition(playerSource)
						local int = getElementInterior(playerSource)
						local dim = getElementDimension(playerSource)
						cigarro[playerSource] = createObject(1485, x, y, z)
						setElementInterior(cigarro[playerSource], int)
						setElementDimension(cigarro[playerSource], dim)
						acao[playerSource] = setTimer(function() end, 7000, 1)
						GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
						setPedAnimation(playerSource, "GANGS", "smkcig_prtl", 7000, false, true, false, false, _, true)
						exports.bone_attach:attachElementToBone(cigarro[playerSource], playerSource, 12, -0.03, 0.06, 0.04, 30, -50, -24)
						local random = math.random(1, 10)
						if random == 1 then
							GiveAndTakeAndGetItem("take", playerSource, "isqueiro", 1)
						end
						setTimer(function()
							exports._infobox:addNotification(playerSource, "Pressione 'X' para fumar", "info")
							bindKey(playerSource, "x", "down", fumarCigarro)
							setTimer(function()
								destroyElement(cigarro[playerSource])
								cigarro[playerSource] = nil
								unbindKey(playerSource, "x", "down", fumarCigarro)
							end, 60000*3, 1)
						end, 7000, 1)
					else
						exports._infobox:addNotification(playerSource, "Você já está fumando um cigarro", "error")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você não possui 'Isqueiro' em seu inventario", "error")
			end
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "adrenalina" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			GiveAndTakeAndGetItem("take", playerSource, itemUsed, 1)
			setPedAnimation(playerSource, "BOMBER", "BOM_Plant_Loop", 10000, true, false, false, false, _, true)
			setTimer(function()
				if isTimer(acao[playerSource]) then killTimer(acao[playerSource]) end
				setElementFrozen(playerSource, false)
				setElementHealth(playerSource, 100)
				setPedArmor(playerSource, 100)
				setPedAnimation(playerSource, nil)
				toggleAllControls(playerSource, true)
				if getElementData(playerSource, "Desmaiado") then
					triggerEvent("Desmaiado", root, playerSource, false)
				end
				local name = getPlayerName(playerSource)
				local ID1 = getElementData(playerSource, "ID") or "N/A"
				exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nJogador: "..name.." ["..ID1.."]\nAção: Usou o item 'Injeção de Adrenalina'")
				for _, players in pairs(getElementsByType("player")) do
					if players ~= playerSource then
						local x, y, z = getElementPosition(playerSource)
						local x2, y2, z2 = getElementPosition(players)
						if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 30 then
							local name = getPlayerName(playerSource)
							local id = getElementData(playerSource, "ID") or "N/A"
							outputChatBox("[INFO]:#FFFFFF O jogador "..name.."#FFFFFF ("..id..") usou uma '"..realName[itemUsed][1].."'", players, 30, 144, 255, true)
						end
					end
				end
			end, 10000, 1)
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "identidade" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			local name = getPlayerName(playerSource)
			local id = getElementData(playerSource, "ID") or "N/A"
			exports._infobox:addNotification(playerSource, "[IDENTIDADE]  •  Nome: '"..name.."', Nº: '"..id.."'", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
    elseif itemUsed == "cnh" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			local name = getPlayerName(playerSource)
			local id = getElementData(playerSource, "ID") or "N/A"
			local categoria = getElementData(playerSource, "Hab:Moto") or "Inválido"
			exports._infobox:addNotification(playerSource, "[CNH MOTO]  •  Nome: '"..name.."', Nº: '"..id.."', categoria: '"..categoria.."'", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end






	elseif itemUsed == "cnh2" then
			if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
				local name = getPlayerName(playerSource)
				local id = getElementData(playerSource, "ID") or "N/A"
				local categoria = getElementData(playerSource, "Hab:Carro") or "Inválido"
				exports._infobox:addNotification(playerSource, "[CNH CARRO]  •  Nome: '"..name.."', Nº: '"..id.."',  '"..categoria.."'", "info")
			  else
				  exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
			  end




			elseif itemUsed == "cnh3" then
				if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
					local name = getPlayerName(playerSource)
					local id = getElementData(playerSource, "ID") or "N/A"
					local categoria = getElementData(playerSource, "Hab:Caminhao") or "Inválido"
					exports._infobox:addNotification(playerSource, "[CNH CAMINHÃO]  •  Nome: '"..name.."', Nº: '"..id.."',  '"..categoria.."'", "info")
				  else
					  exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
				  end





				elseif itemUsed == "cnh4" then
					if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
						local name = getPlayerName(playerSource)
						local id = getElementData(playerSource, "ID") or "N/A"
						local categoria = getElementData(playerSource, "Hab:Carreta") or "Inválido"
						exports._infobox:addNotification(playerSource, "[CNH CARRETA]  •  Nome: '"..name.."', Nº: '"..id.."',  '"..categoria.."'", "info")
					  else
						  exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
					  end
	



    elseif itemUsed == "porte" then
		if GiveAndTakeAndGetItem("get", playerSource, itemUsed) >= 1 then
			local name = getPlayerName(playerSource)
			local id = getElementData(playerSource, "ID") or "N/A"
			exports._infobox:addNotification(playerSource, "[PORTE DE ARMA]  •  Nome: '"..name.."', Nº: '"..id.."', situação: 'Válido'", "info")
      	else
      		exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemUsed][1].."' em seu inventario", "error")
      	end
	end
end
addEvent("Use", true)
addEventHandler("Use", resourceRoot, use)
-----------------------------------------------------------------------------------------------------------------------------------------
function trade(tipo, arg2, arg3, arg4)
	if tipo == "make" then --tipo, source, player, tabela
		setElementData(arg3, "Trading", arg4)
		exports._infobox:addNotification(arg3, "Você recebeu uma proposta de venda, abra o inventário para aceitar ou recusar", "info")
		triggerClientEvent(arg3, "refreshTrading", resourceRoot)
	elseif tipo == "accept" then --tipo, source, tabela
		removeElementData(arg2, "Trading")
		if GiveAndTakeAndGetItem("get", arg3[1][1], arg3[2][1]) >= arg3[3][1] then
			if arg3[4][1] > 0 then
				if getPlayerMoney(arg2) >= arg3[4][1] then
					if GiveAndTakeAndGetItem("give", arg2, arg3[2][1], arg3[3][1]) then
						if GiveAndTakeAndGetItem("take", arg3[1][1], arg3[2][1], arg3[3][1]) then
							takePlayerMoney(arg2, arg3[4][1])
							givePlayerMoney(arg3[1][1], arg3[4][1])
							exports._infobox:addNotification(arg2, "Você aceitou a proposta e pagou $"..arg3[4][1], "money")
							exports._infobox:addNotification(arg3[1][1], "O comprador aceitou sua proposta e você recebeu $"..arg3[4][1], "money")
							local name = getPlayerName(arg2)
							local ID1 = getElementData(arg2, "ID") or "N/A"
							local name2 = getPlayerName(arg3[1][1])
							local ID2 = getElementData(arg3[1][1], "ID") or "N/A"
							exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nVendedor: "..name2.." ["..ID2.."]\nComprador: "..name.." ["..ID1.."]\nItem: "..arg3[2][1].."\nQuantidade: "..arg3[3][1].."\nValor: $"..arg3[4][1])
						else
							exports._infobox:addNotification(arg2, "O vendedor não possui o item na sua mochila", "error")
							exports._infobox:addNotification(arg3[1][1], "Você não possui o item em sua mochila", "error")
						end
					else
						exports._infobox:addNotification(arg2, "Você não possui espaço em sua mochila", "error")
						exports._infobox:addNotification(arg3[1][1], "O comprador não possui espaço em sua mochila", "error")
					end
				else
					exports._infobox:addNotification(arg2, "Você não possui dinheiro suficiente", "error")
					exports._infobox:addNotification(arg3[1][1], "O comprador não possui dinheiro suficiente", "error")
				end
			else
				if GiveAndTakeAndGetItem("give", arg2, arg3[2][1], arg3[3][1]) then
					if GiveAndTakeAndGetItem("take", arg3[1][1], arg3[2][1], arg3[3][1]) then
						exports._infobox:addNotification(arg2, "Você aceitou a proposta", "success")
						exports._infobox:addNotification(arg3[1][1], "O comprador aceitou sua proposta", "success")
						local name = getPlayerName(arg2)
						local ID1 = getElementData(arg2, "ID") or "N/A"
						local name2 = getPlayerName(arg3[1][1])
						local ID2 = getElementData(arg3[1][1], "ID") or "N/A"
						exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nVendedor: "..name2.." ["..ID2.."]\nComprador: "..name.." ["..ID1.."]\nItem: "..arg3[2][1].."\nQuantidade: "..arg3[3][1].."\nValor: $0")
					else
						exports._infobox:addNotification(arg2, "O vendedor não possui o item na sua mochila", "error")
						exports._infobox:addNotification(arg3[1][1], "Você não possui o item em sua mochila", "error")
					end
				else
					exports._infobox:addNotification(arg2, "Você não possui espaço em sua mochila", "error")
					exports._infobox:addNotification(arg3[1][1], "O comprador não possui espaço em sua mochila", "error")
				end
			end
		else
			exports._infobox:addNotification(arg2, "O vendedor não possui o item na sua mochila", "error")
			exports._infobox:addNotification(arg3[1][1], "Você não possui o item em sua mochila", "error")
		end
	elseif tipo == "decline" then --tipo, source, tabela
		removeElementData(arg2, "Trading")
		exports._infobox:addNotification(arg2, "Você recusou a proposta", "success")
		exports._infobox:addNotification(arg3[1][1], "O comprador recusou sua proposta", "error")
	elseif tipo == "distance" then --tipo, source, tabela
		removeElementData(arg2, "Trading")
		exports._infobox:addNotification(arg2, "A proposta não pode ser aceita pois você está distante do vendedor", "error")
		exports._infobox:addNotification(arg3[1][1], "A proposta não pode ser aceita pois você está distante do comprador", "error")
	end
end
addEvent("Trade", true)
addEventHandler("Trade", resourceRoot, trade)
-----------------------------------------------------------------------------------------------------------------------------------------
function action(playerSource, clickedWorld, itemActioned)
	if itemActioned == "chaves" and getElementType(clickedWorld) == "object" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isTimer(acao[playerSource]) then
				local x, y, z = getElementPosition(playerSource)
				local ex, ey, ez = getElementPosition(clickedWorld)
				if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 10 then
					for i, v in pairs(gates) do
						if v == clickedWorld then
							if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(GatePositions[i][1])) then
								if GatePositions[i][10] == "closed" then
									moveObject(clickedWorld, GatePositions[i][9], GatePositions[i][6], GatePositions[i][7], GatePositions[i][8])
									GatePositions[i][10] = "opened"
									tempo[clickedWorld] = setTimer(function()
										moveObject(clickedWorld, GatePositions[i][9], GatePositions[i][3], GatePositions[i][4], GatePositions[i][5])
										GatePositions[i][10] = "closed"
									end, 10000, 1)
								elseif GatePositions[i][10] == "opened" then
									moveObject(clickedWorld, GatePositions[i][9], GatePositions[i][3], GatePositions[i][4], GatePositions[i][5])
									GatePositions[i][10] = "closed"
									if isTimer(tempo[clickedWorld]) then
										killTimer(tempo[clickedWorld])
									end
								end
							else
								exports._infobox:addNotification(playerSource, "Você não possui as chaves desse portão", "error")
							end
						end
					end
				else
					exports._infobox:addNotification(playerSource, "Você está muito distante do portão", "error")
				end
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "kit_reparo" and getElementType(clickedWorld) == "vehicle" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 3 then
						local counter = 0
						for seat, player in pairs(getVehicleOccupants(clickedWorld)) do
    						counter = counter + 1
						end
						if counter < 1 then
							if not getElementData(clickedWorld, "Engine") then
								if getElementHealth(clickedWorld) < 1000 then
									if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Mecanico")) then
										acao[playerSource] = setTimer(function() end, 14000, 1)
										if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
										local x, y, z = getElementPosition(playerSource)
										item[playerSource] = createObject(1938, x, y, z - 0.65, 0, 90, 0)
										setElementCollisionsEnabled(item[playerSource], false)
										PlaySound3D(playerSource, "repair", "all")
										GiveAndTakeAndGetItem("take", playerSource, itemActioned, 1)
										triggerClientEvent(playerSource, "progressBar", playerSource, 14000)
										setElementFrozen(playerSource, true)
										setElementFrozen(clickedWorld, true)
										local _, _, rot = getElementRotation(playerSource)
										setElementRotation(playerSource, _, _, rot + 180)
										setPedAnimation(playerSource, "CAR", "fixn_car_loop", 14000, true, false, false, false, _, true)
										setTimer(function()
											destroyElement(item[playerSource])
											item[playerSource] = nil
											fixVehicle(clickedWorld)
											setVehicleDamageProof(clickedWorld, false)
											setElementFrozen(clickedWorld, false)
											setElementFrozen(playerSource, false)
											local exp = math.random(expRepair1, expRepair2)
											if getElementData(playerSource, "VIP") then
												local xp = (exp + (exp/4))
												triggerEvent("GiveExp", playerSource, playerSource, xp)
											else
												triggerEvent("GiveExp", playerSource, playerSource, exp)
											end
											exports._infobox:addNotification(playerSource, "Você reparou o veículo", "success")
										end, 14000, 1)
									end
								else
									exports._infobox:addNotification(playerSource, "O veículo não possui nenhum dano para ser reparado", "error")
								end
							else
								exports._infobox:addNotification(playerSource, "O veículo precisa estar desligado para ser reparado", "error")
							end
						else
							exports._infobox:addNotification(playerSource, "O veículo precisa estar vazio para ser reparado", "error")
						end
					else
						exports._infobox:addNotification(playerSource, "Você está muito distante do veículo", "error")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar o '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "pneu" and getElementType(clickedWorld) == "vehicle" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 3 then
						local counter = 0
						for seat, player in pairs(getVehicleOccupants(clickedWorld)) do
    						counter = counter + 1
						end
						if counter < 1 then
							if not getElementData(clickedWorld, "Engine") then
								local r1, r2, r3, r4 = getVehicleWheelStates(clickedWorld)
								if r1 ~= 0 or r2 ~= 0 or r3 ~= 0 or r4 ~= 0 then
									if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Mecanico")) then
										acao[playerSource] = setTimer(function() end, 14000, 1)
										if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
										local x, y, z = getElementPosition(playerSource)
										item[playerSource] = createObject(1025, x, y, z - 0.85, 0, 90, 0)
										setObjectScale(item[playerSource], 0.8)
										setElementCollisionsEnabled(item[playerSource], false)
										PlaySound3D(playerSource, "repair", 100)
										GiveAndTakeAndGetItem("take", playerSource, itemActioned, 1)
										triggerClientEvent(playerSource, "progressBar", playerSource, 14000)
										setElementFrozen(playerSource, true)
										setElementFrozen(clickedWorld, true)
										local _, _, rot = getElementRotation(playerSource)
										setElementRotation(playerSource, _, _, rot + 180)
										setPedAnimation(playerSource, "CAR", "fixn_car_loop", 14000, true, false, false, false, _, true)
										setTimer(function()
											destroyElement(item[playerSource])
											item[playerSource] = nil
											setVehicleWheelStates(clickedWorld, 0, 0, 0, 0)
											setElementFrozen(clickedWorld, false)
											setElementFrozen(playerSource, false)
											local exp = math.random(expPneu1, expPneu2)
											if getElementData(playerSource, "VIP") then
												local xp = (exp + (exp/4))
												triggerEvent("GiveExp", playerSource, playerSource, xp)
											else
												triggerEvent("GiveExp", playerSource, playerSource, exp)
											end
											exports._infobox:addNotification(playerSource, "Você trocou os pneus do veículo", "success")
										end, 14000, 1)
									end
								else
									exports._infobox:addNotification(playerSource, "O veículo não possui nenhum pneu furado", "error")
								end
							else
								exports._infobox:addNotification(playerSource, "O veículo precisa estar desligado para ter seu pneu trocado", "error")
							end
						else
							exports._infobox:addNotification(playerSource, "O veículo precisa estar vazio para ter seu pneu trocado", "error")
						end
					else
						exports._infobox:addNotification(playerSource, "Você está muito distante do veículo", "error")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar o '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "gasolina" and getElementType(clickedWorld) == "vehicle" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 3 then
						local counter = 0
						for seat, player in pairs(getVehicleOccupants(clickedWorld)) do
    						counter = counter + 1
						end
						if counter < 1 then
							if not getElementData(clickedWorld, "Engine") then
								local gas = getElementData(clickedWorld, "Gasolina") or 0
								if gas < 100 then
									acao[playerSource] = setTimer(function() end, 15000, 1)
									if isElement(item[playerSource]) then destroyElement(item[playerSource]) item[playerSource] = nil end
									local x, y, z = getElementPosition(playerSource)
									item[playerSource] = createObject(1650, x, y, z)
									GiveAndTakeAndGetItem("take", playerSource, itemActioned, 1)
									triggerClientEvent(playerSource, "progressBar", playerSource, 15000)
									setElementFrozen(playerSource, true)
									setElementFrozen(clickedWorld, true)
									setPedAnimation(playerSource, "CASINO", "Slot_Plyr", -1, true, false, false, false)
									setTimer(setPedAnimationSpeed, 700, 1, playerSource, "Slot_Plyr", 0)
									exports.bone_attach:attachElementToBone(item[playerSource], playerSource, 12, -0.01, 0.15, 0.05, -48, 62, 140)
									setTimer(function()
										setPedAnimation(playerSource, nil)
										destroyElement(item[playerSource])
										item[playerSource] = nil
										setElementData(clickedWorld, "Gasolina", 100)
										setElementFrozen(clickedWorld, false)
										setElementFrozen(playerSource, false)
										exports._infobox:addNotification(playerSource, "Você encheu o tanque do veículo", "success")
									end, 15000, 1)
								else
									exports._infobox:addNotification(playerSource, "O veículo já está com o tanque cheio", "error")
								end
							else
								exports._infobox:addNotification(playerSource, "O veículo precisa estar desligado para ser abastecido", "error")
							end
						else
							exports._infobox:addNotification(playerSource, "O veículo precisa estar vazio para ser abastecido", "error")
						end
					else
						exports._infobox:addNotification(playerSource, "Você está muito distante do veículo", "error")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar o '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "algema" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(ACL_PM)) then
							if not algemado[clickedWorld] then
								if isElement(item[clickedWorld]) then destroyElement(item[clickedWorld]) item[clickedWorld] = nil end
								local x, y, z = getElementPosition(clickedWorld)
								item[clickedWorld] = createObject(331, x, y, z)
								setObjectScale(item[clickedWorld], 1.2)
								acao[clickedWorld] = setTimer(function() end, 60000*30, 1)
								GiveAndTakeAndGetItem("take", playerSource, itemActioned, 1)
								GiveAndTakeAndGetItem("give", playerSource, "chaves", 1)
								setPedAnimation(playerSource, "CASINO", "dealone", 1000, true, false, false, false, _, true)
								setPedAnimation(clickedWorld, "GANGS","prtial_gngtlkA", 1, false, false, false, true, _, true)
								setTimer(function()
									setPedAnimationSpeed(clickedWorld, "prtial_gngtlkA", 0)
									setTimer(function()
										setPedAnimationProgress(clickedWorld, "prtial_gngtlkA", 0.2)
									end, 500, 1)
								end, 800, 1)
								toggleControl(clickedWorld, "sprint", false)
								toggleControl(clickedWorld, "walk", false)
								toggleControl(clickedWorld, "jump", false)
								toggleControl(clickedWorld, "fire", false)
								toggleControl(clickedWorld, "action", false)
								toggleControl(clickedWorld, "crouch", false)
								toggleControl(clickedWorld, "aim_weapon", false)
								toggleControl(clickedWorld, "enter_exit", false)
								setControlState(clickedWorld, "walk", true)
								algemado[clickedWorld] = playerSource
								algemando[playerSource] = clickedWorld
								exports._infobox:addNotification(playerSource, "Você algemou o criminoso. Use as chaves para soltá-lo novamente", "success")
								exports._infobox:addNotification(clickedWorld, "Você foi algemado pelo policial "..getPlayerName(playerSource), "warning")
								exports.bone_attach:attachElementToBone(item[clickedWorld], clickedWorld, 12, 0.09, 0.03, 0.14, -30, 126, -86)
								timerAlgema[clickedWorld] = setTimer(function()
									setPedAnimation(clickedWorld, "GANGS","prtial_gngtlkA", 1, false, false, false, true, _, true)
									setPedAnimationSpeed(clickedWorld, "prtial_gngtlkA", 0)
									setPedAnimationProgress(clickedWorld, "prtial_gngtlkA", 0.2)
								end, 500, 0)
							else
								exports._infobox:addNotification(playerSource, "Seu alvo já está algemado", "error")
							end
						end
					else
						exports._infobox:addNotification(playerSource, "Você está muito distante do seu alvo", "error")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar a '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "chaves" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						if algemado[clickedWorld] then
							if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(ACL_PM)) then
								if isElement(item[clickedWorld]) then destroyElement(item[clickedWorld]) item[clickedWorld] = nil end
								if isTimer(acao[clickedWorld]) then killTimer(acao[clickedWorld]) end
								if isTimer(timerAlgema[clickedWorld]) then killTimer(timerAlgema[clickedWorld]) timerAlgema[clickedWorld] = nil end
								GiveAndTakeAndGetItem("take", playerSource, itemActioned, 1)
								GiveAndTakeAndGetItem("give", playerSource, "algema", 1)
								setPedAnimation(clickedWorld, "CASINO", "dealone", -1, false)
								setTimer(setPedAnimation, 50, 1, clickedWorld, nil)
								toggleAllControls(clickedWorld, true)
								setControlState(clickedWorld, "walk", false)
								exports._infobox:addNotification(playerSource, "Você tirou as algemas do criminoso", "success")
								exports._infobox:addNotification(clickedWorld, "O policial "..getPlayerName(playerSource).."#FFFFFF removeu suas algemas", "info")
								local pm = algemado[clickedWorld]
								algemando[pm] = nil
								algemado[clickedWorld] = nil
							end
						end
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar as '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "kitmedico" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) and not isPedInVehicle(clickedWorld) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						if getElementData(clickedWorld, "Desmaiado") then
							if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("SAMU")) then
								acao[playerSource] = setTimer(function() end, 20000, 1)
								setElementFrozen(playerSource, true)
								GiveAndTakeAndGetItem("take", playerSource, itemActioned, 1)
								setPedAnimation(playerSource, "MEDIC", "CPR", 20000, true, false, false, false, _, true)
								triggerClientEvent(playerSource, "progressBar", playerSource, 20000)
								setTimer(function()
									triggerEvent("Desmaiado", root, clickedWorld, false)
									setElementFrozen(playerSource, false)
									if isTimer(acao[clickedWorld]) then killTimer(acao[clickedWorld]) end
									exports._infobox:addNotification(playerSource, "Você reanimou o cidadão(ã) "..getPlayerName(clickedWorld), "success")
									exports._infobox:addNotification(clickedWorld, "Você foi re-animado pelo(a) socorrista do SAMU", "info")
									local name = getPlayerName(playerSource)
									local ID1 = getElementData(playerSource, "ID") or "N/A"
									local name2 = getPlayerName(clickedWorld)
									local ID2 = getElementData(clickedWorld, "ID") or "N/A"
									exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nSAMU: "..name.." ["..ID1.."]\nPaciente: "..name2.." ["..ID2.."]")
									if curado[playerSource] ~= clickedWorld then
										local money = math.random(moneySamu1, moneySamu2)
										givePlayerMoney(playerSource, money)
										exports._infobox:addNotification(playerSource, "Você recebeu "..money.." reais", "money")
										local exp = math.random(expSamu1, expSamu2)
										if getElementData(playerSource, "VIP") then
											local xp = (exp + (exp/4))
											triggerEvent("GiveExp", playerSource, playerSource, xp)
										else
											triggerEvent("GiveExp", playerSource, playerSource, exp)
										end
									end
									curado[playerSource] = clickedWorld
								end, 20000, 1)
							end
						else
							exports._infobox:addNotification(playerSource, "Este cidadão(ã) não está precisando de socorros", "error")
						end
					else
						exports._infobox:addNotification(playerSource, "Você está muito distante do cidadão(ã) indicado", "error")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar o '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "lockpick" and getElementType(clickedWorld) == "vehicle" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 2.5 then
						local counter = 0
						for seat, player in pairs(getVehicleOccupants(clickedWorld)) do
    						counter = counter + 1
						end
						if counter < 1 then
							if getElementData(clickedWorld, "Locked") then
								acao[playerSource] = setTimer(function() end, 90000, 1)
								GiveAndTakeAndGetItem("take", playerSource, itemActioned, 1)
								PlaySound3D(playerSource, "vehicle-alarm", "all")
								setElementFrozen(playerSource, true)
								setElementFrozen(clickedWorld, true)
								setPedAnimation(playerSource, "CAMERA", "piccrch_take", 90000, true, false, false, false, _, true)
								triggerClientEvent(playerSource, "progressBar", playerSource, 90000)
								blip[clickedWorld] = createBlipAttachedTo(clickedWorld, 36)
								setElementVisibleTo(blip[clickedWorld], root, false)
								for _, players in pairs(getElementsByType("player")) do
									if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(players)), aclGetGroup(ACL_PM)) then
										exports._infobox:addNotification(players, "[COPOM]: Denúncia de furto de veículo em andamento, o local da ocorrência foi indicado no seu GPS", "warning")
										setElementVisibleTo(blip[clickedWorld], players, true)
									end
								end
								setTimer(function()
									setPedAnimation(playerSource, nil)
									setElementFrozen(playerSource, false)
									setElementFrozen(clickedWorld, false)
									destroyElement(blip[clickedWorld])
									blip[clickedWorld] = nil
									local random = math.random(1, 2)
									if random == 1 then
										setElementData(clickedWorld, "Locked", false)
										setVehicleLocked(clickedWorld, false)
										exports._infobox:addNotification(playerSource, "Você conseguiu mixar o veículo", "success")
										local name = getPlayerName(playerSource)
										local ID1 = getElementData(playerSource, "ID") or "N/A"
										local model = getElementModel(clickedWorld)
										exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nCriminoso: "..name.." ["..ID1.."]\nVeículo: "..model)
									else
										exports._infobox:addNotification(playerSource, "Você não conseguiu mixar o veículo", "error")
									end
								end, 90000, 1)
							else
								exports._infobox:addNotification(playerSource, "Este veículo já está aberto", "error")
							end
						else
							exports._infobox:addNotification(playerSource, "O veículo precisa estar vazio para ser mixado", "error")
						end
					else
						exports._infobox:addNotification(playerSource, "Você está muito distante do veículo", "error")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar o '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "porte" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						local name = getPlayerName(playerSource)
						local id = getElementData(playerSource, "ID") or "N/A"
						exports._infobox:addNotification(clickedWorld, "[PORTE DE ARMA]  •  Nome: '"..name.."', Nº: '"..id.."', situação: 'Válido'", "info")
						exports._infobox:addNotification(playerSource, "Você mostrou seu '"..realName[itemActioned][1].."' para o(a) "..getPlayerName(clickedWorld), "success")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para mostrar seu '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "cnh" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						local name = getPlayerName(playerSource)
						local id = getElementData(playerSource, "ID") or "N/A"
						local categoria = getElementData(playerSource, "Hab:Moto") or "Inválido"
						exports._infobox:addNotification(clickedWorld, "[CNH MOTO]  •  Nome: '"..name.."', Nº: '"..id.."', categoria: '"..categoria.."'", "info")
						exports._infobox:addNotification(playerSource, "Você mostrou sua '"..realName[itemActioned][1].."' para o(a) "..getPlayerName(clickedWorld), "success")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para mostrar sua '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
		
















	elseif itemActioned == "cnh2" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						local name = getPlayerName(playerSource)
						local id = getElementData(playerSource, "ID") or "N/A"
						local categoria = getElementData(playerSource, "Hab:Carro") or "Inválido"
						exports._infobox:addNotification(clickedWorld, "[CNH CARRO]  •  Nome: '"..name.."', Nº: '"..id.."', categoria: '"..categoria.."'", "info")
						exports._infobox:addNotification(playerSource, "Você mostrou sua '"..realName[itemActioned][1].."' para o(a) "..getPlayerName(clickedWorld), "success")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para mostrar sua '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end










	elseif itemActioned == "cnh3" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						local name = getPlayerName(playerSource)
						local id = getElementData(playerSource, "ID") or "N/A"
						local categoria = getElementData(playerSource, "Hab:Caminhao") or "Inválido"
						exports._infobox:addNotification(clickedWorld, "[CNH CAMINHÃO]  •  Nome: '"..name.."', Nº: '"..id.."', categoria: '"..categoria.."'", "info")
						exports._infobox:addNotification(playerSource, "Você mostrou sua '"..realName[itemActioned][1].."' para o(a) "..getPlayerName(clickedWorld), "success")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para mostrar sua '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end








	elseif itemActioned == "cnh4" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						local name = getPlayerName(playerSource)
						local id = getElementData(playerSource, "ID") or "N/A"
						local categoria = getElementData(playerSource, "Hab:Carreta") or "Inválido"
						exports._infobox:addNotification(clickedWorld, "[CNH Carreta]  •  Nome: '"..name.."', Nº: '"..id.."', categoria: '"..categoria.."'", "info")
						exports._infobox:addNotification(playerSource, "Você mostrou sua '"..realName[itemActioned][1].."' para o(a) "..getPlayerName(clickedWorld), "success")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para mostrar sua '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
















	elseif itemActioned == "identidade" and getElementType(clickedWorld) == "player" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						local name = getPlayerName(playerSource)
						local id = getElementData(playerSource, "ID") or "N/A"
						local wanted = getPlayerWantedLevel(playerSource)
						exports._infobox:addNotification(clickedWorld, "[IDENTIDADE]  •  Nome: '"..name.."', Nº: '"..id.."', Mandados de prisão: '"..wanted.."'", "info")
						exports._infobox:addNotification(playerSource, "Você mostrou sua '"..realName[itemActioned][1].."' para o(a) "..getPlayerName(clickedWorld), "success")
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para mostrar sua '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "dinamite" and getElementType(clickedWorld) == "object" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						if getElementData(clickedWorld, "Bank:Gate1") then
							triggerEvent("Banco:Iniciar", root, playerSource)
						end
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "pendrive" and getElementType(clickedWorld) == "object" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						if getElementData(clickedWorld, "Bank:Pass") then
							triggerEvent("Banco:Hackear", root, playerSource)
						end
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	elseif itemActioned == "drill" and getElementType(clickedWorld) == "object" then
		if GiveAndTakeAndGetItem("get", playerSource, itemActioned) >= 1 then
			if not isPedInVehicle(playerSource) then
				if not isTimer(acao[playerSource]) then
					local x, y, z = getElementPosition(playerSource)
					local ex, ey, ez = getElementPosition(clickedWorld)
					if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
						if getElementData(clickedWorld, "Bank:Gate3") then
							triggerEvent("Banco:Furadeira", root, playerSource)
						end
					end
				end
			else
				exports._infobox:addNotification(playerSource, "Você precisa estar fora de um veículo para usar '"..realName[itemActioned][1].."'", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui '"..realName[itemActioned][1].."' em seu inventario", "error")
		end
	end
end
addEvent("Action", true)
addEventHandler("Action", resourceRoot, action)
-----------------------------------------------------------------------------------------------------------------------------------------
function trash(playerSource, item, qntd)
	if GiveAndTakeAndGetItem("get", playerSource, item) >= qntd then
		if not isPedInVehicle(playerSource) then
			if not isTimer(acao[playerSource]) then
				acao[playerSource] = setTimer(function() end, 1300, 1)
				setPedAnimation(playerSource, "POLICE", "CopTraf_Away", 1300, true, false, false, false, _, true)
				setTimer(function()
					PlaySound3D(playerSource, "trash", 20)
					GiveAndTakeAndGetItem("take", playerSource, item, qntd)
					exports._infobox:addNotification(playerSource, "Você descartou "..qntd.."x '"..realName[item][1].."'", "success")
					local name = getPlayerName(playerSource)
					local id = getElementData(playerSource, "ID") or "N/A"
					exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nJogador: "..name.." ["..id.."]\nItem: "..item.."\nQuantidade: "..qntd.."\nAção: Descarte lixo")
					for _, players in pairs(getElementsByType("player")) do
						if players ~= playerSource then
							local x, y, z = getElementPosition(playerSource)
							local x2, y2, z2 = getElementPosition(players)
							if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 30 then
								local name = getPlayerName(playerSource)
								local id = getElementData(playerSource, "ID") or "N/A"
								outputChatBox("[INFO]:#FFFFFF O jogador #FFFF00"..name.."#FFFFFF ("..id..") descartou "..qntd.."x '"..realName[item][1].."' em uma lixeira próxima de você.", players, 30, 144, 255, true)
							end
						end
					end
				end, 1300, 1)
			end
		end
	else
		exports._infobox:addNotification(playerSource, "Você não possui a quantidade indicada deste item", "error")
	end
end
addEvent("Trash", true)
addEventHandler("Trash", resourceRoot, trash)
-----------------------------------------------------------------------------------------------------------------------------------------
function box(estado, playerSource, gang, item, qntd)
	if estado == "guardar" then
		for i, v in pairs(BoxPositions) do
			if BoxPositions[i][1] == gang then
				if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(BoxPositions[i][2])) then
					if GiveAndTakeAndGetItem("get", playerSource, item) >= qntd then
						if not isPedInVehicle(playerSource) then
							if not isTimer(acao[playerSource]) then
								acao[playerSource] = setTimer(function() end, 1300, 1)
								setPedAnimation(playerSource, "POLICE", "CopTraf_Away", 1300, true, false, false, false, _, true)
								setTimer(function()
									PlaySound3D(playerSource, "trash", 20)
									GiveAndTakeAndGetItem("take", playerSource, item, qntd)
									exports._infobox:addNotification(playerSource, "Você guardou "..qntd.."x '"..realName[item][1].."'", "success")
									local name = getPlayerName(playerSource)
									local id = getElementData(playerSource, "ID") or "N/A"
									exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nJogador: "..name.." ["..id.."]\nItem: "..item.."\nQuantidade: "..qntd.."\nBaú: "..gang.."\nAção: "..estado)
									for _, players in pairs(getElementsByType("player")) do
										if players ~= playerSource then
											local x, y, z = getElementPosition(playerSource)
											local x2, y2, z2 = getElementPosition(players)
											if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 30 then
												local name = getPlayerName(playerSource)
												local id = getElementData(playerSource, "ID") or "N/A"
												outputChatBox("[INFO]:#FFFFFF O jogador #FFFF00"..name.."#FFFFFF ("..id..") guardou "..qntd.."x '"..realName[item][1].."' em um baú próximo de você.", players, 30, 144, 255, true)
											end
										end
									end
									if bau[gang][item] then
										bau[gang][item][1] = bau[gang][item][1] + tonumber(qntd)
									else
										bau[gang][item] = {}
										bau[gang][item][1] = tonumber(qntd)
									end
								end, 1300, 1)
							end
						end
					else
						exports._infobox:addNotification(playerSource, "Você não possui a quantidade indicada deste item", "error")
					end
				end
			end
		end
	elseif estado == "pegar" then
		for i, v in pairs(BoxPositions) do
			if BoxPositions[i][1] == gang then
				if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(BoxPositions[i][2])) then
					if bau[gang][item] then
						if bau[gang][item][1] >= qntd then
							if GiveAndTakeAndGetItem("give", playerSource, item, qntd) then
								bau[gang][item][1] = bau[gang][item][1] - qntd
								if bau[gang][item][1] <= 0 then
									bau[gang][item] = nil
								end
								exports._infobox:addNotification(playerSource, "Você pegou "..qntd.."x '"..realName[item][1].."'", "success")
								local name = getPlayerName(playerSource)
								local id = getElementData(playerSource, "ID") or "N/A"
								exports["[MOD]Logs"]:CreateLog("[INVENTARIO]\nJogador: "..name.." ["..id.."]\nItem: "..item.."\nQuantidade: "..qntd.."\nBaú: "..gang.."\nAção: "..estado)
								for _, players in pairs(getElementsByType("player")) do
									if players ~= playerSource then
										local x, y, z = getElementPosition(playerSource)
										local x2, y2, z2 = getElementPosition(players)
										if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 30 then
											local name = getPlayerName(playerSource)
											local id = getElementData(playerSource, "ID") or "N/A"
											outputChatBox("[INFO]:#FFFFFF O jogador #FFFF00"..name.."#FFFFFF ("..id..") pegou "..qntd.."x '"..realName[item][1].."' de um baú próximo à você.", players, 30, 144, 255, true)
										end
									end
								end
							else
								exports._infobox:addNotification(playerSource, "Você não possui capacidade na mochila para pegar este item", "error")
							end
						else
							exports._infobox:addNotification(playerSource, "O baú não possui a quantidade indicada deste item", "error")
						end
					else
						exports._infobox:addNotification(playerSource, "O baú não possui este item", "error")
					end
				end
			end
		end
	end
end
addEvent("Box", true)
addEventHandler("Box", resourceRoot, box)
-----------------------------------------------------------------------------------------------------------------------------------------
function click(button, state, playerSource)
	if button == "left" and state == "down" then
        if getElementType(source) == "object" then
        	if getElementModel(source) == 1227 then
        	    for i, v in pairs(boxes) do
        	        if v == source then
        	            local x, y, z = getElementPosition(playerSource)
        	            local ex, ey, ez = getElementPosition(source)
        	            if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 1.5 then
        	            	if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(BoxPositions[i][2])) then
        	            		local gangBox = BoxPositions[i][1]
        	                	triggerClientEvent(playerSource, "RenderBox", resourceRoot, bau[gangBox], gangBox)
        	                end
        	            end
        	        end
        	    end
        	end
        end
    end
end
addEventHandler("onElementClicked", root, click)
-----------------------------------------------------------------------------------------------------------------------------------------
function fumarCigarro(source)
	if isElement(cigarro[source]) then
		if not isTimer(acao[source]) then
			acao[source] = setTimer(function() end, 7000, 1)
			setPedAnimation(source, "GANGS", "smkcig_prtl", 7000, false, true, false, false, _, true)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function onLogin(_, account)
	if not isGuestAccount(account) then
		timerStart[source] = setTimer(function(source)
			inventario[source] = {}
			if getAccountData(account, "Inventario") then
				local itens = fromJSON(getAccountData(account, "Inventario"))
				for index, value in pairs(itens) do
					if realName[itens[index][1]] then
						table.insert(inventario[source], value)
					end
				end
			end
			triggerClientEvent(source, "refresh", resourceRoot, inventario[source])
		end, 10000, 1, source)
	end
end
addEventHandler("onPlayerLogin", root, onLogin)
-----------------------------------------------------------------------------------------------------------------------------------------
function onQuit()
	local account = getPlayerAccount(source)
	if not isGuestAccount(account) then
		if not isTimer(timerStart[source]) then
			local itens = toJSON(inventario[source])
			setAccountData(account, "Inventario", itens)
			takeAllWeapons(source)
			acao[source] = nil
			arma[source] = nil
			algemado[source] = nil
			algemando[source] = nil
			curado[source] = nil
			inventario[source] = nil
			if isTimer(timerAlgema[source]) then killTimer(timerAlgema[source]) timerAlgema[source] = nil end
			if isElement(item[source]) then destroyElement(item[source]) item[source] = nil end
			if isElement(capacete[source]) then destroyElement(capacete[source]) capacete[source] = nil setElementData(source, "Capacete", false) end
			if isElement(mascara[source]) then destroyElement(mascara[source]) mascara[source] = nil end
			if isElement(maleta[source]) then destroyElement(maleta[source]) maleta[source] = nil end
			if isElement(som[source]) then destroyElement(som[source]) som[source] = nil end
			if isElement(flor[source]) then destroyElement(flor[source]) flor[source] = nil end
			if isElement(cigarro[source]) then destroyElement(cigarro[source]) cigarro[source] = nil end
			if isElement(item[source]) then destroyElement(item[source]) item[source] = nil end
			if isElement(item[source]) then destroyElement(item[source]) item[source] = nil end
			if isElement(item[source]) then destroyElement(item[source]) item[source] = nil end
		end
	end
end
addEventHandler("onPlayerQuit", root, onQuit)
-----------------------------------------------------------------------------------------------------------------------------------------
function onStart()
	for i, players in pairs(getElementsByType("player")) do
		timerStart[players] = setTimer(function()
			local account = getPlayerAccount(players)
			if not isGuestAccount(account) then
				inventario[players] = {}
				if getAccountData(account, "Inventario") then
					local itens = fromJSON(getAccountData(account, "Inventario"))
					for index, value in pairs(itens) do
						if realName[itens[index][1]] then
							table.insert(inventario[players], value)
						end
					end
				end
				triggerClientEvent(players, "refresh", resourceRoot, inventario[players])
			end
		end, 10000, 1)
	end
	for i, v in pairs(bau) do
		local data = executeSQLQuery("SELECT * FROM Baú WHERE gang = ?", i)
		if data and type(data) == "table" and #data ~= 0 then
			data[1].valor = fromJSON(data[1].valor)
			for index, value in pairs(data[1].valor) do
				bau[i][index] = {}
				bau[i][index][1] = data[1].valor[index][1]
			end
		end
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onStart)
-----------------------------------------------------------------------------------------------------------------------------------------
function onStop()
	for i, players in pairs(getElementsByType("player")) do
		local account = getPlayerAccount(players)
		if not isGuestAccount(account) then
			if not isTimer(timerStart[players]) then
				local itens = toJSON(inventario[players])
				setAccountData(account, "Inventario", itens)
			end
		end
	end
	executeSQLQuery("CREATE TABLE IF NOT EXISTS Baú (gang TEXT, valor TEXT)")
	for i, v in pairs(bau) do
		executeSQLQuery("DELETE FROM Baú WHERE gang = ?", i)
		executeSQLQuery("INSERT INTO Baú (gang, valor) VALUES (?, ?)", i, toJSON(bau[i]))
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onStop)
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function Refresh(playerSource)
	local int = getElementInterior(playerSource)
	local dim = getElementDimension(playerSource)
	if isElement(item[playerSource]) then
		setElementInterior(item[playerSource], int)
		setElementDimension(item[playerSource], dim)
	end
	if isElement(capacete[playerSource]) then
		setElementInterior(capacete[playerSource], int)
		setElementDimension(capacete[playerSource], dim)
	end
	if isElement(mascara[playerSource]) then
		setElementInterior(mascara[playerSource], int)
		setElementDimension(mascara[playerSource], dim)
	end
	if isElement(maleta[playerSource]) then
		setElementInterior(maleta[playerSource], int)
		setElementDimension(maleta[playerSource], dim)
	end
	if isElement(som[playerSource]) then
		setElementInterior(som[playerSource], int)
		setElementDimension(som[playerSource], dim)
	end
	if isElement(flor[playerSource]) then
		setElementInterior(flor[playerSource], int)
		setElementDimension(flor[playerSource], dim)
	end
	if isElement(cigarro[playerSource]) then
		setElementInterior(cigarro[playerSource], int)
		setElementDimension(cigarro[playerSource], dim)
	end
end
addEvent("RefreshBoneAttach", true)
addEventHandler("RefreshBoneAttach", root, Refresh)
-----------------------------------------------------------------------------------------------------------------------------------------
function PlaySound3D(playerSource, som, distance)
	if distance == "all" then
		triggerClientEvent(root, "playSound", resourceRoot, som, playerSource)
	else
		for i, players in pairs(getElementsByType("player")) do
			local x, y, z = getElementPosition(playerSource)
			local ex, ey, ez = getElementPosition(players)
			if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= distance then
				triggerClientEvent(players, "playSound", resourceRoot, som, playerSource)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
function onWasted()
	if not getElementData(source, "Staff") then
		for index = #inventario[source], 1, -1 do
			local item = inventario[source][index][1]
			if not itensCantRemoved[item] then
				GiveAndTakeAndGetItem("take", source, item, "all")
			end
		end
	end
	takeAllWeapons(source)
	curado[source] = nil
	acao[source] = nil
	arma[source] = nil
	if isElement(cigarro[source]) then
		destroyElement(cigarro[source])
		cigarro[source] = nil
		unbindKey(source, "x", "down", fumarCigarro)
	end
	if algemado[source] then
		destroyElement(item[source])
		item[source] = nil
		killTimer(timerAlgema[source])
		timerAlgema[source] = nil
		setControlState(source, "walk", false)
	end
	if algemando[source] then
		algemando[source] = nil
	end
end
addEventHandler("onPlayerWasted", root, onWasted)
-----------------------------------------------------------------------------------------------------------------------------------------
function removeItem(playerSource, item)
	if item == "radinho" then
		setElementData(playerSource, "Radinho", false)
	elseif item == "porco" or item == "criatura" or item == "capeta" or item == "caveira" or item == "macaco" or item == "cavalo" or item == "touro" or item == "sacola" then
		destroyElement(mascara[playerSource])
		mascara[playerSource] = nil
	elseif item == "maleta" then
		destroyElement(maleta[playerSource])
		maleta[playerSource] = nil
	elseif item == "capacete" then
		destroyElement(capacete[playerSource])
		capacete[playerSource] = nil
		setElementData(playerSource, "Capacete", false)
	elseif item == "som" then
		destroyElement(som[playerSource])
		som[playerSource] = nil
	elseif item == "flor" then
		destroyElement(flor[playerSource])
		flor[playerSource] = nil
	else
		if arma[playerSource] == item then
    		local ammo = getPedTotalAmmo(playerSource, weapons[item][3]) or 0
    		if ammo > 1 then
    			GiveAndTakeAndGetItem("give", playerSource, weapons[item][2], ammo - 1)
    		end
			arma[playerSource] = nil
			takeWeapon(playerSource, weapons[item][1])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------