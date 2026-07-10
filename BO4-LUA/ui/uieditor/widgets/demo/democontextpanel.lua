require("x64:abd9d2111472f07")
require("x64:439f1611752f8e0")
local f0_local0 = function(f1_arg0, f1_arg1)
	local f1_local0 = @"mp/unknown"
	if IsDemoClipPreviewRunning() then
		f1_local0 = @"hash_21BF53D95E5AC2B5"
	elseif IsDemoCreatingHighlightReel() then
		f1_local0 = @"hash_3AAD9F5A753F0418"
	elseif IsDemoContextPlaybackMode() then
		f1_local0 = @"hash_7C985CBA47878B1C"
	elseif IsDemoContextBasicMode() then
		f1_local0 = @"hash_42466B35790D15BF"
	elseif IsDemoContextDirectorMode() then
		f1_local0 = @"hash_FC244F0B9CC213B"
	elseif IsDemoContextObjectLinkMode() then
		f1_local0 = @"hash_72961AAF61FB5B21"
	elseif IsDemoContextLighterMode() then
		f1_local0 = @"hash_7EBDDCC281D5C214"
	elseif IsDemoContextHighlightReelMode() then
		f1_local0 = @"hash_5E4E395171E8600C"
	end
	f1_arg0.ModeName:setText(Engine[@"hash_4F9F1239CFD921FE"](f1_local0))
end
local f0_local1 = function(f2_arg0, f2_arg1, f2_arg2)
	f2_arg0.ModeName:subscribeToGlobalModel(f2_arg1, "Demo", "contextMode", function(model)
		f0_local0(f2_arg0, f2_arg1)
	end)
	f2_arg0.ModeName:subscribeToGlobalModel(f2_arg1, "Demo", "clipState", function(model)
		f0_local0(f2_arg0, f2_arg1)
	end)
	f2_arg0.ModeName:subscribeToGlobalModel(f2_arg1, "Demo", "isCreatingHighlightReel", function(model)
		f0_local0(f2_arg0, f2_arg1)
	end)
end
CoD.DemoContextPanel = InheritFrom(LUI.UIElement)
CoD.DemoContextPanel.__defaultWidth = 300
CoD.DemoContextPanel.__defaultHeight = 60
CoD.DemoContextPanel.new = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8, f6_arg9)
	local self = LUI.UIElement.new(f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8, f6_arg9)
	self:setClass(CoD.DemoContextPanel)
	self.id = "DemoContextPanel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f6_arg0:addElementToPendingUpdateStateList(self)
	local BGBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_381EEB1F96D4BE0A"))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local BGTintButton = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -30, 0)
	BGTintButton:setRGB(0, 0, 0)
	BGTintButton:setAlpha(0.6)
	BGTintButton:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_381EEB1F96D4BE0A"))
	BGTintButton:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGTintButton)
	self.BGTintButton = BGTintButton
	local BGTintFull = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGTintFull:setRGB(0, 0, 0)
	BGTintFull:setAlpha(0.6)
	BGTintFull:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BGTintFull:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(BGTintFull)
	self.BGTintFull = BGTintFull
	local PixelGridTiledBacking = LUI.UIImage.new(0.5, 0.5, -150, 150, 1, 1, -30, 0)
	PixelGridTiledBacking:setAlpha(0.1)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local DemoControlsSpectatingBar = CoD.DemoControlsSpectatingBar.new(f6_arg0, f6_arg1, 0.5, 0.5, -145, 145, 1, 1, -30, 0)
	self:addElement(DemoControlsSpectatingBar)
	self.DemoControlsSpectatingBar = DemoControlsSpectatingBar
	local ModeName = LUI.UIText.new(0.5, 0.5, -145, 145, 0, 0, 5, 25)
	ModeName:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	ModeName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_42466B35790D15BF"))
	ModeName:setTTF("ttmussels_regular")
	ModeName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	ModeName:setShaderVector(0, 0.02, 0, 0, 0)
	ModeName:setShaderVector(1, 0.03, 0, 0, 0)
	ModeName:setShaderVector(2, 1, 0, 0, 0)
	ModeName:setLetterSpacing(1)
	ModeName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ModeName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ModeName)
	self.ModeName = ModeName
	local ButtonPrompt = CoD.DemoButtonPrompt.new(f6_arg0, f6_arg1, 0.5, 0.5, -115.5, 115.5, 0, 0, -34, -4)
	ButtonPrompt:setScale(0.8, 0.8)
	ButtonPrompt.label:setText(LocalizeString(@"hash_111CF7B88D647093"))
	ButtonPrompt:subscribeToGlobalModel(f6_arg1, "Controller", "secondary_button_image", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ButtonPrompt.buttonPromptImage:setImage(RegisterImage(f7_local0))
		end
	end)
	ButtonPrompt:linkToElementModel(self, "Label", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ButtonPrompt.KBMlabel:setText(LocalizeToUpperString(f8_local0))
		end
	end)
	ButtonPrompt:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		if IsMouseOrKeyboard(f6_arg1) then
			HideWidget(element)
		end
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(ButtonPrompt)
	self.ButtonPrompt = ButtonPrompt
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	self:mergeStateConditions({
		{
			stateName = "ClipPreview",
			condition = function(menu, element, event)
				return IsDemoClipPreviewRunning()
			end,
		},
		{
			stateName = "CreatingHighlightReel",
			condition = function(menu, element, event)
				return IsDemoCreatingHighlightReel()
			end,
		},
		{
			stateName = "ShowChangeModeButtonPrompt",
			condition = function(menu, element, event)
				local f12_local0
				if not IsEditingDollyCameraMarker(f6_arg1) and not IsEditingLightmanMarker(f6_arg1) then
					f12_local0 = not IsMouseOrKeyboard(f6_arg1)
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
	})
	local f6_local9 = self
	local f6_local10 = self.subscribeToModel
	local f6_local11 = Engine[@"getglobalmodel"]()
	f6_local10(f6_local9, f6_local11["demo.clipState"], function(f13_arg0)
		f6_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f6_arg0,
			controller = f6_arg1,
			modelValue = f13_arg0:get(),
			modelName = "demo.clipState",
		})
	end, false)
	f6_local9 = self
	f6_local10 = self.subscribeToModel
	f6_local11 = Engine[@"getglobalmodel"]()
	f6_local10(f6_local9, f6_local11["demo.isCreatingHighlightReel"], function(f14_arg0)
		f6_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f6_arg0,
			controller = f6_arg1,
			modelValue = f14_arg0:get(),
			modelName = "demo.isCreatingHighlightReel",
		})
	end, false)
	f6_local9 = self
	f6_local10 = self.subscribeToModel
	f6_local11 = Engine[@"getglobalmodel"]()
	f6_local10(f6_local9, f6_local11["demo.highlightedDollyCamMarker"], function(f15_arg0)
		f6_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f6_arg0,
			controller = f6_arg1,
			modelValue = f15_arg0:get(),
			modelName = "demo.highlightedDollyCamMarker",
		})
	end, false)
	f6_local9 = self
	f6_local10 = self.subscribeToModel
	f6_local11 = Engine[@"getglobalmodel"]()
	f6_local10(f6_local9, f6_local11["demo.editingDollyCameraMarker"], function(f16_arg0)
		f6_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f6_arg0,
			controller = f6_arg1,
			modelValue = f16_arg0:get(),
			modelName = "demo.editingDollyCameraMarker",
		})
	end, false)
	f6_local9 = self
	f6_local10 = self.subscribeToModel
	f6_local11 = Engine[@"getglobalmodel"]()
	f6_local10(f6_local9, f6_local11["demo.highlightedLightmanMarker"], function(f17_arg0)
		f6_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f6_arg0,
			controller = f6_arg1,
			modelValue = f17_arg0:get(),
			modelName = "demo.highlightedLightmanMarker",
		})
	end, false)
	f6_local9 = self
	f6_local10 = self.subscribeToModel
	f6_local11 = Engine[@"getglobalmodel"]()
	f6_local10(f6_local9, f6_local11["demo.editingLightmanMarker"], function(f18_arg0)
		f6_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f6_arg0,
			controller = f6_arg1,
			modelValue = f18_arg0:get(),
			modelName = "demo.editingLightmanMarker",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f6_arg0
		f6_arg0:updateElementState(self, f19_arg1)
	end)
	f6_local9 = self
	f6_local10 = self.subscribeToModel
	f6_local11 = Engine[@"getmodelforcontroller"](f6_arg1)
	f6_local10(f6_local9, f6_local11.LastInput, function(f20_arg0)
		f6_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f6_arg0,
			controller = f6_arg1,
			modelValue = f20_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if CoD.isPC then
		DemoControlsSpectatingBar.id = "DemoControlsSpectatingBar"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if f0_local1 then
		f0_local1(self, f6_arg1, f6_arg0)
	end
	f6_local10 = self
	if IsPC() then
		CoD.HUDUtility.SetUseCylinderMapping(f6_local10, false)
	end
	return self
end
CoD.DemoContextPanel.__resetProperties = function(f21_arg0)
	f21_arg0.ButtonPrompt:completeAnimation()
	f21_arg0.ModeName:completeAnimation()
	f21_arg0.DemoControlsSpectatingBar:completeAnimation()
	f21_arg0.ButtonPrompt:setLeftRight(0.5, 0.5, -115.5, 115.5)
	f21_arg0.ButtonPrompt:setTopBottom(0, 0, -34, -4)
	f21_arg0.ButtonPrompt:setAlpha(1)
	f21_arg0.ButtonPrompt.label:setText(LocalizeString(@"hash_111CF7B88D647093"))
	f21_arg0.ModeName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_42466B35790D15BF"))
	f21_arg0.DemoControlsSpectatingBar:setAlpha(1)
end
CoD.DemoContextPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.ButtonPrompt:completeAnimation()
			f22_arg0.ButtonPrompt.label:completeAnimation()
			f22_arg0.ButtonPrompt:setLeftRight(0, 0, 94.5, 325.5)
			f22_arg0.ButtonPrompt:setTopBottom(0, 0, -34, -4)
			f22_arg0.ButtonPrompt:setAlpha(0)
			f22_arg0.ButtonPrompt.label:setText(LocalizeString(@"hash_111CF7B88D647093"))
			f22_arg0.clipFinished(f22_arg0.ButtonPrompt)
		end,
	},
	ClipPreview = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.DemoControlsSpectatingBar:completeAnimation()
			f23_arg0.DemoControlsSpectatingBar:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.DemoControlsSpectatingBar)
			f23_arg0.ModeName:completeAnimation()
			f23_arg0.ModeName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_21BF53D95E5AC2B5"))
			f23_arg0.clipFinished(f23_arg0.ModeName)
			f23_arg0.ButtonPrompt:completeAnimation()
			f23_arg0.ButtonPrompt.label:completeAnimation()
			f23_arg0.ButtonPrompt:setLeftRight(0.5, 0.5, -115.5, 115.5)
			f23_arg0.ButtonPrompt:setTopBottom(0, 0, 51, 81)
			f23_arg0.ButtonPrompt:setAlpha(1)
			f23_arg0.ButtonPrompt.label:setText(LocalizeString(@"menu/cancel"))
			f23_arg0.clipFinished(f23_arg0.ButtonPrompt)
		end,
	},
	CreatingHighlightReel = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.DemoControlsSpectatingBar:completeAnimation()
			f24_arg0.DemoControlsSpectatingBar:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DemoControlsSpectatingBar)
			f24_arg0.ModeName:completeAnimation()
			f24_arg0.ModeName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3AAD9F5A753F0418"))
			f24_arg0.clipFinished(f24_arg0.ModeName)
			f24_arg0.ButtonPrompt:completeAnimation()
			f24_arg0.ButtonPrompt:setLeftRight(0.5, 0.5, -115.5, 115.5)
			f24_arg0.ButtonPrompt:setTopBottom(0, 0, 51, 81)
			f24_arg0.ButtonPrompt:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.ButtonPrompt)
		end,
	},
	ShowChangeModeButtonPrompt = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.ButtonPrompt:completeAnimation()
			f25_arg0.ButtonPrompt.label:completeAnimation()
			f25_arg0.ButtonPrompt:setAlpha(1)
			f25_arg0.ButtonPrompt.label:setText(LocalizeString(@"hash_111CF7B88D647093"))
			f25_arg0.clipFinished(f25_arg0.ButtonPrompt)
		end,
	},
}
CoD.DemoContextPanel.__onClose = function(f26_arg0)
	f26_arg0.DemoControlsSpectatingBar:close()
	f26_arg0.ButtonPrompt:close()
end
