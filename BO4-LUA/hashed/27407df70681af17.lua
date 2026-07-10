CoD.BM_ActiveBountyInternal = InheritFrom(LUI.UIElement)
CoD.BM_ActiveBountyInternal.__defaultWidth = 460
CoD.BM_ActiveBountyInternal.__defaultHeight = 60
CoD.BM_ActiveBountyInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ActiveBountyInternal)
	self.id = "BM_ActiveBountyInternal"
	self.soundSet = "none"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.WarzoneTeammate3.r, ColorSet.WarzoneTeammate3.g, ColorSet.WarzoneTeammate3.b)
	self:addElement(Backing)
	self.Backing = Backing
	local MiddleText = LUI.UIText.new(0, 1, 16, -16, 0.5, 0.5, -12, 12)
	MiddleText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	MiddleText:setText(LocalizeToUpperString(0x0))
	MiddleText:setTTF("ttmussels_regular")
	MiddleText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	MiddleText:setLetterSpacing(3)
	MiddleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MiddleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(MiddleText)
	self.MiddleText = MiddleText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
