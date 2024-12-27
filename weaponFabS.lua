--  ____    ______   _____  
-- |  _ \  |  ____| |  __ \ 
-- | |_) | | |__    | |__) |
-- |  _ <  |  __|   |  _  / 
-- | |_) | | |____  | | \ \ 
-- |____/  |______| |_|  \_\
-----------------------------------------------------------------------------------------------------------------------------------------
spots = {}
local marker = createMarker(-86.27547, -299.32, 2.7646 + 0.75, "arrow", 1, 255, 115, 55, 255)
createBlipAttachedTo(marker, 37)
local marker2 = createMarker(2570.837, -1301.901, 1044.125 + 0.75, "arrow", 1.2, 255, 255, 255, 255)
setElementInterior(marker2, 2)
setElementDimension(marker2, 1)
local parede = createObject(3095, 2571.183, -1301.937, 1044.125, 0, 90, 0)
setElementInterior(parede, 2)
setElementDimension(parede, 1)
setElementAlpha(parede, 0)
local parede2 = createObject(3095, 2522, -1301.894, 1048.289, 0, 90, 0)
setElementInterior(parede2, 2)
setElementDimension(parede2, 1)
setElementAlpha(parede2, 0)
-----------------------------------------------------------------------------------------------------------------------------------------
for i, v in pairs(weaponsFabPositions) do
	spots[i] = createMarker(weaponsFabPositions[i][1], weaponsFabPositions[i][2], weaponsFabPositions[i][3] -1, "cylinder", 1.25, 30, 144, 255, 80)
	setElementInterior(spots[i], 2)
	setElementDimension(spots[i], 1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
function onHit(playerSource)
	if source == marker then
		if ((getElementInterior(playerSource)) == 0 and (getElementDimension(playerSource) == 0)) then
			if not isPedInVehicle(playerSource) then
				for i, v in pairs(WeaponsFabACL) do
					if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(v)) then
						fadeCamera(playerSource, false, 0.5)
						setTimer(function()
					        setElementRotation(playerSource, 1,1,-90)
							setElementPosition(playerSource, 2523.00195, -1301.88953, 1048.26)						
							setElementInterior(playerSource, 2)                            
							setElementDimension(playerSource, 1)
							setCameraTarget(playerSource, playerSource)
							fadeCamera(playerSource, true, 0.5)
							
							exports._infobox:addNotification(playerSource, "Você entrou em uma área verde, é extremamente proibido agredir ou matar alguém aqui.", "warning")
						end, 1000, 1)
					end
				end
			end
		end
	elseif source == marker2 then
		if ((getElementInterior(playerSource)) == 2 and (getElementDimension(playerSource) == 1)) then
			if not isPedInVehicle(playerSource) then
				fadeCamera(playerSource, false, 0.5)	
				setTimer(function()
		
					
					setElementPosition(playerSource, -86.12794, -301.18045, 2.76)
		
					setElementInterior(playerSource, 0)
					setElementDimension(playerSource, 0)
					setCameraTarget(playerSource, playerSource)
					fadeCamera(playerSource, true, 0.5)
				end, 1000, 1)
			end
		end
	else
		for i, v in pairs(spots) do
			if source == v then
				for index, value in pairs(WeaponsFabACL) do
					if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup(value)) then
						triggerClientEvent(playerSource, "toggleFabricPanel", resourceRoot)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit", root, onHit)
-----------------------------------------------------------------------------------------------------------------------------------------
function StartFabrication(playerSource, weapon)
	for i, v in pairs(spots) do
		if isElementWithinMarker(playerSource, v) then
			if weapon == "glock" then
				if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][3]) >= 1 then
					if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][4]) >= 1 then
						if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][5]) >= 1 then
							StartFabrication2(playerSource, weapon)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][3], 1)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][4], 1)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][5], 1)
						else
							local peca = weaponsFabInfos[weapon][5]
							exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
						end
					else
						local peca = weaponsFabInfos[weapon][4]
						exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
					end
				else
					local peca = weaponsFabInfos[weapon][3]
					exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
				end
		--[[	elseif weapon == "escopeta" then
				if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][3]) >= 1 then
					if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][4]) >= 1 then
						StartFabrication2(playerSource, weapon)
						GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][3], 1)
						GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][4], 1)
					else
						local peca = weaponsFabInfos[weapon][4]
						exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
					end
				else
					local peca = weaponsFabInfos[weapon][3]
					exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
				end
			elseif weapon == "tec9" then
				if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][3]) >= 1 then
					if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][4]) >= 1 then
						if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][5]) >= 1 then
							StartFabrication2(playerSource, weapon)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][3], 1)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][4], 1)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][5], 1)
						else
							local peca = weaponsFabInfos[weapon][5]
							exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
						end
					else
						local peca = weaponsFabInfos[weapon][4]
						exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
					end
				else
					local peca = weaponsFabInfos[weapon][3]
					exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
				end --]]
			elseif weapon == "ak47" then
				if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][3]) >= 1 then
					if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][4]) >= 1 then
						if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][5]) >= 1 then
							if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][6]) >= 1 then
								StartFabrication2(playerSource, weapon)
								GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][3], 1)
								GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][4], 1)
								GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][5], 1)
								GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][6], 1)
							else
								local peca = weaponsFabInfos[weapon][6]
								exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
							end
						else
							local peca = weaponsFabInfos[weapon][5]
							exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
						end
					else
						local peca = weaponsFabInfos[weapon][4]
						exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
					end
				else
					local peca = weaponsFabInfos[weapon][3]
					exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
				end
			elseif weapon == "9mm" or weapon == "12" or weapon == ".45" or weapon == "762" then
				if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][3]) >= 30 then
					if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][4]) >= 30 then
						StartFabrication2(playerSource, weapon)
						GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][3], 30)
						GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][4], 30)
					else
						local peca = weaponsFabInfos[weapon][4]
						exports._infobox:addNotification(playerSource, "Você não possui 30x '"..realName[peca][1].."'", "error")
					end
				else
					local peca = weaponsFabInfos[weapon][3]
					exports._infobox:addNotification(playerSource, "Você não possui 30x '"..realName[peca][1].."'", "error")
				end
			 elseif weapon == "colete" then
				if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][3]) >= 1 then
					if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][4]) >= 1 then
						if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][5]) >= 1 then
							StartFabrication2(playerSource, weapon)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][3], 1)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][4], 1)
							GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][5], 1)
						else
							local peca = weaponsFabInfos[weapon][5]
							exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
						end
					else
						local peca = weaponsFabInfos[weapon][4]
						exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
					end
				else
					local peca = weaponsFabInfos[weapon][3]
					exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
				end 


			 elseif weapon == "deagle" then
					if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][3]) >= 1 then
						if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][4]) >= 1 then
							if GiveAndTakeAndGetItem("get", playerSource, weaponsFabInfos[weapon][5]) >= 1 then
								StartFabrication2(playerSource, weapon)
								GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][3], 1)
								GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][4], 1)
								GiveAndTakeAndGetItem("take", playerSource, weaponsFabInfos[weapon][5], 1)
							else
								local peca = weaponsFabInfos[weapon][5]
								exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
							end
						else
							local peca = weaponsFabInfos[weapon][4]
							exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
						end
					else
						local peca = weaponsFabInfos[weapon][3]
						exports._infobox:addNotification(playerSource, "Você não possui a peça '"..realName[peca][1].."'", "error")
					end
				
			end
		end
	end
end




addEvent("startFabric", true)
addEventHandler("startFabric", resourceRoot, StartFabrication)
-----------------------------------------------------------------------------------------------------------------------------------------
function StartFabrication2(playerSource, weapon)
	exports._infobox:addNotification(playerSource, "Você começou a fabricação de um(a) '"..realName[weapon][1].."'", "info")
	setElementFrozen(playerSource, true)
	giveWeapon(playerSource, weaponsFabInfos[weapon][1], 1, true)
	setPedAnimation(playerSource, "CASINO", "dealone", weaponsFabInfos[weapon][2], true, false, false, false, _, true)
	--triggerClientEvent(playerSource, "progressBar", playerSource, weaponsFabInfos[weapon][2])
	local pedanim = setTimer ( setPedAnimation, 500, 0, playerSource, "CASINO", "dealone" ) 
	setTimer(function()
		if weapon == "9mm" or weapon == "12" or weapon == ".45" or weapon == "762" then
			takeWeapon(playerSource, weaponsFabInfos[weapon][1])
			setElementFrozen(playerSource, false)
			if GiveAndTakeAndGetItem("give", playerSource, weapon, 30) then
				 killTimer( pedanim ) 
				 setPedAnimation ( playerSource ) 
				exports._infobox:addNotification(playerSource, "Você fabricou 30x '"..realName[weapon][1].."'", "success")
				triggerEvent("GiveExp", playerSource, playerSource, weaponsFabExp[weapon][1])
			else
				exports._infobox:addNotification(playerSource, "Você não possui espaço em sua mochila", "error")
			end
		else
			takeWeapon(playerSource, weaponsFabInfos[weapon][1])
			setElementFrozen(playerSource, false)
			if GiveAndTakeAndGetItem("give", playerSource, weapon, 1) then
				 killTimer( pedanim ) 
				 setPedAnimation ( playerSource ) 
				exports._infobox:addNotification(playerSource, "Você fabricou um(a) '"..realName[weapon][1].."'", "success")
				triggerEvent("GiveExp", playerSource, playerSource, weaponsFabExp[weapon][1])

			else
				exports._infobox:addNotification(playerSource, "Você não possui espaço em sua mochila", "error")
			end
		end
	end, weaponsFabInfos[weapon][2], 1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------