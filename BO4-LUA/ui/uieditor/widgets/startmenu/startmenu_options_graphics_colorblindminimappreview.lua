CoD.StartMenu_Options_Graphics_ColorBlindMinimapPreview = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Graphics_ColorBlindMinimapPreview.__defaultWidth = 750
CoD.StartMenu_Options_Graphics_ColorBlindMinimapPreview.__defaultHeight = 390
CoD.StartMenu_Options_Graphics_ColorBlindMinimapPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "profile.colorblindMode")
	self:setClass(CoD.StartMenu_Options_Graphics_ColorBlindMinimapPreview)
	self.id = "StartMenu_Options_Graphics_ColorBlindMinimapPreview"
	self.soundSet = "default"
	local minimap = LUI.UIImage.new(0, 0, 0, 750, 0, 0, 0, 282)
	minimap:setImage(RegisterImage(0x691108AB641BBC4))
	self:addElement(minimap)
	self.minimap = minimap
	local playerArrow = LUI.UIImage.new(0, 0, 100, 134, 0, 0, 341, 375)
	playerArrow.__Color = function()
		playerArrow:setRGB(GetColorBlindSafeColorFromBase("PlayerYellow", f1_arg1, 1, 1, 1))
	end
	playerArrow.__Color()
	playerArrow:setImage(RegisterImage(0x81A80F86C516C0A))
	self:addElement(playerArrow)
	self.playerArrow = playerArrow
	local playerScorestreakDiamond = LUI.UIImage.new(0, 0, 146.5, 180.5, 0, 0, 341, 375)
	playerScorestreakDiamond.__Color = function()
		playerScorestreakDiamond:setRGB(GetColorBlindSafeColorFromBase("PlayerYellow", f1_arg1, 1, 1, 1))
	end
	playerScorestreakDiamond.__Color()
	playerScorestreakDiamond:setImage(RegisterImage(0xABBC4C99C38383F))
	self:addElement(playerScorestreakDiamond)
	self.playerScorestreakDiamond = playerScorestreakDiamond
	local friendlyArrow = LUI.UIImage.new(0, 0, 358, 392, 0, 0, 341, 375)
	friendlyArrow.__Color = function()
		friendlyArrow:setRGB(GetColorBlindSafeColorFromBase("FriendlyBlue", f1_arg1, 1, 1, 1))
	end
	friendlyArrow.__Color()
	friendlyArrow:setImage(RegisterImage(0xC70611936881460))
	self:addElement(friendlyArrow)
	self.friendlyArrow = friendlyArrow
	local friendlyPartyArrow = LUI.UIImage.new(0, 0, 310, 344, 0, 0, 341, 375)
	friendlyPartyArrow.__Color = function()
		friendlyPartyArrow:setRGB(GetColorBlindSafeColorFromBase("PartyFriendlyBlue", f1_arg1, 1, 1, 1))
	end
	friendlyPartyArrow.__Color()
	friendlyPartyArrow:setImage(RegisterImage(0xC70611936881460))
	self:addElement(friendlyPartyArrow)
	self.friendlyPartyArrow = friendlyPartyArrow
	local friendlyObjective = LUI.UIImage.new(0, 0, 406, 440, 0, 0, 341, 375)
	friendlyObjective.__Color = function()
		friendlyObjective:setRGB(GetColorBlindSafeColorFromBase("FriendlyBlue", f1_arg1, 1, 1, 1))
	end
	friendlyObjective.__Color()
	friendlyObjective:setImage(RegisterImage(0x3DD751B506DFEB6))
	self:addElement(friendlyObjective)
	self.friendlyObjective = friendlyObjective
	local enemyArrow = LUI.UIImage.new(0, 0, 545, 579, 0, 0, 341, 375)
	enemyArrow.__Color = function()
		enemyArrow:setRGB(GetColorBlindSafeColorFromBase("EnemyOrange", f1_arg1, 1, 1, 1))
	end
	enemyArrow.__Color()
	enemyArrow:setImage(RegisterImage(0x5AE9DCC3F499F1B))
	self:addElement(enemyArrow)
	self.enemyArrow = enemyArrow
	local enemyObjective = LUI.UIImage.new(0, 0, 593, 627, 0, 0, 341, 375)
	enemyObjective.__Color = function()
		enemyObjective:setRGB(GetColorBlindSafeColorFromBase("EnemyOrange", f1_arg1, 1, 1, 1))
	end
	enemyObjective.__Color()
	enemyObjective:setImage(RegisterImage(0x3DD751B506DFEB6))
	self:addElement(enemyObjective)
	self.enemyObjective = enemyObjective
	local enemyScorestreakDiamond = LUI.UIImage.new(0, 0, 641, 675, 0, 0, 341, 375)
	enemyScorestreakDiamond.__Color = function()
		enemyScorestreakDiamond:setRGB(GetColorBlindSafeColorFromBase("EnemyScorestreakTarget", f1_arg1, 1, 1, 1))
	end
	enemyScorestreakDiamond.__Color()
	enemyScorestreakDiamond:setImage(RegisterImage(0xABBC4C99C38383F))
	self:addElement(enemyScorestreakDiamond)
	self.enemyScorestreakDiamond = enemyScorestreakDiamond
	local playerHeader = LUI.UIText.new(0, 0, -9, 291, 0, 0, 305.5, 326.5)
	playerHeader.__Color = function()
		playerHeader:setRGB(GetColorBlindSafeColorFromBase("PlayerYellow", f1_arg1, 1, 1, 1))
	end
	playerHeader.__Color()
	playerHeader:setText(Engine[0xF9F1239CFD921FE](0x1F9844545CB4FF6))
	playerHeader:setTTF("ttmussels_regular")
	playerHeader:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	playerHeader:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(playerHeader)
	self.playerHeader = playerHeader
	local friendlyHeader = LUI.UIText.new(0, 0, 225, 525, 0, 0, 305.5, 326.5)
	friendlyHeader.__Color = function()
		friendlyHeader:setRGB(GetColorBlindSafeColorFromBase("FriendlyBlue", f1_arg1, 1, 1, 1))
	end
	friendlyHeader.__Color()
	friendlyHeader:setText(LocalizeToUpperString(0x57D890DF7DB4CFC))
	friendlyHeader:setTTF("ttmussels_regular")
	friendlyHeader:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	friendlyHeader:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(friendlyHeader)
	self.friendlyHeader = friendlyHeader
	local enemyHeader = LUI.UIText.new(0, 0, 460, 760, 0, 0, 305.5, 326.5)
	enemyHeader.__Color = function()
		enemyHeader:setRGB(GetColorBlindSafeColorFromBase("EnemyOrange", f1_arg1, 1, 1, 1))
	end
	enemyHeader.__Color()
	enemyHeader:setText(LocalizeToUpperString(0x91876E35BECF3CD))
	enemyHeader:setTTF("ttmussels_regular")
	enemyHeader:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	enemyHeader:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(enemyHeader)
	self.enemyHeader = enemyHeader
	local minimapPlayerArrow = LUI.UIImage.new(0, 0, 62, 110, 0, 0, 130, 178)
	minimapPlayerArrow.__Color = function()
		minimapPlayerArrow:setRGB(GetColorBlindSafeColorFromBase("PlayerYellow", f1_arg1, 1, 1, 1))
	end
	minimapPlayerArrow.__Color()
	minimapPlayerArrow:setZRot(-90)
	minimapPlayerArrow:setImage(RegisterImage(0x81A80F86C516C0A))
	self:addElement(minimapPlayerArrow)
	self.minimapPlayerArrow = minimapPlayerArrow
	local minimapFriendlyPlayerArrow = LUI.UIImage.new(0, 0, 117, 165, 0, 0, 104, 152)
	minimapFriendlyPlayerArrow.__Color = function()
		minimapFriendlyPlayerArrow:setRGB(GetColorBlindSafeColorFromBase("FriendlyBlue", f1_arg1, 1, 1, 1))
	end
	minimapFriendlyPlayerArrow.__Color()
	minimapFriendlyPlayerArrow:setZRot(-34)
	minimapFriendlyPlayerArrow:setImage(RegisterImage(0xC70611936881460))
	self:addElement(minimapFriendlyPlayerArrow)
	self.minimapFriendlyPlayerArrow = minimapFriendlyPlayerArrow
	local minimapPartyFriendlyPlayerArrow = LUI.UIImage.new(0, 0, 279, 327, 0, 0, 171, 219)
	minimapPartyFriendlyPlayerArrow.__Color = function()
		minimapPartyFriendlyPlayerArrow:setRGB(GetColorBlindSafeColorFromBase("PartyFriendlyBlue", f1_arg1, 1, 1, 1))
	end
	minimapPartyFriendlyPlayerArrow.__Color()
	minimapPartyFriendlyPlayerArrow:setZRot(-34)
	minimapPartyFriendlyPlayerArrow:setImage(RegisterImage(0xC70611936881460))
	self:addElement(minimapPartyFriendlyPlayerArrow)
	self.minimapPartyFriendlyPlayerArrow = minimapPartyFriendlyPlayerArrow
	local minimapEnemyPing1 = LUI.UIImage.new(0, 0, 303, 351, 0, 0, 123, 171)
	minimapEnemyPing1.__Color = function()
		minimapEnemyPing1:setRGB(GetColorBlindSafeColorFromBase("EnemyOrange", f1_arg1, 1, 1, 1))
	end
	minimapEnemyPing1.__Color()
	minimapEnemyPing1:setImage(RegisterImage(0x82B58A3A0F90B01))
	self:addElement(minimapEnemyPing1)
	self.minimapEnemyPing1 = minimapEnemyPing1
	local minimapEnemyPing2 = LUI.UIImage.new(0, 0, 412, 460, 0, 0, 93, 141)
	minimapEnemyPing2.__Color = function()
		minimapEnemyPing2:setRGB(GetColorBlindSafeColorFromBase("EnemyOrange", f1_arg1, 1, 1, 1))
	end
	minimapEnemyPing2.__Color()
	minimapEnemyPing2:setImage(RegisterImage(0x82B58A3A0F90B01))
	self:addElement(minimapEnemyPing2)
	self.minimapEnemyPing2 = minimapEnemyPing2
	local minimapEnemyPing3 = LUI.UIImage.new(0, 0, 538, 586, 0, 0, 159, 207)
	minimapEnemyPing3.__Color = function()
		minimapEnemyPing3:setRGB(GetColorBlindSafeColorFromBase("EnemyOrange", f1_arg1, 1, 1, 1))
	end
	minimapEnemyPing3.__Color()
	minimapEnemyPing3:setImage(RegisterImage(0x82B58A3A0F90B01))
	self:addElement(minimapEnemyPing3)
	self.minimapEnemyPing3 = minimapEnemyPing3
	local objectivePointA = LUI.UIImage.new(0, 0, 135, 183, 0, 0, 146, 194)
	objectivePointA.__Color = function()
		objectivePointA:setRGB(GetColorBlindSafeColorFromBase("FriendlyBlue", f1_arg1, 1, 1, 1))
	end
	objectivePointA.__Color()
	objectivePointA:setImage(RegisterImage(0x24C57F8DB0BFCE6))
	self:addElement(objectivePointA)
	self.objectivePointA = objectivePointA
	local objectivePointB = LUI.UIImage.new(0, 0, 342, 390, 0, 0, 122, 170)
	objectivePointB:setImage(RegisterImage(0x58FBDC4C0C829B1))
	self:addElement(objectivePointB)
	self.objectivePointB = objectivePointB
	local objectivePointC = LUI.UIImage.new(0, 0, 532, 580, 0, 0, 99, 147)
	objectivePointC.__Color = function()
		objectivePointC:setRGB(GetColorBlindSafeColorFromBase("EnemyOrange", f1_arg1, 1, 1, 1))
	end
	objectivePointC.__Color()
	objectivePointC:setImage(RegisterImage(0x484B59524AE2B0))
	self:addElement(objectivePointC)
	self.objectivePointC = objectivePointC
	local f1_local22 = playerArrow
	local f1_local23 = playerArrow.subscribeToModel
	local f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], playerArrow.__Color)
	f1_local22 = playerScorestreakDiamond
	f1_local23 = playerScorestreakDiamond.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], playerScorestreakDiamond.__Color)
	f1_local22 = friendlyArrow
	f1_local23 = friendlyArrow.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], friendlyArrow.__Color)
	f1_local22 = friendlyPartyArrow
	f1_local23 = friendlyPartyArrow.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], friendlyPartyArrow.__Color)
	f1_local22 = friendlyObjective
	f1_local23 = friendlyObjective.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], friendlyObjective.__Color)
	f1_local22 = enemyArrow
	f1_local23 = enemyArrow.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], enemyArrow.__Color)
	f1_local22 = enemyObjective
	f1_local23 = enemyObjective.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], enemyObjective.__Color)
	f1_local22 = enemyScorestreakDiamond
	f1_local23 = enemyScorestreakDiamond.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], enemyScorestreakDiamond.__Color)
	f1_local22 = playerHeader
	f1_local23 = playerHeader.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], playerHeader.__Color)
	f1_local22 = friendlyHeader
	f1_local23 = friendlyHeader.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], friendlyHeader.__Color)
	f1_local22 = enemyHeader
	f1_local23 = enemyHeader.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], enemyHeader.__Color)
	f1_local22 = minimapPlayerArrow
	f1_local23 = minimapPlayerArrow.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], minimapPlayerArrow.__Color)
	f1_local22 = minimapFriendlyPlayerArrow
	f1_local23 = minimapFriendlyPlayerArrow.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], minimapFriendlyPlayerArrow.__Color)
	f1_local22 = minimapPartyFriendlyPlayerArrow
	f1_local23 = minimapPartyFriendlyPlayerArrow.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], minimapPartyFriendlyPlayerArrow.__Color)
	f1_local22 = minimapEnemyPing1
	f1_local23 = minimapEnemyPing1.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], minimapEnemyPing1.__Color)
	f1_local22 = minimapEnemyPing2
	f1_local23 = minimapEnemyPing2.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], minimapEnemyPing2.__Color)
	f1_local22 = minimapEnemyPing3
	f1_local23 = minimapEnemyPing3.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], minimapEnemyPing3.__Color)
	f1_local22 = objectivePointA
	f1_local23 = objectivePointA.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], objectivePointA.__Color)
	f1_local22 = objectivePointC
	f1_local23 = objectivePointC.subscribeToModel
	f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local23(f1_local22, f1_local24["profile.colorblindMode"], objectivePointC.__Color)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Graphics_ColorBlindMinimapPreview.__onClose = function(f21_arg0)
	f21_arg0.playerArrow:close()
	f21_arg0.playerScorestreakDiamond:close()
	f21_arg0.friendlyArrow:close()
	f21_arg0.friendlyPartyArrow:close()
	f21_arg0.friendlyObjective:close()
	f21_arg0.enemyArrow:close()
	f21_arg0.enemyObjective:close()
	f21_arg0.enemyScorestreakDiamond:close()
	f21_arg0.playerHeader:close()
	f21_arg0.friendlyHeader:close()
	f21_arg0.enemyHeader:close()
	f21_arg0.minimapPlayerArrow:close()
	f21_arg0.minimapFriendlyPlayerArrow:close()
	f21_arg0.minimapPartyFriendlyPlayerArrow:close()
	f21_arg0.minimapEnemyPing1:close()
	f21_arg0.minimapEnemyPing2:close()
	f21_arg0.minimapEnemyPing3:close()
	f21_arg0.objectivePointA:close()
	f21_arg0.objectivePointC:close()
end
