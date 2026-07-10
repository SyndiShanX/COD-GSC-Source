require("x64:6d874b1ace30c05")
CoD.GameSettings_GameModeName = InheritFrom(LUI.UIElement)
CoD.GameSettings_GameModeName.__defaultWidth = 733
CoD.GameSettings_GameModeName.__defaultHeight = 45
CoD.GameSettings_GameModeName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_GameModeName)
	self.id = "GameSettings_GameModeName"
	self.soundSet = "ChooseDecal"
	local GameSettingstextboxBG = CoD.GameSettings_textboxBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(GameSettingstextboxBG)
	self.GameSettingstextboxBG = GameSettingstextboxBG
	local GameModeTextBox = LUI.UIText.new(0, 0, 0, 733, 0.5, 0.5, -19.5, 19.5)
	GameModeTextBox:setRGB(0.96, 0.93, 0.84)
	GameModeTextBox:setText(LocalizedGameType())
	GameModeTextBox:setTTF("ttmussels_regular")
	GameModeTextBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	GameModeTextBox:setShaderVector(0, 0.08, 0, 0, 0)
	GameModeTextBox:setShaderVector(1, 0, 0, 0, 0)
	GameModeTextBox:setShaderVector(2, 1, 0, 0, 0)
	GameModeTextBox:setLetterSpacing(6)
	GameModeTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameModeTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GameModeTextBox)
	self.GameModeTextBox = GameModeTextBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_GameModeName.__onClose = function(f2_arg0)
	f2_arg0.GameSettingstextboxBG:close()
end
