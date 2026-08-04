require("ui/uieditor/widgets/cac/newbreadcrumbcount")
require("ui/uieditor/widgets/common/commonbuttonoutlinethin")
require("ui/uieditor/widgets/common/commonpixelbacking")
CoD.PC_FullscreenPopup_Buttons = InheritFrom(LUI.UIElement)
CoD.PC_FullscreenPopup_Buttons.__defaultWidth = 190
CoD.PC_FullscreenPopup_Buttons.__defaultHeight = 60
CoD.PC_FullscreenPopup_Buttons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_FullscreenPopup_Buttons)
	self.id = "PC_FullscreenPopup_Buttons"
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
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.09, 0.09, 0.09)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local FocusGlow = LUI.UIImage.new(0, 1, -75, 75, 0, 1, -166, 166)
	FocusGlow:setImage(RegisterImage("uie_ui_menu_common_tab_glow"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.21, 0.09)
	FocusGlow:setShaderVector(1, 1.36, 0, 0, 0)
	FocusGlow:setupNineSliceShader(150, 200)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
	DotTiledBacking.TiledShaderImage:setAlpha(0.7)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FocusHighlight = LUI.UIImage.new(0, 1, -52, 52, 0, 1, -42, 42)
	FocusHighlight:setAlpha(0.5)
	FocusHighlight:setImage(RegisterImage("uie_ui_menu_common_tab_backing"))
	FocusHighlight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusHighlight:setShaderVector(0, 0, 0, 0.27, 0.18)
	FocusHighlight:setShaderVector(1, 0.9, 0, 0, 0)
	FocusHighlight:setupNineSliceShader(135, 70)
	self:addElement(FocusHighlight)
	self.FocusHighlight = FocusHighlight
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage("uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local Title = LUI.UIText.new(0, 1, 12, -12, 0.5, 0.5, -10.5, 11.5)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(3)
	Title:setLineSpacing(1)
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	Title:linkToElementModel(self, "Label", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Icon = LUI.UIFixedAspectRatioImage.new(0, 1, 0, 0, 0.5, 0.5, -30, 30)
	Icon:setAlpha(0)
	self:addElement(Icon)
	self.Icon = Icon
	local CommonButtonOutlineThin = CoD.CommonButtonOutlineThin.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0, 1, 0, 0)
	CommonButtonOutlineThin:linkToElementModel(self, nil, false, function(model)
		CommonButtonOutlineThin:setModel(model, f1_arg1)
	end)
	self:addElement(CommonButtonOutlineThin)
	self.CommonButtonOutlineThin = CommonButtonOutlineThin
	local newIcon = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 0, 0, -11, 8, 0.5, 0.5, -9, 9)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.ShouldShowTheMenuBreadcrumb(element, f1_arg1)
			end,
		},
	})
	newIcon:linkToElementModel(newIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	newIcon:setYRot(180)
	self:addElement(newIcon)
	self.newIcon = newIcon
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_disable_prompts"])
				if f6_local0 then
					if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
						f6_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "Label")
					else
						f6_local0 = false
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f8_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_enable_prompts"])
				if f8_local0 then
					if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
						f8_local0 = not ShouldHideButtonPromptForPC(element, f1_arg1)
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
	})
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local13(f1_local12, f1_local14.usingCursorInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local13(f1_local12, f1_local14.hidden, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine.GetModelForController(f1_arg1)
	f1_local13(f1_local12, f1_local14.activeKeys, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	self:linkToElementModel(self, "flags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	self:linkToElementModel(self, "Label", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Label",
		})
	end)
	CommonButtonOutlineThin.id = "CommonButtonOutlineThin"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local13 = self
	CoD.PCUtility.SetupButtonPromptForPC(self, f1_arg1, f1_arg0)
	return self
end
CoD.PC_FullscreenPopup_Buttons.__resetProperties = function(f15_arg0)
	f15_arg0.Title:completeAnimation()
	f15_arg0.FocusHighlight:completeAnimation()
	f15_arg0.DotTiledBacking:completeAnimation()
	f15_arg0.FocusGlow:completeAnimation()
	f15_arg0.Blur:completeAnimation()
	f15_arg0.Background:completeAnimation()
	f15_arg0.NoiseTiledBacking:completeAnimation()
	f15_arg0.FrontendFrame:completeAnimation()
	f15_arg0.CommonButtonOutlineThin:completeAnimation()
	f15_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f15_arg0.Title:setAlpha(1)
	f15_arg0.FocusHighlight:setAlpha(0.5)
	f15_arg0.DotTiledBacking:setAlpha(1)
	f15_arg0.FocusGlow:setAlpha(1)
	f15_arg0.Blur:setAlpha(1)
	f15_arg0.Background:setAlpha(0.9)
	f15_arg0.NoiseTiledBacking:setAlpha(0.5)
	f15_arg0.FrontendFrame:setAlpha(0.2)
	f15_arg0.CommonButtonOutlineThin:setAlpha(1)
end
CoD.PC_FullscreenPopup_Buttons.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.FocusGlow:completeAnimation()
			f17_arg0.FocusGlow:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.FocusGlow)
			f17_arg0.DotTiledBacking:completeAnimation()
			f17_arg0.DotTiledBacking:setAlpha(0.4)
			f17_arg0.clipFinished(f17_arg0.DotTiledBacking)
			f17_arg0.FocusHighlight:completeAnimation()
			f17_arg0.FocusHighlight:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.FocusHighlight)
			f17_arg0.Title:completeAnimation()
			f17_arg0.Title:setAlpha(0.2)
			f17_arg0.clipFinished(f17_arg0.Title)
		end,
	},
	Hidden = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(9)
			f18_arg0.Blur:completeAnimation()
			f18_arg0.Blur:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Blur)
			f18_arg0.Background:completeAnimation()
			f18_arg0.Background:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Background)
			f18_arg0.NoiseTiledBacking:completeAnimation()
			f18_arg0.NoiseTiledBacking:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.NoiseTiledBacking)
			f18_arg0.FocusGlow:completeAnimation()
			f18_arg0.FocusGlow:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.FocusGlow)
			f18_arg0.DotTiledBacking:completeAnimation()
			f18_arg0.DotTiledBacking:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.DotTiledBacking)
			f18_arg0.FocusHighlight:completeAnimation()
			f18_arg0.FocusHighlight:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.FocusHighlight)
			f18_arg0.FrontendFrame:completeAnimation()
			f18_arg0.FrontendFrame:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.FrontendFrame)
			f18_arg0.Title:completeAnimation()
			f18_arg0.Title:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Title)
			f18_arg0.CommonButtonOutlineThin:completeAnimation()
			f18_arg0.CommonButtonOutlineThin:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.CommonButtonOutlineThin)
		end,
	},
	Enabled = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.FocusGlow:completeAnimation()
			f19_arg0.FocusGlow:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.FocusGlow)
			f19_arg0.DotTiledBacking:completeAnimation()
			f19_arg0.DotTiledBacking:setAlpha(0.5)
			f19_arg0.clipFinished(f19_arg0.DotTiledBacking)
			f19_arg0.FocusHighlight:completeAnimation()
			f19_arg0.FocusHighlight:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.FocusHighlight)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			f20_arg0.FocusGlow:completeAnimation()
			f20_arg0.FocusGlow:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FocusGlow)
			f20_arg0.DotTiledBacking:completeAnimation()
			f20_arg0.DotTiledBacking:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.DotTiledBacking)
			f20_arg0.FocusHighlight:completeAnimation()
			f20_arg0.FocusHighlight:setAlpha(0.5)
			f20_arg0.clipFinished(f20_arg0.FocusHighlight)
			f20_arg0.Title:completeAnimation()
			f20_arg0.Title:setRGB(0, 0, 0)
			f20_arg0.Title:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.Title)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			local f21_local0 = function(f22_arg0)
				f21_arg0.FocusGlow:beginAnimation(200)
				f21_arg0.FocusGlow:setAlpha(1)
				f21_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.FocusGlow:completeAnimation()
			f21_arg0.FocusGlow:setAlpha(0)
			f21_local0(f21_arg0.FocusGlow)
			local f21_local1 = function(f23_arg0)
				f21_arg0.DotTiledBacking:beginAnimation(200)
				f21_arg0.DotTiledBacking:setAlpha(1)
				f21_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.DotTiledBacking:completeAnimation()
			f21_arg0.DotTiledBacking:setAlpha(0.5)
			f21_local1(f21_arg0.DotTiledBacking)
			local f21_local2 = function(f24_arg0)
				f21_arg0.FocusHighlight:beginAnimation(200)
				f21_arg0.FocusHighlight:setAlpha(0.5)
				f21_arg0.FocusHighlight:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.FocusHighlight:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.FocusHighlight:completeAnimation()
			f21_arg0.FocusHighlight:setAlpha(0)
			f21_local2(f21_arg0.FocusHighlight)
			local f21_local3 = function(f25_arg0)
				f21_arg0.Title:beginAnimation(200)
				f21_arg0.Title:setRGB(0, 0, 0)
				f21_arg0.Title:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Title:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Title:completeAnimation()
			f21_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f21_arg0.Title:setAlpha(1)
			f21_local3(f21_arg0.Title)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			local f26_local0 = function(f27_arg0)
				f26_arg0.FocusGlow:beginAnimation(200)
				f26_arg0.FocusGlow:setAlpha(0)
				f26_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FocusGlow:completeAnimation()
			f26_arg0.FocusGlow:setAlpha(1)
			f26_local0(f26_arg0.FocusGlow)
			local f26_local1 = function(f28_arg0)
				f26_arg0.DotTiledBacking:beginAnimation(200)
				f26_arg0.DotTiledBacking:setAlpha(0.5)
				f26_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.DotTiledBacking:completeAnimation()
			f26_arg0.DotTiledBacking:setAlpha(1)
			f26_local1(f26_arg0.DotTiledBacking)
			local f26_local2 = function(f29_arg0)
				f26_arg0.FocusHighlight:beginAnimation(200)
				f26_arg0.FocusHighlight:setAlpha(0)
				f26_arg0.FocusHighlight:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FocusHighlight:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FocusHighlight:completeAnimation()
			f26_arg0.FocusHighlight:setAlpha(0.5)
			f26_local2(f26_arg0.FocusHighlight)
			local f26_local3 = function(f30_arg0)
				f26_arg0.Title:beginAnimation(200)
				f26_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f26_arg0.Title:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Title:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Title:completeAnimation()
			f26_arg0.Title:setRGB(0, 0, 0)
			f26_arg0.Title:setAlpha(1)
			f26_local3(f26_arg0.Title)
		end,
	},
}
CoD.PC_FullscreenPopup_Buttons.__onClose = function(f31_arg0)
	f31_arg0.DotTiledBacking:close()
	f31_arg0.Title:close()
	f31_arg0.CommonButtonOutlineThin:close()
	f31_arg0.newIcon:close()
end
