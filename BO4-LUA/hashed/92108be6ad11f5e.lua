require("x64:5f8cf56752aa71b")
require("x64:9c202ce339fe865")
require("x64:fd740505876fd7b")
CoD.ItemShopPreviewButtonInternal = InheritFrom(LUI.UIElement)
CoD.ItemShopPreviewButtonInternal.__defaultWidth = 225
CoD.ItemShopPreviewButtonInternal.__defaultHeight = 309
CoD.ItemShopPreviewButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopPreviewButtonInternal)
	self.id = "ItemShopPreviewButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Strip = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Strip:setAlpha(0.8)
	Strip:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	Strip:setShaderVector(0, 0.7, 0, 0, 0)
	Strip:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Strip:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f2_local0))
		end
	end)
	self:addElement(Strip)
	self.Strip = Strip
	local StripDarken = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	StripDarken:setRGB(0, 0, 0)
	StripDarken:setAlpha(0.88)
	self:addElement(StripDarken)
	self.StripDarken = StripDarken
	local LED = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LED:setRGB(0, 0, 0)
	LED:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	LED:setShaderVector(0, 0, 0, 0, 0)
	LED:setupNineSliceShader(24, 24)
	self:addElement(LED)
	self.LED = LED
	local LED2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LED2:setRGB(0, 0, 0)
	LED2:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	LED2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	LED2:setShaderVector(0, 0, 0, 0, 0)
	LED2:setupNineSliceShader(24, 24)
	self:addElement(LED2)
	self.LED2 = LED2
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3E7BDCB879A5176D"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setShaderVector(1, 0, 0, 0, 0)
	Border:setupNineSliceShader(1, 1)
	Border:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Border:setRGB(ColorMultiply(0.5, CoD.BlackMarketUtility.LootRarityToColor(f3_local0)))
		end
	end)
	self:addElement(Border)
	self.Border = Border
	local ContractIcon = CoD.ItemShopPreviewButtonContentImage.new(f1_arg0, f1_arg1, 0, 0, 1, 225, 0, 0, 1, 309)
	ContractIcon:linkToElementModel(self, nil, false, function(model)
		ContractIcon:setModel(model, f1_arg1)
	end)
	self:addElement(ContractIcon)
	self.ContractIcon = ContractIcon
	local FeaturedImage = CoD.ReservesContentImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -146, 146, 0.5, 0.5, -196.5, 154.5)
	FeaturedImage:setAlpha(0)
	FeaturedImage:setScale(0.7, 0.7)
	FeaturedImage:linkToElementModel(self, nil, false, function(model)
		FeaturedImage:setModel(model, f1_arg1)
	end)
	self:addElement(FeaturedImage)
	self.FeaturedImage = FeaturedImage
	local Image = LUI.UIImage.new(0, 0, 1, 224, 0, 0, 273.5, 308.5)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.8)
	self:addElement(Image)
	self.Image = Image
	local Text = LUI.UIText.new(0, 0, 9, 217, 0, 0, 282.5, 300.5)
	Text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Text:setText(LocalizeToUpperString(@"hash_3DE6A90417A1818A"))
	Text:setTTF("ttmussels_regular")
	Text:setLetterSpacing(1)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Text)
	self.Text = Text
	local VideoPlayIcon = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -42, 22)
	VideoPlayIcon:setAlpha(0.58)
	VideoPlayIcon:setImage(RegisterImage(@"hash_528C77CAF49CB973"))
	self:addElement(VideoPlayIcon)
	self.VideoPlayIcon = VideoPlayIcon
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 0, 0, 225, 0, 0, 0, 308)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	self:mergeStateConditions({
		{
			stateName = "VideoPreview",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "movieName")
			end,
		},
		{
			stateName = "CamoOrDeathFXNoPreview",
			condition = function(menu, element, event)
				local f7_local0 = IsPC()
				if f7_local0 then
					if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "allowFrozenMoment", true) and not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "movieName") then
						f7_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(self, f1_arg1, "itemCategory", @"single_weapon_charm", @"hash_1AD68520D53FDBFB")
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "CamoOrDeathFXPreview",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(self, f1_arg1, "itemCategory", @"single_weapon_charm", @"hash_1AD68520D53FDBFB")
			end,
		},
		{
			stateName = "NoPreview",
			condition = function(menu, element, event)
				local f9_local0 = IsPC()
				if f9_local0 then
					if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "allowFrozenMoment", true) then
						f9_local0 = not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "movieName")
					else
						f9_local0 = false
					end
				end
				return f9_local0
			end,
		},
	})
	self:linkToElementModel(self, "movieName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "movieName",
		})
	end)
	self:linkToElementModel(self, "allowFrozenMoment", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allowFrozenMoment",
		})
	end)
	self:linkToElementModel(self, "itemCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
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
CoD.ItemShopPreviewButtonInternal.__resetProperties = function(f13_arg0)
	f13_arg0.VideoPlayIcon:completeAnimation()
	f13_arg0.CommonButtonOutline:completeAnimation()
	f13_arg0.ContractIcon:completeAnimation()
	f13_arg0.FeaturedImage:completeAnimation()
	f13_arg0.Text:completeAnimation()
	f13_arg0.Image:completeAnimation()
	f13_arg0.VideoPlayIcon:setAlpha(0.58)
	f13_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
	f13_arg0.ContractIcon:setAlpha(1)
	f13_arg0.FeaturedImage:setAlpha(0)
	f13_arg0.Text:setAlpha(1)
	f13_arg0.Image:setAlpha(0.8)
end
CoD.ItemShopPreviewButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.VideoPlayIcon:completeAnimation()
			f14_arg0.VideoPlayIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.VideoPlayIcon)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.VideoPlayIcon:completeAnimation()
			f15_arg0.VideoPlayIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.VideoPlayIcon)
			f15_arg0.CommonButtonOutline:completeAnimation()
			f15_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f15_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.VideoPlayIcon:completeAnimation()
			f16_arg0.VideoPlayIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.VideoPlayIcon)
			local f16_local0 = function(f17_arg0)
				f16_arg0.CommonButtonOutline:beginAnimation(200)
				f16_arg0.CommonButtonOutline.FocusGlow:beginAnimation(200)
				f16_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
				f16_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.CommonButtonOutline:completeAnimation()
			f16_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f16_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
			f16_local0(f16_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.VideoPlayIcon:completeAnimation()
			f18_arg0.VideoPlayIcon:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.VideoPlayIcon)
			local f18_local0 = function(f19_arg0)
				f18_arg0.CommonButtonOutline:beginAnimation(200)
				f18_arg0.CommonButtonOutline.FocusGlow:beginAnimation(200)
				f18_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
				f18_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.CommonButtonOutline:completeAnimation()
			f18_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f18_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
			f18_local0(f18_arg0.CommonButtonOutline)
		end,
	},
	VideoPreview = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.CommonButtonOutline:completeAnimation()
			f21_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f21_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.CommonButtonOutline:beginAnimation(200)
				f22_arg0.CommonButtonOutline.FocusGlow:beginAnimation(200)
				f22_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
				f22_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.CommonButtonOutline:completeAnimation()
			f22_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f22_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
			f22_local0(f22_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.CommonButtonOutline:beginAnimation(200)
				f24_arg0.CommonButtonOutline.FocusGlow:beginAnimation(200)
				f24_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
				f24_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.CommonButtonOutline:completeAnimation()
			f24_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f24_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
			f24_local0(f24_arg0.CommonButtonOutline)
		end,
	},
	CamoOrDeathFXNoPreview = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	CamoOrDeathFXPreview = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.ContractIcon:completeAnimation()
			f27_arg0.ContractIcon:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ContractIcon)
			f27_arg0.FeaturedImage:completeAnimation()
			f27_arg0.FeaturedImage:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.FeaturedImage)
			f27_arg0.VideoPlayIcon:completeAnimation()
			f27_arg0.VideoPlayIcon:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.VideoPlayIcon)
		end,
	},
	NoPreview = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			f28_arg0.Image:completeAnimation()
			f28_arg0.Image:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.Image)
			f28_arg0.Text:completeAnimation()
			f28_arg0.Text:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.Text)
			f28_arg0.VideoPlayIcon:completeAnimation()
			f28_arg0.VideoPlayIcon:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.VideoPlayIcon)
		end,
	},
}
CoD.ItemShopPreviewButtonInternal.__onClose = function(f29_arg0)
	f29_arg0.Strip:close()
	f29_arg0.Border:close()
	f29_arg0.ContractIcon:close()
	f29_arg0.FeaturedImage:close()
	f29_arg0.CommonButtonOutline:close()
end
