require("x64:19c1945d2e472b0")
CoD.AARTierPip = InheritFrom(LUI.UIElement)
CoD.AARTierPip.__defaultWidth = 54
CoD.AARTierPip.__defaultHeight = 54
CoD.AARTierPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierPip)
	self.id = "AARTierPip"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameBorder = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FrameBorder:setAlpha(0)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local ImageX = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	ImageX:setAlpha(0)
	ImageX:setImage(RegisterImage(@"uie_t7_menu_frontend_slidex"))
	ImageX:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ImageX)
	self.ImageX = ImageX
	local Glow = LUI.UIImage.new(0, 1, -12, 12, 0, 1, -15, 15)
	Glow:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_ui_hud_core_no_ammo_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local Background = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	Background:setRGB(1, 0.93, 0)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 2, -2, 0, 1, 2, -2)
	DotTiledBacking:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	DotTiledBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FocusBorder = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FocusBorder:setRGB(ColorSet.WarzoneTeammate1.r, ColorSet.WarzoneTeammate1.g, ColorSet.WarzoneTeammate1.b)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(8, 8)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local TierText = LUI.UIText.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	TierText:setAlpha(0)
	TierText:setTTF("ttmussels_regular")
	TierText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	TierText:setShaderVector(0, 0.02, 0, 0, 0)
	TierText:setShaderVector(1, 0.06, 0, 0, 0)
	TierText:setShaderVector(2, 1, 0, 0, 0)
	TierText:setLetterSpacing(2)
	TierText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TierText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(TierText)
	self.TierText = TierText
	self.TierText:linkToElementModel(self, "tierText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TierText:setText(f2_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierPip.__resetProperties = function(f3_arg0)
	f3_arg0.FrameBorder:completeAnimation()
	f3_arg0.TierText:completeAnimation()
	f3_arg0.ImageX:completeAnimation()
	f3_arg0.Glow:completeAnimation()
	f3_arg0.Background:completeAnimation()
	f3_arg0.DotTiledBacking:completeAnimation()
	f3_arg0.FocusBorder:completeAnimation()
	f3_arg0.FrameBorder:setAlpha(0)
	f3_arg0.TierText:setRGB(1, 1, 1)
	f3_arg0.TierText:setAlpha(0)
	f3_arg0.ImageX:setRGB(1, 1, 1)
	f3_arg0.ImageX:setAlpha(0)
	f3_arg0.Glow:setAlpha(0)
	f3_arg0.Background:setAlpha(0)
	f3_arg0.DotTiledBacking:setAlpha(0)
	f3_arg0.FocusBorder:setAlpha(0)
end
CoD.AARTierPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.FrameBorder:completeAnimation()
			f4_arg0.FrameBorder:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.FrameBorder)
			f4_arg0.ImageX:completeAnimation()
			f4_arg0.ImageX:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ImageX)
			f4_arg0.TierText:completeAnimation()
			f4_arg0.TierText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TierText)
		end,
	},
	Filled = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(6)
			f5_arg0.ImageX:completeAnimation()
			f5_arg0.ImageX:setRGB(0, 0, 0)
			f5_arg0.ImageX:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ImageX)
			f5_arg0.Glow:completeAnimation()
			f5_arg0.Glow:setAlpha(0.6)
			f5_arg0.clipFinished(f5_arg0.Glow)
			f5_arg0.Background:completeAnimation()
			f5_arg0.Background:setAlpha(0.7)
			f5_arg0.clipFinished(f5_arg0.Background)
			f5_arg0.DotTiledBacking:completeAnimation()
			f5_arg0.DotTiledBacking:setAlpha(0.25)
			f5_arg0.clipFinished(f5_arg0.DotTiledBacking)
			f5_arg0.FocusBorder:completeAnimation()
			f5_arg0.FocusBorder:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.FocusBorder)
			f5_arg0.TierText:completeAnimation()
			f5_arg0.TierText:setRGB(0, 0, 0)
			f5_arg0.TierText:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.TierText)
		end,
	},
	NotFilled = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.FrameBorder:completeAnimation()
			f6_arg0.FrameBorder:setAlpha(0.15)
			f6_arg0.clipFinished(f6_arg0.FrameBorder)
			f6_arg0.ImageX:completeAnimation()
			f6_arg0.ImageX:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.ImageX)
			f6_arg0.TierText:completeAnimation()
			f6_arg0.TierText:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TierText)
		end,
	},
}
CoD.AARTierPip.__onClose = function(f7_arg0)
	f7_arg0.DotTiledBacking:close()
	f7_arg0.TierText:close()
end
