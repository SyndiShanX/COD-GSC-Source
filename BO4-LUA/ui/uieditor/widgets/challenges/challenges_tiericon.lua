require("x64:4f4ebc58e721a19")
require("x64:19c1945d2e472b0")
CoD.Challenges_TierIcon = InheritFrom(LUI.UIElement)
CoD.Challenges_TierIcon.__defaultWidth = 54
CoD.Challenges_TierIcon.__defaultHeight = 114
CoD.Challenges_TierIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_TierIcon)
	self.id = "Challenges_TierIcon"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameBorder = LUI.UIImage.new(0.5, 0.5, -27, 27, 0, 0, 0, 54)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local ImageX = LUI.UIImage.new(0, 0, 2, 52, 0, 0, 2, 52)
	ImageX:setImage(RegisterImage(0xCCAE79885973D29))
	ImageX:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	ImageX:linkToElementModel(self, "rankIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ImageX:setAlpha(HideIfNotEmptyString(f2_local0))
		end
	end)
	self:addElement(ImageX)
	self.ImageX = ImageX
	local Glow = LUI.UIImage.new(0, 0, -16, 69, 0, 0, -19, 73)
	Glow:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(0xC58FF2328701EBA))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	local Background = LUI.UIImage.new(0, 0, 2, 52, 0, 0, 2, 52)
	Background:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 2, 52, 0, 0, 2, 52)
	DotTiledBacking:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	DotTiledBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FocusBorder = LUI.UIImage.new(0.07, 0.93, -4, 4, 0.04, 0.43, -4, 4)
	FocusBorder:setRGB(ColorSet.WarzoneTeammate1.r, ColorSet.WarzoneTeammate1.g, ColorSet.WarzoneTeammate1.b)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(8, 8)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local TierText = LUI.UIText.new(0, 0, 5, 35, 0, 0, 12, 42)
	TierText:setTTF("ttmussels_regular")
	TierText:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	TierText:setShaderVector(0, 0.02, 0, 0, 0)
	TierText:setShaderVector(1, 0.06, 0, 0, 0)
	TierText:setShaderVector(2, 1, 0, 0, 0)
	TierText:setLetterSpacing(2)
	TierText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TierText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(TierText)
	self.TierText = TierText
	local CurrentTierArrow = LUI.UIImage.new(0, 0, 22, 32, 1, 1, -60, -43)
	CurrentTierArrow:setZRot(90)
	CurrentTierArrow:setScale(0.8, 0.8)
	CurrentTierArrow:setImage(RegisterImage(0x1226A0CC6137EEE))
	self:addElement(CurrentTierArrow)
	self.CurrentTierArrow = CurrentTierArrow
	local XP = CoD.CallingCardProfilerXP.new(f1_arg0, f1_arg1, 0, 0, 0, 158, 0, 0, 57, 111)
	XP.XPIcon:setScale(0.59, 0.59)
	XP:linkToElementModel(self, nil, false, function(model)
		XP:setModel(model, f1_arg1)
	end)
	self:addElement(XP)
	self.XP = XP
	self.TierText:linkToElementModel(self, "tierText", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TierText:setText(f4_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Unreached",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isReached")
			end,
		},
		{
			stateName = "CurrentTier",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isCurrentTier")
			end,
		},
	})
	self:linkToElementModel(self, "isReached", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isReached",
		})
	end)
	self:linkToElementModel(self, "isCurrentTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isCurrentTier",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_TierIcon.__resetProperties = function(f9_arg0)
	f9_arg0.CurrentTierArrow:completeAnimation()
	f9_arg0.XP:completeAnimation()
	f9_arg0.Background:completeAnimation()
	f9_arg0.TierText:completeAnimation()
	f9_arg0.ImageX:completeAnimation()
	f9_arg0.Glow:completeAnimation()
	f9_arg0.DotTiledBacking:completeAnimation()
	f9_arg0.FocusBorder:completeAnimation()
	f9_arg0.CurrentTierArrow:setAlpha(1)
	f9_arg0.XP:setAlpha(1)
	f9_arg0.Background:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	f9_arg0.Background:setAlpha(0)
	f9_arg0.TierText:setRGB(1, 1, 1)
	f9_arg0.ImageX:setRGB(1, 1, 1)
	f9_arg0.Glow:setAlpha(0)
	f9_arg0.DotTiledBacking:setAlpha(0)
	f9_arg0.FocusBorder:setAlpha(0)
end
CoD.Challenges_TierIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.CurrentTierArrow:completeAnimation()
			f10_arg0.CurrentTierArrow:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CurrentTierArrow)
			f10_arg0.XP:completeAnimation()
			f10_arg0.XP:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.XP)
		end,
	},
	Unreached = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.CurrentTierArrow:completeAnimation()
			f11_arg0.CurrentTierArrow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CurrentTierArrow)
			f11_arg0.XP:completeAnimation()
			f11_arg0.XP:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.XP)
		end,
	},
	CurrentTier = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(6)
			f12_arg0.ImageX:completeAnimation()
			f12_arg0.ImageX:setRGB(0, 0, 0)
			f12_arg0.clipFinished(f12_arg0.ImageX)
			f12_arg0.Glow:completeAnimation()
			f12_arg0.Glow:setAlpha(0.6)
			f12_arg0.clipFinished(f12_arg0.Glow)
			f12_arg0.Background:completeAnimation()
			f12_arg0.Background:setRGB(1, 0.93, 0)
			f12_arg0.Background:setAlpha(0.7)
			f12_arg0.clipFinished(f12_arg0.Background)
			f12_arg0.DotTiledBacking:completeAnimation()
			f12_arg0.DotTiledBacking:setAlpha(0.25)
			f12_arg0.clipFinished(f12_arg0.DotTiledBacking)
			f12_arg0.FocusBorder:completeAnimation()
			f12_arg0.FocusBorder:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.FocusBorder)
			f12_arg0.TierText:completeAnimation()
			f12_arg0.TierText:setRGB(0, 0, 0)
			f12_arg0.clipFinished(f12_arg0.TierText)
		end,
	},
}
CoD.Challenges_TierIcon.__onClose = function(f13_arg0)
	f13_arg0.ImageX:close()
	f13_arg0.DotTiledBacking:close()
	f13_arg0.TierText:close()
	f13_arg0.XP:close()
end
