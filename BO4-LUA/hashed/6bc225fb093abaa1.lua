require("x64:5f8cf56752aa71b")
require("x64:f885721e8768c0f")
CoD.ContractPreviewButtonInternal = InheritFrom(LUI.UIElement)
CoD.ContractPreviewButtonInternal.__defaultWidth = 225
CoD.ContractPreviewButtonInternal.__defaultHeight = 309
CoD.ContractPreviewButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractPreviewButtonInternal)
	self.id = "ContractPreviewButtonInternal"
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
	StripDarken:setAlpha(0.97)
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
	local ContractIcon = LUI.UIImage.new(0, 0, 1, 225, 0, 0, -1, 309)
	ContractIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	ContractIcon:setShaderVector(0, 0.9, 0, 0, 0)
	ContractIcon:setShaderVector(1, 1, 1, 0, 0)
	ContractIcon:setShaderVector(2, 0, 0, 0, 0)
	ContractIcon:linkToElementModel(self, "detailsImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContractIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(ContractIcon)
	self.ContractIcon = ContractIcon
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3E7BDCB879A5176D"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setShaderVector(1, 0, 0, 0, 0)
	Border:setupNineSliceShader(1, 1)
	Border:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Border:setRGB(ColorMultiply(0.5, CoD.BlackMarketUtility.LootRarityToColor(f4_local0)))
		end
	end)
	self:addElement(Border)
	self.Border = Border
	local Image = LUI.UIImage.new(0, 0, 1, 224, 0, 0, 273.5, 308.5)
	Image:setRGB(0, 0, 0)
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
	VideoPlayIcon:setAlpha(0.5)
	VideoPlayIcon:setImage(RegisterImage(@"hash_528C77CAF49CB973"))
	self:addElement(VideoPlayIcon)
	self.VideoPlayIcon = VideoPlayIcon
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 0, 0, 225, 0, 0, 0, 308)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local Seasonal = CoD.ContractSeasonalOverlay_PreviewButton.new(f1_arg0, f1_arg1, 0, 0, 0, 225, 0, 0, 0, 309)
	Seasonal:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "seasonal")
			end,
		},
	})
	Seasonal:linkToElementModel(Seasonal, "seasonal", true, function(model)
		f1_arg0:updateElementState(Seasonal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "seasonal",
		})
	end)
	Seasonal:linkToElementModel(self, nil, false, function(model)
		Seasonal:setModel(model, f1_arg1)
	end)
	self:addElement(Seasonal)
	self.Seasonal = Seasonal
	self:mergeStateConditions({
		{
			stateName = "VideoPreview",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "movieName")
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
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractPreviewButtonInternal.__resetProperties = function(f10_arg0)
	f10_arg0.VideoPlayIcon:completeAnimation()
	f10_arg0.CommonButtonOutline:completeAnimation()
	f10_arg0.VideoPlayIcon:setAlpha(0.5)
	f10_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
end
CoD.ContractPreviewButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.VideoPlayIcon:completeAnimation()
			f11_arg0.VideoPlayIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.VideoPlayIcon)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.VideoPlayIcon:completeAnimation()
			f12_arg0.VideoPlayIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.VideoPlayIcon)
			f12_arg0.CommonButtonOutline:completeAnimation()
			f12_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f12_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.VideoPlayIcon:completeAnimation()
			f13_arg0.VideoPlayIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.VideoPlayIcon)
			local f13_local0 = function(f14_arg0)
				f13_arg0.CommonButtonOutline:beginAnimation(200)
				f13_arg0.CommonButtonOutline.FocusGlow:beginAnimation(200)
				f13_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
				f13_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.CommonButtonOutline:completeAnimation()
			f13_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f13_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
			f13_local0(f13_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.VideoPlayIcon:completeAnimation()
			f15_arg0.VideoPlayIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.VideoPlayIcon)
			local f15_local0 = function(f16_arg0)
				f15_arg0.CommonButtonOutline:beginAnimation(200)
				f15_arg0.CommonButtonOutline.FocusGlow:beginAnimation(200)
				f15_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
				f15_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.CommonButtonOutline:completeAnimation()
			f15_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f15_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
			f15_local0(f15_arg0.CommonButtonOutline)
		end,
	},
	VideoPreview = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.CommonButtonOutline:completeAnimation()
			f18_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f18_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.CommonButtonOutline:beginAnimation(200)
				f19_arg0.CommonButtonOutline.FocusGlow:beginAnimation(200)
				f19_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
				f19_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.CommonButtonOutline:completeAnimation()
			f19_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f19_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
			f19_local0(f19_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.CommonButtonOutline:beginAnimation(200)
				f21_arg0.CommonButtonOutline.FocusGlow:beginAnimation(200)
				f21_arg0.CommonButtonOutline.FocusGlow:setAlpha(0)
				f21_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.CommonButtonOutline:completeAnimation()
			f21_arg0.CommonButtonOutline.FocusGlow:completeAnimation()
			f21_arg0.CommonButtonOutline.FocusGlow:setAlpha(1)
			f21_local0(f21_arg0.CommonButtonOutline)
		end,
	},
}
CoD.ContractPreviewButtonInternal.__onClose = function(f23_arg0)
	f23_arg0.Strip:close()
	f23_arg0.ContractIcon:close()
	f23_arg0.Border:close()
	f23_arg0.CommonButtonOutline:close()
	f23_arg0.Seasonal:close()
end
