CoD.ArenaGauntletTierProgressInactive = InheritFrom(LUI.UIElement)
CoD.ArenaGauntletTierProgressInactive.__defaultWidth = 150
CoD.ArenaGauntletTierProgressInactive.__defaultHeight = 200
CoD.ArenaGauntletTierProgressInactive.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaGauntletTierProgressInactive)
	self.id = "ArenaGauntletTierProgressInactive"
	self.soundSet = "none"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.HealthBarBackground.r, ColorSet.HealthBarBackground.g, ColorSet.HealthBarBackground.b)
	self:addElement(Backing)
	self.Backing = Backing
	local WinTargetLabel = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 70, 94)
	WinTargetLabel:setText(LocalizeToUpperString(0xE409A10287D5833))
	WinTargetLabel:setTTF("ttmussels_regular")
	WinTargetLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WinTargetLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WinTargetLabel)
	self.WinTargetLabel = WinTargetLabel
	local WinTargetCount = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 100, 130)
	WinTargetCount:setText("")
	WinTargetCount:setTTF("ttmussels_demibold")
	WinTargetCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WinTargetCount:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WinTargetCount)
	self.WinTargetCount = WinTargetCount
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
