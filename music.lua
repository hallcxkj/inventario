addEventHandler('onClientResourceStart', resourceRoot,
	function()
		local sound = playSound3D("files/music.mp3", 2558.48584, -1293.31787, 1046, true) 
		setElementInterior(sound, 2)
		setElementDimension(sound, 1)
		setSoundMaxDistance(sound, 26)
		setSoundVolume( sound, 0.1 )


		local sound2 = playSound3D("files/music.mp3", 2554.18506, -1293.68054, 1046, true) 
		setElementInterior(sound2, 2)
		setElementDimension(sound2, 1)
		setSoundMaxDistance(sound2, 26)
		setSoundVolume( sound2, 0.1 )

	end
)