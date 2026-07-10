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
	WinsLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4585891326C1258C"))
	WinsLabel:setTTF("ttmussels_demibold")
	WinsLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WinsLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(WinsLabel)
	self.WinsLabel = WinsLabel
	local WinCount = LUI.UIText.new(0.01, 0.99, 0, 0, 0, 0, 39, 79)
	WinCount:setRGB(ColorSet.PlayerGreen.r, ColorSet.PlayerGreen.g, ColorSet.PlayerGreen.b)
	WinCount:setText("")
	WinCount:setTTF("ttmussels_demibold")
	WinCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WinCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(WinCount)
	self.WinCount = WinCount
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
