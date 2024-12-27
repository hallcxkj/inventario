--  ____    ______   _____  
-- |  _ \  |  ____| |  __ \ 
-- | |_) | | |__    | |__) |
-- |  _ <  |  __|   |  _  / 
-- | |_) | | |____  | | \ \ 
-- |____/  |______| |_|  \_\
-----------------------------------------------------------------------------------------------------------------------------------------
function Buy(playerSource, selecionado, shop, quantidade)
	local item = nil
	local valor = 0
	if shop == "food" then
		item = FoodShopItems[selecionado][1]
		valor = (FoodShopItems[selecionado][2] * quantidade)
	elseif shop == "guns" then
		item = GunShopItems[selecionado][1]
		valor = (GunShopItems[selecionado][2] * quantidade)
	elseif shop == "utility" then
		item = UtilityShopItems[selecionado][1]
		valor = (UtilityShopItems[selecionado][2] * quantidade)
		

	elseif shop == "utility2" then
		item = UtilityShopItems2[selecionado][1]
		valor = (UtilityShopItems2[selecionado][2] * quantidade)


	elseif shop == "bar" then
		item = BarShopItems[selecionado][1]
		valor = (BarShopItems[selecionado][2] * quantidade)
	elseif shop == "ilegal" then
		item = IlegalShopItems[selecionado][1]
		valor = (IlegalShopItems[selecionado][2] * quantidade)
	elseif shop == "ferramentas" then
		item = FerramentasShopItems[selecionado][1]
		valor = (FerramentasShopItems[selecionado][2] * quantidade)
	end
	if shop == "guns" then
		if GunShopItems[selecionado][3] then
			if GiveAndTakeAndGetItem("get", playerSource, "porte") >= 1 then
				if getPlayerMoney(playerSource) >= valor then
					if GiveAndTakeAndGetItem("give", playerSource, item, quantidade) then
						takePlayerMoney(playerSource, valor)
						exports._infobox:addNotification(playerSource, "Você comprou "..quantidade.."x "..realName[item][1].." por $"..valor, "money")
					else
						exports._infobox:addNotification(playerSource, "Você não possui espaço suficiente em sua mochila", "error")
					end
				else
					exports._infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
				end
			else
				if getElementData(playerSource, "VIP") then
					if getPlayerMoney(playerSource) >= valor then
						if GiveAndTakeAndGetItem("give", playerSource, item, quantidade) then
							takePlayerMoney(playerSource, valor)
							exports._infobox:addNotification(playerSource, "Você comprou "..quantidade.."x "..realName[item][1].." por $"..valor, "money")
						else
							exports._infobox:addNotification(playerSource, "Você não possui espaço suficiente em sua mochila", "error")
						end
					else
						exports._infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
					end
				else
					exports._infobox:addNotification(playerSource, "Você não possui '"..realName["porte"][1].."'", "error")
				end
			end
		else
			if getPlayerMoney(playerSource) >= valor then
				if GiveAndTakeAndGetItem("give", playerSource, item, quantidade) then
					takePlayerMoney(playerSource, valor)
					exports._infobox:addNotification(playerSource, "Você comprou "..quantidade.."x "..realName[item][1].." por $"..valor, "money")
				else
					exports._infobox:addNotification(playerSource, "Você não possui espaço suficiente em sua mochila", "error")
				end
			else
				exports._infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
			end
		end
	elseif shop == "ilegal" then
		if IlegalShopItems[selecionado][3] then
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(ACL_Gang)) then
				if getPlayerMoney(playerSource) >= valor then
					if GiveAndTakeAndGetItem("give", playerSource, item, quantidade) then
						takePlayerMoney(playerSource, valor)
						exports._infobox:addNotification(playerSource, "Você comprou "..quantidade.."x "..realName[item][1].." por $"..valor, "money")
					else
						exports._infobox:addNotification(playerSource, "Você não possui espaço suficiente em sua mochila", "error")
					end
				else
					exports._infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
				end
			else
				exports._infobox:addNotification(playerSource, "Você não faz parte de uma organização criminosa", "error")
			end
		else
			if getPlayerMoney(playerSource) >= valor then
				if GiveAndTakeAndGetItem("give", playerSource, item, quantidade) then
					takePlayerMoney(playerSource, valor)
					exports._infobox:addNotification(playerSource, "Você comprou "..quantidade.."x "..realName[item][1].." por $"..valor, "money")
				else
					exports._infobox:addNotification(playerSource, "Você não possui espaço suficiente em sua mochila", "error")
				end
			else
				exports._infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
			end
		end
	else
		if getPlayerMoney(playerSource) >= valor then
			if GiveAndTakeAndGetItem("give", playerSource, item, quantidade) then
				takePlayerMoney(playerSource, valor)
				exports._infobox:addNotification(playerSource, "Você comprou "..quantidade.."x "..realName[item][1].." por $"..valor, "money")
			else
				exports._infobox:addNotification(playerSource, "Você não possui espaço suficiente em sua mochila", "error")
			end
		else
			exports._infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
		end
	end
end
addEvent("BuyItem", true)
addEventHandler("BuyItem", resourceRoot, Buy)
-----------------------------------------------------------------------------------------------------------------------------------------