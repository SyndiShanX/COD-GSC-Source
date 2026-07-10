require("x64:2675595fa323085")
require("x64:724e515e60ad1c4")
require("x64:19c1945d2e472b0")
CoD.CustomGames_Restrictions_CategoryButton = InheritFrom(LUI.UIElement)
CoD.CustomGames_Restrictions_CategoryButton.__defaultWidth = 242
CoD.CustomGames_Restrictions_CategoryButton.__defaultHeight = 242
CoD.CustomGames_Restrictions_CategoryButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomGames_Restrictions_CategoryButton)
	self.id = "CustomGames_Restrictions_CategoryButton"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusBorder = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FocusBorder:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlay:setAlpha(0.02)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local SettingLabel = LUI.UIText.new(0, 0, 15, 265, 0, 0, 12, 29)
	SettingLabel:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	SettingLabel:setTTF("ttmussels_regular")
	SettingLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SettingLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	SettingLabel:linkToElementModel(self, "categoryName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SettingLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(SettingLabel)
	self.SettingLabel = SettingLabel
	local ItemFrameAdd = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -2, 2)
	ItemFrameAdd:setImage(RegisterImage(@"uie_ui_menu_store_element_frame"))
	ItemFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ItemFrameAdd:setShaderVector(0, 0, 0, 0, 0)
	ItemFrameAdd:setupNineSliceShader(12, 164)
	self:addElement(ItemFrameAdd)
	self.ItemFrameAdd = ItemFrameAdd
	local FrameSelected = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	FrameSelected:setAlpha(0)
	FrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrameSelected:setupNineSliceShader(8, 8)
	self:addElement(FrameSelected)
	self.FrameSelected = FrameSelected
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.3)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local FlyoutIndicator = CoD.StartMenu_Options_FlyoutIndicator.new(f1_arg0, f1_arg1, 0.5, 0.5, -2.5, 2.5, 0, 0, -128, 110)
	FlyoutIndicator:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return not CoD.OptionsUtility.IsCustomGameOptionCategoryDefault(self, f1_arg1)
			end,
		},
	})
	local ItemImage = FlyoutIndicator
	local TopBarFocus = FlyoutIndicator.subscribeToModel
	local f1_local13 = Engine[@"getglobalmodel"]()
	TopBarFocus(ItemImage, f1_local13["GametypeSettings.Update"], function(f5_arg0)
		f1_arg0:updateElementState(FlyoutIndicator, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "GametypeSettings.Update",
		})
	end, false)
	FlyoutIndicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FlyoutIndicator:setAlpha(0.1)
	FlyoutIndicator:setZRot(90)
	FlyoutIndicator:linkToElementModel(self, nil, false, function(model)
		FlyoutIndicator:setModel(model, f1_arg1)
	end)
	self:addElement(FlyoutIndicator)
	self.FlyoutIndicator = FlyoutIndicator
	TopBarFocus = LUI.UIImage.new(0, 1, -11, 11, 0, 0, -13, -6)
	TopBarFocus:setAlpha(0)
	TopBarFocus:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar_focused"))
	TopBarFocus:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBarFocus)
	self.TopBarFocus = TopBarFocus
	ItemImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -90, 90, 0.5, 0.5, -72, 98)
	ItemImage:linkToElementModel(self, "categoryImage", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ItemImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(ItemImage)
	self.ItemImage = ItemImage
	self:registerEventHandler("gain_focus", function(self, event)
		local f8_local0 = nil
		if self.gainFocus then
			f8_local0 = self:gainFocus(event)
		elseif self.super.gainFocus then
			f8_local0 = self.super:gainFocus(event)
		end
		SetFocusToElement(self, "emptyFocusable", f1_arg1)
		return f8_local0
	end)
	emptyFocusable.id = "emptyFocusable"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomGames_Restrictions_CategoryButton.__resetProperties = function(f9_arg0)
	f9_arg0.SettingLabel:completeAnimation()
	f9_arg0.ItemFrameAdd:completeAnimation()
	f9_arg0.SelectorOverlay:completeAnimation()
	f9_arg0.TopBarFocus:completeAnimation()
	f9_arg0.FlyoutIndicator:completeAnimation()
	f9_arg0.FocusBorder:completeAnimation()
	f9_arg0.ItemImage:completeAnimation()
	f9_arg0.SettingLabel:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f9_arg0.SettingLabel:setAlpha(1)
	f9_arg0.ItemFrameAdd:setAlpha(1)
	f9_arg0.SelectorOverlay:setAlpha(0.02)
	f9_arg0.TopBarFocus:setAlpha(0)
	f9_arg0.FlyoutIndicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f9_arg0.FlyoutIndicator:setAlpha(0.1)
	f9_arg0.FocusBorder:setAlpha(0)
	f9_arg0.ItemImage:setAlpha(1)
end
CoD.CustomGames_Restrictions_CategoryButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(7)
			f10_arg0.FocusBorder:completeAnimation()
			f10_arg0.FocusBorder:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FocusBorder)
			f10_arg0.SelectorOverlay:completeAnimation()
			f10_arg0.SelectorOverlay:setAlpha(0.02)
			f10_arg0.clipFinished(f10_arg0.SelectorOverlay)
			f10_arg0.SettingLabel:completeAnimation()
			f10_arg0.SettingLabel:setRGB(0.92, 0.92, 0.92)
			f10_arg0.SettingLabel:setAlpha(0.5)
			f10_arg0.clipFinished(f10_arg0.SettingLabel)
			f10_arg0.ItemFrameAdd:completeAnimation()
			f10_arg0.ItemFrameAdd:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ItemFrameAdd)
			f10_arg0.FlyoutIndicator:completeAnimation()
			f10_arg0.FlyoutIndicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f10_arg0.FlyoutIndicator:setAlpha(0.1)
			f10_arg0.clipFinished(f10_arg0.FlyoutIndicator)
			f10_arg0.TopBarFocus:completeAnimation()
			f10_arg0.TopBarFocus:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TopBarFocus)
			f10_arg0.ItemImage:completeAnimation()
			f10_arg0.ItemImage:setAlpha(0.7)
			f10_arg0.clipFinished(f10_arg0.ItemImage)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			f11_arg0.FocusBorder:completeAnimation()
			f11_arg0.FocusBorder:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FocusBorder)
			f11_arg0.SelectorOverlay:completeAnimation()
			f11_arg0.SelectorOverlay:setAlpha(0.04)
			f11_arg0.clipFinished(f11_arg0.SelectorOverlay)
			f11_arg0.SettingLabel:completeAnimation()
			f11_arg0.SettingLabel:setRGB(0.92, 0.89, 0.72)
			f11_arg0.clipFinished(f11_arg0.SettingLabel)
			f11_arg0.ItemFrameAdd:completeAnimation()
			f11_arg0.ItemFrameAdd:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.ItemFrameAdd)
			f11_arg0.FlyoutIndicator:completeAnimation()
			f11_arg0.FlyoutIndicator:setRGB(0.92, 0.89, 0.72)
			f11_arg0.FlyoutIndicator:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FlyoutIndicator)
			f11_arg0.TopBarFocus:completeAnimation()
			f11_arg0.TopBarFocus:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.TopBarFocus)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(7)
			local f12_local0 = function(f13_arg0)
				f12_arg0.FocusBorder:beginAnimation(200)
				f12_arg0.FocusBorder:setAlpha(1)
				f12_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FocusBorder:completeAnimation()
			f12_arg0.FocusBorder:setAlpha(0)
			f12_local0(f12_arg0.FocusBorder)
			local f12_local1 = function(f14_arg0)
				f12_arg0.SelectorOverlay:beginAnimation(150)
				f12_arg0.SelectorOverlay:setAlpha(0.04)
				f12_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SelectorOverlay:completeAnimation()
			f12_arg0.SelectorOverlay:setAlpha(0.02)
			f12_local1(f12_arg0.SelectorOverlay)
			local f12_local2 = function(f15_arg0)
				f12_arg0.SettingLabel:beginAnimation(150)
				f12_arg0.SettingLabel:setRGB(0.92, 0.89, 0.72)
				f12_arg0.SettingLabel:setAlpha(1)
				f12_arg0.SettingLabel:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SettingLabel:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SettingLabel:completeAnimation()
			f12_arg0.SettingLabel:setRGB(0.92, 0.92, 0.92)
			f12_arg0.SettingLabel:setAlpha(0.5)
			f12_local2(f12_arg0.SettingLabel)
			local f12_local3 = function(f16_arg0)
				f12_arg0.ItemFrameAdd:beginAnimation(150)
				f12_arg0.ItemFrameAdd:setAlpha(1)
				f12_arg0.ItemFrameAdd:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ItemFrameAdd:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ItemFrameAdd:completeAnimation()
			f12_arg0.ItemFrameAdd:setAlpha(0)
			f12_local3(f12_arg0.ItemFrameAdd)
			local f12_local4 = function(f17_arg0)
				f12_arg0.FlyoutIndicator:beginAnimation(150)
				f12_arg0.FlyoutIndicator:setRGB(0.92, 0.89, 0.72)
				f12_arg0.FlyoutIndicator:setAlpha(1)
				f12_arg0.FlyoutIndicator:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FlyoutIndicator:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FlyoutIndicator:completeAnimation()
			f12_arg0.FlyoutIndicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f12_arg0.FlyoutIndicator:setAlpha(0.1)
			f12_local4(f12_arg0.FlyoutIndicator)
			local f12_local5 = function(f18_arg0)
				f12_arg0.TopBarFocus:beginAnimation(150)
				f12_arg0.TopBarFocus:setAlpha(1)
				f12_arg0.TopBarFocus:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.TopBarFocus:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.TopBarFocus:completeAnimation()
			f12_arg0.TopBarFocus:setAlpha(0)
			f12_local5(f12_arg0.TopBarFocus)
			local f12_local6 = function(f19_arg0)
				f12_arg0.ItemImage:beginAnimation(150)
				f12_arg0.ItemImage:setAlpha(1)
				f12_arg0.ItemImage:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ItemImage:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ItemImage:completeAnimation()
			f12_arg0.ItemImage:setAlpha(0.7)
			f12_local6(f12_arg0.ItemImage)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(7)
			f20_arg0.FocusBorder:beginAnimation(150)
			f20_arg0.FocusBorder:setAlpha(0)
			f20_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
			f20_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			local f20_local0 = function(f21_arg0)
				f20_arg0.SelectorOverlay:beginAnimation(150)
				f20_arg0.SelectorOverlay:setAlpha(0.02)
				f20_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.SelectorOverlay:completeAnimation()
			f20_arg0.SelectorOverlay:setAlpha(0.04)
			f20_local0(f20_arg0.SelectorOverlay)
			local f20_local1 = function(f22_arg0)
				f20_arg0.SettingLabel:beginAnimation(150)
				f20_arg0.SettingLabel:setRGB(0.92, 0.92, 0.92)
				f20_arg0.SettingLabel:setAlpha(0.5)
				f20_arg0.SettingLabel:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SettingLabel:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.SettingLabel:completeAnimation()
			f20_arg0.SettingLabel:setRGB(0.92, 0.89, 0.72)
			f20_arg0.SettingLabel:setAlpha(1)
			f20_local1(f20_arg0.SettingLabel)
			local f20_local2 = function(f23_arg0)
				f20_arg0.ItemFrameAdd:beginAnimation(150)
				f20_arg0.ItemFrameAdd:setAlpha(0)
				f20_arg0.ItemFrameAdd:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ItemFrameAdd:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ItemFrameAdd:completeAnimation()
			f20_arg0.ItemFrameAdd:setAlpha(1)
			f20_local2(f20_arg0.ItemFrameAdd)
			local f20_local3 = function(f24_arg0)
				f20_arg0.FlyoutIndicator:beginAnimation(150)
				f20_arg0.FlyoutIndicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f20_arg0.FlyoutIndicator:setAlpha(0.1)
				f20_arg0.FlyoutIndicator:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FlyoutIndicator:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FlyoutIndicator:completeAnimation()
			f20_arg0.FlyoutIndicator:setRGB(0.92, 0.89, 0.72)
			f20_arg0.FlyoutIndicator:setAlpha(1)
			f20_local3(f20_arg0.FlyoutIndicator)
			local f20_local4 = function(f25_arg0)
				f20_arg0.TopBarFocus:beginAnimation(150)
				f20_arg0.TopBarFocus:setAlpha(0)
				f20_arg0.TopBarFocus:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.TopBarFocus:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.TopBarFocus:completeAnimation()
			f20_arg0.TopBarFocus:setAlpha(1)
			f20_local4(f20_arg0.TopBarFocus)
			local f20_local5 = function(f26_arg0)
				f20_arg0.ItemImage:beginAnimation(150)
				f20_arg0.ItemImage:setAlpha(0.7)
				f20_arg0.ItemImage:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ItemImage:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ItemImage:completeAnimation()
			f20_arg0.ItemImage:setAlpha(1)
			f20_local5(f20_arg0.ItemImage)
		end,
	},
}
CoD.CustomGames_Restrictions_CategoryButton.__onClose = function(f27_arg0)
	f27_arg0.emptyFocusable:close()
	f27_arg0.DotTiledBacking:close()
	f27_arg0.SettingLabel:close()
	f27_arg0.FlyoutIndicator:close()
	f27_arg0.ItemImage:close()
end
