require("x64:5f8cf56752aa71b")
require("x64:19c1945d2e472b0")
CoD.CustomizeIconGridItem_Internal = InheritFrom(LUI.UIElement)
CoD.CustomizeIconGridItem_Internal.__defaultWidth = 173
CoD.CustomizeIconGridItem_Internal.__defaultHeight = 146
CoD.CustomizeIconGridItem_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomizeIconGridItem_Internal)
	self.id = "CustomizeIconGridItem_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
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
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local IconImage = LUI.UIImage.new(0.5, 0.5, -62, 62, 0, 0, 2, 126)
	IconImage:linkToElementModel(self, "iconImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			IconImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(IconImage)
	self.IconImage = IconImage
	local LockedVictoryCoinIcon = LUI.UIImage.new(0.5, 0.5, -62, 62, 0, 0, 2, 126)
	LockedVictoryCoinIcon:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LockedVictoryCoinIcon:setAlpha(0)
	LockedVictoryCoinIcon:setImage(RegisterImage(@"uie_ui_icon_wz_prestige_empty"))
	self:addElement(LockedVictoryCoinIcon)
	self.LockedVictoryCoinIcon = LockedVictoryCoinIcon
	local Name = LUI.UIText.new(0.5, 0.5, -81.5, 81.5, 1, 1, -20, -2)
	Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Name:setTTF("ttmussels_regular")
	Name:setLetterSpacing(1)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	Name:linkToElementModel(self, "iconName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local LockIconBacking = LUI.UIImage.new(0.5, 0.5, -18, 18, 0.5, 0.5, -27, 9)
	LockIconBacking:setRGB(0, 0, 0)
	LockIconBacking:setAlpha(0)
	self:addElement(LockIconBacking)
	self.LockIconBacking = LockIconBacking
	local LockIconDotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 68.5, 104.5, 0, 0, 46, 82)
	LockIconDotTiledBacking:setAlpha(0)
	self:addElement(LockIconDotTiledBacking)
	self.LockIconDotTiledBacking = LockIconDotTiledBacking
	local LockIcon = LUI.UIImage.new(0.5, 0.5, -18, 18, 0.5, 0.5, -28, 8)
	LockIcon:setAlpha(0)
	LockIcon:setImage(RegisterImage(@"uie_icon_locks_lock_01"))
	self:addElement(LockIcon)
	self.LockIcon = LockIcon
	local EquippedIcon = LUI.UIImage.new(0, 0, 136, 186, 0, 0, -13, 37)
	EquippedIcon:setAlpha(0)
	EquippedIcon:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	self:addElement(EquippedIcon)
	self.EquippedIcon = EquippedIcon
	local ButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonOutline)
	self.ButtonOutline = ButtonOutline
	self:mergeStateConditions({
		{
			stateName = "LockedVictoryCoin",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLockedByWins")
			end,
		},
		{
			stateName = "LockedState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "EquippedState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isEquipped")
			end,
		},
	})
	self:linkToElementModel(self, "isLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	self:linkToElementModel(self, "isLockedByWins", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLockedByWins",
		})
	end)
	self:linkToElementModel(self, "isEquipped", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isEquipped",
		})
	end)
	ButtonOutline.id = "ButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomizeIconGridItem_Internal.__resetProperties = function(f10_arg0)
	f10_arg0.Name:completeAnimation()
	f10_arg0.LockIcon:completeAnimation()
	f10_arg0.LockIconBacking:completeAnimation()
	f10_arg0.LockIconDotTiledBacking:completeAnimation()
	f10_arg0.IconImage:completeAnimation()
	f10_arg0.LockedVictoryCoinIcon:completeAnimation()
	f10_arg0.EquippedIcon:completeAnimation()
	f10_arg0.Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f10_arg0.LockIcon:setAlpha(0)
	f10_arg0.LockIconBacking:setAlpha(0)
	f10_arg0.LockIconDotTiledBacking:setAlpha(0)
	f10_arg0.IconImage:setRGB(1, 1, 1)
	f10_arg0.IconImage:setAlpha(1)
	f10_arg0.LockedVictoryCoinIcon:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f10_arg0.LockedVictoryCoinIcon:setAlpha(0)
	f10_arg0.EquippedIcon:setAlpha(0)
end
CoD.CustomizeIconGridItem_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Name:completeAnimation()
			f12_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f12_arg0.clipFinished(f12_arg0.Name)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Name:completeAnimation()
			f13_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f13_arg0.clipFinished(f13_arg0.Name)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Name:completeAnimation()
			f14_arg0.Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f14_arg0.clipFinished(f14_arg0.Name)
		end,
	},
	LockedVictoryCoin = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.IconImage:completeAnimation()
			f15_arg0.IconImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.IconImage)
			f15_arg0.LockedVictoryCoinIcon:completeAnimation()
			f15_arg0.LockedVictoryCoinIcon:setRGB(0.29, 0.29, 0.29)
			f15_arg0.LockedVictoryCoinIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.LockedVictoryCoinIcon)
			f15_arg0.LockIconBacking:completeAnimation()
			f15_arg0.LockIconBacking:setAlpha(0.4)
			f15_arg0.clipFinished(f15_arg0.LockIconBacking)
			f15_arg0.LockIconDotTiledBacking:completeAnimation()
			f15_arg0.LockIconDotTiledBacking:setAlpha(0.95)
			f15_arg0.clipFinished(f15_arg0.LockIconDotTiledBacking)
			f15_arg0.LockIcon:completeAnimation()
			f15_arg0.LockIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.LockIcon)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(6)
			f16_arg0.IconImage:completeAnimation()
			f16_arg0.IconImage:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.IconImage)
			f16_arg0.LockedVictoryCoinIcon:completeAnimation()
			f16_arg0.LockedVictoryCoinIcon:setRGB(0.49, 0.49, 0.49)
			f16_arg0.LockedVictoryCoinIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.LockedVictoryCoinIcon)
			f16_arg0.Name:completeAnimation()
			f16_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f16_arg0.clipFinished(f16_arg0.Name)
			f16_arg0.LockIconBacking:completeAnimation()
			f16_arg0.LockIconBacking:setAlpha(0.4)
			f16_arg0.clipFinished(f16_arg0.LockIconBacking)
			f16_arg0.LockIconDotTiledBacking:completeAnimation()
			f16_arg0.LockIconDotTiledBacking:setAlpha(0.95)
			f16_arg0.clipFinished(f16_arg0.LockIconDotTiledBacking)
			f16_arg0.LockIcon:completeAnimation()
			f16_arg0.LockIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.LockIcon)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(6)
			f17_arg0.IconImage:completeAnimation()
			f17_arg0.IconImage:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.IconImage)
			local f17_local0 = function(f18_arg0)
				f17_arg0.LockedVictoryCoinIcon:beginAnimation(200)
				f17_arg0.LockedVictoryCoinIcon:setRGB(0.49, 0.49, 0.49)
				f17_arg0.LockedVictoryCoinIcon:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.LockedVictoryCoinIcon:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.LockedVictoryCoinIcon:completeAnimation()
			f17_arg0.LockedVictoryCoinIcon:setRGB(0.29, 0.29, 0.29)
			f17_arg0.LockedVictoryCoinIcon:setAlpha(1)
			f17_local0(f17_arg0.LockedVictoryCoinIcon)
			f17_arg0.Name:completeAnimation()
			f17_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f17_arg0.clipFinished(f17_arg0.Name)
			f17_arg0.LockIconBacking:completeAnimation()
			f17_arg0.LockIconBacking:setAlpha(0.4)
			f17_arg0.clipFinished(f17_arg0.LockIconBacking)
			f17_arg0.LockIconDotTiledBacking:completeAnimation()
			f17_arg0.LockIconDotTiledBacking:setAlpha(0.95)
			f17_arg0.clipFinished(f17_arg0.LockIconDotTiledBacking)
			f17_arg0.LockIcon:completeAnimation()
			f17_arg0.LockIcon:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.LockIcon)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(6)
			f19_arg0.IconImage:completeAnimation()
			f19_arg0.IconImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.IconImage)
			local f19_local0 = function(f20_arg0)
				f19_arg0.LockedVictoryCoinIcon:beginAnimation(200)
				f19_arg0.LockedVictoryCoinIcon:setRGB(0.29, 0.29, 0.29)
				f19_arg0.LockedVictoryCoinIcon:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.LockedVictoryCoinIcon:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.LockedVictoryCoinIcon:completeAnimation()
			f19_arg0.LockedVictoryCoinIcon:setRGB(0.49, 0.49, 0.49)
			f19_arg0.LockedVictoryCoinIcon:setAlpha(1)
			f19_local0(f19_arg0.LockedVictoryCoinIcon)
			f19_arg0.Name:completeAnimation()
			f19_arg0.Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f19_arg0.clipFinished(f19_arg0.Name)
			f19_arg0.LockIconBacking:completeAnimation()
			f19_arg0.LockIconBacking:setAlpha(0.4)
			f19_arg0.clipFinished(f19_arg0.LockIconBacking)
			f19_arg0.LockIconDotTiledBacking:completeAnimation()
			f19_arg0.LockIconDotTiledBacking:setAlpha(0.95)
			f19_arg0.clipFinished(f19_arg0.LockIconDotTiledBacking)
			f19_arg0.LockIcon:completeAnimation()
			f19_arg0.LockIcon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.LockIcon)
		end,
	},
	LockedState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			f21_arg0.IconImage:completeAnimation()
			f21_arg0.IconImage:setRGB(0.29, 0.29, 0.29)
			f21_arg0.IconImage:setAlpha(0.6)
			f21_arg0.clipFinished(f21_arg0.IconImage)
			f21_arg0.LockIconBacking:completeAnimation()
			f21_arg0.LockIconBacking:setAlpha(0.4)
			f21_arg0.clipFinished(f21_arg0.LockIconBacking)
			f21_arg0.LockIconDotTiledBacking:completeAnimation()
			f21_arg0.LockIconDotTiledBacking:setAlpha(0.95)
			f21_arg0.clipFinished(f21_arg0.LockIconDotTiledBacking)
			f21_arg0.LockIcon:completeAnimation()
			f21_arg0.LockIcon:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.LockIcon)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.IconImage:completeAnimation()
			f22_arg0.IconImage:setRGB(0.49, 0.49, 0.49)
			f22_arg0.IconImage:setAlpha(0.6)
			f22_arg0.clipFinished(f22_arg0.IconImage)
			f22_arg0.Name:completeAnimation()
			f22_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f22_arg0.clipFinished(f22_arg0.Name)
			f22_arg0.LockIconBacking:completeAnimation()
			f22_arg0.LockIconBacking:setAlpha(0.4)
			f22_arg0.clipFinished(f22_arg0.LockIconBacking)
			f22_arg0.LockIconDotTiledBacking:completeAnimation()
			f22_arg0.LockIconDotTiledBacking:setAlpha(0.95)
			f22_arg0.clipFinished(f22_arg0.LockIconDotTiledBacking)
			f22_arg0.LockIcon:completeAnimation()
			f22_arg0.LockIcon:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.LockIcon)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			local f23_local0 = function(f24_arg0)
				f23_arg0.IconImage:beginAnimation(200)
				f23_arg0.IconImage:setRGB(0.49, 0.49, 0.49)
				f23_arg0.IconImage:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.IconImage:completeAnimation()
			f23_arg0.IconImage:setRGB(0.29, 0.29, 0.29)
			f23_arg0.IconImage:setAlpha(0.6)
			f23_local0(f23_arg0.IconImage)
			f23_arg0.Name:completeAnimation()
			f23_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f23_arg0.clipFinished(f23_arg0.Name)
			f23_arg0.LockIconBacking:completeAnimation()
			f23_arg0.LockIconBacking:setAlpha(0.4)
			f23_arg0.clipFinished(f23_arg0.LockIconBacking)
			f23_arg0.LockIconDotTiledBacking:completeAnimation()
			f23_arg0.LockIconDotTiledBacking:setAlpha(0.95)
			f23_arg0.clipFinished(f23_arg0.LockIconDotTiledBacking)
			f23_arg0.LockIcon:completeAnimation()
			f23_arg0.LockIcon:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.LockIcon)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(5)
			local f25_local0 = function(f26_arg0)
				f25_arg0.IconImage:beginAnimation(200)
				f25_arg0.IconImage:setRGB(0.29, 0.29, 0.29)
				f25_arg0.IconImage:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.IconImage:completeAnimation()
			f25_arg0.IconImage:setRGB(0.49, 0.49, 0.49)
			f25_arg0.IconImage:setAlpha(0.6)
			f25_local0(f25_arg0.IconImage)
			f25_arg0.Name:completeAnimation()
			f25_arg0.Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f25_arg0.clipFinished(f25_arg0.Name)
			f25_arg0.LockIconBacking:completeAnimation()
			f25_arg0.LockIconBacking:setAlpha(0.4)
			f25_arg0.clipFinished(f25_arg0.LockIconBacking)
			f25_arg0.LockIconDotTiledBacking:completeAnimation()
			f25_arg0.LockIconDotTiledBacking:setAlpha(0.95)
			f25_arg0.clipFinished(f25_arg0.LockIconDotTiledBacking)
			f25_arg0.LockIcon:completeAnimation()
			f25_arg0.LockIcon:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.LockIcon)
		end,
	},
	EquippedState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.EquippedIcon:completeAnimation()
			f27_arg0.EquippedIcon:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.EquippedIcon)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.Name:completeAnimation()
			f28_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f28_arg0.clipFinished(f28_arg0.Name)
			f28_arg0.EquippedIcon:completeAnimation()
			f28_arg0.EquippedIcon:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.EquippedIcon)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.Name:completeAnimation()
			f29_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f29_arg0.clipFinished(f29_arg0.Name)
			f29_arg0.EquippedIcon:completeAnimation()
			f29_arg0.EquippedIcon:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.EquippedIcon)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.Name:completeAnimation()
			f30_arg0.Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f30_arg0.clipFinished(f30_arg0.Name)
			f30_arg0.EquippedIcon:completeAnimation()
			f30_arg0.EquippedIcon:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.EquippedIcon)
		end,
	},
}
CoD.CustomizeIconGridItem_Internal.__onClose = function(f31_arg0)
	f31_arg0.IconImage:close()
	f31_arg0.Name:close()
	f31_arg0.LockIconDotTiledBacking:close()
	f31_arg0.ButtonOutline:close()
end
