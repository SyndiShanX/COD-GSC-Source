require("ui/uieditor/widgets/buttonprogressringcontainer")
require("ui/uieditor/widgets/cac/newbreadcrumbcount")
require("ui/uieditor/widgets/common/commonpixelbacking")
require("ui/uieditor/widgets/pc/footer/footerbutton_tooltip")
CoD.FooterButtonPromptPC = InheritFrom(LUI.UIElement)
CoD.FooterButtonPromptPC.__defaultWidth = 150
CoD.FooterButtonPromptPC.__defaultHeight = 54
CoD.FooterButtonPromptPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButtonPromptPC)
	self.id = "FooterButtonPromptPC"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingTint:setRGB(0.26, 0.09, 0.01)
	BackingTint:setAlpha(0)
	BackingTint:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BackingTint:setShaderVector(0, 1.3, 0, 0, 0)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local buttonPromptImage = LUI.UIImage.new(0.06, 0.06, 6, 36, 0.5, 0.5, -18, 12)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0.5, 0.5, -75, 75, 0.5, 0.5, -12, 6)
	label:setRGB(0.58, 0.56, 0.49)
	label:setTTF("ttmussels_demibold")
	label:setLetterSpacing(4)
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
	local GlowAdd = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -61, -1)
	GlowAdd:setAlpha(0)
	GlowAdd:setImage(RegisterImage("uie_circularglow"))
	GlowAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(GlowAdd)
	self.GlowAdd = GlowAdd
	local BigBarGlow = LUI.UIImage.new(-0.5, 1.5, 0, 0, 1, 1, -20, 15)
	BigBarGlow:setAlpha(0)
	BigBarGlow:setImage(RegisterImage("uie_ui_menu_common_tab_glow"))
	BigBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BigBarGlow:setShaderVector(0, 1.36, 0, 0, 0)
	self:addElement(BigBarGlow)
	self.BigBarGlow = BigBarGlow
	local BigBarBacking = LUI.UIImage.new(-0.25, 1.25, 0, 0, 1, 1, -9, 4)
	BigBarBacking:setAlpha(0)
	BigBarBacking:setImage(RegisterImage("uie_ui_menu_common_tab_backing"))
	BigBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BigBarBacking:setShaderVector(0, 0.9, 0, 0, 0)
	self:addElement(BigBarBacking)
	self.BigBarBacking = BigBarBacking
	local SmallBarGlow = LUI.UIImage.new(-0.5, 1.5, 0, 0, 1, 1, -17, 1)
	SmallBarGlow:setAlpha(0)
	SmallBarGlow:setImage(RegisterImage("uie_ui_menu_common_tab_glow"))
	SmallBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SmallBarGlow:setShaderVector(0, 1.36, 0, 0, 0)
	self:addElement(SmallBarGlow)
	self.SmallBarGlow = SmallBarGlow
	local SmallBarBacking = LUI.UIImage.new(-0.25, 1.25, 0, 0, 1, 1, -11, -5)
	SmallBarBacking:setAlpha(0)
	SmallBarBacking:setImage(RegisterImage("uie_ui_menu_common_tab_backing"))
	SmallBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SmallBarBacking:setShaderVector(0, 0.9, 0, 0, 0)
	self:addElement(SmallBarBacking)
	self.SmallBarBacking = SmallBarBacking
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking:setAlpha(0)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
	DotTiledBacking.TiledShaderImage:setAlpha(0)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
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
	local progressRing = CoD.ButtonProgressRingContainer.new(f1_arg0, f1_arg1, 0.06, 0.06, 0, 42, 0.5, 0.5, -24, 18)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f1_arg1)
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
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
				local f10_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_disable_prompts"])
				if f10_local0 then
					if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
						f10_local0 = IsMouseOrKeyboard(f1_arg1)
						if f10_local0 then
							f10_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "Label")
							if f10_local0 then
								f10_local0 = not ShouldHideButtonPromptForPC(element, f1_arg1)
							end
						end
					else
						f10_local0 = false
					end
				end
				return f10_local0
			end,
		},
		{
			stateName = "DisabledGamepad",
			condition = function(menu, element, event)
				local f11_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_disable_prompts"])
				if f11_local0 then
					if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
						f11_local0 = IsGamepad(f1_arg1)
						if f11_local0 then
							f11_local0 = not ShouldHideButtonPromptForPC(element, f1_arg1)
						end
					else
						f11_local0 = false
					end
				end
				return f11_local0
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f12_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_enable_prompts"])
				if f12_local0 then
					if not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f12_local0 = IsMouseOrKeyboard(f1_arg1)
						if f12_local0 then
							f12_local0 = not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
						end
					else
						f12_local0 = false
					end
				end
				return f12_local0
			end,
		},
		{
			stateName = "EnabledGamepad",
			condition = function(menu, element, event)
				local f13_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_enable_prompts"])
				if f13_local0 then
					if not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f13_local0 = IsGamepad(f1_arg1)
						if f13_local0 then
							f13_local0 = not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
						end
					else
						f13_local0 = false
					end
				end
				return f13_local0
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
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.usingCursorInput, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.hidden, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine.GetModelForController(f1_arg1)
	f1_local14(f1_local13, f1_local15.activeKeys, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
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
	self:appendEventHandler("input_source_changed", function(f20_arg0, f20_arg1)
		f20_arg1.menu = f20_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f20_arg1)
	end)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine.GetModelForController(f1_arg1)
	f1_local14(f1_local13, f1_local15.LastInput, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
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
	self.__on_menuOpened_self = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
		local f23_local0 = self
		CoD.PCUtility.RestrictButtonFooterTooltipToScreenSafe(self, self.footerTooltip, f23_arg1, f23_arg2)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local14 = self
	if IsPC() then
		CoD.PCUtility.SetupButtonPromptForPC(self, f1_arg1, f1_arg0)
		DisableKeyboardNavigationByElement(self)
	end
	return self
end
CoD.FooterButtonPromptPC.__resetProperties = function(f25_arg0)
	f25_arg0.buttonPromptImage:completeAnimation()
	f25_arg0.label:completeAnimation()
	f25_arg0.footerTooltip:completeAnimation()
	f25_arg0.BackingTint:completeAnimation()
	f25_arg0.SmallBarBacking:completeAnimation()
	f25_arg0.BigBarBacking:completeAnimation()
	f25_arg0.BigBarGlow:completeAnimation()
	f25_arg0.SmallBarGlow:completeAnimation()
	f25_arg0.GlowAdd:completeAnimation()
	f25_arg0.DotTiledBacking:completeAnimation()
	f25_arg0.buttonPromptImage:setRGB(1, 1, 1)
	f25_arg0.buttonPromptImage:setAlpha(1)
	f25_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
	f25_arg0.buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	f25_arg0.label:setRGB(0.58, 0.56, 0.49)
	f25_arg0.label:setAlpha(1)
	f25_arg0.label:setScale(1, 1)
	f25_arg0.footerTooltip:setAlpha(0)
	f25_arg0.BackingTint:setAlpha(0)
	f25_arg0.SmallBarBacking:setAlpha(0)
	f25_arg0.SmallBarBacking:setShaderVector(0, 0.9, 0, 0, 0)
	f25_arg0.BigBarBacking:setAlpha(0)
	f25_arg0.BigBarBacking:setShaderVector(0, 0.9, 0, 0, 0)
	f25_arg0.BigBarGlow:setAlpha(0)
	f25_arg0.SmallBarGlow:setAlpha(0)
	f25_arg0.GlowAdd:setAlpha(0)
	f25_arg0.GlowAdd:setScale(1, 1)
	f25_arg0.DotTiledBacking:setAlpha(0)
	f25_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0)
end
CoD.FooterButtonPromptPC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.buttonPromptImage:completeAnimation()
			f26_arg0.buttonPromptImage:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.buttonPromptImage)
			f26_arg0.label:completeAnimation()
			f26_arg0.label:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.label)
			f26_arg0.footerTooltip:completeAnimation()
			f26_arg0.footerTooltip:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.footerTooltip)
		end,
	},
	Disabled = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.buttonPromptImage:completeAnimation()
			f27_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f27_arg0.buttonPromptImage:setAlpha(0)
			f27_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
			f27_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f27_arg0.clipFinished(f27_arg0.buttonPromptImage)
			f27_arg0.label:completeAnimation()
			f27_arg0.label:setAlpha(0.2)
			f27_arg0.clipFinished(f27_arg0.label)
		end,
	},
	DisabledGamepad = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.buttonPromptImage:completeAnimation()
			f28_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f28_arg0.buttonPromptImage:setAlpha(0.2)
			f28_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
			f28_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f28_arg0.clipFinished(f28_arg0.buttonPromptImage)
			f28_arg0.label:completeAnimation()
			f28_arg0.label:setAlpha(0.2)
			f28_arg0.clipFinished(f28_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.buttonPromptImage:completeAnimation()
			f29_arg0.buttonPromptImage:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.buttonPromptImage)
			f29_arg0.footerTooltip:completeAnimation()
			f29_arg0.footerTooltip:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.footerTooltip)
		end,
		Hide = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.buttonPromptImage:completeAnimation()
			f30_arg0.buttonPromptImage:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.buttonPromptImage)
			f30_arg0.label:completeAnimation()
			f30_arg0.label:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.label)
			f30_arg0.footerTooltip:completeAnimation()
			f30_arg0.footerTooltip:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.footerTooltip)
		end,
		Focus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(10)
			f31_arg0.BackingTint:completeAnimation()
			f31_arg0.BackingTint:setAlpha(0.5)
			f31_arg0.clipFinished(f31_arg0.BackingTint)
			f31_arg0.buttonPromptImage:completeAnimation()
			f31_arg0.buttonPromptImage:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.buttonPromptImage)
			f31_arg0.label:completeAnimation()
			f31_arg0.label:setRGB(1, 0.9, 0.59)
			f31_arg0.label:setScale(1.1, 1.1)
			f31_arg0.clipFinished(f31_arg0.label)
			f31_arg0.GlowAdd:completeAnimation()
			f31_arg0.GlowAdd:setAlpha(0.1)
			f31_arg0.clipFinished(f31_arg0.GlowAdd)
			f31_arg0.BigBarGlow:completeAnimation()
			f31_arg0.BigBarGlow:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.BigBarGlow)
			f31_arg0.BigBarBacking:completeAnimation()
			f31_arg0.BigBarBacking:setAlpha(0.5)
			f31_arg0.BigBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f31_arg0.clipFinished(f31_arg0.BigBarBacking)
			f31_arg0.SmallBarGlow:completeAnimation()
			f31_arg0.SmallBarGlow:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.SmallBarGlow)
			f31_arg0.SmallBarBacking:completeAnimation()
			f31_arg0.SmallBarBacking:setAlpha(0.5)
			f31_arg0.SmallBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f31_arg0.clipFinished(f31_arg0.SmallBarBacking)
			f31_arg0.DotTiledBacking:completeAnimation()
			f31_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f31_arg0.DotTiledBacking:setAlpha(1)
			f31_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.35)
			f31_arg0.clipFinished(f31_arg0.DotTiledBacking)
			f31_arg0.footerTooltip:completeAnimation()
			f31_arg0.footerTooltip:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.footerTooltip)
		end,
		GainFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(10)
			local f32_local0 = function(f33_arg0)
				f32_arg0.BackingTint:beginAnimation(200)
				f32_arg0.BackingTint:setAlpha(0.5)
				f32_arg0.BackingTint:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BackingTint:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.BackingTint:completeAnimation()
			f32_arg0.BackingTint:setAlpha(0)
			f32_local0(f32_arg0.BackingTint)
			f32_arg0.buttonPromptImage:completeAnimation()
			f32_arg0.buttonPromptImage:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.buttonPromptImage)
			local f32_local1 = function(f34_arg0)
				f32_arg0.label:beginAnimation(200)
				f32_arg0.label:setRGB(1, 0.9, 0.59)
				f32_arg0.label:setScale(1.1, 1.1)
				f32_arg0.label:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.label:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.label:completeAnimation()
			f32_arg0.label:setRGB(0.58, 0.56, 0.49)
			f32_arg0.label:setScale(1, 1)
			f32_local1(f32_arg0.label)
			local f32_local2 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(80)
					f36_arg0:setAlpha(0.1)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.GlowAdd:beginAnimation(120)
				f32_arg0.GlowAdd:setAlpha(0.06)
				f32_arg0.GlowAdd:setScale(1, 1)
				f32_arg0.GlowAdd:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.GlowAdd:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f32_arg0.GlowAdd:completeAnimation()
			f32_arg0.GlowAdd:setAlpha(0)
			f32_arg0.GlowAdd:setScale(0, 0.5)
			f32_local2(f32_arg0.GlowAdd)
			local f32_local3 = function(f37_arg0)
				f32_arg0.BigBarGlow:beginAnimation(200)
				f32_arg0.BigBarGlow:setAlpha(1)
				f32_arg0.BigBarGlow:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BigBarGlow:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.BigBarGlow:completeAnimation()
			f32_arg0.BigBarGlow:setAlpha(0)
			f32_local3(f32_arg0.BigBarGlow)
			local f32_local4 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(49)
					f39_arg0:setAlpha(0.5)
					f39_arg0:setShaderVector(0, 1, 0, 0, 0)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f38_arg0:beginAnimation(50)
				f38_arg0:setAlpha(0.25)
				f38_arg0:setShaderVector(0, 2, 0, 0, 0)
				f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f32_arg0.BigBarBacking:beginAnimation(100)
			f32_arg0.BigBarBacking:setAlpha(0)
			f32_arg0.BigBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f32_arg0.BigBarBacking:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
			f32_arg0.BigBarBacking:registerEventHandler("transition_complete_keyframe", f32_local4)
			local f32_local5 = function(f40_arg0)
				f32_arg0.SmallBarGlow:beginAnimation(200)
				f32_arg0.SmallBarGlow:setAlpha(1)
				f32_arg0.SmallBarGlow:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.SmallBarGlow:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.SmallBarGlow:completeAnimation()
			f32_arg0.SmallBarGlow:setAlpha(0)
			f32_local5(f32_arg0.SmallBarGlow)
			local f32_local6 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(49)
					f42_arg0:setAlpha(0.5)
					f42_arg0:setShaderVector(0, 1, 0, 0, 0)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f41_arg0:beginAnimation(50)
				f41_arg0:setAlpha(0.25)
				f41_arg0:setShaderVector(0, 2, 0, 0, 0)
				f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f32_arg0.SmallBarBacking:beginAnimation(100)
			f32_arg0.SmallBarBacking:setAlpha(0)
			f32_arg0.SmallBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f32_arg0.SmallBarBacking:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
			f32_arg0.SmallBarBacking:registerEventHandler("transition_complete_keyframe", f32_local6)
			local f32_local7 = function(f43_arg0)
				f32_arg0.DotTiledBacking:beginAnimation(200)
				f32_arg0.DotTiledBacking.TiledShaderImage:beginAnimation(200)
				f32_arg0.DotTiledBacking:setAlpha(1)
				f32_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.35)
				f32_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.DotTiledBacking:completeAnimation()
			f32_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f32_arg0.DotTiledBacking:setAlpha(0)
			f32_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0)
			f32_local7(f32_arg0.DotTiledBacking)
			local f32_local8 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(490)
					f45_arg0:setAlpha(1)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.footerTooltip:beginAnimation(500)
				f32_arg0.footerTooltip:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.footerTooltip:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f32_arg0.footerTooltip:completeAnimation()
			f32_arg0.footerTooltip:setAlpha(0)
			f32_local8(f32_arg0.footerTooltip)
		end,
		LoseFocus = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(10)
			local f46_local0 = function(f47_arg0)
				f46_arg0.BackingTint:beginAnimation(200)
				f46_arg0.BackingTint:setAlpha(0)
				f46_arg0.BackingTint:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.BackingTint:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.BackingTint:completeAnimation()
			f46_arg0.BackingTint:setAlpha(0.5)
			f46_local0(f46_arg0.BackingTint)
			f46_arg0.buttonPromptImage:completeAnimation()
			f46_arg0.buttonPromptImage:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.buttonPromptImage)
			local f46_local1 = function(f48_arg0)
				f46_arg0.label:beginAnimation(200)
				f46_arg0.label:setRGB(0.58, 0.56, 0.49)
				f46_arg0.label:setScale(1, 1)
				f46_arg0.label:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.label:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.label:completeAnimation()
			f46_arg0.label:setRGB(1, 0.9, 0.59)
			f46_arg0.label:setScale(1.1, 1.1)
			f46_local1(f46_arg0.label)
			local f46_local2 = function(f49_arg0)
				f46_arg0.GlowAdd:beginAnimation(200)
				f46_arg0.GlowAdd:setAlpha(0)
				f46_arg0.GlowAdd:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.GlowAdd:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.GlowAdd:completeAnimation()
			f46_arg0.GlowAdd:setAlpha(0.1)
			f46_local2(f46_arg0.GlowAdd)
			local f46_local3 = function(f50_arg0)
				f46_arg0.BigBarGlow:beginAnimation(200)
				f46_arg0.BigBarGlow:setAlpha(0)
				f46_arg0.BigBarGlow:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.BigBarGlow:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.BigBarGlow:completeAnimation()
			f46_arg0.BigBarGlow:setAlpha(1)
			f46_local3(f46_arg0.BigBarGlow)
			local f46_local4 = function(f51_arg0)
				f46_arg0.BigBarBacking:beginAnimation(200)
				f46_arg0.BigBarBacking:setAlpha(0)
				f46_arg0.BigBarBacking:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.BigBarBacking:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.BigBarBacking:completeAnimation()
			f46_arg0.BigBarBacking:setAlpha(0.5)
			f46_arg0.BigBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f46_local4(f46_arg0.BigBarBacking)
			local f46_local5 = function(f52_arg0)
				f46_arg0.SmallBarGlow:beginAnimation(200)
				f46_arg0.SmallBarGlow:setAlpha(0)
				f46_arg0.SmallBarGlow:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.SmallBarGlow:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.SmallBarGlow:completeAnimation()
			f46_arg0.SmallBarGlow:setAlpha(1)
			f46_local5(f46_arg0.SmallBarGlow)
			local f46_local6 = function(f53_arg0)
				f46_arg0.SmallBarBacking:beginAnimation(200)
				f46_arg0.SmallBarBacking:setAlpha(0)
				f46_arg0.SmallBarBacking:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.SmallBarBacking:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.SmallBarBacking:completeAnimation()
			f46_arg0.SmallBarBacking:setAlpha(0.5)
			f46_arg0.SmallBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f46_local6(f46_arg0.SmallBarBacking)
			local f46_local7 = function(f54_arg0)
				f46_arg0.DotTiledBacking:beginAnimation(200)
				f46_arg0.DotTiledBacking.TiledShaderImage:beginAnimation(200)
				f46_arg0.DotTiledBacking:setAlpha(0)
				f46_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0)
				f46_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.DotTiledBacking:completeAnimation()
			f46_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f46_arg0.DotTiledBacking:setAlpha(1)
			f46_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.35)
			f46_local7(f46_arg0.DotTiledBacking)
			f46_arg0.footerTooltip:completeAnimation()
			f46_arg0.footerTooltip:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.footerTooltip)
		end,
	},
	EnabledGamepad = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(1)
			f55_arg0.footerTooltip:completeAnimation()
			f55_arg0.footerTooltip:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.footerTooltip)
		end,
		Hide = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(2)
			f56_arg0.label:completeAnimation()
			f56_arg0.label:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.label)
			f56_arg0.footerTooltip:completeAnimation()
			f56_arg0.footerTooltip:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.footerTooltip)
		end,
	},
	InitialState = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(0)
		end,
	},
}
if not CoD.isPC then
	CoD.FooterButtonPromptPC.__clipsPerState.Enabled.Focus = nil
	CoD.FooterButtonPromptPC.__clipsPerState.Enabled.GainFocus = nil
	CoD.FooterButtonPromptPC.__clipsPerState.Enabled.LoseFocus = nil
end
CoD.FooterButtonPromptPC.__onClose = function(f58_arg0)
	f58_arg0.__on_close_removeOverrides()
	f58_arg0.label:close()
	f58_arg0.DotTiledBacking:close()
	f58_arg0.footerTooltip:close()
	f58_arg0.progressRing:close()
	f58_arg0.newIcon:close()
end
