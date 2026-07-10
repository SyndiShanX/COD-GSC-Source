require("x64:f00a10fc8301da2")
require("x64:88b4d51833c79f5")
require("x64:a5b6deff4bc3cab")
require("x64:7813f9cbf9b0834")
require("x64:dd310064e88e674")
require("x64:ca5faac82324b65")
require("x64:c96de52191fe142")
require("x64:c7e896ee4bc3f8")
require("x64:6ee653ade3452f5")
CoD.AARSummaryTab_WZ = InheritFrom(LUI.UIElement)
CoD.AARSummaryTab_WZ.__defaultWidth = 1920
CoD.AARSummaryTab_WZ.__defaultHeight = 900
CoD.AARSummaryTab_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSummaryTab_WZ)
	self.id = "AARSummaryTab_WZ"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.1, 1.1, 0, 0)
	ScorestreakAspectRatioFix:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -358, 998, 0.5, 0.5, -409, 427)
	AarMpBacking.Backer:setRGB(0, 0, 0)
	AarMpBacking.Backer:setAlpha(0.5)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local XPMeter = CoD.AARXpMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -620, 680, 0.5, 0.5, 335, 354)
	XPMeter:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsPublicOnlineGame()
			end,
		},
		{
			stateName = "MaxRank",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rank", CoD.RankUtility.GetRankCap() + 1) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "xpNeededToLevelUp", 0)
			end,
		},
	})
	XPMeter:linkToElementModel(XPMeter, "rank", true, function(model)
		f1_arg0:updateElementState(XPMeter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rank",
		})
	end)
	XPMeter:linkToElementModel(XPMeter, "xpNeededToLevelUp", true, function(model)
		f1_arg0:updateElementState(XPMeter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xpNeededToLevelUp",
		})
	end)
	XPMeter.maxRankText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4F80010008304EC0"))
	XPMeter:linkToElementModel(self, nil, false, function(model)
		XPMeter:setModel(model, f1_arg1)
	end)
	XPMeter:linkToElementModel(self, "levelProgress", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			XPMeter.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "levelProgress", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			XPMeter.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "levelProgress", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			XPMeter.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "previousProgressThisLevel", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			XPMeter.PreviousXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "previousProgressThisLevel", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			XPMeter.PreviousXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f12_local0, 1), CoD.GetVectorComponentFromString(f12_local0, 2), CoD.GetVectorComponentFromString(f12_local0, 3), CoD.GetVectorComponentFromString(f12_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "previousProgressThisLevel", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			XPMeter.PreviousXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f13_local0, 1), CoD.GetVectorComponentFromString(f13_local0, 2), CoD.GetVectorComponentFromString(f13_local0, 3), CoD.GetVectorComponentFromString(f13_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "xpEarnedDuringMatch", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			XPMeter.xpEarnedText:setText(LocalizeIntoString(@"hash_29EDF95589F9CAF1", f14_local0))
		end
	end)
	XPMeter:linkToElementModel(self, "xpNeededToLevelUp", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			XPMeter.xpNeededText:setText(LocalizeIntoString(@"hash_2C1881B67805BFCA", f15_local0))
		end
	end)
	self:addElement(XPMeter)
	self.XPMeter = XPMeter
	local AARGameHistory = CoD.AARGameHistory.new(f1_arg0, f1_arg1, 0.5, 0.5, -323.5, 836.5, 0.5, 0.5, 15, 315)
	AARGameHistory:linkToElementModel(self, nil, false, function(model)
		AARGameHistory:setModel(model, f1_arg1)
	end)
	self:addElement(AARGameHistory)
	self.AARGameHistory = AARGameHistory
	local PerformanceLabel = LUI.UIText.new(0.5, 0.5, -321.5, 533.5, 0.5, 0.5, -255, -217)
	PerformanceLabel:setRGB(0.9, 0.89, 0.78)
	PerformanceLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](0x4B072C59118316))
	PerformanceLabel:setTTF("dinnext_regular")
	PerformanceLabel:setLetterSpacing(10)
	PerformanceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PerformanceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PerformanceLabel)
	self.PerformanceLabel = PerformanceLabel
	local AARGametypeHeader = CoD.AARGametypeHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -351.5, 648.5, 0.5, 0.5, -400, -250)
	AARGametypeHeader:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "gametypeIcon", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			AARGametypeHeader.GametypeImage:setImage(RegisterImage(f17_local0))
		end
	end)
	AARGametypeHeader:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "gametypeDisplay", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			AARGametypeHeader.GametypeGlow:setText(f18_local0)
		end
	end)
	AARGametypeHeader:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "gametypeDisplay", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			AARGametypeHeader.Gametype:setText(f19_local0)
		end
	end)
	self:addElement(AARGametypeHeader)
	self.AARGametypeHeader = AARGametypeHeader
	local AARTierBar = CoD.AARTierBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -164.5, 677.5, 0.5, 0.5, 385, 405)
	AARTierBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.AARUtility.ShouldHideTierRewardMiniStatus(self, f1_arg1)
			end,
		},
	})
	AARTierBar:linkToElementModel(self, "tierProgress", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			AARTierBar.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "tierProgress", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			AARTierBar.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f22_local0, 1), CoD.GetVectorComponentFromString(f22_local0, 2), CoD.GetVectorComponentFromString(f22_local0, 3), CoD.GetVectorComponentFromString(f22_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "tierProgress", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			AARTierBar.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f23_local0, 1), CoD.GetVectorComponentFromString(f23_local0, 2), CoD.GetVectorComponentFromString(f23_local0, 3), CoD.GetVectorComponentFromString(f23_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "previousTierProgress", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			AARTierBar.PreviousXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f24_local0, 1), CoD.GetVectorComponentFromString(f24_local0, 2), CoD.GetVectorComponentFromString(f24_local0, 3), CoD.GetVectorComponentFromString(f24_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "previousTierProgress", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			AARTierBar.PreviousXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f25_local0, 1), CoD.GetVectorComponentFromString(f25_local0, 2), CoD.GetVectorComponentFromString(f25_local0, 3), CoD.GetVectorComponentFromString(f25_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "previousTierProgress", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			AARTierBar.PreviousXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f26_local0, 1), CoD.GetVectorComponentFromString(f26_local0, 2), CoD.GetVectorComponentFromString(f26_local0, 3), CoD.GetVectorComponentFromString(f26_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "barCurrentTier", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			AARTierBar.CurrentTier:setText(LocalizeStringWithParameter(@"hash_1E743A7E5D0C37CD", f27_local0))
		end
	end)
	AARTierBar:linkToElementModel(self, "barNextTier", true, function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			AARTierBar.NextTier:setText(LocalizeStringWithParameter(@"hash_1E743A7E5D0C37CD", f28_local0))
		end
	end)
	self:addElement(AARTierBar)
	self.AARTierBar = AARTierBar
	local f1_local8 = nil
	self.TrialInfoBannerWidget = LUI.UIElement.createFake()
	local TrialInfoBannerWidgetPC = nil
	TrialInfoBannerWidgetPC = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -948, -443, 0.5, 0.5, 331, 405)
	TrialInfoBannerWidgetPC:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
		{
			stateName = "ShownWrap",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysTrue()
			end,
		},
	})
	TrialInfoBannerWidgetPC.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_138324BF4626CE42"))
	self:addElement(TrialInfoBannerWidgetPC)
	self.TrialInfoBannerWidgetPC = TrialInfoBannerWidgetPC
	local DamageStat = CoD.AARPerformanceWidgets.new(f1_arg0, f1_arg1, 0.5, 0.5, -321.5, 862.5, 0.5, 0.5, -203.5, -71.5)
	DamageStat:linkToElementModel(self, nil, false, function(model)
		DamageStat:setModel(model, f1_arg1)
	end)
	self:addElement(DamageStat)
	self.DamageStat = DamageStat
	local LootCaseMeter = CoD.AARTierRewardLootCaseMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, 712.5, 862.5, 0, 0, 96.5, 246.5)
	LootCaseMeter:linkToElementModel(self, "lootCaseProgress", true, function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			LootCaseMeter.CurrentProgressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f32_local0, 1), CoD.GetVectorComponentFromString(f32_local0, 2), CoD.GetVectorComponentFromString(f32_local0, 3), CoD.GetVectorComponentFromString(f32_local0, 4))
		end
	end)
	LootCaseMeter:linkToElementModel(self, "previousLootCaseProgress", true, function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			LootCaseMeter.PreviousProgressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f33_local0, 1), CoD.GetVectorComponentFromString(f33_local0, 2), CoD.GetVectorComponentFromString(f33_local0, 3), CoD.GetVectorComponentFromString(f33_local0, 4))
		end
	end)
	LootCaseMeter:linkToElementModel(self, "lootCaseCount", true, function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			LootCaseMeter.CaseCount:setText(f34_local0)
		end
	end)
	self:addElement(LootCaseMeter)
	self.LootCaseMeter = LootCaseMeter
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
			end,
		},
	})
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["AAR.activeTab"], function(f36_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	AARGameHistory.id = "AARGameHistory"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSummaryTab_WZ.__resetProperties = function(f37_arg0)
	f37_arg0.AARGameHistory:completeAnimation()
	f37_arg0.XPMeter:completeAnimation()
	f37_arg0.AARGametypeHeader:completeAnimation()
	f37_arg0.PerformanceLabel:completeAnimation()
	f37_arg0.AarMpBacking:completeAnimation()
	f37_arg0.AARTierBar:completeAnimation()
	f37_arg0.TrialInfoBannerWidget:completeAnimation()
	f37_arg0.TrialInfoBannerWidgetPC:completeAnimation()
	f37_arg0.LootCaseMeter:completeAnimation()
	f37_arg0.AARGameHistory:setAlpha(1)
	f37_arg0.XPMeter:setAlpha(1)
	f37_arg0.AARGametypeHeader:setAlpha(1)
	f37_arg0.PerformanceLabel:setAlpha(1)
	f37_arg0.AarMpBacking:setAlpha(1)
	f37_arg0.AARTierBar:setAlpha(1)
	f37_arg0.TrialInfoBannerWidget:setAlpha(1)
	f37_arg0.TrialInfoBannerWidgetPC:setAlpha(1)
	f37_arg0.LootCaseMeter:setAlpha(1)
end
CoD.AARSummaryTab_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(8)
			f38_arg0.AarMpBacking:completeAnimation()
			f38_arg0.AarMpBacking:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.AarMpBacking)
			f38_arg0.XPMeter:completeAnimation()
			f38_arg0.XPMeter:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.XPMeter)
			f38_arg0.AARGameHistory:completeAnimation()
			f38_arg0.AARGameHistory:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.AARGameHistory)
			f38_arg0.PerformanceLabel:completeAnimation()
			f38_arg0.PerformanceLabel:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.PerformanceLabel)
			f38_arg0.AARGametypeHeader:completeAnimation()
			f38_arg0.AARGametypeHeader:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.AARGametypeHeader)
			f38_arg0.AARTierBar:completeAnimation()
			f38_arg0.AARTierBar:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.AARTierBar)
			f38_arg0.TrialInfoBannerWidget:completeAnimation()
			f38_arg0.TrialInfoBannerWidget:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.TrialInfoBannerWidget)
			f38_arg0.TrialInfoBannerWidgetPC:completeAnimation()
			f38_arg0.TrialInfoBannerWidgetPC:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.TrialInfoBannerWidgetPC)
			f38_arg0.LootCaseMeter:completeAnimation()
			f38_arg0.LootCaseMeter:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.LootCaseMeter)
		end,
	},
	Visible = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(8)
			local f39_local0 = function(f40_arg0)
				f39_arg0.AarMpBacking:beginAnimation(150)
				f39_arg0.AarMpBacking:setAlpha(1)
				f39_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.AarMpBacking:completeAnimation()
			f39_arg0.AarMpBacking:setAlpha(0)
			f39_local0(f39_arg0.AarMpBacking)
			local f39_local1 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					local f42_local0 = function(f43_arg0)
						f43_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
						f43_arg0:setAlpha(1)
						f43_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
					end
					f42_arg0:beginAnimation(239)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
				end
				f39_arg0.XPMeter:beginAnimation(150)
				f39_arg0.XPMeter:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.XPMeter:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f39_arg0.XPMeter:completeAnimation()
			f39_arg0.XPMeter:setAlpha(0)
			f39_local1(f39_arg0.XPMeter)
			local f39_local2 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						f46_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
						f46_arg0:setAlpha(1)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
					end
					f45_arg0:beginAnimation(190)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f39_arg0.AARGameHistory:beginAnimation(150)
				f39_arg0.AARGameHistory:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.AARGameHistory:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f39_arg0.AARGameHistory:completeAnimation()
			f39_arg0.AARGameHistory:setAlpha(0)
			f39_local2(f39_arg0.AARGameHistory)
			local f39_local3 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					local f48_local0 = function(f49_arg0)
						f49_arg0:beginAnimation(99)
						f49_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
					end
					f48_arg0:beginAnimation(80)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
				end
				f39_arg0.PerformanceLabel:beginAnimation(100)
				f39_arg0.PerformanceLabel:setAlpha(1)
				f39_arg0.PerformanceLabel:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.PerformanceLabel:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f39_arg0.PerformanceLabel:completeAnimation()
			f39_arg0.PerformanceLabel:setAlpha(0)
			f39_local3(f39_arg0.PerformanceLabel)
			local f39_local4 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					f51_arg0:beginAnimation(100)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.AARGametypeHeader:beginAnimation(50)
				f39_arg0.AARGametypeHeader:setAlpha(1)
				f39_arg0.AARGametypeHeader:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.AARGametypeHeader:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f39_arg0.AARGametypeHeader:completeAnimation()
			f39_arg0.AARGametypeHeader:setAlpha(0)
			f39_local4(f39_arg0.AARGametypeHeader)
			local f39_local5 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					local f53_local0 = function(f54_arg0)
						f54_arg0:beginAnimation(100)
						f54_arg0:setAlpha(1)
						f54_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
					end
					f53_arg0:beginAnimation(239)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
				end
				f39_arg0.AARTierBar:beginAnimation(150)
				f39_arg0.AARTierBar:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.AARTierBar:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f39_arg0.AARTierBar:completeAnimation()
			f39_arg0.AARTierBar:setAlpha(0)
			f39_local5(f39_arg0.AARTierBar)
			local f39_local6 = function(f55_arg0)
				f39_arg0.TrialInfoBannerWidget:beginAnimation(490)
				f39_arg0.TrialInfoBannerWidget:setAlpha(1)
				f39_arg0.TrialInfoBannerWidget:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.TrialInfoBannerWidget:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.TrialInfoBannerWidget:completeAnimation()
			f39_arg0.TrialInfoBannerWidget:setAlpha(0)
			f39_local6(f39_arg0.TrialInfoBannerWidget)
			local f39_local7 = function(f56_arg0)
				f39_arg0.TrialInfoBannerWidgetPC:beginAnimation(490)
				f39_arg0.TrialInfoBannerWidgetPC:setAlpha(1)
				f39_arg0.TrialInfoBannerWidgetPC:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.TrialInfoBannerWidgetPC:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.TrialInfoBannerWidgetPC:completeAnimation()
			f39_arg0.TrialInfoBannerWidgetPC:setAlpha(0)
			f39_local7(f39_arg0.TrialInfoBannerWidgetPC)
			local f39_local8 = function(f57_arg0)
				local f57_local0 = function(f58_arg0)
					f58_arg0:beginAnimation(100)
					f58_arg0:setAlpha(1)
					f58_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.LootCaseMeter:beginAnimation(390)
				f39_arg0.LootCaseMeter:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.LootCaseMeter:registerEventHandler("transition_complete_keyframe", f57_local0)
			end
			f39_arg0.LootCaseMeter:completeAnimation()
			f39_arg0.LootCaseMeter:setAlpha(0)
			f39_local8(f39_arg0.LootCaseMeter)
		end,
	},
}
CoD.AARSummaryTab_WZ.__onClose = function(f59_arg0)
	f59_arg0.ScorestreakAspectRatioFix:close()
	f59_arg0.AarMpBacking:close()
	f59_arg0.XPMeter:close()
	f59_arg0.AARGameHistory:close()
	f59_arg0.AARGametypeHeader:close()
	f59_arg0.AARTierBar:close()
	f59_arg0.TrialInfoBannerWidget:close()
	f59_arg0.TrialInfoBannerWidgetPC:close()
	f59_arg0.DamageStat:close()
	f59_arg0.LootCaseMeter:close()
end
