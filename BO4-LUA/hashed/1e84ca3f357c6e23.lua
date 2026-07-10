require("x64:5f8cf56752aa71b")
CoD.BountyHunterGenericBuyInternal = InheritFrom(LUI.UIElement)
CoD.BountyHunterGenericBuyInternal.__defaultWidth = 127
CoD.BountyHunterGenericBuyInternal.__defaultHeight = 127
CoD.BountyHunterGenericBuyInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterGenericBuyInternal)
	self.id = "BountyHunterGenericBuyInternal"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local FocusGlow = LUI.UIImage.new(0, 1, -61, 61, 0, 1, -37, 37)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_large"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(300, 300)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
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
	local TextBackerBG = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -17, 0)
	TextBackerBG:setRGB(0, 0, 0)
	TextBackerBG:setAlpha(0)
	self:addElement(TextBackerBG)
	self.TextBackerBG = TextBackerBG
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGrid:setAlpha(0.05)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local Name = LUI.UIText.new(0.5, 0.5, -63, 63, 1, 1, -17, 0)
	Name:setAlpha(0)
	Name:setTTF("ttmussels_regular")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Name:linkToElementModel(self, "item1.displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f2_local0))
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
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -38.5, 38.5, 0.5, 0.5, -38.5, 38.5)
	FixedAspectRatioImage:linkToElementModel(self, "item1.image", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FixedAspectRatioImage:setImage(CoD.BaseUtility.AlreadyRegistered(f3_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
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
CoD.BountyHunterGenericBuyInternal.__resetProperties = function(f6_arg0)
	f6_arg0.Name:completeAnimation()
	f6_arg0.SelectOvelay:completeAnimation()
	f6_arg0.TextBackerBG:completeAnimation()
	f6_arg0.AddPlus:completeAnimation()
	f6_arg0.Name:setRGB(1, 1, 1)
	f6_arg0.Name:setAlpha(0)
	f6_arg0.SelectOvelay:setAlpha(0.01)
	f6_arg0.TextBackerBG:setAlpha(0)
	f6_arg0.AddPlus:setRGB(1, 1, 1)
	f6_arg0.AddPlus:setAlpha(0)
end
CoD.BountyHunterGenericBuyInternal.__clipsPerState = {
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
		GainChildFocus = function(f9_arg0, f9_arg1)
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
			local f9_local1 = function(f11_arg0)
				f9_arg0.Name:beginAnimation(200)
				f9_arg0.Name:setRGB(0.92, 0.89, 0.72)
				f9_arg0.Name:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Name:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Name:completeAnimation()
			f9_arg0.Name:setRGB(1, 1, 1)
			f9_local1(f9_arg0.Name)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				f12_arg0.SelectOvelay:beginAnimation(200)
				f12_arg0.SelectOvelay:setAlpha(0.01)
				f12_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SelectOvelay:completeAnimation()
			f12_arg0.SelectOvelay:setAlpha(0.04)
			f12_local0(f12_arg0.SelectOvelay)
			local f12_local1 = function(f14_arg0)
				f12_arg0.Name:beginAnimation(200)
				f12_arg0.Name:setRGB(1, 1, 1)
				f12_arg0.Name:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Name:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Name:completeAnimation()
			f12_arg0.Name:setRGB(0.92, 0.89, 0.72)
			f12_local1(f12_arg0.Name)
		end,
	},
	Add = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.TextBackerBG:completeAnimation()
			f15_arg0.TextBackerBG:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TextBackerBG)
			f15_arg0.Name:completeAnimation()
			f15_arg0.Name:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Name)
			f15_arg0.AddPlus:completeAnimation()
			f15_arg0.AddPlus:setAlpha(0.7)
			f15_arg0.clipFinished(f15_arg0.AddPlus)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.SelectOvelay:completeAnimation()
			f16_arg0.SelectOvelay:setAlpha(0.04)
			f16_arg0.clipFinished(f16_arg0.SelectOvelay)
			f16_arg0.TextBackerBG:completeAnimation()
			f16_arg0.TextBackerBG:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TextBackerBG)
			f16_arg0.Name:completeAnimation()
			f16_arg0.Name:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Name)
			f16_arg0.AddPlus:completeAnimation()
			f16_arg0.AddPlus:setRGB(0.92, 0.89, 0.72)
			f16_arg0.AddPlus:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.AddPlus)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			local f17_local0 = function(f18_arg0)
				f17_arg0.SelectOvelay:beginAnimation(200)
				f17_arg0.SelectOvelay:setAlpha(0.04)
				f17_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.SelectOvelay:completeAnimation()
			f17_arg0.SelectOvelay:setAlpha(0.01)
			f17_local0(f17_arg0.SelectOvelay)
			f17_arg0.TextBackerBG:completeAnimation()
			f17_arg0.TextBackerBG:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TextBackerBG)
			f17_arg0.Name:completeAnimation()
			f17_arg0.Name:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Name)
			local f17_local1 = function(f19_arg0)
				f17_arg0.AddPlus:beginAnimation(200)
				f17_arg0.AddPlus:setRGB(0.92, 0.89, 0.72)
				f17_arg0.AddPlus:setAlpha(1)
				f17_arg0.AddPlus:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.AddPlus:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.AddPlus:completeAnimation()
			f17_arg0.AddPlus:setRGB(1, 1, 1)
			f17_arg0.AddPlus:setAlpha(0.7)
			f17_local1(f17_arg0.AddPlus)
		end,
		LoseFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			local f20_local0 = function(f21_arg0)
				f20_arg0.SelectOvelay:beginAnimation(200)
				f20_arg0.SelectOvelay:setAlpha(0.01)
				f20_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.SelectOvelay:completeAnimation()
			f20_arg0.SelectOvelay:setAlpha(0.04)
			f20_local0(f20_arg0.SelectOvelay)
			f20_arg0.TextBackerBG:completeAnimation()
			f20_arg0.TextBackerBG:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.TextBackerBG)
			f20_arg0.Name:completeAnimation()
			f20_arg0.Name:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Name)
			local f20_local1 = function(f22_arg0)
				f20_arg0.AddPlus:beginAnimation(200)
				f20_arg0.AddPlus:setRGB(1, 1, 1)
				f20_arg0.AddPlus:setAlpha(0.7)
				f20_arg0.AddPlus:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.AddPlus:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.AddPlus:completeAnimation()
			f20_arg0.AddPlus:setRGB(0.92, 0.89, 0.72)
			f20_arg0.AddPlus:setAlpha(1)
			f20_local1(f20_arg0.AddPlus)
		end,
	},
}
CoD.BountyHunterGenericBuyInternal.__onClose = function(f23_arg0)
	f23_arg0.Name:close()
	f23_arg0.FixedAspectRatioImage:close()
	f23_arg0.CommonButtonOutline:close()
end
