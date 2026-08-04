require("ui/uieditor/widgets/common/commonpixelbacking")
require("ui/uieditor/widgets/director/directorselectbuttonlines")
require("ui/uieditor/widgets/pc/footer/footerbutton_tooltip")
CoD.FooterButton_QuitBack = InheritFrom(LUI.UIElement)
CoD.FooterButton_QuitBack.__defaultWidth = 150
CoD.FooterButton_QuitBack.__defaultHeight = 54
CoD.FooterButton_QuitBack.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButton_QuitBack)
	self.id = "FooterButton_QuitBack"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.09, 0.09, 0.09)
	self:addElement(BG)
	self.BG = BG
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local FocusGlow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FocusGlow:setAlpha(0)
	FocusGlow:setScale(2, 6)
	FocusGlow:setImage(RegisterImage("uie_ui_menu_common_tab_glow"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.21, 0.09)
	FocusGlow:setShaderVector(1, 1.36, 0, 0, 0)
	FocusGlow:setupNineSliceShader(245, 185)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local FocusHighlight = LUI.UIImage.new(-0.3, 1.3, 1, 1, -0.75, 1.75, 0, 0)
	FocusHighlight:setAlpha(0)
	FocusHighlight:setImage(RegisterImage("uie_ui_menu_common_tab_backing"))
	FocusHighlight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusHighlight:setShaderVector(0, 0, 0, 0.27, 0.18)
	FocusHighlight:setShaderVector(1, 0.9, 0, 0, 0)
	FocusHighlight:setupNineSliceShader(135, 70)
	self:addElement(FocusHighlight)
	self.FocusHighlight = FocusHighlight
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
	DotTiledBacking.TiledShaderImage:setAlpha(0.15)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	Lines:setAlpha(0.4)
	self:addElement(Lines)
	self.Lines = Lines
	local buttonPromptImage = LUI.UIImage.new(0.06, 0.06, 6, 36, 0.5, 0.5, -15, 15)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0.5, 0.5, -75, 75, 0.5, 0.5, -8.5, 8.5)
	label:setRGB(0.58, 0.56, 0.49)
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(5)
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	label:linkToElementModel(self, "Label", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			label:setText(LocalizeToUpperString(CoD.PCUtility.ReplaceButtonLabelForPC(f1_arg1, f2_local0)))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(label, "setText", function(element, controller)
		CoD.PCUtility.UpscaleFooterLabelIfStringIcon(element)
		CoD.PCUtility.ResizeButtonWithButtonPromptImage(self, f1_arg1, element)
	end)
	label:subscribeToGlobalModel(f1_arg1, "PerController", "LastInput", function(model)
		CoD.PCUtility.ResizeButtonWithButtonPromptImage(self, f1_arg1, label)
	end)
	self:addElement(label)
	self.label = label
	local footerTooltip = CoD.FooterButton_Tooltip.new(f1_arg0, f1_arg1, 0, 0, 0, 262, 0, 0, -36, 0)
	footerTooltip:setAlpha(0)
	footerTooltip:linkToElementModel(self, "TooltipLabel", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			footerTooltip.label:setText(ConvertToUpperString(f5_local0))
		end
	end)
	footerTooltip:linkToElementModel(self, "TooltipKeyShortcut", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(footerTooltip)
	self.footerTooltip = footerTooltip
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				local f7_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_disable_prompts"])
				if f7_local0 then
					if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
						f7_local0 = IsMouseOrKeyboard(f1_arg1)
						if f7_local0 then
							f7_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "Label")
							if f7_local0 then
								f7_local0 = not ShouldHideButtonPromptForPC(element, f1_arg1)
							end
						end
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "DisabledGamepad",
			condition = function(menu, element, event)
				local f8_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_disable_prompts"])
				if f8_local0 then
					if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
						f8_local0 = IsGamepad(f1_arg1)
						if f8_local0 then
							f8_local0 = not ShouldHideButtonPromptForPC(element, f1_arg1)
						end
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f9_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_enable_prompts"])
				if f9_local0 then
					if not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f9_local0 = IsMouseOrKeyboard(f1_arg1)
						if f9_local0 then
							f9_local0 = not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
						end
					else
						f9_local0 = false
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "EnabledGamepad",
			condition = function(menu, element, event)
				local f10_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_enable_prompts"])
				if f10_local0 then
					if not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f10_local0 = IsGamepad(f1_arg1)
						if f10_local0 then
							f10_local0 = not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
						end
					else
						f10_local0 = false
					end
				end
				return f10_local0
			end,
		},
		{
			stateName = "InitialState",
			condition = function(menu, element, event)
				return AlwaysFalse()
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
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local11(f1_local10, f1_local12.usingCursorInput, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local11(f1_local10, f1_local12.hidden, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine.GetModelForController(f1_arg1)
	f1_local11(f1_local10, f1_local12.activeKeys, function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
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
	self:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f17_arg1)
	end)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine.GetModelForController(f1_arg1)
	f1_local11(f1_local10, f1_local12.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "Label", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Label",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local11 = self
	if IsPC() then
		CoD.PCUtility.SetupButtonPromptForPC(self, f1_arg1, f1_arg0)
		DisableKeyboardNavigationByElement(self)
	end
	return self
end
CoD.FooterButton_QuitBack.__resetProperties = function(f20_arg0)
	f20_arg0.buttonPromptImage:completeAnimation()
	f20_arg0.label:completeAnimation()
	f20_arg0.footerTooltip:completeAnimation()
	f20_arg0.DotTiledBacking:completeAnimation()
	f20_arg0.Lines:completeAnimation()
	f20_arg0.FocusHighlight:completeAnimation()
	f20_arg0.FocusGlow:completeAnimation()
	f20_arg0.buttonPromptImage:setRGB(1, 1, 1)
	f20_arg0.buttonPromptImage:setAlpha(1)
	f20_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
	f20_arg0.buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	f20_arg0.label:setAlpha(1)
	f20_arg0.label:setScale(1, 1)
	f20_arg0.footerTooltip:setAlpha(0)
	f20_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
	f20_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.15)
	f20_arg0.Lines:setAlpha(0.4)
	f20_arg0.FocusHighlight:setAlpha(0)
	f20_arg0.FocusGlow:setAlpha(0)
end
CoD.FooterButton_QuitBack.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.buttonPromptImage:completeAnimation()
			f21_arg0.buttonPromptImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.buttonPromptImage)
			f21_arg0.label:completeAnimation()
			f21_arg0.label:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.label)
			f21_arg0.footerTooltip:completeAnimation()
			f21_arg0.footerTooltip:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.footerTooltip)
		end,
	},
	Disabled = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.buttonPromptImage:completeAnimation()
			f22_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f22_arg0.buttonPromptImage:setAlpha(0)
			f22_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
			f22_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f22_arg0.clipFinished(f22_arg0.buttonPromptImage)
			f22_arg0.label:completeAnimation()
			f22_arg0.label:setAlpha(0.2)
			f22_arg0.clipFinished(f22_arg0.label)
		end,
	},
	DisabledGamepad = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.buttonPromptImage:completeAnimation()
			f23_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f23_arg0.buttonPromptImage:setAlpha(0.2)
			f23_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
			f23_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f23_arg0.clipFinished(f23_arg0.buttonPromptImage)
			f23_arg0.label:completeAnimation()
			f23_arg0.label:setAlpha(0.2)
			f23_arg0.clipFinished(f23_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.buttonPromptImage:completeAnimation()
			f24_arg0.buttonPromptImage:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.buttonPromptImage)
			f24_arg0.footerTooltip:completeAnimation()
			f24_arg0.footerTooltip:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.footerTooltip)
		end,
		Hide = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.buttonPromptImage:completeAnimation()
			f25_arg0.buttonPromptImage:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.buttonPromptImage)
			f25_arg0.label:completeAnimation()
			f25_arg0.label:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.label)
			f25_arg0.footerTooltip:completeAnimation()
			f25_arg0.footerTooltip:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.footerTooltip)
		end,
		Focus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(7)
			f26_arg0.FocusGlow:completeAnimation()
			f26_arg0.FocusGlow:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.FocusGlow)
			f26_arg0.FocusHighlight:completeAnimation()
			f26_arg0.FocusHighlight:setAlpha(0.5)
			f26_arg0.clipFinished(f26_arg0.FocusHighlight)
			f26_arg0.DotTiledBacking:completeAnimation()
			f26_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f26_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
			f26_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.7)
			f26_arg0.clipFinished(f26_arg0.DotTiledBacking)
			f26_arg0.Lines:completeAnimation()
			f26_arg0.Lines:setAlpha(0.2)
			f26_arg0.clipFinished(f26_arg0.Lines)
			f26_arg0.buttonPromptImage:completeAnimation()
			f26_arg0.buttonPromptImage:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.buttonPromptImage)
			f26_arg0.label:completeAnimation()
			f26_arg0.label:setScale(1.1, 1.1)
			f26_arg0.clipFinished(f26_arg0.label)
			f26_arg0.footerTooltip:completeAnimation()
			f26_arg0.footerTooltip:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.footerTooltip)
		end,
		GainFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(7)
			local f27_local0 = function(f28_arg0)
				f27_arg0.FocusGlow:beginAnimation(200)
				f27_arg0.FocusGlow:setAlpha(1)
				f27_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.FocusGlow:completeAnimation()
			f27_arg0.FocusGlow:setAlpha(0)
			f27_local0(f27_arg0.FocusGlow)
			local f27_local1 = function(f29_arg0)
				f27_arg0.FocusHighlight:beginAnimation(200)
				f27_arg0.FocusHighlight:setAlpha(0.5)
				f27_arg0.FocusHighlight:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.FocusHighlight:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.FocusHighlight:completeAnimation()
			f27_arg0.FocusHighlight:setAlpha(0)
			f27_local1(f27_arg0.FocusHighlight)
			local f27_local2 = function(f30_arg0)
				f27_arg0.DotTiledBacking:beginAnimation(200)
				f27_arg0.DotTiledBacking.TiledShaderImage:beginAnimation(200)
				f27_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
				f27_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.7)
				f27_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.DotTiledBacking:completeAnimation()
			f27_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f27_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
			f27_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.15)
			f27_local2(f27_arg0.DotTiledBacking)
			local f27_local3 = function(f31_arg0)
				f27_arg0.Lines:beginAnimation(200)
				f27_arg0.Lines:setAlpha(0.2)
				f27_arg0.Lines:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.Lines:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.Lines:completeAnimation()
			f27_arg0.Lines:setAlpha(0.4)
			f27_local3(f27_arg0.Lines)
			f27_arg0.buttonPromptImage:completeAnimation()
			f27_arg0.buttonPromptImage:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.buttonPromptImage)
			local f27_local4 = function(f32_arg0)
				f27_arg0.label:beginAnimation(100)
				f27_arg0.label:setScale(1.1, 1.1)
				f27_arg0.label:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.label:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.label:completeAnimation()
			f27_arg0.label:setScale(1, 1)
			f27_local4(f27_arg0.label)
			local f27_local5 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(500)
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.footerTooltip:beginAnimation(500)
				f27_arg0.footerTooltip:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.footerTooltip:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f27_arg0.footerTooltip:completeAnimation()
			f27_arg0.footerTooltip:setAlpha(0)
			f27_local5(f27_arg0.footerTooltip)
		end,
		LoseFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(7)
			local f35_local0 = function(f36_arg0)
				f35_arg0.FocusGlow:beginAnimation(200)
				f35_arg0.FocusGlow:setAlpha(0)
				f35_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FocusGlow:completeAnimation()
			f35_arg0.FocusGlow:setAlpha(1)
			f35_local0(f35_arg0.FocusGlow)
			local f35_local1 = function(f37_arg0)
				f35_arg0.FocusHighlight:beginAnimation(200)
				f35_arg0.FocusHighlight:setAlpha(0)
				f35_arg0.FocusHighlight:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FocusHighlight:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FocusHighlight:completeAnimation()
			f35_arg0.FocusHighlight:setAlpha(0.5)
			f35_local1(f35_arg0.FocusHighlight)
			local f35_local2 = function(f38_arg0)
				f35_arg0.DotTiledBacking:beginAnimation(200)
				f35_arg0.DotTiledBacking.TiledShaderImage:beginAnimation(200)
				f35_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
				f35_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.15)
				f35_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.DotTiledBacking:completeAnimation()
			f35_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f35_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
			f35_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.7)
			f35_local2(f35_arg0.DotTiledBacking)
			local f35_local3 = function(f39_arg0)
				f35_arg0.Lines:beginAnimation(200)
				f35_arg0.Lines:setAlpha(0.4)
				f35_arg0.Lines:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Lines:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.Lines:completeAnimation()
			f35_arg0.Lines:setAlpha(0.2)
			f35_local3(f35_arg0.Lines)
			f35_arg0.buttonPromptImage:completeAnimation()
			f35_arg0.buttonPromptImage:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.buttonPromptImage)
			local f35_local4 = function(f40_arg0)
				f35_arg0.label:beginAnimation(200)
				f35_arg0.label:setScale(1, 1)
				f35_arg0.label:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.label:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.label:completeAnimation()
			f35_arg0.label:setScale(1.1, 1.1)
			f35_local4(f35_arg0.label)
			f35_arg0.footerTooltip:completeAnimation()
			f35_arg0.footerTooltip:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.footerTooltip)
		end,
	},
	EnabledGamepad = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			f41_arg0.buttonPromptImage:completeAnimation()
			f41_arg0.buttonPromptImage:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.buttonPromptImage)
			f41_arg0.footerTooltip:completeAnimation()
			f41_arg0.footerTooltip:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.footerTooltip)
		end,
		Hide = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(3)
			f42_arg0.buttonPromptImage:completeAnimation()
			f42_arg0.buttonPromptImage:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.buttonPromptImage)
			f42_arg0.label:completeAnimation()
			f42_arg0.label:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.label)
			f42_arg0.footerTooltip:completeAnimation()
			f42_arg0.footerTooltip:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.footerTooltip)
		end,
		Focus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(7)
			f43_arg0.FocusGlow:completeAnimation()
			f43_arg0.FocusGlow:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.FocusGlow)
			f43_arg0.FocusHighlight:completeAnimation()
			f43_arg0.FocusHighlight:setAlpha(0.5)
			f43_arg0.clipFinished(f43_arg0.FocusHighlight)
			f43_arg0.DotTiledBacking:completeAnimation()
			f43_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f43_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
			f43_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.7)
			f43_arg0.clipFinished(f43_arg0.DotTiledBacking)
			f43_arg0.Lines:completeAnimation()
			f43_arg0.Lines:setAlpha(0.2)
			f43_arg0.clipFinished(f43_arg0.Lines)
			f43_arg0.buttonPromptImage:completeAnimation()
			f43_arg0.buttonPromptImage:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.buttonPromptImage)
			f43_arg0.label:completeAnimation()
			f43_arg0.label:setScale(1.1, 1.1)
			f43_arg0.clipFinished(f43_arg0.label)
			f43_arg0.footerTooltip:completeAnimation()
			f43_arg0.footerTooltip:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.footerTooltip)
		end,
		LoseFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(7)
			local f44_local0 = function(f45_arg0)
				f44_arg0.FocusGlow:beginAnimation(200)
				f44_arg0.FocusGlow:setAlpha(0)
				f44_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.FocusGlow:completeAnimation()
			f44_arg0.FocusGlow:setAlpha(1)
			f44_local0(f44_arg0.FocusGlow)
			local f44_local1 = function(f46_arg0)
				f44_arg0.FocusHighlight:beginAnimation(200)
				f44_arg0.FocusHighlight:setAlpha(0)
				f44_arg0.FocusHighlight:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.FocusHighlight:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.FocusHighlight:completeAnimation()
			f44_arg0.FocusHighlight:setAlpha(0.5)
			f44_local1(f44_arg0.FocusHighlight)
			local f44_local2 = function(f47_arg0)
				f44_arg0.DotTiledBacking:beginAnimation(200)
				f44_arg0.DotTiledBacking.TiledShaderImage:beginAnimation(200)
				f44_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
				f44_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.15)
				f44_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.DotTiledBacking:completeAnimation()
			f44_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f44_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
			f44_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.7)
			f44_local2(f44_arg0.DotTiledBacking)
			local f44_local3 = function(f48_arg0)
				f44_arg0.Lines:beginAnimation(200)
				f44_arg0.Lines:setAlpha(0.4)
				f44_arg0.Lines:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.Lines:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.Lines:completeAnimation()
			f44_arg0.Lines:setAlpha(0.2)
			f44_local3(f44_arg0.Lines)
			f44_arg0.buttonPromptImage:completeAnimation()
			f44_arg0.buttonPromptImage:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.buttonPromptImage)
			local f44_local4 = function(f49_arg0)
				f44_arg0.label:beginAnimation(200)
				f44_arg0.label:setScale(1, 1)
				f44_arg0.label:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.label:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.label:completeAnimation()
			f44_arg0.label:setScale(1.1, 1.1)
			f44_local4(f44_arg0.label)
			f44_arg0.footerTooltip:completeAnimation()
			f44_arg0.footerTooltip:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.footerTooltip)
		end,
		GainFocus = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(7)
			local f50_local0 = function(f51_arg0)
				f50_arg0.FocusGlow:beginAnimation(200)
				f50_arg0.FocusGlow:setAlpha(1)
				f50_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.FocusGlow:completeAnimation()
			f50_arg0.FocusGlow:setAlpha(0)
			f50_local0(f50_arg0.FocusGlow)
			local f50_local1 = function(f52_arg0)
				f50_arg0.FocusHighlight:beginAnimation(200)
				f50_arg0.FocusHighlight:setAlpha(0.5)
				f50_arg0.FocusHighlight:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.FocusHighlight:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.FocusHighlight:completeAnimation()
			f50_arg0.FocusHighlight:setAlpha(0)
			f50_local1(f50_arg0.FocusHighlight)
			local f50_local2 = function(f53_arg0)
				f50_arg0.DotTiledBacking:beginAnimation(200)
				f50_arg0.DotTiledBacking.TiledShaderImage:beginAnimation(200)
				f50_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
				f50_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.7)
				f50_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.DotTiledBacking:completeAnimation()
			f50_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f50_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
			f50_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.15)
			f50_local2(f50_arg0.DotTiledBacking)
			local f50_local3 = function(f54_arg0)
				f50_arg0.Lines:beginAnimation(200)
				f50_arg0.Lines:setAlpha(0.2)
				f50_arg0.Lines:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.Lines:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.Lines:completeAnimation()
			f50_arg0.Lines:setAlpha(0.4)
			f50_local3(f50_arg0.Lines)
			f50_arg0.buttonPromptImage:completeAnimation()
			f50_arg0.buttonPromptImage:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.buttonPromptImage)
			local f50_local4 = function(f55_arg0)
				f50_arg0.label:beginAnimation(100)
				f50_arg0.label:setScale(1.1, 1.1)
				f50_arg0.label:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.label:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.label:completeAnimation()
			f50_arg0.label:setScale(1, 1)
			f50_local4(f50_arg0.label)
			local f50_local5 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					f57_arg0:beginAnimation(500)
					f57_arg0:setAlpha(1)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
				end
				f50_arg0.footerTooltip:beginAnimation(500)
				f50_arg0.footerTooltip:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.footerTooltip:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f50_arg0.footerTooltip:completeAnimation()
			f50_arg0.footerTooltip:setAlpha(0)
			f50_local5(f50_arg0.footerTooltip)
		end,
	},
	InitialState = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(0)
		end,
	},
}
if not CoD.isPC then
	CoD.FooterButton_QuitBack.__clipsPerState.Enabled.Focus = nil
	CoD.FooterButton_QuitBack.__clipsPerState.Enabled.GainFocus = nil
	CoD.FooterButton_QuitBack.__clipsPerState.Enabled.LoseFocus = nil
	CoD.FooterButton_QuitBack.__clipsPerState.EnabledGamepad.Focus = nil
	CoD.FooterButton_QuitBack.__clipsPerState.EnabledGamepad.LoseFocus = nil
	CoD.FooterButton_QuitBack.__clipsPerState.EnabledGamepad.GainFocus = nil
end
CoD.FooterButton_QuitBack.__onClose = function(f59_arg0)
	f59_arg0.DotTiledBacking:close()
	f59_arg0.Lines:close()
	f59_arg0.label:close()
	f59_arg0.footerTooltip:close()
end
