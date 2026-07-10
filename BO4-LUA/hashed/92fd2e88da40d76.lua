require("x64:5f8cf56752aa71b")
CoD.BountyHunterWeaponBuyInternal = InheritFrom(LUI.UIElement)
CoD.BountyHunterWeaponBuyInternal.__defaultWidth = 280
CoD.BountyHunterWeaponBuyInternal.__defaultHeight = 127
CoD.BountyHunterWeaponBuyInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterWeaponBuyInternal)
	self.id = "BountyHunterWeaponBuyInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectOvelay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectOvelay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectOvelay:setAlpha(0.01)
	self:addElement(SelectOvelay)
	self.SelectOvelay = SelectOvelay
	local ButtonBGTiled = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ButtonBGTiled:setRGB(0.28, 0.28, 0.28)
	ButtonBGTiled:setAlpha(0.8)
	ButtonBGTiled:setImage(RegisterImage(@"hash_7D78A9159503BFBB"))
	ButtonBGTiled:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	ButtonBGTiled:setShaderVector(0, 0, 0, 0, 0)
	ButtonBGTiled:setupNineSliceShader(16, 16)
	self:addElement(ButtonBGTiled)
	self.ButtonBGTiled = ButtonBGTiled
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGrid:setAlpha(0.05)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -140, 140, 0.5, 0.5, -41, 41)
	WeaponImage:linkToElementModel(self, "item1.image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponImage:setImage(CoD.BaseUtility.AlreadyRegistered(f2_local0))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local Name = LUI.UIText.new(0, 0, 5, 150, 1, 1, -27, -5)
	Name:setRGB(0.92, 0.92, 0.92)
	Name:setTTF("ttmussels_regular")
	Name:setLetterSpacing(4)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Name:linkToElementModel(self, "item1.displayName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local AddPlus = LUI.UIImage.new(0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	AddPlus:setAlpha(0)
	AddPlus:setImage(RegisterImage(@"uie_ui_menu_common_add_plus"))
	AddPlus:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(AddPlus)
	self.AddPlus = AddPlus
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	self:mergeStateConditions({
		{
			stateName = "Add",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "packageID")
			end,
		},
	})
	self:linkToElementModel(self, "packageID", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "packageID",
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
CoD.BountyHunterWeaponBuyInternal.__resetProperties = function(f6_arg0)
	f6_arg0.Name:completeAnimation()
	f6_arg0.SelectOvelay:completeAnimation()
	f6_arg0.AddPlus:completeAnimation()
	f6_arg0.WeaponImage:completeAnimation()
	f6_arg0.Name:setRGB(0.92, 0.92, 0.92)
	f6_arg0.Name:setAlpha(1)
	f6_arg0.SelectOvelay:setAlpha(0.01)
	f6_arg0.AddPlus:setAlpha(0)
	f6_arg0.WeaponImage:setAlpha(1)
end
CoD.BountyHunterWeaponBuyInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.SelectOvelay:completeAnimation()
			f8_arg0.SelectOvelay:setAlpha(0.04)
			f8_arg0.clipFinished(f8_arg0.SelectOvelay)
			f8_arg0.Name:completeAnimation()
			f8_arg0.Name:setRGB(0.92, 0.89, 0.72)
			f8_arg0.clipFinished(f8_arg0.Name)
		end,
		ChildGainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.SelectOvelay:beginAnimation(200)
				f9_arg0.SelectOvelay:setAlpha(0.04)
				f9_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SelectOvelay:completeAnimation()
			f9_arg0.SelectOvelay:setAlpha(0.01)
			f9_local0(f9_arg0.SelectOvelay)
			f9_arg0.Name:completeAnimation()
			f9_arg0.Name:setRGB(0.92, 0.89, 0.72)
			f9_arg0.clipFinished(f9_arg0.Name)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.SelectOvelay:beginAnimation(200)
				f11_arg0.SelectOvelay:setAlpha(0.01)
				f11_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.SelectOvelay:completeAnimation()
			f11_arg0.SelectOvelay:setAlpha(0.04)
			f11_local0(f11_arg0.SelectOvelay)
			f11_arg0.Name:completeAnimation()
			f11_arg0.Name:setRGB(0.92, 0.92, 0.92)
			f11_arg0.clipFinished(f11_arg0.Name)
		end,
	},
	Add = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.WeaponImage:completeAnimation()
			f13_arg0.WeaponImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.WeaponImage)
			f13_arg0.Name:completeAnimation()
			f13_arg0.Name:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Name)
			f13_arg0.AddPlus:completeAnimation()
			f13_arg0.AddPlus:setAlpha(0.7)
			f13_arg0.clipFinished(f13_arg0.AddPlus)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.SelectOvelay:completeAnimation()
			f14_arg0.SelectOvelay:setAlpha(0.04)
			f14_arg0.clipFinished(f14_arg0.SelectOvelay)
			f14_arg0.WeaponImage:completeAnimation()
			f14_arg0.WeaponImage:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.WeaponImage)
			f14_arg0.Name:completeAnimation()
			f14_arg0.Name:setRGB(0.92, 0.89, 0.72)
			f14_arg0.Name:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Name)
			f14_arg0.AddPlus:completeAnimation()
			f14_arg0.AddPlus:setAlpha(0.7)
			f14_arg0.clipFinished(f14_arg0.AddPlus)
		end,
		GainFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			local f15_local0 = function(f16_arg0)
				f15_arg0.SelectOvelay:beginAnimation(200)
				f15_arg0.SelectOvelay:setAlpha(0.04)
				f15_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.SelectOvelay:completeAnimation()
			f15_arg0.SelectOvelay:setAlpha(0.01)
			f15_local0(f15_arg0.SelectOvelay)
			f15_arg0.WeaponImage:completeAnimation()
			f15_arg0.WeaponImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.WeaponImage)
			local f15_local1 = function(f17_arg0)
				f15_arg0.Name:beginAnimation(200)
				f15_arg0.Name:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Name:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Name:completeAnimation()
			f15_arg0.Name:setRGB(0.92, 0.89, 0.72)
			f15_arg0.Name:setAlpha(0)
			f15_local1(f15_arg0.Name)
			f15_arg0.AddPlus:completeAnimation()
			f15_arg0.AddPlus:setAlpha(0.7)
			f15_arg0.clipFinished(f15_arg0.AddPlus)
		end,
		LoseFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			local f18_local0 = function(f19_arg0)
				f18_arg0.SelectOvelay:beginAnimation(200)
				f18_arg0.SelectOvelay:setAlpha(0.01)
				f18_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.SelectOvelay:completeAnimation()
			f18_arg0.SelectOvelay:setAlpha(0.04)
			f18_local0(f18_arg0.SelectOvelay)
			f18_arg0.WeaponImage:completeAnimation()
			f18_arg0.WeaponImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.WeaponImage)
			local f18_local1 = function(f20_arg0)
				f18_arg0.Name:beginAnimation(200)
				f18_arg0.Name:setRGB(0.92, 0.92, 0.92)
				f18_arg0.Name:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Name:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Name:completeAnimation()
			f18_arg0.Name:setRGB(0.92, 0.89, 0.72)
			f18_arg0.Name:setAlpha(0)
			f18_local1(f18_arg0.Name)
			f18_arg0.AddPlus:completeAnimation()
			f18_arg0.AddPlus:setAlpha(0.7)
			f18_arg0.clipFinished(f18_arg0.AddPlus)
		end,
	},
}
CoD.BountyHunterWeaponBuyInternal.__onClose = function(f21_arg0)
	f21_arg0.WeaponImage:close()
	f21_arg0.Name:close()
	f21_arg0.CommonButtonOutline:close()
end
