require("x64:dab8c3a6f5b136c")
require("x64:5f8cf56752aa71b")
CoD.CommonListButtonLeftInternal = InheritFrom(LUI.UIElement)
CoD.CommonListButtonLeftInternal.__defaultWidth = 500
CoD.CommonListButtonLeftInternal.__defaultHeight = 40
CoD.CommonListButtonLeftInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonListButtonLeftInternal)
	self.id = "CommonListButtonLeftInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.95)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Tint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Tint:setRGB(0, 0, 0)
	Tint:setAlpha(0.75)
	self:addElement(Tint)
	self.Tint = Tint
	local FocusGlow = LUI.UIImage.new(0, 1, -130, 130, 0, 1, -158, 158)
	FocusGlow:setAlpha(0)
	FocusGlow:setScale(0.99, 0.8)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_tab_glow"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.21, 0.09)
	FocusGlow:setShaderVector(1, 1.36, 0, 0, 0)
	FocusGlow:setupNineSliceShader(245, 185)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local FocusHighlight = LUI.UIImage.new(0, 1, -52, 52, 0, 1, -42, 42)
	FocusHighlight:setAlpha(0)
	FocusHighlight:setImage(RegisterImage(@"uie_ui_menu_common_tab_backing"))
	FocusHighlight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusHighlight:setShaderVector(0, 0, 0, 0.27, 0.18)
	FocusHighlight:setShaderVector(1, 0.9, 0, 0, 0)
	FocusHighlight:setupNineSliceShader(135, 70)
	self:addElement(FocusHighlight)
	self.FocusHighlight = FocusHighlight
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
	DotTiledBacking.TiledShaderImage:setAlpha(0.15)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.1)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local Title = LUI.UIText.new(0, 0, 9, 492, 0.5, 0.5, -11, 11)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(1)
	Title:setLineSpacing(1)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Title:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(ConvertToUpperString(CoD.BaseUtility.LocalizeIfXHash(f2_local0)))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 0, 40)
	CommonButtonOutline.FocusGlow:setScale(1, 0.7)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1) and not PropertyIsTrue(self, "hideHelpItemLabel")
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonListButtonLeftInternal.__resetProperties = function(f5_arg0)
	f5_arg0.DotTiledBacking:completeAnimation()
	f5_arg0.FocusHighlight:completeAnimation()
	f5_arg0.FocusGlow:completeAnimation()
	f5_arg0.Title:completeAnimation()
	f5_arg0.DotTiledBacking:setAlpha(1)
	f5_arg0.FocusHighlight:setAlpha(0)
	f5_arg0.FocusGlow:setAlpha(0)
	f5_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f5_arg0.Title:setAlpha(1)
end
CoD.CommonListButtonLeftInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DotTiledBacking:completeAnimation()
			f6_arg0.DotTiledBacking:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.DotTiledBacking)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.FocusGlow:completeAnimation()
			f7_arg0.FocusGlow:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.FocusGlow)
			f7_arg0.FocusHighlight:completeAnimation()
			f7_arg0.FocusHighlight:setAlpha(0.5)
			f7_arg0.clipFinished(f7_arg0.FocusHighlight)
			f7_arg0.Title:completeAnimation()
			f7_arg0.Title:setRGB(0, 0, 0)
			f7_arg0.clipFinished(f7_arg0.Title)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			local f8_local0 = function(f9_arg0)
				f8_arg0.FocusGlow:beginAnimation(150)
				f8_arg0.FocusGlow:setAlpha(1)
				f8_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FocusGlow:completeAnimation()
			f8_arg0.FocusGlow:setAlpha(0)
			f8_local0(f8_arg0.FocusGlow)
			local f8_local1 = function(f10_arg0)
				f8_arg0.FocusHighlight:beginAnimation(150)
				f8_arg0.FocusHighlight:setAlpha(0.5)
				f8_arg0.FocusHighlight:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusHighlight:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FocusHighlight:completeAnimation()
			f8_arg0.FocusHighlight:setAlpha(0)
			f8_local1(f8_arg0.FocusHighlight)
			f8_arg0.DotTiledBacking:completeAnimation()
			f8_arg0.DotTiledBacking:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.DotTiledBacking)
			local f8_local2 = function(f11_arg0)
				f8_arg0.Title:beginAnimation(150)
				f8_arg0.Title:setRGB(0, 0, 0)
				f8_arg0.Title:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Title:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Title:completeAnimation()
			f8_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f8_local2(f8_arg0.Title)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			local f12_local0 = function(f13_arg0)
				f12_arg0.FocusGlow:beginAnimation(100)
				f12_arg0.FocusGlow:setAlpha(0)
				f12_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FocusGlow:completeAnimation()
			f12_arg0.FocusGlow:setAlpha(1)
			f12_local0(f12_arg0.FocusGlow)
			local f12_local1 = function(f14_arg0)
				f12_arg0.FocusHighlight:beginAnimation(100)
				f12_arg0.FocusHighlight:setAlpha(0)
				f12_arg0.FocusHighlight:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FocusHighlight:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FocusHighlight:completeAnimation()
			f12_arg0.FocusHighlight:setAlpha(0.5)
			f12_local1(f12_arg0.FocusHighlight)
			f12_arg0.DotTiledBacking:completeAnimation()
			f12_arg0.DotTiledBacking:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.DotTiledBacking)
			local f12_local2 = function(f15_arg0)
				f12_arg0.Title:beginAnimation(100)
				f12_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f12_arg0.Title:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Title:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Title:completeAnimation()
			f12_arg0.Title:setRGB(0, 0, 0)
			f12_local2(f12_arg0.Title)
		end,
	},
	Disabled = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Title:completeAnimation()
			f16_arg0.Title:setAlpha(0.2)
			f16_arg0.clipFinished(f16_arg0.Title)
		end,
	},
}
CoD.CommonListButtonLeftInternal.__onClose = function(f17_arg0)
	f17_arg0.DotTiledBacking:close()
	f17_arg0.Title:close()
	f17_arg0.CommonButtonOutline:close()
end
