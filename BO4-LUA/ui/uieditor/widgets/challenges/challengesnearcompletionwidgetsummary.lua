require("x64:eeba57f916954d1")
require("x64:af90a79c38908dd")
CoD.ChallengesNearCompletionWidgetSummary = InheritFrom(LUI.UIElement)
CoD.ChallengesNearCompletionWidgetSummary.__defaultWidth = 1158
CoD.ChallengesNearCompletionWidgetSummary.__defaultHeight = 80
CoD.ChallengesNearCompletionWidgetSummary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesNearCompletionWidgetSummary)
	self.id = "ChallengesNearCompletionWidgetSummary"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local ProgressBarBorder = LUI.UIImage.new(0, 0.75, 3, 5, 0.06, 0.94, -1, 1)
	ProgressBarBorder:setAlpha(0.05)
	ProgressBarBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	ProgressBarBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ProgressBarBorder:setShaderVector(0, 0, 0, 0, 0)
	ProgressBarBorder:setupNineSliceShader(12, 12)
	self:addElement(ProgressBarBorder)
	self.ProgressBarBorder = ProgressBarBorder
	local ProgressBar = LUI.UIImage.new(0, 0.75, 5, 3, 0.06, 0.94, 1, -1)
	ProgressBar:setRGB(1, 0.36, 0)
	ProgressBar:setAlpha(0.15)
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local ProgressFraction = LUI.UIText.new(1, 1, -392.5, -300.5, 0.5, 0.5, -28, -4)
	ProgressFraction:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ProgressFraction:setTTF("default")
	ProgressFraction:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(ProgressFraction)
	self.ProgressFraction = ProgressFraction
	local ChallengeIcon = CoD.Challenges_NearCompletion_CroppedImage.new(f1_arg0, f1_arg1, 1, 1, -284, -6, 0.5, 0.5, -35, 35)
	ChallengeIcon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ChallengeIcon.Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ChallengeIcon)
	self.ChallengeIcon = ChallengeIcon
	local Description = LUI.UIText.new(0, 0, 16, 858, 0.5, 0.5, -1.5, 15.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(1)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Description)
	self.Description = Description
	local Title = LUI.UIText.new(0.01, 0.66, 10, 10, 0.5, 0.5, -31, -7)
	Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	local TitleBg = LUI.UIImage.new(0.73, 0.73, 145, 177, 0, 0, 24, 56)
	TitleBg:setRGB(0, 0, 0)
	TitleBg:setAlpha(0.85)
	TitleBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	TitleBg:setShaderVector(0, 0.02, 0.02, 0.02, 0.02)
	self:addElement(TitleBg)
	self.TitleBg = TitleBg
	local PixelGridTiledBacking = LUI.UIImage.new(0.74, 0.74, 141, 173, 0, 0, 24, 56)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local LockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 0, 0, 998, 1026, 0, 0, 26, 54)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	self.ProgressBar:linkToElementModel(self, "statPercent", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self.ProgressFraction:linkToElementModel(self, "statFractionText", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressFraction:setText(f4_local0)
		end
	end)
	self.Description:linkToElementModel(self, "description", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Description:setText(CoD.BaseUtility.AlreadyLocalized(f5_local0))
		end
	end)
	self.Title:linkToElementModel(self, "title", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Title:setText(ConvertToUpperString(f6_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesNearCompletionWidgetSummary.__resetProperties = function(f7_arg0)
	f7_arg0.Title:completeAnimation()
	f7_arg0.Title:setAlpha(1)
end
CoD.ChallengesNearCompletionWidgetSummary.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		Active = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Title:completeAnimation()
			f9_arg0.Title:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Title)
		end,
	},
}
CoD.ChallengesNearCompletionWidgetSummary.__onClose = function(f10_arg0)
	f10_arg0.ProgressBar:close()
	f10_arg0.ProgressFraction:close()
	f10_arg0.ChallengeIcon:close()
	f10_arg0.Description:close()
	f10_arg0.Title:close()
	f10_arg0.LockedIcon:close()
end
