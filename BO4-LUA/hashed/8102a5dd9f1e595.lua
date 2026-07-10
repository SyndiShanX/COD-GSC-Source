require("x64:5be072bd539a5e")
require("x64:99810be36658368")
CoD.AARTierBar = InheritFrom(LUI.UIElement)
CoD.AARTierBar.__defaultWidth = 1350
CoD.AARTierBar.__defaultHeight = 20
CoD.AARTierBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierBar)
	self.id = "AARTierBar"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBarBG9Slice = LUI.UIImage.new(0, 1, -1, 1, 0.5, 0.5, -4, 4)
	ProgressBarBG9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_attachment_meter_backing_01"))
	ProgressBarBG9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	ProgressBarBG9Slice:setShaderVector(0, 0, 0, 0, 0)
	ProgressBarBG9Slice:setupNineSliceShader(675, 4)
	self:addElement(ProgressBarBG9Slice)
	self.ProgressBarBG9Slice = ProgressBarBG9Slice
	local EarnedXP = CoD.CommonWipeMeterWithGlow.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -6, 6)
	EarnedXP.Meter:setRGB(CoD.BlackMarketUtility.AdjustColorIfTierBoost(f1_arg1, 0.36, 0.63, 0.74))
	EarnedXP.Meter:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar"))
	EarnedXP.Meter:setShaderVector(0, 0.75, 0, 0, 0)
	EarnedXP.MeterAdd:setRGB(CoD.BlackMarketUtility.AdjustColorIfTierBoost(f1_arg1, 0.36, 0.61, 0.72))
	EarnedXP.MeterAdd:setAlpha(0.3)
	EarnedXP.MeterAdd:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar"))
	EarnedXP.MeterAdd:setShaderVector(0, 0.75, 0, 0, 0)
	EarnedXP.MeterGlow:setRGB(0.39, 0.18, 0)
	EarnedXP.MeterGlow:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar_glow"))
	EarnedXP.MeterGlow:setShaderVector(0, 0.75, 0, 0, 0)
	self:addElement(EarnedXP)
	self.EarnedXP = EarnedXP
	local PreviousXP = CoD.CommonWipeMeterWithGlow.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -6, 6)
	PreviousXP.Meter:setRGB(0.14, 0.27, 0.33)
	PreviousXP.Meter:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar"))
	PreviousXP.Meter:setShaderVector(0, 0.25, 0, 0, 0)
	PreviousXP.MeterAdd:setAlpha(0)
	PreviousXP.MeterAdd:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar"))
	PreviousXP.MeterAdd:setShaderVector(0, 0.25, 0, 0, 0)
	PreviousXP.MeterGlow:setRGB(0.5, 0.85, 1)
	PreviousXP.MeterGlow:setAlpha(0.5)
	PreviousXP.MeterGlow:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar_glow"))
	PreviousXP.MeterGlow:setShaderVector(0, 0.25, 0, 0, 0)
	self:addElement(PreviousXP)
	self.PreviousXP = PreviousXP
	local CurrentTier = LUI.UIText.new(0, 0, -127, -21, 0.5, 0.5, -11, 11)
	CurrentTier:setRGB(0.88, 0.96, 1)
	CurrentTier:setTTF("ttmussels_demibold")
	CurrentTier:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	CurrentTier:setLetterSpacing(2)
	CurrentTier:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	CurrentTier:linkToElementModel(self, "barCurrentTier", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CurrentTier:setText(LocalizeStringWithParameter(@"hash_1E743A7E5D0C37CD", f2_local0))
		end
	end)
	self:addElement(CurrentTier)
	self.CurrentTier = CurrentTier
	local NextTier = LUI.UIText.new(1, 1, 19, 125, 0.5, 0.5, -11, 11)
	NextTier:setRGB(0.88, 0.96, 1)
	NextTier:setTTF("ttmussels_demibold")
	NextTier:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	NextTier:setLetterSpacing(2)
	NextTier:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NextTier:linkToElementModel(self, "barNextTier", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			NextTier:setText(LocalizeStringWithParameter(@"hash_1E743A7E5D0C37CD", f3_local0))
		end
	end)
	self:addElement(NextTier)
	self.NextTier = NextTier
	local TierBoostNotification = CoD.TierBoostNotification.new(f1_arg0, f1_arg1, 1, 1, 133, 205, 0.5, 0.5, -36, 36)
	TierBoostNotification:mergeStateConditions({
		{
			stateName = "TierBoost",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "TierBoostAAR",
			condition = function(menu, element, event)
				return IsTierBoostActive(f1_arg1)
			end,
		},
	})
	self:addElement(TierBoostNotification)
	self.TierBoostNotification = TierBoostNotification
	local Glow = LUI.UIImage.new(0, 0, -140, 60, 0.5, 0.5, -37.5, 37.5)
	Glow:setRGB(0.8, 0.58, 0.12)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_ui_hud_notifications_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Glow:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Glow)
	self.Glow = Glow
	self:linkToElementModel(self, "tierSkipEarned", true, function(model)
		if CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "tierSkipEarned") then
			PlayClip(self, "TierSkip", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierBar.__resetProperties = function(f7_arg0)
	f7_arg0.NextTier:completeAnimation()
	f7_arg0.CurrentTier:completeAnimation()
	f7_arg0.Glow:completeAnimation()
	f7_arg0.ProgressBarBG9Slice:completeAnimation()
	f7_arg0.EarnedXP:completeAnimation()
	f7_arg0.PreviousXP:completeAnimation()
	f7_arg0.NextTier:setTopBottom(0.5, 0.5, -11, 11)
	f7_arg0.NextTier:setAlpha(1)
	f7_arg0.NextTier:setScale(1, 1)
	f7_arg0.CurrentTier:setTopBottom(0.5, 0.5, -11, 11)
	f7_arg0.CurrentTier:setAlpha(1)
	f7_arg0.CurrentTier:setScale(1, 1)
	f7_arg0.Glow:setAlpha(0)
	f7_arg0.Glow:setScale(1, 1)
	f7_arg0.ProgressBarBG9Slice:setAlpha(1)
	f7_arg0.EarnedXP:setAlpha(1)
	f7_arg0.PreviousXP:setAlpha(1)
end
CoD.AARTierBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.CurrentTier:completeAnimation()
			f8_arg0.CurrentTier:setTopBottom(0.5, 0.5, -11, 11)
			f8_arg0.clipFinished(f8_arg0.CurrentTier)
			f8_arg0.NextTier:completeAnimation()
			f8_arg0.NextTier:setTopBottom(0.5, 0.5, -11, 11)
			f8_arg0.clipFinished(f8_arg0.NextTier)
		end,
		TierSkip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(110, Enum[@"luitween"][@"luitween_ease_out"])
					f11_arg0:setScale(1, 1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.CurrentTier:beginAnimation(220, Enum[@"luitween"][@"luitween_ease_out"])
				f9_arg0.CurrentTier:setAlpha(1)
				f9_arg0.CurrentTier:setScale(0.2, 0.2)
				f9_arg0.CurrentTier:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.CurrentTier:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.CurrentTier:completeAnimation()
			f9_arg0.CurrentTier:setAlpha(0)
			f9_arg0.CurrentTier:setScale(7, 7)
			f9_local0(f9_arg0.CurrentTier)
			local f9_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(49)
					f13_arg0:setAlpha(1)
					f13_arg0:setScale(1, 1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.NextTier:beginAnimation(200)
				f9_arg0.NextTier:setAlpha(0)
				f9_arg0.NextTier:setScale(8, 8)
				f9_arg0.NextTier:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.NextTier:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f9_arg0.NextTier:completeAnimation()
			f9_arg0.NextTier:setAlpha(1)
			f9_arg0.NextTier:setScale(1, 1)
			f9_local1(f9_arg0.NextTier)
			local f9_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(299)
						f16_arg0:setAlpha(0)
						f16_arg0:setScale(5, 2)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(120)
					f15_arg0:setAlpha(1)
					f15_arg0:setScale(2.14, 2)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f9_arg0.Glow:beginAnimation(280)
				f9_arg0.Glow:setScale(1, 1.5)
				f9_arg0.Glow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Glow:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f9_arg0.Glow:completeAnimation()
			f9_arg0.Glow:setAlpha(0)
			f9_arg0.Glow:setScale(1, 1)
			f9_local2(f9_arg0.Glow)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			f17_arg0.ProgressBarBG9Slice:completeAnimation()
			f17_arg0.ProgressBarBG9Slice:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ProgressBarBG9Slice)
			f17_arg0.EarnedXP:completeAnimation()
			f17_arg0.EarnedXP:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.EarnedXP)
			f17_arg0.PreviousXP:completeAnimation()
			f17_arg0.PreviousXP:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PreviousXP)
			f17_arg0.CurrentTier:completeAnimation()
			f17_arg0.CurrentTier:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.CurrentTier)
			f17_arg0.NextTier:completeAnimation()
			f17_arg0.NextTier:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.NextTier)
		end,
	},
}
CoD.AARTierBar.__onClose = function(f18_arg0)
	f18_arg0.EarnedXP:close()
	f18_arg0.PreviousXP:close()
	f18_arg0.CurrentTier:close()
	f18_arg0.NextTier:close()
	f18_arg0.TierBoostNotification:close()
end
