require("x64:88b4d51833c79f5")
require("x64:1e60cbe5188f2c2")
require("x64:8fd38b89728974a")
require("x64:2718c2daeffcc4b")
require("x64:125bdc86bbab0bf")
require("x64:e97ae2edf67ce32")
CoD.MeritReportWidget = InheritFrom(LUI.UIElement)
CoD.MeritReportWidget.__defaultWidth = 1920
CoD.MeritReportWidget.__defaultHeight = 1080
CoD.MeritReportWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MeritReportWidget)
	self.id = "MeritReportWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MeritOverlayManualHeader = CoD.MeritOverlayManualHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	MeritOverlayManualHeader:mergeStateConditions({
		{
			stateName = "NoIntro",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "ContractsEnabledTabs")
			end,
		},
	})
	MeritOverlayManualHeader:subscribeToGlobalModel(f1_arg1, "AARMeritReport", nil, function(model)
		MeritOverlayManualHeader:setModel(model, f1_arg1)
	end)
	self:addElement(MeritOverlayManualHeader)
	self.MeritOverlayManualHeader = MeritOverlayManualHeader
	local XpMeter = CoD.AARXpMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -877, 423, 0.5, 0.5, 464, 484)
	XpMeter:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "MaxRank",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rank", CoD.RankUtility.GetRankCap() + 1)
			end,
		},
	})
	XpMeter:linkToElementModel(XpMeter, "rank", true, function(model)
		f1_arg0:updateElementState(XpMeter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rank",
		})
	end)
	XpMeter.maxRankText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4F80010008304EC0"))
	XpMeter:subscribeToGlobalModel(f1_arg1, "AARMeritReport", "earnedXpProgress", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			XpMeter.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg1, "AARMeritReport", "earnedXpProgress", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			XpMeter.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg1, "AARMeritReport", "previousXpProgress", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			XpMeter.PreviousXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg1, "AARMeritReport", "previousXpProgress", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			XpMeter.PreviousXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4))
		end
	end)
	XpMeter:linkToElementModel(self, nil, false, function(model)
		XpMeter:setModel(model, f1_arg1)
	end)
	XpMeter:linkToElementModel(self, "earnedXpProgress", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			XpMeter.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f12_local0, 1), CoD.GetVectorComponentFromString(f12_local0, 2), CoD.GetVectorComponentFromString(f12_local0, 3), CoD.GetVectorComponentFromString(f12_local0, 4))
		end
	end)
	XpMeter:linkToElementModel(self, "previousXpProgress", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			XpMeter.PreviousXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f13_local0, 1), CoD.GetVectorComponentFromString(f13_local0, 2), CoD.GetVectorComponentFromString(f13_local0, 3), CoD.GetVectorComponentFromString(f13_local0, 4))
		end
	end)
	XpMeter:linkToElementModel(self, "xpEarnedDuringMatch", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			XpMeter.xpEarnedText:setText(CoD.BaseUtility.AlreadyLocalized(f14_local0))
		end
	end)
	XpMeter:linkToElementModel(self, "xpNeededForLevelUp", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			XpMeter.xpNeededText:setText(LocalizeIntoString(@"hash_F8D3A275EFD4C8A", f15_local0))
		end
	end)
	self:addElement(XpMeter)
	self.XpMeter = XpMeter
	local MeritBoard = CoD.MeritOverlayBoard.new(f1_arg0, f1_arg1, 0, 0, 402.5, 1517.5, 0, 0, 590, 870)
	MeritBoard:linkToElementModel(self, nil, false, function(model)
		MeritBoard:setModel(model, f1_arg1)
	end)
	self:addElement(MeritBoard)
	self.MeritBoard = MeritBoard
	local MeritBoardWithMedals = CoD.MeritOverlayBoardWithMedals.new(f1_arg0, f1_arg1, 0.5, 0.5, -270, 270, 0.5, 0.5, -232, 396)
	MeritBoardWithMedals:mergeStateConditions({
		{
			stateName = "NoIntro",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "ContractsEnabledTabs")
			end,
		},
	})
	MeritBoardWithMedals:setAlpha(0)
	MeritBoardWithMedals:linkToElementModel(self, nil, false, function(model)
		MeritBoardWithMedals:setModel(model, f1_arg1)
	end)
	self:addElement(MeritBoardWithMedals)
	self.MeritBoardWithMedals = MeritBoardWithMedals
	local Echelon = CoD.AAREchelon.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0, 0, 150, 550)
	Echelon:linkToElementModel(self, nil, false, function(model)
		Echelon:setModel(model, f1_arg1)
	end)
	self:addElement(Echelon)
	self.Echelon = Echelon
	local ChallengeCoin = CoD.ChallengeCoin.new(f1_arg0, f1_arg1, 0, 0, 307.5, 507.5, 0, 0, 500, 700)
	ChallengeCoin:setZRot(7)
	ChallengeCoin:subscribeToGlobalModel(f1_arg1, "AARMeritReport", nil, function(model)
		ChallengeCoin:setModel(model, f1_arg1)
	end)
	ChallengeCoin:linkToElementModel(self, "challengeCoinImage", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			ChallengeCoin.ChallengeCoinImage:setImage(RegisterImage(f21_local0))
		end
	end)
	ChallengeCoin:linkToElementModel(self, "challengeCoinImage", true, function(model)
		local f22_local0 = ChallengeCoin
		PlayClipOnElement(self, {
			elementName = "ChallengeCoin",
			clipName = "Slam",
		}, f1_arg1)
	end)
	self:addElement(ChallengeCoin)
	self.ChallengeCoin = ChallengeCoin
	self:mergeStateConditions({
		{
			stateName = "ContractsEnabled",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("ui_enableContractsAndBounties")
			end,
		},
		{
			stateName = "ContractsEnabledTabs",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f25_arg2, f25_arg3, f25_arg4)
		UpdateElementState(self, "MeritBoardWithMedals", controller)
		UpdateElementState(self, "MeritOverlayManualHeader", controller)
	end)
	self:subscribeToGlobalModel(f1_arg1, "AARMeritReport", "showRank", function(model)
		local f26_local0 = self
		CoD.AARUtility.DelayAndOpenMeritMedal(self, f1_arg1, 0.25)
	end)
	self:subscribeToGlobalModel(f1_arg1, "AARMeritReport", "showRankDone", function(model)
		local f27_local0 = self
		CoD.AARUtility.DelayAndCloseMeritMedal(self, f1_arg1, 4)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.AARUtility.SetupAnimateMeritRankUp(self, f1_arg1)
	return self
end
CoD.MeritReportWidget.__resetProperties = function(f28_arg0)
	f28_arg0.Echelon:completeAnimation()
	f28_arg0.MeritBoard:completeAnimation()
	f28_arg0.XpMeter:completeAnimation()
	f28_arg0.ChallengeCoin:completeAnimation()
	f28_arg0.MeritOverlayManualHeader:completeAnimation()
	f28_arg0.MeritBoardWithMedals:completeAnimation()
	f28_arg0.Echelon:setAlpha(1)
	f28_arg0.MeritBoard:setAlpha(1)
	f28_arg0.XpMeter:setAlpha(1)
	f28_arg0.ChallengeCoin:setLeftRight(0, 0, 307.5, 507.5)
	f28_arg0.ChallengeCoin:setTopBottom(0, 0, 500, 700)
	f28_arg0.ChallengeCoin:setAlpha(1)
	f28_arg0.ChallengeCoin:setZRot(7)
	f28_arg0.ChallengeCoin:setScale(1, 1)
	f28_arg0.MeritOverlayManualHeader:setTopBottom(0.5, 0.5, -540, 540)
	f28_arg0.MeritOverlayManualHeader:setAlpha(1)
	f28_arg0.MeritBoardWithMedals:setAlpha(0)
	f28_arg0.MeritBoardWithMedals:setScale(1, 1)
	f28_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:setAlpha(1)
	f28_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.Title:setAlpha(1)
	f28_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:setAlpha(1)
	f28_arg0.MeritBoardWithMedals.AAREchelon:setAlpha(1)
	f28_arg0.MeritBoardWithMedals.AAREchelon.blurBg:setAlpha(0)
	f28_arg0.MeritBoardWithMedals.AAREchelon.NoiseTiledBacking:setAlpha(1)
end
CoD.MeritReportWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(5)
			f29_arg0.MeritOverlayManualHeader:completeAnimation()
			f29_arg0.MeritOverlayManualHeader:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.MeritOverlayManualHeader)
			local f29_local0 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.XpMeter:beginAnimation(350)
				f29_arg0.XpMeter:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.XpMeter:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f29_arg0.XpMeter:completeAnimation()
			f29_arg0.XpMeter:setAlpha(0)
			f29_local0(f29_arg0.XpMeter)
			local f29_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(150)
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.MeritBoard:beginAnimation(150)
				f29_arg0.MeritBoard:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.MeritBoard:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f29_arg0.MeritBoard:completeAnimation()
			f29_arg0.MeritBoard:setAlpha(0)
			f29_local1(f29_arg0.MeritBoard)
			local f29_local2 = function(f34_arg0)
				f29_arg0.Echelon:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
				f29_arg0.Echelon:setAlpha(1)
				f29_arg0.Echelon:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.Echelon:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.Echelon:completeAnimation()
			f29_arg0.Echelon:setAlpha(0)
			f29_local2(f29_arg0.Echelon)
			local f29_local3 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					local f36_local0 = function(f37_arg0)
						f37_arg0:beginAnimation(50)
						f37_arg0:setAlpha(1)
						f37_arg0:setScale(1, 1)
						f37_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
					end
					f36_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
					f36_arg0:setAlpha(0.75)
					f36_arg0:setZRot(7)
					f36_arg0:setScale(0.97, 0.97)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
				end
				f29_arg0.ChallengeCoin:beginAnimation(400)
				f29_arg0.ChallengeCoin:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ChallengeCoin:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f29_arg0.ChallengeCoin:completeAnimation()
			f29_arg0.ChallengeCoin:setAlpha(0)
			f29_arg0.ChallengeCoin:setZRot(30)
			f29_arg0.ChallengeCoin:setScale(2.5, 2.5)
			f29_local3(f29_arg0.ChallengeCoin)
		end,
	},
	ContractsEnabled = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(6)
			f38_arg0.MeritOverlayManualHeader:completeAnimation()
			f38_arg0.MeritOverlayManualHeader:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.MeritOverlayManualHeader)
			f38_arg0.XpMeter:completeAnimation()
			f38_arg0.XpMeter:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.XpMeter)
			f38_arg0.MeritBoard:completeAnimation()
			f38_arg0.MeritBoard:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.MeritBoard)
			local f38_local0 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						f41_arg0:beginAnimation(50)
						f41_arg0:setAlpha(1)
						f41_arg0:setScale(1, 1)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
					end
					f40_arg0:beginAnimation(99)
					f40_arg0:setAlpha(0.67)
					f40_arg0:setScale(0.9, 0.9)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f38_arg0.MeritBoardWithMedals:beginAnimation(150)
				f38_arg0.MeritBoardWithMedals:setScale(1.54, 1.54)
				f38_arg0.MeritBoardWithMedals:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.MeritBoardWithMedals:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f38_arg0.MeritBoardWithMedals:completeAnimation()
			f38_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:completeAnimation()
			f38_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.Title:completeAnimation()
			f38_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:completeAnimation()
			f38_arg0.MeritBoardWithMedals.AAREchelon:completeAnimation()
			f38_arg0.MeritBoardWithMedals.AAREchelon.blurBg:completeAnimation()
			f38_arg0.MeritBoardWithMedals.AAREchelon.NoiseTiledBacking:completeAnimation()
			f38_arg0.MeritBoardWithMedals:setAlpha(0)
			f38_arg0.MeritBoardWithMedals:setScale(2.5, 2.5)
			f38_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:setAlpha(1)
			f38_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.Title:setAlpha(1)
			f38_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:setAlpha(1)
			f38_arg0.MeritBoardWithMedals.AAREchelon:setAlpha(0)
			f38_arg0.MeritBoardWithMedals.AAREchelon.blurBg:setAlpha(0)
			f38_arg0.MeritBoardWithMedals.AAREchelon.NoiseTiledBacking:setAlpha(1)
			f38_local0(f38_arg0.MeritBoardWithMedals)
			f38_arg0.Echelon:completeAnimation()
			f38_arg0.Echelon:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Echelon)
			local f38_local1 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						f44_arg0:beginAnimation(50)
						f44_arg0:setAlpha(1)
						f44_arg0:setScale(1, 1)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
					end
					f43_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_in"])
					f43_arg0:setAlpha(0.75)
					f43_arg0:setScale(0.97, 0.97)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f38_arg0.ChallengeCoin:beginAnimation(430)
				f38_arg0.ChallengeCoin:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.ChallengeCoin:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f38_arg0.ChallengeCoin:completeAnimation()
			f38_arg0.ChallengeCoin:setLeftRight(0, 0, 1564.5, 1764.5)
			f38_arg0.ChallengeCoin:setTopBottom(0, 0, 40, 240)
			f38_arg0.ChallengeCoin:setAlpha(0)
			f38_arg0.ChallengeCoin:setZRot(0)
			f38_arg0.ChallengeCoin:setScale(2.5, 2.5)
			f38_local1(f38_arg0.ChallengeCoin)
		end,
		MedalIntro = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(6)
			f45_arg0.MeritOverlayManualHeader:completeAnimation()
			f45_arg0.MeritOverlayManualHeader:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.MeritOverlayManualHeader)
			f45_arg0.XpMeter:completeAnimation()
			f45_arg0.XpMeter:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.XpMeter)
			f45_arg0.MeritBoard:completeAnimation()
			f45_arg0.MeritBoard:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.MeritBoard)
			local f45_local0 = function(f46_arg0)
				f45_arg0.MeritBoardWithMedals:beginAnimation(100)
				f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:beginAnimation(100)
				f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:beginAnimation(100)
				f45_arg0.MeritBoardWithMedals.AAREchelon:beginAnimation(100)
				f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:setAlpha(0)
				f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:setAlpha(0)
				f45_arg0.MeritBoardWithMedals.AAREchelon:setAlpha(1)
				f45_arg0.MeritBoardWithMedals:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.MeritBoardWithMedals:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.MeritBoardWithMedals:completeAnimation()
			f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:completeAnimation()
			f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.Title:completeAnimation()
			f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:completeAnimation()
			f45_arg0.MeritBoardWithMedals.AAREchelon:completeAnimation()
			f45_arg0.MeritBoardWithMedals:setAlpha(1)
			f45_arg0.MeritBoardWithMedals:setScale(1, 1)
			f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:setAlpha(1)
			f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.Title:setAlpha(1)
			f45_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:setAlpha(1)
			f45_arg0.MeritBoardWithMedals.AAREchelon:setAlpha(0)
			f45_local0(f45_arg0.MeritBoardWithMedals)
			f45_arg0.Echelon:completeAnimation()
			f45_arg0.Echelon:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.Echelon)
			f45_arg0.ChallengeCoin:completeAnimation()
			f45_arg0.ChallengeCoin:setLeftRight(0, 0, 1564.5, 1764.5)
			f45_arg0.ChallengeCoin:setTopBottom(0, 0, 40, 240)
			f45_arg0.ChallengeCoin:setAlpha(1)
			f45_arg0.ChallengeCoin:setZRot(0)
			f45_arg0.ChallengeCoin:setScale(1, 1)
			f45_arg0.clipFinished(f45_arg0.ChallengeCoin)
		end,
		MedalOutro = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(6)
			f47_arg0.MeritOverlayManualHeader:completeAnimation()
			f47_arg0.MeritOverlayManualHeader:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.MeritOverlayManualHeader)
			f47_arg0.XpMeter:completeAnimation()
			f47_arg0.XpMeter:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.XpMeter)
			f47_arg0.MeritBoard:completeAnimation()
			f47_arg0.MeritBoard:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.MeritBoard)
			local f47_local0 = function(f48_arg0)
				f47_arg0.MeritBoardWithMedals:beginAnimation(300)
				f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:beginAnimation(300)
				f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:beginAnimation(300)
				f47_arg0.MeritBoardWithMedals.AAREchelon:beginAnimation(300)
				f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:setAlpha(1)
				f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:setAlpha(1)
				f47_arg0.MeritBoardWithMedals.AAREchelon:setAlpha(0)
				f47_arg0.MeritBoardWithMedals:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.MeritBoardWithMedals:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.MeritBoardWithMedals:completeAnimation()
			f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:completeAnimation()
			f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.Title:completeAnimation()
			f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:completeAnimation()
			f47_arg0.MeritBoardWithMedals.AAREchelon:completeAnimation()
			f47_arg0.MeritBoardWithMedals:setAlpha(1)
			f47_arg0.MeritBoardWithMedals:setScale(1, 1)
			f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.MeritsHeader:setAlpha(0)
			f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVerticalBG.Title:setAlpha(1)
			f47_arg0.MeritBoardWithMedals.MeritOverlayManualLayoutVertical:setAlpha(0)
			f47_arg0.MeritBoardWithMedals.AAREchelon:setAlpha(1)
			f47_local0(f47_arg0.MeritBoardWithMedals)
			f47_arg0.Echelon:completeAnimation()
			f47_arg0.Echelon:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Echelon)
			f47_arg0.ChallengeCoin:completeAnimation()
			f47_arg0.ChallengeCoin:setLeftRight(0, 0, 1564.5, 1764.5)
			f47_arg0.ChallengeCoin:setTopBottom(0, 0, 40, 240)
			f47_arg0.ChallengeCoin:setAlpha(1)
			f47_arg0.ChallengeCoin:setZRot(0)
			f47_arg0.ChallengeCoin:setScale(1, 1)
			f47_arg0.clipFinished(f47_arg0.ChallengeCoin)
		end,
	},
	ContractsEnabledTabs = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(6)
			f49_arg0.MeritOverlayManualHeader:completeAnimation()
			f49_arg0.MeritOverlayManualHeader:setTopBottom(0.5, 0.5, -480, 600)
			f49_arg0.MeritOverlayManualHeader:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.MeritOverlayManualHeader)
			f49_arg0.XpMeter:completeAnimation()
			f49_arg0.XpMeter:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.XpMeter)
			f49_arg0.MeritBoard:completeAnimation()
			f49_arg0.MeritBoard:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.MeritBoard)
			f49_arg0.MeritBoardWithMedals:completeAnimation()
			f49_arg0.MeritBoardWithMedals.AAREchelon:completeAnimation()
			f49_arg0.MeritBoardWithMedals:setAlpha(1)
			f49_arg0.MeritBoardWithMedals:setScale(1, 1)
			f49_arg0.MeritBoardWithMedals.AAREchelon:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.MeritBoardWithMedals)
			f49_arg0.Echelon:completeAnimation()
			f49_arg0.Echelon:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.Echelon)
			f49_arg0.ChallengeCoin:completeAnimation()
			f49_arg0.ChallengeCoin:setLeftRight(0, 0, 1564.5, 1764.5)
			f49_arg0.ChallengeCoin:setTopBottom(0, 0, 100, 300)
			f49_arg0.ChallengeCoin:setAlpha(1)
			f49_arg0.ChallengeCoin:setZRot(0)
			f49_arg0.ChallengeCoin:setScale(1, 1)
			f49_arg0.clipFinished(f49_arg0.ChallengeCoin)
		end,
	},
}
CoD.MeritReportWidget.__onClose = function(f50_arg0)
	f50_arg0.MeritOverlayManualHeader:close()
	f50_arg0.XpMeter:close()
	f50_arg0.MeritBoard:close()
	f50_arg0.MeritBoardWithMedals:close()
	f50_arg0.Echelon:close()
	f50_arg0.ChallengeCoin:close()
end
