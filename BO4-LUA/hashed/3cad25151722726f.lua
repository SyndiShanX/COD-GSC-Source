require("x64:e272191e46af824")
require("x64:266118fa96f77c8")
require("x64:3c21aa1a96202c9")
require("x64:95553e1dbf377f6")
require("x64:8c811a1d34161cf")
CoD.ReservesSpecialContractInternal = InheritFrom(LUI.UIElement)
CoD.ReservesSpecialContractInternal.__defaultWidth = 684
CoD.ReservesSpecialContractInternal.__defaultHeight = 132
CoD.ReservesSpecialContractInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesSpecialContractInternal)
	self.id = "ReservesSpecialContractInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusGlow = LUI.UIImage.new(0, 1, -69, 69, 0, 1, -51, 51)
	FocusGlow:setAlpha(0)
	FocusGlow:setScale(1.01, 1)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_small"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.24, 0.24)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(160, 160)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local PreviewScene = LUI.UIImage.new(0, 0, 0, 684, 0, 0, 0, 132)
	PreviewScene:linkToElementModel(self, "bundleReservesImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PreviewScene:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PreviewScene)
	self.PreviewScene = PreviewScene
	local gradient = LUI.UIImage.new(0, 0, 5.5, 525.5, 0, 0, 5, 127)
	gradient:setAlpha(0.9)
	gradient:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_gradient_normal"))
	gradient:setShaderVector(0, 0, 0, 0, 1)
	gradient:setShaderVector(1, 0, 0, 0, 0)
	gradient:setShaderVector(2, 0.67, 0, 0, 0)
	self:addElement(gradient)
	self.gradient = gradient
	local PreviewButton = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 1, 1)
	PreviewButton:setAlpha(0)
	PreviewButton:setImage(RegisterImage(@"hash_9B5AB12D437292D"))
	self:addElement(PreviewButton)
	self.PreviewButton = PreviewButton
	local Title = LUI.UIText.new(0, 0, 17, 452, 0, 0, 10.5, 34.5)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Title:linkToElementModel(self, "categoryString", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Description = LUI.UIText.new(0, 0, 19, 491, 0, 0, 37.5, 52.5)
	Description:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Description:setTTF("ttmussels_demibold")
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Description:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Description:setText(f4_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local RewardName = LUI.UIText.new(0, 0, 433.5, 678.5, 0, 0, 86.5, 104.5)
	RewardName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	RewardName:setTTF("ttmussels_demibold")
	RewardName:setLetterSpacing(4)
	RewardName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RewardName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	RewardName:linkToElementModel(self, "rewardName", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RewardName:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(RewardName)
	self.RewardName = RewardName
	local Timer = CoD.TimerRight.new(f1_arg0, f1_arg1, 1, 1, -436, -400, 1, 1, -43, -28)
	Timer.TextBox2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Timer:subscribeToGlobalModel(f1_arg1, "AutoEvents", "autoevent_special_contract_timer", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Timer.TextBox2:setText(f6_local0)
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	local ActiveBanner = CoD.ContractActiveBanner.new(f1_arg0, f1_arg1, 0, 0, 25, 175, 1, 1, -48.5, -23.5)
	ActiveBanner:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ActiveBanner)
	self.ActiveBanner = ActiveBanner
	local ProgressBar = CoD.ReservesSpecialContractProgressBar.new(f1_arg0, f1_arg1, 0, 0, 8, 656, 0, 0, 108.5, 126.5)
	ProgressBar:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ProgressBar.Progress:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar"))
	ProgressBar.ProgressGlow:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar_glow"))
	ProgressBar:linkToElementModel(self, "progress", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ProgressBar.Progress:setShaderVector(0, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4))
		end
	end)
	ProgressBar:linkToElementModel(self, "progress", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ProgressBar.ProgressGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4))
		end
	end)
	ProgressBar:linkToElementModel(self, "progress", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ProgressBar.ProgressFraction:setText(NumberAsPercent(CoD.BaseUtility.FloorFraction(2, StringMultiply(100, f12_local0))))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local Darken = LUI.UIImage.new(0, 1, 6, -6, 0, 1, 6, -6)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local NineSliceBMFrame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	NineSliceBMFrame:setImage(RegisterImage(@"hash_71AC151A09D526DC"))
	NineSliceBMFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	NineSliceBMFrame:setShaderVector(0, 0, 0, 0, 0)
	NineSliceBMFrame:setupNineSliceShader(162, 52)
	self:addElement(NineSliceBMFrame)
	self.NineSliceBMFrame = NineSliceBMFrame
	local FocusBorder = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	FocusBorder:setRGB(1, 0.75, 0.47)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(18, 18)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local CompleteBanner = CoD.ContractCompleteBanner.new(f1_arg0, f1_arg1, 0, 0, 31, 181, 1, 1, -51.5, -26.5)
	CompleteBanner:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	CompleteBanner:setAlpha(0)
	self:addElement(CompleteBanner)
	self.CompleteBanner = CompleteBanner
	local ItemHintText = CoD.CommonToolTip.new(f1_arg0, f1_arg1, 0.5, 0.5, -342, 342, 1, 1, 0, 45)
	ItemHintText:mergeStateConditions({
		{
			stateName = "Mouse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "toolTip")
			end,
		},
		{
			stateName = "CenterAlign",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ItemHintText:linkToElementModel(ItemHintText, "toolTip", true, function(model)
		f1_arg0:updateElementState(ItemHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "toolTip",
		})
	end)
	ItemHintText:setAlpha(0)
	ItemHintText:linkToElementModel(self, "toolTip", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			ItemHintText.textCenterAlign:setText(Engine[@"hash_4F9F1239CFD921FE"](f18_local0))
		end
	end)
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	self:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "complete")
			end,
		},
	})
	self:linkToElementModel(self, "complete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesSpecialContractInternal.__resetProperties = function(f21_arg0)
	f21_arg0.FocusGlow:completeAnimation()
	f21_arg0.ItemHintText:completeAnimation()
	f21_arg0.FocusBorder:completeAnimation()
	f21_arg0.CompleteBanner:completeAnimation()
	f21_arg0.Darken:completeAnimation()
	f21_arg0.ActiveBanner:completeAnimation()
	f21_arg0.Timer:completeAnimation()
	f21_arg0.ProgressBar:completeAnimation()
	f21_arg0.gradient:completeAnimation()
	f21_arg0.FocusGlow:setAlpha(0)
	f21_arg0.ItemHintText:setAlpha(0)
	f21_arg0.FocusBorder:setAlpha(0)
	f21_arg0.CompleteBanner:setAlpha(0)
	f21_arg0.Darken:setAlpha(0)
	f21_arg0.ActiveBanner:setAlpha(1)
	f21_arg0.Timer:setAlpha(1)
	f21_arg0.ProgressBar:setAlpha(1)
	f21_arg0.gradient:setAlpha(0.9)
end
CoD.ReservesSpecialContractInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.FocusGlow:completeAnimation()
			f23_arg0.FocusGlow:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.FocusGlow)
			f23_arg0.FocusBorder:completeAnimation()
			f23_arg0.FocusBorder:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.FocusBorder)
			local f23_local0 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(199)
					f25_arg0:setAlpha(0)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
				end
				f23_arg0.ItemHintText:beginAnimation(5000)
				f23_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f23_arg0.ItemHintText:completeAnimation()
			f23_arg0.ItemHintText:setAlpha(1)
			f23_local0(f23_arg0.ItemHintText)
		end,
		GainFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			local f26_local0 = function(f27_arg0)
				f26_arg0.FocusGlow:beginAnimation(200)
				f26_arg0.FocusGlow:setAlpha(1)
				f26_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FocusGlow:completeAnimation()
			f26_arg0.FocusGlow:setAlpha(0)
			f26_local0(f26_arg0.FocusGlow)
			local f26_local1 = function(f28_arg0)
				f26_arg0.FocusBorder:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f26_arg0.FocusBorder:setAlpha(1)
				f26_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FocusBorder:completeAnimation()
			f26_arg0.FocusBorder:setAlpha(0)
			f26_local1(f26_arg0.FocusBorder)
			local f26_local2 = function(f29_arg0)
				f26_arg0.ItemHintText:beginAnimation(200)
				f26_arg0.ItemHintText:setAlpha(1)
				f26_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.ItemHintText:completeAnimation()
			f26_arg0.ItemHintText:setAlpha(0)
			f26_local2(f26_arg0.ItemHintText)
		end,
		LoseFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			local f30_local0 = function(f31_arg0)
				f30_arg0.FocusGlow:beginAnimation(100)
				f30_arg0.FocusGlow:setAlpha(0)
				f30_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.FocusGlow:completeAnimation()
			f30_arg0.FocusGlow:setAlpha(1)
			f30_local0(f30_arg0.FocusGlow)
			local f30_local1 = function(f32_arg0)
				f30_arg0.FocusBorder:beginAnimation(100)
				f30_arg0.FocusBorder:setAlpha(0)
				f30_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.FocusBorder:completeAnimation()
			f30_arg0.FocusBorder:setAlpha(1)
			f30_local1(f30_arg0.FocusBorder)
		end,
	},
	Complete = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(6)
			f33_arg0.gradient:completeAnimation()
			f33_arg0.gradient:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.gradient)
			f33_arg0.Timer:completeAnimation()
			f33_arg0.Timer:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Timer)
			f33_arg0.ActiveBanner:completeAnimation()
			f33_arg0.ActiveBanner:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ActiveBanner)
			f33_arg0.ProgressBar:completeAnimation()
			f33_arg0.ProgressBar:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ProgressBar)
			f33_arg0.Darken:completeAnimation()
			f33_arg0.Darken:setAlpha(0.8)
			f33_arg0.clipFinished(f33_arg0.Darken)
			f33_arg0.CompleteBanner:completeAnimation()
			f33_arg0.CompleteBanner:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.CompleteBanner)
		end,
		Focus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(8)
			f34_arg0.FocusGlow:completeAnimation()
			f34_arg0.FocusGlow:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.FocusGlow)
			f34_arg0.gradient:completeAnimation()
			f34_arg0.gradient:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.gradient)
			f34_arg0.Timer:completeAnimation()
			f34_arg0.Timer:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Timer)
			f34_arg0.ActiveBanner:completeAnimation()
			f34_arg0.ActiveBanner:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ActiveBanner)
			f34_arg0.ProgressBar:completeAnimation()
			f34_arg0.ProgressBar:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ProgressBar)
			f34_arg0.Darken:completeAnimation()
			f34_arg0.Darken:setAlpha(0.8)
			f34_arg0.clipFinished(f34_arg0.Darken)
			f34_arg0.FocusBorder:completeAnimation()
			f34_arg0.FocusBorder:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.FocusBorder)
			f34_arg0.CompleteBanner:completeAnimation()
			f34_arg0.CompleteBanner:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.CompleteBanner)
		end,
		GainFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(8)
			local f35_local0 = function(f36_arg0)
				f35_arg0.FocusGlow:beginAnimation(200)
				f35_arg0.FocusGlow:setAlpha(1)
				f35_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FocusGlow:completeAnimation()
			f35_arg0.FocusGlow:setAlpha(0)
			f35_local0(f35_arg0.FocusGlow)
			f35_arg0.gradient:completeAnimation()
			f35_arg0.gradient:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.gradient)
			f35_arg0.Timer:completeAnimation()
			f35_arg0.Timer:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.Timer)
			f35_arg0.ActiveBanner:completeAnimation()
			f35_arg0.ActiveBanner:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ActiveBanner)
			f35_arg0.ProgressBar:completeAnimation()
			f35_arg0.ProgressBar:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ProgressBar)
			f35_arg0.Darken:completeAnimation()
			f35_arg0.Darken:setAlpha(0.8)
			f35_arg0.clipFinished(f35_arg0.Darken)
			local f35_local1 = function(f37_arg0)
				f35_arg0.FocusBorder:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f35_arg0.FocusBorder:setAlpha(1)
				f35_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FocusBorder:completeAnimation()
			f35_arg0.FocusBorder:setAlpha(0)
			f35_local1(f35_arg0.FocusBorder)
			f35_arg0.CompleteBanner:completeAnimation()
			f35_arg0.CompleteBanner:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.CompleteBanner)
		end,
		LoseFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(8)
			local f38_local0 = function(f39_arg0)
				f38_arg0.FocusGlow:beginAnimation(100)
				f38_arg0.FocusGlow:setAlpha(0)
				f38_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.FocusGlow:completeAnimation()
			f38_arg0.FocusGlow:setAlpha(1)
			f38_local0(f38_arg0.FocusGlow)
			f38_arg0.gradient:completeAnimation()
			f38_arg0.gradient:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.gradient)
			f38_arg0.Timer:completeAnimation()
			f38_arg0.Timer:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Timer)
			f38_arg0.ActiveBanner:completeAnimation()
			f38_arg0.ActiveBanner:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ActiveBanner)
			f38_arg0.ProgressBar:completeAnimation()
			f38_arg0.ProgressBar:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ProgressBar)
			f38_arg0.Darken:completeAnimation()
			f38_arg0.Darken:setAlpha(0.8)
			f38_arg0.clipFinished(f38_arg0.Darken)
			local f38_local1 = function(f40_arg0)
				f38_arg0.FocusBorder:beginAnimation(100)
				f38_arg0.FocusBorder:setAlpha(0)
				f38_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.FocusBorder:completeAnimation()
			f38_arg0.FocusBorder:setAlpha(1)
			f38_local1(f38_arg0.FocusBorder)
			f38_arg0.CompleteBanner:completeAnimation()
			f38_arg0.CompleteBanner:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.CompleteBanner)
		end,
	},
}
CoD.ReservesSpecialContractInternal.__onClose = function(f41_arg0)
	f41_arg0.PreviewScene:close()
	f41_arg0.Title:close()
	f41_arg0.Description:close()
	f41_arg0.RewardName:close()
	f41_arg0.Timer:close()
	f41_arg0.ActiveBanner:close()
	f41_arg0.ProgressBar:close()
	f41_arg0.CompleteBanner:close()
	f41_arg0.ItemHintText:close()
end
