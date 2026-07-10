require("x64:996da65dbb00ef8")
CoD.SpecialDeal = InheritFrom(LUI.UIElement)
CoD.SpecialDeal.__defaultWidth = 716
CoD.SpecialDeal.__defaultHeight = 128
CoD.SpecialDeal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("AutoEvents.loot_special_deal_timer")
	self:setClass(CoD.SpecialDeal)
	self.id = "SpecialDeal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 0, 58, 716, 0, 0, 1, 129)
	Backing:setImage(RegisterImage(@"hash_3EB0F197ED85C0AE"))
	self:addElement(Backing)
	self.Backing = Backing
	local Backing2 = LUI.UIImage.new(0, 0, 58, 716, 0, 0, 1, 129)
	Backing2:setAlpha(0.55)
	Backing2:setImage(RegisterImage(@"hash_695E240D18D8D396"))
	Backing2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint_reveal"))
	Backing2:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Backing2)
	self.Backing2 = Backing2
	local PromoImage = LUI.UIImage.new(0, 0, 0, 150, 0, 0, -11, 139)
	PromoImage:setImage(RegisterImage(CoD.BlackMarketUtility.SpecialDealImage(@"ui_icon_blackmarket_tier_medium")))
	self:addElement(PromoImage)
	self.PromoImage = PromoImage
	local DescBacking = LUI.UIImage.new(0, 0, 145, 695, 0, 0, 20.5, 110.5)
	DescBacking:setImage(RegisterImage(@"hash_1B1A530A66113"))
	DescBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	DescBacking:setShaderVector(0, 0, 0, 0, 0)
	DescBacking:setupNineSliceShader(20, 20)
	self:addElement(DescBacking)
	self.DescBacking = DescBacking
	local DescText = LUI.UIText.new(0, 0, 155, 689, 0, 0, 70.5, 89.5)
	DescText:setText(CoD.BlackMarketUtility.SpecialDealDesc(f1_arg1, @"hash_12F600A0107F78D8"))
	DescText:setTTF("dinnext_regular")
	DescText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DescText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(DescText)
	self.DescText = DescText
	local TitleText = LUI.UIText.new(0, 0, 155, 689, 0, 0, 31.5, 60.5)
	TitleText:setRGB(0.89, 0.79, 0.26)
	TitleText:setText(LocalizeToUpperString(CoD.BlackMarketUtility.SpecialDealTitle(f1_arg1, @"hash_42C2A081852E8870")))
	TitleText:setTTF("ttmussels_demibold")
	TitleText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	TitleText:setShaderVector(0, 1, 0, 0, 0)
	TitleText:setShaderVector(1, 0, 0, 0, 0)
	TitleText:setShaderVector(2, 1, 0.21, 0, 0.35)
	TitleText:setLetterSpacing(1)
	TitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(TitleText)
	self.TitleText = TitleText
	local FocusBorder = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -4, 4)
	FocusBorder:setRGB(0.96, 0.94, 0.78)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local TimerText = LUI.UIText.new(0, 0, 316, 704, 0, 0, 12.5, 35.5)
	TimerText:setRGB(0.09, 0.09, 0.09)
	TimerText:setAlpha(0)
	TimerText:setText(LocalizeToUpperString(CoD.BlackMarketUtility.SpecialDealTitle(f1_arg1, @"hash_42C2A081852E8870")))
	TimerText:setTTF("ttmussels_demibold")
	TimerText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	TimerText:setShaderVector(0, 0, 0, 0, 0)
	TimerText:setShaderVector(1, 0, 0, 0, 0)
	TimerText:setShaderVector(2, 0, 0, 0, 0)
	TimerText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	TimerText:setBackingType(3)
	TimerText:setBackingXPadding(6)
	TimerText:setBackingYPadding(8)
	TimerText:setBackingImage(RegisterImage(@"hash_1714F15AF25A104F"))
	TimerText:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	TimerText:setBackingShaderVector(0, 0, 0, 0, 0)
	TimerText:setupBackingNineSliceShader(200, 20)
	self:addElement(TimerText)
	self.TimerText = TimerText
	local SpecialDealTimer = CoD.SpecialDealTimer.new(f1_arg0, f1_arg1, 0, 0, 316, 704, 0, 0, 12.5, 35.5)
	self:addElement(SpecialDealTimer)
	self.SpecialDealTimer = SpecialDealTimer
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsBooleanDvarSet("ui_specialDealActive")
			end,
		},
		{
			stateName = "HasAction",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("ui_SpecialDealAction")
			end,
		},
	})
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsSelfInState(self, "HasAction") then
			CoD.BlackMarketUtility.SpecialDealAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfInState(self, "HasAction") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "AutoEvents.cycled", function(model)
		local f6_local0 = self
		UpdateSelfState(self, f1_arg1)
		UpdateSelfElementState(f1_arg0, self.SpecialDealTimer, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialDeal.__resetProperties = function(f7_arg0)
	f7_arg0.PromoImage:completeAnimation()
	f7_arg0.TitleText:completeAnimation()
	f7_arg0.DescText:completeAnimation()
	f7_arg0.FocusBorder:completeAnimation()
	f7_arg0.Backing2:completeAnimation()
	f7_arg0.Backing:completeAnimation()
	f7_arg0.DescBacking:completeAnimation()
	f7_arg0.TimerText:completeAnimation()
	f7_arg0.SpecialDealTimer:completeAnimation()
	f7_arg0.PromoImage:setAlpha(1)
	f7_arg0.TitleText:setAlpha(1)
	f7_arg0.DescText:setAlpha(1)
	f7_arg0.FocusBorder:setAlpha(0)
	f7_arg0.Backing2:setAlpha(0.55)
	f7_arg0.Backing2:setShaderVector(0, 0, 0, 0, 0)
	f7_arg0.Backing:setAlpha(1)
	f7_arg0.DescBacking:setAlpha(1)
	f7_arg0.TimerText:setAlpha(0)
	f7_arg0.SpecialDealTimer:setAlpha(1)
end
CoD.SpecialDeal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(6529)
					f10_arg0:setShaderVector(0, 1, 0, 0, 0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.Backing2:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
				f8_arg0.Backing2:setShaderVector(0, 2, 0, 0, 0)
				f8_arg0.Backing2:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Backing2:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.Backing2:completeAnimation()
			f8_arg0.Backing2:setShaderVector(0, 0, 0, 0, 0)
			f8_local0(f8_arg0.Backing2)
			f8_arg0.PromoImage:completeAnimation()
			f8_arg0.PromoImage:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.PromoImage)
			f8_arg0.DescText:completeAnimation()
			f8_arg0.DescText:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.DescText)
			f8_arg0.TitleText:completeAnimation()
			f8_arg0.TitleText:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.TitleText)
			f8_arg0.FocusBorder:completeAnimation()
			f8_arg0.FocusBorder:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.FocusBorder)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(9)
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Backing)
			f11_arg0.Backing2:completeAnimation()
			f11_arg0.Backing2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Backing2)
			f11_arg0.PromoImage:completeAnimation()
			f11_arg0.PromoImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PromoImage)
			f11_arg0.DescBacking:completeAnimation()
			f11_arg0.DescBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DescBacking)
			f11_arg0.DescText:completeAnimation()
			f11_arg0.DescText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DescText)
			f11_arg0.TitleText:completeAnimation()
			f11_arg0.TitleText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TitleText)
			f11_arg0.FocusBorder:completeAnimation()
			f11_arg0.FocusBorder:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.FocusBorder)
			f11_arg0.TimerText:completeAnimation()
			f11_arg0.TimerText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TimerText)
			f11_arg0.SpecialDealTimer:completeAnimation()
			f11_arg0.SpecialDealTimer:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.SpecialDealTimer)
		end,
	},
	HasAction = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(6510)
					f14_arg0:setShaderVector(0, 1, 0, 0, 0)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.Backing2:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
				f12_arg0.Backing2:setShaderVector(0, 2, 0, 0, 0)
				f12_arg0.Backing2:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Backing2:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.Backing2:completeAnimation()
			f12_arg0.Backing2:setShaderVector(0, 0, 0, 0, 0)
			f12_local0(f12_arg0.Backing2)
			f12_arg0.PromoImage:completeAnimation()
			f12_arg0.PromoImage:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.PromoImage)
			f12_arg0.DescText:completeAnimation()
			f12_arg0.DescText:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.DescText)
			f12_arg0.TitleText:completeAnimation()
			f12_arg0.TitleText:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.TitleText)
			f12_arg0.FocusBorder:completeAnimation()
			f12_arg0.FocusBorder:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.FocusBorder)
			f12_arg0.nextClip = "DefaultClip"
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.PromoImage:completeAnimation()
			f15_arg0.PromoImage:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.PromoImage)
			f15_arg0.DescText:completeAnimation()
			f15_arg0.DescText:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.DescText)
			f15_arg0.TitleText:completeAnimation()
			f15_arg0.TitleText:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.TitleText)
			f15_arg0.FocusBorder:completeAnimation()
			f15_arg0.FocusBorder:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusBorder)
		end,
	},
}
CoD.SpecialDeal.__onClose = function(f16_arg0)
	f16_arg0.SpecialDealTimer:close()
end
