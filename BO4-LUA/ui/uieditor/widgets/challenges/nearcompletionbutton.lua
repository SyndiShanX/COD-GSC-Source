require("x64:eeba57f916954d1")
require("x64:af90a79c38908dd")
require("x64:5f8cf56752aa71b")
CoD.NearCompletionButton = InheritFrom(LUI.UIElement)
CoD.NearCompletionButton.__defaultWidth = 1100
CoD.NearCompletionButton.__defaultHeight = 80
CoD.NearCompletionButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.NearCompletionButton)
	self.id = "NearCompletionButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local ProgressBarBorder = LUI.UIImage.new(0, 0.73, 3, 5, 0.06, 0.94, -1, 1)
	ProgressBarBorder:setAlpha(0.05)
	ProgressBarBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	ProgressBarBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ProgressBarBorder:setShaderVector(0, 0, 0, 0, 0)
	ProgressBarBorder:setupNineSliceShader(12, 12)
	self:addElement(ProgressBarBorder)
	self.ProgressBarBorder = ProgressBarBorder
	local ProgressBar = LUI.UIImage.new(0, 0.73, 5, 3, 0.06, 0.94, 1, -1)
	ProgressBar:setRGB(1, 0.36, 0)
	ProgressBar:setAlpha(0.15)
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	ProgressBar:linkToElementModel(self, "statPercent", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local Title = LUI.UIText.new(0, 0, 11, 741, 0.5, 0.5, -31, -7)
	Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(3)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local Description = LUI.UIText.new(0, 0, 11, 801, 0.5, 0.5, -1, 16)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setAlpha(0.8)
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(1)
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local Icon = CoD.Challenges_NearCompletion_CroppedImage.new(f1_arg0, f1_arg1, 0, 0, 814.5, 1094.5, 0.5, 0.5, -34.5, 34.5)
	Icon:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Icon.Image:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local ProgressFraction = LUI.UIText.new(0, 0, 762, 801, 0, 0, 13, 37)
	ProgressFraction:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ProgressFraction:setTTF("default")
	ProgressFraction:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ProgressFraction:linkToElementModel(self, "statFractionText", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressFraction:setText(f4_local0)
		end
	end)
	self:addElement(ProgressFraction)
	self.ProgressFraction = ProgressFraction
	local Tier = LUI.UIText.new(0, 0, 705.5, 735.5, 0, 0, 12, 36)
	Tier:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Tier:setAlpha(0)
	Tier:setTTF("ttmussels_regular")
	Tier:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Tier:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Tier:linkToElementModel(self, "currentTier", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Tier:setText(Engine[0xF9F1239CFD921FE](CoD.ChallengesUtility.GetChallengeTierNumeral(f5_local0)))
		end
	end)
	self:addElement(Tier)
	self.Tier = Tier
	local TitleBg = LUI.UIImage.new(0.73, 0.73, 130, 162, 0, 0, 24, 56)
	TitleBg:setRGB(0, 0, 0)
	TitleBg:setAlpha(0.85)
	TitleBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	TitleBg:setShaderVector(0, 0.02, 0.02, 0.02, 0.02)
	self:addElement(TitleBg)
	self.TitleBg = TitleBg
	local PixelGridTiledBacking = LUI.UIImage.new(0.74, 0.74, 126.5, 158.5, 0, 0, 24, 56)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local LockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 0, 0, 940.5, 968.5, 0, 0, 25, 53)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local ButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonOutline)
	self.ButtonOutline = ButtonOutline
	self.Title:linkToElementModel(self, "title", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self.Description:linkToElementModel(self, "description", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Description:setText(f7_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	ButtonOutline.id = "ButtonOutline"
	self.__defaultFocus = ButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NearCompletionButton.__resetProperties = function(f9_arg0)
	f9_arg0.SelectorOverlay:completeAnimation()
	f9_arg0.Title:completeAnimation()
	f9_arg0.Tier:completeAnimation()
	f9_arg0.ProgressFraction:completeAnimation()
	f9_arg0.Description:completeAnimation()
	f9_arg0.SelectorOverlay:setAlpha(0.01)
	f9_arg0.Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	f9_arg0.Tier:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f9_arg0.ProgressFraction:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f9_arg0.Description:setTopBottom(0.5, 0.5, -1, 16)
end
CoD.NearCompletionButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.SelectorOverlay:completeAnimation()
			f11_arg0.SelectorOverlay:setAlpha(0.04)
			f11_arg0.clipFinished(f11_arg0.SelectorOverlay)
			f11_arg0.Title:completeAnimation()
			f11_arg0.Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f11_arg0.clipFinished(f11_arg0.Title)
			f11_arg0.ProgressFraction:completeAnimation()
			f11_arg0.ProgressFraction:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f11_arg0.clipFinished(f11_arg0.ProgressFraction)
			f11_arg0.Tier:completeAnimation()
			f11_arg0.Tier:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f11_arg0.clipFinished(f11_arg0.Tier)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			local f12_local0 = function(f13_arg0)
				f12_arg0.SelectorOverlay:beginAnimation(200)
				f12_arg0.SelectorOverlay:setAlpha(0.04)
				f12_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SelectorOverlay:completeAnimation()
			f12_arg0.SelectorOverlay:setAlpha(0.01)
			f12_local0(f12_arg0.SelectorOverlay)
			f12_arg0.Title:completeAnimation()
			f12_arg0.Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f12_arg0.clipFinished(f12_arg0.Title)
			f12_arg0.ProgressFraction:completeAnimation()
			f12_arg0.ProgressFraction:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f12_arg0.clipFinished(f12_arg0.ProgressFraction)
			f12_arg0.Tier:completeAnimation()
			f12_arg0.Tier:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f12_arg0.clipFinished(f12_arg0.Tier)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.SelectorOverlay:beginAnimation(200)
				f14_arg0.SelectorOverlay:setAlpha(0.01)
				f14_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.SelectorOverlay:completeAnimation()
			f14_arg0.SelectorOverlay:setAlpha(0.04)
			f14_local0(f14_arg0.SelectorOverlay)
			f14_arg0.Title:completeAnimation()
			f14_arg0.Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f14_arg0.clipFinished(f14_arg0.Title)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Description:completeAnimation()
			f16_arg0.Description:setTopBottom(0.5, 0.5, 2, 14)
			f16_arg0.clipFinished(f16_arg0.Description)
		end,
	},
}
CoD.NearCompletionButton.__onClose = function(f17_arg0)
	f17_arg0.ProgressBar:close()
	f17_arg0.Title:close()
	f17_arg0.Description:close()
	f17_arg0.Icon:close()
	f17_arg0.ProgressFraction:close()
	f17_arg0.Tier:close()
	f17_arg0.LockedIcon:close()
	f17_arg0.ButtonOutline:close()
end
