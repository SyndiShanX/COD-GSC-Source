require("x64:c96de52191fe142")
require("x64:5f8cf56752aa71b")
require("x64:5f6bd8a847938ba")
require("x64:19c1945d2e472b0")
CoD.DirectorBlackMarketButtonInternal = InheritFrom(LUI.UIElement)
CoD.DirectorBlackMarketButtonInternal.__defaultWidth = 354
CoD.DirectorBlackMarketButtonInternal.__defaultHeight = 110
CoD.DirectorBlackMarketButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreatePersistentControllerModel(f1_arg1, "LootStreamProgress.personalTierBoost")
	self:setClass(CoD.DirectorBlackMarketButtonInternal)
	self.id = "DirectorBlackMarketButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local BgTint = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	BgTint:setRGB(0, 0, 0)
	BgTint:setAlpha(0.5)
	self:addElement(BgTint)
	self.BgTint = BgTint
	local BgTintAll = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgTintAll:setRGB(0, 0, 0)
	BgTintAll:setAlpha(0.2)
	self:addElement(BgTintAll)
	self.BgTintAll = BgTintAll
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	DotTiledBacking.NoiseBacking:setAlpha(0.9)
	DotTiledBacking.TiledShaderImage:setAlpha(0.3)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local DotTiledBackingTop = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0.5, 1.5, -221, -229, 0, 0, 4, 30)
	DotTiledBackingTop:setAlpha(0)
	DotTiledBackingTop.NoiseBacking:setAlpha(0)
	DotTiledBackingTop.TiledShaderImage:setAlpha(0.2)
	DotTiledBackingTop.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBackingTop)
	self.DotTiledBackingTop = DotTiledBackingTop
	local SpecialEventBanner = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	SpecialEventBanner.__Image = function()
		SpecialEventBanner:setImage(RegisterImage(CoD.BlackMarketUtility.GetCurrentBlackMarketBannerImage(@"blacktransparent")))
	end
	SpecialEventBanner.__Image()
	SpecialEventBanner:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	SpecialEventBanner:setShaderVector(0, 0.5, 0.5, 0, 0)
	SpecialEventBanner:setShaderVector(1, 1, 1, 0, 0)
	SpecialEventBanner:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(SpecialEventBanner)
	self.SpecialEventBanner = SpecialEventBanner
	local FrontendFrame02 = LUI.UIImage.new(0.4, 0.4, -125.5, 125.5, 0, 0, 89, 101)
	FrontendFrame02:setRGB(0, 0.66, 1)
	FrontendFrame02:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(6, 6)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	local tierProgressBackground = LUI.UIImage.new(0.4, 0.4, -125, 125, 1, 1, -21, -9)
	tierProgressBackground:setRGB(0.09, 0.09, 0.09)
	tierProgressBackground:setImage(RegisterImage(@"hash_32F80AF66C054F97"))
	self:addElement(tierProgressBackground)
	self.tierProgressBackground = tierProgressBackground
	local Border = LUI.UIImage.new(0.4, 0.4, -125, 125, 1, 1, -21, -9)
	Border:setRGB(0.08, 0.14, 0.18)
	Border:setAlpha(0.8)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	Border:setShaderVector(0, 0, 0.1, 0, 0.1)
	self:addElement(Border)
	self.Border = Border
	local tierProgress = LUI.UIImage.new(0.4, 0.4, -125, 125, 1, 1, -21, -9)
	tierProgress:setRGB(0.5, 0.85, 1)
	tierProgress:setImage(RegisterImage(@"hash_3E51FDFB95E8F82B"))
	tierProgress:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	tierProgress:setShaderVector(1, 0, 0, 0, 0)
	tierProgress:setShaderVector(2, 1, 0, 0, 0)
	tierProgress:setShaderVector(3, 0, 0, 0, 0)
	tierProgress:setShaderVector(4, 0, 0, 0, 0)
	tierProgress:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "tierProgress", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			tierProgress:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(tierProgress)
	self.tierProgress = tierProgress
	local tierProgressAdd = LUI.UIImage.new(0.4, 0.4, -125, 125, 1, 1, -21, -9)
	tierProgressAdd:setRGB(0.5, 0.85, 1)
	tierProgressAdd:setImage(RegisterImage(@"hash_3E51FDFB95E8F82B"))
	tierProgressAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	tierProgressAdd:setShaderVector(1, 0, 0, 0, 0)
	tierProgressAdd:setShaderVector(2, 0, 1, 0, 0)
	tierProgressAdd:setShaderVector(3, 0, 0, 0, 0)
	tierProgressAdd:setShaderVector(4, 0, 0, 0, 0)
	tierProgressAdd:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "tierProgress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			tierProgressAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(tierProgressAdd)
	self.tierProgressAdd = tierProgressAdd
	local TierText = LUI.UIText.new(0.4, 0.4, -137.5, 137.5, 1, 1, -42, -25)
	TierText:setRGB(0.92, 0.92, 0.92)
	TierText:setTTF("ttmussels_demibold")
	TierText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	TierText:setLetterSpacing(4)
	TierText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TierText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	TierText:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "currentTier", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TierText:setText(CoD.BlackMarketUtility.AppendCurrentSeasonTier(f5_local0))
		end
	end)
	self:addElement(TierText)
	self.TierText = TierText
	local StreamName = LUI.UIText.new(0.5, 0.5, -219.5, 219.5, 0, 0, 9, 27)
	StreamName:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	StreamName:setAlpha(0)
	StreamName.__String_Reference = function()
		StreamName:setText(LocalizeToUpperString(CoD.BlackMarketUtility.GetCurrentBlackMarketSeasonName(@"hash_7ED95336C9E8FA66")))
	end
	StreamName.__String_Reference()
	StreamName:setTTF("ttmussels_regular")
	StreamName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	StreamName:setLetterSpacing(6)
	StreamName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(StreamName)
	self.StreamName = StreamName
	local BlackMarketNameGlow = LUI.UIText.new(0.4, 0.4, -135.5, 135.5, 0, 0, 40.5, 64.5)
	BlackMarketNameGlow:setRGB(0, 0, 0)
	BlackMarketNameGlow:setText(LocalizeToUpperString(@"menu/black_market"))
	BlackMarketNameGlow:setTTF("ttmussels_demibold")
	BlackMarketNameGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	BlackMarketNameGlow:setShaderVector(0, 0.81, 0, 0, 0)
	BlackMarketNameGlow:setShaderVector(1, 0, 0, 0, 0)
	BlackMarketNameGlow:setShaderVector(2, 0, 0, 0, 0)
	BlackMarketNameGlow:setLetterSpacing(3)
	BlackMarketNameGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	BlackMarketNameGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(BlackMarketNameGlow)
	self.BlackMarketNameGlow = BlackMarketNameGlow
	local BlackMarketName = LUI.UIText.new(0.4, 0.4, -135.5, 135.5, 0, 0, 40.5, 64.5)
	BlackMarketName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	BlackMarketName:setText(LocalizeToUpperString(@"menu/black_market"))
	BlackMarketName:setTTF("ttmussels_demibold")
	BlackMarketName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	BlackMarketName:setLetterSpacing(3)
	BlackMarketName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	BlackMarketName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(BlackMarketName)
	self.BlackMarketName = BlackMarketName
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local LootCaseMeter = CoD.AARTierRewardLootCaseMeter.new(f1_arg0, f1_arg1, 1, 1, -122, 28, 0, 0, -20, 130)
	LootCaseMeter:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LootCaseMeter:setScale(0.5, 0.5)
	LootCaseMeter.PreviousProgressRing:setShaderVector(0, 0, 0, 0, 0)
	LootCaseMeter:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "caseProgress", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			LootCaseMeter.CurrentProgressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	LootCaseMeter:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootCaseCount", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			LootCaseMeter.CaseCount:setText(SetValueIfNumberEqualTo(-1, "-", f9_local0))
		end
	end)
	self:addElement(LootCaseMeter)
	self.LootCaseMeter = LootCaseMeter
	local LootTierBoostPercentContraband = CoD.LootTierBoostPercentContraband.new(f1_arg0, f1_arg1, 0.4, 0.4, -67.5, 67.5, 0, 0, 68, 84)
	LootTierBoostPercentContraband:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.ShowTierBoostPercent(f1_arg1, menu)
			end,
		},
	})
	local f1_local19 = LootTierBoostPercentContraband
	local f1_local20 = LootTierBoostPercentContraband.subscribeToModel
	local f1_local21 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local20(f1_local19, f1_local21["LootStreamProgress.personalTierBoost"], function(f11_arg0)
		f1_arg0:updateElementState(LootTierBoostPercentContraband, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LootStreamProgress.personalTierBoost",
		})
	end, false)
	LootTierBoostPercentContraband.TierBoost:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(LootTierBoostPercentContraband)
	self.LootTierBoostPercentContraband = LootTierBoostPercentContraband
	f1_local19 = SpecialEventBanner
	f1_local20 = SpecialEventBanner.subscribeToModel
	f1_local21 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21.cycled, SpecialEventBanner.__Image)
	f1_local19 = StreamName
	f1_local20 = StreamName.subscribeToModel
	f1_local21 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21.cycled, StreamName.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "DefaultStateAsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorBlackMarketButtonInternal.__resetProperties = function(f13_arg0)
	f13_arg0.tierProgressAdd:completeAnimation()
	f13_arg0.CommonButtonOutline:completeAnimation()
	f13_arg0.TierText:completeAnimation()
	f13_arg0.tierProgressAdd:setAlpha(1)
	f13_arg0.CommonButtonOutline:setAlpha(1)
	f13_arg0.TierText:setTopBottom(1, 1, -42, -25)
end
CoD.DirectorBlackMarketButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(500)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f14_arg0.tierProgressAdd:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f14_arg0.tierProgressAdd:setAlpha(0.5)
				f14_arg0.tierProgressAdd:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.tierProgressAdd:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.tierProgressAdd:completeAnimation()
			f14_arg0.tierProgressAdd:setAlpha(1)
			f14_local0(f14_arg0.tierProgressAdd)
			f14_arg0.nextClip = "DefaultClip"
		end,
		ChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.CommonButtonOutline:completeAnimation()
			f18_arg0.CommonButtonOutline:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.CommonButtonOutline)
		end,
	},
	DefaultStateAsianLanguage = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						f22_arg0:beginAnimation(500)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f21_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f19_arg0.tierProgressAdd:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f19_arg0.tierProgressAdd:setAlpha(0.5)
				f19_arg0.tierProgressAdd:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.tierProgressAdd:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.tierProgressAdd:completeAnimation()
			f19_arg0.tierProgressAdd:setAlpha(1)
			f19_local0(f19_arg0.tierProgressAdd)
			f19_arg0.TierText:completeAnimation()
			f19_arg0.TierText:setTopBottom(1, 1, -39, -28)
			f19_arg0.clipFinished(f19_arg0.TierText)
			f19_arg0.nextClip = "DefaultClip"
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.TierText:completeAnimation()
			f23_arg0.TierText:setTopBottom(1, 1, -39, -28)
			f23_arg0.clipFinished(f23_arg0.TierText)
			f23_arg0.CommonButtonOutline:completeAnimation()
			f23_arg0.CommonButtonOutline:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.CommonButtonOutline)
		end,
	},
}
CoD.DirectorBlackMarketButtonInternal.__onClose = function(f24_arg0)
	f24_arg0.DotTiledBacking:close()
	f24_arg0.DotTiledBackingTop:close()
	f24_arg0.SpecialEventBanner:close()
	f24_arg0.tierProgress:close()
	f24_arg0.tierProgressAdd:close()
	f24_arg0.TierText:close()
	f24_arg0.StreamName:close()
	f24_arg0.CommonButtonOutline:close()
	f24_arg0.LootCaseMeter:close()
	f24_arg0.LootTierBoostPercentContraband:close()
end
