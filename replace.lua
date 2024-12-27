txdReplace = {
	["capacete"] = {1937},
	["cutelo"] = {339},
	["maleta"] = {1938},
	["picareta"] = {333},
	["algema"] = {331},
	["porco"] = {1877},
	["criatura"] = {1878},
	["capeta"] = {1879},
	["caveira"] = {1880},
	["macaco"] = {1881},
	["cavalo"] = {1882},
	["touro"] = {1903},
	["sacola"] = {1904},
}

function onResourceStart()
	for i, v in pairs(txdReplace) do
		local txd = engineLoadTXD("txd/"..i..".txd")
		engineImportTXD(txd, txdReplace[i][1])
		local dff = engineLoadDFF("txd/"..i..".dff", txdReplace[i][1])
		engineReplaceModel(dff, txdReplace[i][1])
		if fileExists("txd/"..i..".col") then
			local col = engineLoadCOL("txd/"..i..".col")
			engineReplaceCOL(col, txdReplace[i][1])
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)