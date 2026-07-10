require("x64:88b4d51833c79f5")
require("x64:ffa4895b0d22816")
require("x64:117670e09bbb2dc")
require("x64:a5b6deff4bc3cab")
require("x64:9e8b930117f8921")
require("x64:82f04d17b42755f")
require("x64:ca5faac82324b65")
require("x64:c96de52191fe142")
require("x64:df1637f3c8cfb9c")
require("x64:1ff27ba8f489b41")
require("x64:f52167eaf5dc054")
CoD.AARSummaryTabInternal = InheritFrom(LUI.UIElement)
CoD.AARSummaryTabInternal.__defaultWidth = 1920
CoD.AARSummaryTabInternal.__defaultHeight = 900
CoD.AARSummaryTabInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if IsZombies() then
		CoD.ZombieUtility.AdjustAarAllTimeStatWidgetsWidthToStretchAcrossMapImage(f1_arg0, f1_arg1, 2, 4)
		CoD.ZombieUtility.AdjustAarStatWidgetsWidthToStretchAcrossMapImage(f1_arg0, f1_arg1, 14, 2)
	end
	self:setClass(CoD.AARSummaryTabInternal)
	self.id = "AARSummaryTabInternal"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AARTierBar = CoD.AARTierBar.new(f1_arg0, f1_arg1, 0, 0, 797, 1639, 0, 0, 732, 752)
	AARTierBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.AARUtility.ShouldHideTierRewardMiniStatus(self, f1_arg1)
			end,
		},
	})
	AARTierBar:linkToElementModel(self, "tierProgress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AARTierBar.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "tierProgress", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			AARTierBar.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "tierProgress", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			AARTierBar.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "previousTierProgress", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			AARTierBar.PreviousXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "previousTierProgress", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			AARTierBar.PreviousXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "previousTierProgress", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			AARTierBar.PreviousXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	AARTierBar:linkToElementModel(self, "barCurrentTier", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			AARTierBar.CurrentTier:setText(LocalizeStringWithParameter(@"hash_1E743A7E5D0C37CD", f9_local0))
		end
	end)
	AARTierBar:linkToElementModel(self, "barNextTier", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			AARTierBar.NextTier:setText(LocalizeStringWithParameter(@"hash_1E743A7E5D0C37CD", f10_local0))
		end
	end)
	self:addElement(AARTierBar)
	self.AARTierBar = AARTierBar
	local XPMeter = CoD.AARXpMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -620, 680, 0, 0, 684, 704)
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
				local f12_local0
				if not IsMaxPrestigeLevel(f1_arg1) then
					f12_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rank", CoD.RankUtility.GetRankCap())
					if f12_local0 then
						f12_local0 = CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "xpNeededToLevelUp")
					end
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
		{
			stateName = "MaxParagonRank",
			condition = function(menu, element, event)
				local f13_local0 = IsInParagonCapableGameMode()
				if f13_local0 then
					f13_local0 = IsMaxPrestigeLevel(f1_arg1)
					if f13_local0 then
						f13_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "rank", CoD.RankUtility.GetParagonRankCap())
					end
				end
				return f13_local0
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
	XPMeter.maxRankText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/max_level"))
	XPMeter:linkToElementModel(self, nil, false, function(model)
		XPMeter:setModel(model, f1_arg1)
	end)
	XPMeter:linkToElementModel(self, "levelProgress", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			XPMeter.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f17_local0, 1), CoD.GetVectorComponentFromString(f17_local0, 2), CoD.GetVectorComponentFromString(f17_local0, 3), CoD.GetVectorComponentFromString(f17_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "levelProgress", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			XPMeter.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f18_local0, 1), CoD.GetVectorComponentFromString(f18_local0, 2), CoD.GetVectorComponentFromString(f18_local0, 3), CoD.GetVectorComponentFromString(f18_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "levelProgress", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			XPMeter.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f19_local0, 1), CoD.GetVectorComponentFromString(f19_local0, 2), CoD.GetVectorComponentFromString(f19_local0, 3), CoD.GetVectorComponentFromString(f19_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "previousProgressThisLevel", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			XPMeter.PreviousXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f20_local0, 1), CoD.GetVectorComponentFromString(f20_local0, 2), CoD.GetVectorComponentFromString(f20_local0, 3), CoD.GetVectorComponentFromString(f20_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "previousProgressThisLevel", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			XPMeter.PreviousXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "previousProgressThisLevel", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			XPMeter.PreviousXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f22_local0, 1), CoD.GetVectorComponentFromString(f22_local0, 2), CoD.GetVectorComponentFromString(f22_local0, 3), CoD.GetVectorComponentFromString(f22_local0, 4))
		end
	end)
	XPMeter:linkToElementModel(self, "xpEarnedDuringMatch", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			XPMeter.xpEarnedText:setText(LocalizeIntoString(@"hash_75C4E2BA06EA49A5", f23_local0))
		end
	end)
	XPMeter:linkToElementModel(self, "xpNeededToLevelUp", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			XPMeter.xpNeededText:setText(CoD.RankUtility.GetNextRankXPStringLong(f24_local0))
		end
	end)
	self:addElement(XPMeter)
	self.XPMeter = XPMeter
	local AARGameHistory = CoD.AARGameHistory.new(f1_arg0, f1_arg1, 0, 0, 636.5, 1796.5, 0, 0, 366, 666)
	AARGameHistory:linkToElementModel(self, nil, false, function(model)
		AARGameHistory:setModel(model, f1_arg1)
	end)
	self:addElement(AARGameHistory)
	self.AARGameHistory = AARGameHistory
	local AAREnemiesKIAWidget = CoD.AAREnemiesKIAWidget.new(f1_arg0, f1_arg1, 0, 0, 1461, 1801, 0, 0, 135.5, 267.5)
	AAREnemiesKIAWidget:linkToElementModel(self, nil, false, function(model)
		AAREnemiesKIAWidget:setModel(model, f1_arg1)
	end)
	self:addElement(AAREnemiesKIAWidget)
	self.AAREnemiesKIAWidget = AAREnemiesKIAWidget
	local AARDamageWidget = CoD.AARDamageWidget.new(f1_arg0, f1_arg1, 0, 0, 1048.5, 1388.5, 0, 0, 135.5, 267.5)
	AARDamageWidget:linkToElementModel(self, nil, false, function(model)
		AARDamageWidget:setModel(model, f1_arg1)
	end)
	self:addElement(AARDamageWidget)
	self.AARDamageWidget = AARDamageWidget
	local AARScoreWidget = CoD.AARScoreWidget.new(f1_arg0, f1_arg1, 0, 0, 636.5, 976.5, 0, 0, 135.5, 267.5)
	AARScoreWidget:linkToElementModel(self, nil, false, function(model)
		AARScoreWidget:setModel(model, f1_arg1)
	end)
	self:addElement(AARScoreWidget)
	self.AARScoreWidget = AARScoreWidget
	local PerformanceLabel = LUI.UIText.new(0, 0, 638.5, 1493.5, 0, 0, 91, 129)
	PerformanceLabel:setRGB(0.9, 0.89, 0.78)
	PerformanceLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](0x4B072C59118316))
	PerformanceLabel:setTTF("ttmussels_demibold")
	PerformanceLabel:setLetterSpacing(10)
	PerformanceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PerformanceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PerformanceLabel)
	self.PerformanceLabel = PerformanceLabel
	local AARGameInfo = CoD.AARGameInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, -21, 179)
	AARGameInfo:linkToElementModel(self, nil, false, function(model)
		AARGameInfo:setModel(model, f1_arg1)
	end)
	self:addElement(AARGameInfo)
	self.AARGameInfo = AARGameInfo
	local ZmAllTimePerf = CoD.ZMAARAllTimePerfWidget.new(f1_arg0, f1_arg1, 0, 0, 638.5, 1803.5, 0, 0, 306, 712)
	ZmAllTimePerf:setAlpha(0)
	ZmAllTimePerf:linkToElementModel(self, nil, false, function(model)
		ZmAllTimePerf:setModel(model, f1_arg1)
	end)
	self:addElement(ZmAllTimePerf)
	self.ZmAllTimePerf = ZmAllTimePerf
	local ZmGenericSummaryList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 14, 0, nil, nil, false, false, false, false)
	ZmGenericSummaryList:setLeftRight(0, 0, 638.5, 1800.5)
	ZmGenericSummaryList:setTopBottom(0, 0, 128.5, 272.5)
	ZmGenericSummaryList:setAlpha(0)
	ZmGenericSummaryList:setAutoScaleContent(true)
	ZmGenericSummaryList:setWidgetType(CoD.ZMGenericSummaryStatWidget)
	ZmGenericSummaryList:setHorizontalCount(6)
	ZmGenericSummaryList:setSpacing(14)
	ZmGenericSummaryList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ZmGenericSummaryList:setDataSource("ZMSummaryListGeneric")
	self:addElement(ZmGenericSummaryList)
	self.ZmGenericSummaryList = ZmGenericSummaryList
	local ZMPerformanceLabel = LUI.UIText.new(0, 0, 635.5, 1490.5, 0, 0, 87, 125)
	ZMPerformanceLabel:setRGB(0.9, 0.89, 0.78)
	ZMPerformanceLabel:setAlpha(0)
	ZMPerformanceLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](0x4B072C59118316))
	ZMPerformanceLabel:setTTF("skorzhen")
	ZMPerformanceLabel:setLetterSpacing(10)
	ZMPerformanceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ZMPerformanceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ZMPerformanceLabel)
	self.ZMPerformanceLabel = ZMPerformanceLabel
	local ZMAARGameInfo = CoD.ZMAARGameInfo.new(f1_arg0, f1_arg1, 0, 0, 615, 1589, 0, 0, -45, 68)
	ZMAARGameInfo:setAlpha(0)
	ZMAARGameInfo:linkToElementModel(self, nil, false, function(model)
		ZMAARGameInfo:setModel(model, f1_arg1)
	end)
	self:addElement(ZMAARGameInfo)
	self.ZMAARGameInfo = ZMAARGameInfo
	local LootCaseMeter = CoD.AARTierRewardLootCaseMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, 693.5, 843.5, 0, 0, -25, 125)
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
			stateName = "ShowMp_PC",
			condition = function(menu, element, event)
				local f35_local0
				if not IsZombies() then
					f35_local0 = IsPC()
				else
					f35_local0 = false
				end
				return f35_local0
			end,
		},
		{
			stateName = "ShowZm_PC",
			condition = function(menu, element, event)
				return IsZombies() and IsPC()
			end,
		},
		{
			stateName = "DefaultState_PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "ShowMp",
			condition = function(menu, element, event)
				return not IsZombies()
			end,
		},
		{
			stateName = "ShowZm",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f40_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	AARGameHistory.id = "AARGameHistory"
	ZmAllTimePerf.id = "ZmAllTimePerf"
	ZmGenericSummaryList.id = "ZmGenericSummaryList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSummaryTabInternal.__resetProperties = function(f41_arg0)
	f41_arg0.AARScoreWidget:completeAnimation()
	f41_arg0.AARDamageWidget:completeAnimation()
	f41_arg0.AAREnemiesKIAWidget:completeAnimation()
	f41_arg0.AARGameHistory:completeAnimation()
	f41_arg0.ZmGenericSummaryList:completeAnimation()
	f41_arg0.ZmAllTimePerf:completeAnimation()
	f41_arg0.XPMeter:completeAnimation()
	f41_arg0.PerformanceLabel:completeAnimation()
	f41_arg0.AARGameInfo:completeAnimation()
	f41_arg0.ZMPerformanceLabel:completeAnimation()
	f41_arg0.ZMAARGameInfo:completeAnimation()
	f41_arg0.AARTierBar:completeAnimation()
	f41_arg0.AARScoreWidget:setAlpha(1)
	f41_arg0.AARDamageWidget:setAlpha(1)
	f41_arg0.AAREnemiesKIAWidget:setAlpha(1)
	f41_arg0.AARGameHistory:setAlpha(1)
	f41_arg0.ZmGenericSummaryList:setAlpha(0)
	f41_arg0.ZmAllTimePerf:setAlpha(0)
	f41_arg0.XPMeter:setTopBottom(0, 0, 684, 704)
	f41_arg0.XPMeter:setAlpha(1)
	f41_arg0.PerformanceLabel:setLeftRight(0, 0, 638.5, 1493.5)
	f41_arg0.PerformanceLabel:setTopBottom(0, 0, 91, 129)
	f41_arg0.PerformanceLabel:setAlpha(1)
	f41_arg0.AARGameInfo:setAlpha(1)
	f41_arg0.ZMPerformanceLabel:setAlpha(0)
	f41_arg0.ZMAARGameInfo:setAlpha(0)
	f41_arg0.AARTierBar:setTopBottom(0, 0, 732, 752)
	f41_arg0.AARTierBar:setAlpha(1)
end
CoD.AARSummaryTabInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(0)
		end,
	},
	ShowMp_PC = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(12)
			local f43_local0 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(99)
					f45_arg0:setAlpha(1)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.AARTierBar:beginAnimation(400)
				f43_arg0.AARTierBar:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.AARTierBar:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f43_arg0.AARTierBar:completeAnimation()
			f43_arg0.AARTierBar:setTopBottom(0, 0, 748, 768)
			f43_arg0.AARTierBar:setAlpha(0)
			f43_local0(f43_arg0.AARTierBar)
			local f43_local1 = function(f46_arg0)
				local f46_local0 = function(f47_arg0)
					f47_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f47_arg0:setAlpha(1)
					f47_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.XPMeter:beginAnimation(400)
				f43_arg0.XPMeter:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.XPMeter:registerEventHandler("transition_complete_keyframe", f46_local0)
			end
			f43_arg0.XPMeter:completeAnimation()
			f43_arg0.XPMeter:setTopBottom(0, 0, 700, 720)
			f43_arg0.XPMeter:setAlpha(0)
			f43_local1(f43_arg0.XPMeter)
			local f43_local2 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					f49_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f49_arg0:setAlpha(1)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.AARGameHistory:beginAnimation(350)
				f43_arg0.AARGameHistory:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.AARGameHistory:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f43_arg0.AARGameHistory:completeAnimation()
			f43_arg0.AARGameHistory:setAlpha(0)
			f43_local2(f43_arg0.AARGameHistory)
			local f43_local3 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					f51_arg0:beginAnimation(100)
					f51_arg0:setAlpha(1)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.AAREnemiesKIAWidget:beginAnimation(210)
				f43_arg0.AAREnemiesKIAWidget:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.AAREnemiesKIAWidget:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f43_arg0.AAREnemiesKIAWidget:completeAnimation()
			f43_arg0.AAREnemiesKIAWidget:setAlpha(0)
			f43_local3(f43_arg0.AAREnemiesKIAWidget)
			local f43_local4 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					f53_arg0:beginAnimation(100)
					f53_arg0:setAlpha(1)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.AARDamageWidget:beginAnimation(200)
				f43_arg0.AARDamageWidget:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.AARDamageWidget:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f43_arg0.AARDamageWidget:completeAnimation()
			f43_arg0.AARDamageWidget:setAlpha(0)
			f43_local4(f43_arg0.AARDamageWidget)
			local f43_local5 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					f55_arg0:beginAnimation(99)
					f55_arg0:setAlpha(1)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.AARScoreWidget:beginAnimation(190)
				f43_arg0.AARScoreWidget:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.AARScoreWidget:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f43_arg0.AARScoreWidget:completeAnimation()
			f43_arg0.AARScoreWidget:setAlpha(0)
			f43_local5(f43_arg0.AARScoreWidget)
			local f43_local6 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					f57_arg0:beginAnimation(99)
					f57_arg0:setAlpha(1)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.PerformanceLabel:beginAnimation(190)
				f43_arg0.PerformanceLabel:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.PerformanceLabel:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f43_arg0.PerformanceLabel:completeAnimation()
			f43_arg0.PerformanceLabel:setAlpha(0)
			f43_local6(f43_arg0.PerformanceLabel)
			local f43_local7 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					f59_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
					f59_arg0:setAlpha(1)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.AARGameInfo:beginAnimation(50)
				f43_arg0.AARGameInfo:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.AARGameInfo:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f43_arg0.AARGameInfo:completeAnimation()
			f43_arg0.AARGameInfo:setAlpha(0)
			f43_local7(f43_arg0.AARGameInfo)
			f43_arg0.ZmAllTimePerf:completeAnimation()
			f43_arg0.ZmAllTimePerf:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ZmAllTimePerf)
			f43_arg0.ZmGenericSummaryList:completeAnimation()
			f43_arg0.ZmGenericSummaryList:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ZmGenericSummaryList)
			f43_arg0.ZMPerformanceLabel:completeAnimation()
			f43_arg0.ZMPerformanceLabel:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ZMPerformanceLabel)
			f43_arg0.ZMAARGameInfo:completeAnimation()
			f43_arg0.ZMAARGameInfo:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ZMAARGameInfo)
		end,
	},
	ShowZm_PC = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(12)
			f60_arg0.AARTierBar:completeAnimation()
			f60_arg0.AARTierBar:setTopBottom(0, 0, 763, 783)
			f60_arg0.AARTierBar:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.AARTierBar)
			local f60_local0 = function(f61_arg0)
				local f61_local0 = function(f62_arg0)
					f62_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f62_arg0:setAlpha(1)
					f62_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.XPMeter:beginAnimation(400)
				f60_arg0.XPMeter:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.XPMeter:registerEventHandler("transition_complete_keyframe", f61_local0)
			end
			f60_arg0.XPMeter:completeAnimation()
			f60_arg0.XPMeter:setTopBottom(0, 0, 720, 740)
			f60_arg0.XPMeter:setAlpha(0)
			f60_local0(f60_arg0.XPMeter)
			f60_arg0.AARGameHistory:completeAnimation()
			f60_arg0.AARGameHistory:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.AARGameHistory)
			f60_arg0.AAREnemiesKIAWidget:completeAnimation()
			f60_arg0.AAREnemiesKIAWidget:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.AAREnemiesKIAWidget)
			f60_arg0.AARDamageWidget:completeAnimation()
			f60_arg0.AARDamageWidget:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.AARDamageWidget)
			f60_arg0.AARScoreWidget:completeAnimation()
			f60_arg0.AARScoreWidget:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.AARScoreWidget)
			f60_arg0.PerformanceLabel:completeAnimation()
			f60_arg0.PerformanceLabel:setLeftRight(0, 0, 614.5, 1469.5)
			f60_arg0.PerformanceLabel:setTopBottom(0, 0, 89, 127)
			f60_arg0.PerformanceLabel:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.PerformanceLabel)
			f60_arg0.AARGameInfo:completeAnimation()
			f60_arg0.AARGameInfo:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.AARGameInfo)
			local f60_local1 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					f64_arg0:beginAnimation(99)
					f64_arg0:setAlpha(1)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.ZmAllTimePerf:beginAnimation(350)
				f60_arg0.ZmAllTimePerf:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.ZmAllTimePerf:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f60_arg0.ZmAllTimePerf:completeAnimation()
			f60_arg0.ZmAllTimePerf:setAlpha(0)
			f60_local1(f60_arg0.ZmAllTimePerf)
			local f60_local2 = function(f65_arg0)
				local f65_local0 = function(f66_arg0)
					f66_arg0:beginAnimation(100)
					f66_arg0:setAlpha(1)
					f66_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.ZmGenericSummaryList:beginAnimation(200)
				f60_arg0.ZmGenericSummaryList:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.ZmGenericSummaryList:registerEventHandler("transition_complete_keyframe", f65_local0)
			end
			f60_arg0.ZmGenericSummaryList:completeAnimation()
			f60_arg0.ZmGenericSummaryList:setAlpha(0)
			f60_local2(f60_arg0.ZmGenericSummaryList)
			local f60_local3 = function(f67_arg0)
				local f67_local0 = function(f68_arg0)
					f68_arg0:beginAnimation(99)
					f68_arg0:setAlpha(1)
					f68_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.ZMPerformanceLabel:beginAnimation(180)
				f60_arg0.ZMPerformanceLabel:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.ZMPerformanceLabel:registerEventHandler("transition_complete_keyframe", f67_local0)
			end
			f60_arg0.ZMPerformanceLabel:completeAnimation()
			f60_arg0.ZMPerformanceLabel:setAlpha(0)
			f60_local3(f60_arg0.ZMPerformanceLabel)
			local f60_local4 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					f70_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
					f70_arg0:setAlpha(1)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.ZMAARGameInfo:beginAnimation(50)
				f60_arg0.ZMAARGameInfo:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.ZMAARGameInfo:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f60_arg0.ZMAARGameInfo:completeAnimation()
			f60_arg0.ZMAARGameInfo:setAlpha(0)
			f60_local4(f60_arg0.ZMAARGameInfo)
		end,
	},
	DefaultState_PC = {
		DefaultClip = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(2)
			f71_arg0.AARTierBar:completeAnimation()
			f71_arg0.AARTierBar:setTopBottom(0, 0, 748, 768)
			f71_arg0.clipFinished(f71_arg0.AARTierBar)
			f71_arg0.XPMeter:completeAnimation()
			f71_arg0.XPMeter:setTopBottom(0, 0, 700, 720)
			f71_arg0.clipFinished(f71_arg0.XPMeter)
		end,
	},
	ShowMp = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(12)
			local f72_local0 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					f74_arg0:beginAnimation(99)
					f74_arg0:setAlpha(1)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.AARTierBar:beginAnimation(400)
				f72_arg0.AARTierBar:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.AARTierBar:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f72_arg0.AARTierBar:completeAnimation()
			f72_arg0.AARTierBar:setAlpha(0)
			f72_local0(f72_arg0.AARTierBar)
			local f72_local1 = function(f75_arg0)
				local f75_local0 = function(f76_arg0)
					f76_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f76_arg0:setAlpha(1)
					f76_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.XPMeter:beginAnimation(400)
				f72_arg0.XPMeter:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.XPMeter:registerEventHandler("transition_complete_keyframe", f75_local0)
			end
			f72_arg0.XPMeter:completeAnimation()
			f72_arg0.XPMeter:setAlpha(0)
			f72_local1(f72_arg0.XPMeter)
			local f72_local2 = function(f77_arg0)
				local f77_local0 = function(f78_arg0)
					f78_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f78_arg0:setAlpha(1)
					f78_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.AARGameHistory:beginAnimation(350)
				f72_arg0.AARGameHistory:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.AARGameHistory:registerEventHandler("transition_complete_keyframe", f77_local0)
			end
			f72_arg0.AARGameHistory:completeAnimation()
			f72_arg0.AARGameHistory:setAlpha(0)
			f72_local2(f72_arg0.AARGameHistory)
			local f72_local3 = function(f79_arg0)
				local f79_local0 = function(f80_arg0)
					f80_arg0:beginAnimation(100)
					f80_arg0:setAlpha(1)
					f80_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.AAREnemiesKIAWidget:beginAnimation(210)
				f72_arg0.AAREnemiesKIAWidget:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.AAREnemiesKIAWidget:registerEventHandler("transition_complete_keyframe", f79_local0)
			end
			f72_arg0.AAREnemiesKIAWidget:completeAnimation()
			f72_arg0.AAREnemiesKIAWidget:setAlpha(0)
			f72_local3(f72_arg0.AAREnemiesKIAWidget)
			local f72_local4 = function(f81_arg0)
				local f81_local0 = function(f82_arg0)
					f82_arg0:beginAnimation(100)
					f82_arg0:setAlpha(1)
					f82_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.AARDamageWidget:beginAnimation(200)
				f72_arg0.AARDamageWidget:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.AARDamageWidget:registerEventHandler("transition_complete_keyframe", f81_local0)
			end
			f72_arg0.AARDamageWidget:completeAnimation()
			f72_arg0.AARDamageWidget:setAlpha(0)
			f72_local4(f72_arg0.AARDamageWidget)
			local f72_local5 = function(f83_arg0)
				local f83_local0 = function(f84_arg0)
					f84_arg0:beginAnimation(99)
					f84_arg0:setAlpha(1)
					f84_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.AARScoreWidget:beginAnimation(190)
				f72_arg0.AARScoreWidget:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.AARScoreWidget:registerEventHandler("transition_complete_keyframe", f83_local0)
			end
			f72_arg0.AARScoreWidget:completeAnimation()
			f72_arg0.AARScoreWidget:setAlpha(0)
			f72_local5(f72_arg0.AARScoreWidget)
			local f72_local6 = function(f85_arg0)
				local f85_local0 = function(f86_arg0)
					f86_arg0:beginAnimation(99)
					f86_arg0:setAlpha(1)
					f86_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.PerformanceLabel:beginAnimation(190)
				f72_arg0.PerformanceLabel:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.PerformanceLabel:registerEventHandler("transition_complete_keyframe", f85_local0)
			end
			f72_arg0.PerformanceLabel:completeAnimation()
			f72_arg0.PerformanceLabel:setAlpha(0)
			f72_local6(f72_arg0.PerformanceLabel)
			local f72_local7 = function(f87_arg0)
				local f87_local0 = function(f88_arg0)
					f88_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
					f88_arg0:setAlpha(1)
					f88_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.AARGameInfo:beginAnimation(50)
				f72_arg0.AARGameInfo:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.AARGameInfo:registerEventHandler("transition_complete_keyframe", f87_local0)
			end
			f72_arg0.AARGameInfo:completeAnimation()
			f72_arg0.AARGameInfo:setAlpha(0)
			f72_local7(f72_arg0.AARGameInfo)
			f72_arg0.ZmAllTimePerf:completeAnimation()
			f72_arg0.ZmAllTimePerf:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ZmAllTimePerf)
			f72_arg0.ZmGenericSummaryList:completeAnimation()
			f72_arg0.ZmGenericSummaryList:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ZmGenericSummaryList)
			f72_arg0.ZMPerformanceLabel:completeAnimation()
			f72_arg0.ZMPerformanceLabel:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ZMPerformanceLabel)
			f72_arg0.ZMAARGameInfo:completeAnimation()
			f72_arg0.ZMAARGameInfo:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ZMAARGameInfo)
		end,
	},
	ShowZm = {
		DefaultClip = function(f89_arg0, f89_arg1)
			f89_arg0:__resetProperties()
			f89_arg0:setupElementClipCounter(12)
			f89_arg0.AARTierBar:completeAnimation()
			f89_arg0.AARTierBar:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.AARTierBar)
			local f89_local0 = function(f90_arg0)
				local f90_local0 = function(f91_arg0)
					f91_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f91_arg0:setAlpha(1)
					f91_arg0:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
				end
				f89_arg0.XPMeter:beginAnimation(400)
				f89_arg0.XPMeter:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.XPMeter:registerEventHandler("transition_complete_keyframe", f90_local0)
			end
			f89_arg0.XPMeter:completeAnimation()
			f89_arg0.XPMeter:setTopBottom(0, 0, 720, 740)
			f89_arg0.XPMeter:setAlpha(0)
			f89_local0(f89_arg0.XPMeter)
			f89_arg0.AARGameHistory:completeAnimation()
			f89_arg0.AARGameHistory:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.AARGameHistory)
			f89_arg0.AAREnemiesKIAWidget:completeAnimation()
			f89_arg0.AAREnemiesKIAWidget:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.AAREnemiesKIAWidget)
			f89_arg0.AARDamageWidget:completeAnimation()
			f89_arg0.AARDamageWidget:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.AARDamageWidget)
			f89_arg0.AARScoreWidget:completeAnimation()
			f89_arg0.AARScoreWidget:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.AARScoreWidget)
			f89_arg0.PerformanceLabel:completeAnimation()
			f89_arg0.PerformanceLabel:setLeftRight(0, 0, 614.5, 1469.5)
			f89_arg0.PerformanceLabel:setTopBottom(0, 0, 89, 127)
			f89_arg0.PerformanceLabel:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.PerformanceLabel)
			f89_arg0.AARGameInfo:completeAnimation()
			f89_arg0.AARGameInfo:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.AARGameInfo)
			local f89_local1 = function(f92_arg0)
				local f92_local0 = function(f93_arg0)
					f93_arg0:beginAnimation(99)
					f93_arg0:setAlpha(1)
					f93_arg0:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
				end
				f89_arg0.ZmAllTimePerf:beginAnimation(350)
				f89_arg0.ZmAllTimePerf:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.ZmAllTimePerf:registerEventHandler("transition_complete_keyframe", f92_local0)
			end
			f89_arg0.ZmAllTimePerf:completeAnimation()
			f89_arg0.ZmAllTimePerf:setAlpha(0)
			f89_local1(f89_arg0.ZmAllTimePerf)
			local f89_local2 = function(f94_arg0)
				local f94_local0 = function(f95_arg0)
					f95_arg0:beginAnimation(100)
					f95_arg0:setAlpha(1)
					f95_arg0:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
				end
				f89_arg0.ZmGenericSummaryList:beginAnimation(200)
				f89_arg0.ZmGenericSummaryList:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.ZmGenericSummaryList:registerEventHandler("transition_complete_keyframe", f94_local0)
			end
			f89_arg0.ZmGenericSummaryList:completeAnimation()
			f89_arg0.ZmGenericSummaryList:setAlpha(0)
			f89_local2(f89_arg0.ZmGenericSummaryList)
			local f89_local3 = function(f96_arg0)
				local f96_local0 = function(f97_arg0)
					f97_arg0:beginAnimation(99)
					f97_arg0:setAlpha(1)
					f97_arg0:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
				end
				f89_arg0.ZMPerformanceLabel:beginAnimation(180)
				f89_arg0.ZMPerformanceLabel:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.ZMPerformanceLabel:registerEventHandler("transition_complete_keyframe", f96_local0)
			end
			f89_arg0.ZMPerformanceLabel:completeAnimation()
			f89_arg0.ZMPerformanceLabel:setAlpha(0)
			f89_local3(f89_arg0.ZMPerformanceLabel)
			local f89_local4 = function(f98_arg0)
				local f98_local0 = function(f99_arg0)
					f99_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
					f99_arg0:setAlpha(1)
					f99_arg0:registerEventHandler("transition_complete_keyframe", f89_arg0.clipFinished)
				end
				f89_arg0.ZMAARGameInfo:beginAnimation(50)
				f89_arg0.ZMAARGameInfo:registerEventHandler("interrupted_keyframe", f89_arg0.clipInterrupted)
				f89_arg0.ZMAARGameInfo:registerEventHandler("transition_complete_keyframe", f98_local0)
			end
			f89_arg0.ZMAARGameInfo:completeAnimation()
			f89_arg0.ZMAARGameInfo:setAlpha(0)
			f89_local4(f89_arg0.ZMAARGameInfo)
		end,
	},
}
CoD.AARSummaryTabInternal.__onClose = function(f100_arg0)
	f100_arg0.AARTierBar:close()
	f100_arg0.XPMeter:close()
	f100_arg0.AARGameHistory:close()
	f100_arg0.AAREnemiesKIAWidget:close()
	f100_arg0.AARDamageWidget:close()
	f100_arg0.AARScoreWidget:close()
	f100_arg0.AARGameInfo:close()
	f100_arg0.ZmAllTimePerf:close()
	f100_arg0.ZmGenericSummaryList:close()
	f100_arg0.ZMAARGameInfo:close()
	f100_arg0.LootCaseMeter:close()
end
