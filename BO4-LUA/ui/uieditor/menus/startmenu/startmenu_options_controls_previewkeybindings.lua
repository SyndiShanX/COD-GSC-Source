require("x64:ce1e6b6549d478c")
require("x64:85b76a463d2f0f5")
require("x64:5b996a85e104bf9")
CoD.StartMenu_Options_Controls_PreviewKeybindings = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_Controls_PreviewKeybindings = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_Controls_PreviewKeybindings", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.StartMenu_Options_Controls_PreviewKeybindings)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(-0.1, 1.1, 0, 0, -0.1, 1.1, 0, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = LUI.UIImage.new(-0.1, 1.1, 0, 0, -0.1, 1.1, 0, 0)
	Background:setRGB(0.04, 0.04, 0.04)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local KeybindsPreview = LUI.UIImage.new(0.5, 0.5, -759, 759, 1, 1, -927, -73)
	KeybindsPreview:setAlpha(0)
	KeybindsPreview:setImage(RegisterImage(0x1D7F93185DD79F))
	self:addElement(KeybindsPreview)
	self.KeybindsPreview = KeybindsPreview
	local PreloadImage1 = LUI.UIImage.new(0, 0, 1350, 1478, 0, 0, -223.5, -95.5)
	PreloadImage1:setAlpha(0)
	PreloadImage1:setImage(RegisterImage(@"hash_6D8060B016B78EC5"))
	self:addElement(PreloadImage1)
	self.PreloadImage1 = PreloadImage1
	local PreloadImage2 = LUI.UIImage.new(0, 0, 1496, 1624, 0, 0, -223.5, -95.5)
	PreloadImage2:setAlpha(0)
	PreloadImage2:setImage(RegisterImage(@"hash_1FC5C06AFCAE7380"))
	self:addElement(PreloadImage2)
	self.PreloadImage2 = PreloadImage2
	local PreloadImage3 = LUI.UIImage.new(0, 0, 1634, 1762, 0, 0, -223.5, -95.5)
	PreloadImage3:setAlpha(0)
	PreloadImage3:setImage(RegisterImage(@"hash_6E061B05A775D343"))
	self:addElement(PreloadImage3)
	self.PreloadImage3 = PreloadImage3
	local PreloadImage5 = LUI.UIImage.new(0, 0, 1890, 2018, 0, 0, -223.5, -95.5)
	PreloadImage5:setAlpha(0)
	PreloadImage5:setImage(RegisterImage(@"hash_52C592ED9C8F62F0"))
	self:addElement(PreloadImage5)
	self.PreloadImage5 = PreloadImage5
	local PreloadImage4 = LUI.UIImage.new(0, 0, 1890, 2018, 0, 0, -223.5, -95.5)
	PreloadImage4:setAlpha(0)
	PreloadImage4:setImage(RegisterImage(@"hash_42D51E0C753FB7C9"))
	self:addElement(PreloadImage4)
	self.PreloadImage4 = PreloadImage4
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2 = CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton.new(f1_local1, f1_arg0, 0, 0, 1350, 1586, 0, 0, 104, 169)
	PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2:setAlpha(0)
	PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2.BtnText:setText(LocalizeToUpperString(@"hash_41BA0AE610631004"))
	PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.PCWidgetUtility.DisplayApplyPresetConfirmationPopup(self, controller, self.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings, true, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2)
	self.PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2 = PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2
	local KeyboardOutlines = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -813.5, 813.5, 1, 1, -937.5, -302.5)
	KeyboardOutlines:setAlpha(0.3)
	KeyboardOutlines:setImage(RegisterImage(@"hash_4DA06C276EB39986"))
	self:addElement(KeyboardOutlines)
	self.KeyboardOutlines = KeyboardOutlines
	local backing = LUI.UIImage.new(0.5, 0.5, -400, 400, 1, 1, -730, -510)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.7)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -400, 400, 1, 1, -730, -510)
	NoiseTiledBacking:setAlpha(0.7)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Border = LUI.UIImage.new(0.5, 0.5, -400, 400, 1, 1, -730, -510)
	Border:setRGB(0.8, 0.76, 0.7)
	Border:setAlpha(0.15)
	Border:setImage(RegisterImage(@"uie_highlight_border_line"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(6, 6)
	self:addElement(Border)
	self.Border = Border
	local PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings = CoD.PC_StartMenu_Options_Controls_TabContent_DropDownPresetKeybindings.new(f1_local1, f1_arg0, 0.5, 0.5, -352, 352, 1, 1, -629.5, -559.5)
	PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings:subscribeToGlobalModel(f1_arg0, "OptionControlKeyBindingsDropDown", nil, function(model)
		PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings:setModel(model, f1_arg0)
	end)
	self:addElement(PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings)
	self.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings = PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings
	local title = LUI.UIText.new(0.5, 0.5, -352, 352, 1, 1, -688, -652)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4109C9B63520D921"))
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(title)
	self.title = title
	self:registerEventHandler("close_all_ingame_menus", function(self, event)
		local f6_local0 = nil
		Close(self, f1_arg0)
		if not f6_local0 then
			f6_local0 = self:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f7_local0 = nil
		if self.OcclusionChange then
			f7_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f7_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			SetState(self, "Hidden", f1_arg0)
		elseif IsEventPropertyEqualTo(event, "occluded", false) then
			SetState(self, "DefaultState", f1_arg0)
		end
		if not f7_local0 then
			f7_local0 = self:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.PCWidgetUtility.DisplayApplyPresetConfirmationPopup(self, controller, self.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings, true, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsSelfPropertyValue(self, "_parentMenuId", "Director") then
			CoD.PCWidgetUtility.DisplayApplyPresetConfirmationPopupAndGoToSettings(self, controller, self.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfPropertyValue(self, "_parentMenuId", "Director") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_372149EF86CFB295", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.PCWidgetUtility.ResetAllKeysColor()
		CoD.PCWidgetUtility.DefaultKeyboardPulseColor()
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2.id = "PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2"
	PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings.id = "PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FooterContainerFrontendRight
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local18 = self
	CoD.PCWidgetUtility.KeyboardColorReset("0")
	CoD.PCWidgetUtility.ResetAllKeysColor()
	CoD.PCWidgetUtility.ResetOptionsKeysetBindingsDropdownToDvars(self, f1_arg0, self.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings, true)
	CoD.PCWidgetUtility.SetDvarBool(self, f1_arg0, "cl_firstTimeOpenControlsOptionsScreen", false)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	return self
end
CoD.StartMenu_Options_Controls_PreviewKeybindings.__resetProperties = function(f13_arg0)
	f13_arg0.KeyboardOutlines:completeAnimation()
	f13_arg0.title:completeAnimation()
	f13_arg0.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings:completeAnimation()
	f13_arg0.Border:completeAnimation()
	f13_arg0.NoiseTiledBacking:completeAnimation()
	f13_arg0.backing:completeAnimation()
	f13_arg0.KeyboardOutlines:setAlpha(0.3)
	f13_arg0.title:setAlpha(1)
	f13_arg0.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings:setAlpha(1)
	f13_arg0.Border:setAlpha(0.15)
	f13_arg0.NoiseTiledBacking:setAlpha(0.7)
	f13_arg0.backing:setAlpha(0.7)
end
CoD.StartMenu_Options_Controls_PreviewKeybindings.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.KeyboardOutlines:beginAnimation(360)
				f14_arg0.KeyboardOutlines:setAlpha(0.3)
				f14_arg0.KeyboardOutlines:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.KeyboardOutlines:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.KeyboardOutlines:completeAnimation()
			f14_arg0.KeyboardOutlines:setAlpha(0)
			f14_local0(f14_arg0.KeyboardOutlines)
		end,
	},
	Hidden = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(5)
			f16_arg0.backing:completeAnimation()
			f16_arg0.backing:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.backing)
			f16_arg0.NoiseTiledBacking:completeAnimation()
			f16_arg0.NoiseTiledBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.NoiseTiledBacking)
			f16_arg0.Border:completeAnimation()
			f16_arg0.Border:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Border)
			f16_arg0.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings:completeAnimation()
			f16_arg0.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings)
			f16_arg0.title:completeAnimation()
			f16_arg0.title:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.title)
		end,
	},
}
CoD.StartMenu_Options_Controls_PreviewKeybindings.__onClose = function(f17_arg0)
	f17_arg0.FooterContainerFrontendRight:close()
	f17_arg0.PCStartMenuOptionsControlsTabContentKeyBindingPreviewButton2:close()
	f17_arg0.PCStartMenuOptionsControlsTabContentDropDownPresetKeybindings:close()
end
