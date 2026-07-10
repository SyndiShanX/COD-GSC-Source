CoD.ArenaGauntletWinCounter = InheritFrom(LUI.UIElement)
CoD.ArenaGauntletWinCounter.__defaultWidth = 80
CoD.ArenaGauntletWinCounter.__defaultHeight = 100
CoD.ArenaGauntletWinCounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaGauntletWinCounter)
	self.id = "ArenaGauntletWinCounter"
	self.soundSet = "none"
	local WinsLabel = LUI.UIText.new(-0.75, 1.75, 0, 0, 0, 0, 0, 24)
	WinsLabel:setRGB(ColorSet.PlayerGreen.r, ColorSet.PlayerGreen.g, ColorSet.PlayerGreen.b)
	WinsLabel:setText(Engine[0xF9F1239CFD921FE](0x585891326C1258C))
	WinsLabel:setTTF("ttmussels_demibold")
	WinsLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WinsLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WinsLabel)
	self.WinsLabel = WinsLabel
	local WinCount = LUI.UIText.new(0.01, 0.99, 0, 0, 0, 0, 39, 79)
	WinCount:setRGB(ColorSet.PlayerGreen.r, ColorSet.PlayerGreen.g, ColorSet.PlayerGreen.b)
	WinCount:setText("")
	WinCount:setTTF("ttmussels_demibold")
	WinCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WinCount:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WinCount)
	self.WinCount = WinCount
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
