require("x64:fa3f15fd69b38b3")
require("x64:4f4ebc58e721a19")
require("x64:228a7baa572b047")
require("x64:724ff42701198ce")
require("x64:c792f6ab57549c1")
require("x64:b9ad3e1e7c33125")
require("x64:19c1945d2e472b0")
require("x64:c7e896ee4bc3f8")
CoD.Challenges_CallingCardProfiler = InheritFrom(LUI.UIElement)
CoD.Challenges_CallingCardProfiler.__defaultWidth = 525
CoD.Challenges_CallingCardProfiler.__defaultHeight = 732
CoD.Challenges_CallingCardProfiler.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.callingCardProfilingType", "default")
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.profilingMasterCallingCard", 0)
	self:setClass(CoD.Challenges_CallingCardProfiler)
	self.id = "Challenges_CallingCardProfiler"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 131)
	CardIcon:linkToElementModel(self, nil, false, function(model)
		CardIcon:setModel(model, f1_arg1)
	end)
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local CTClassifiedOverlay = LUI.UIImage.new(0, 1, -1, 1, 0, 0, 0, 131)
	CTClassifiedOverlay:setRGB(0, 0, 0)
	CTClassifiedOverlay:setAlpha(0)
	CTClassifiedOverlay:setImage(RegisterImage(0x2746D911ABDE62E))
	self:addElement(CTClassifiedOverlay)
	self.CTClassifiedOverlay = CTClassifiedOverlay
	local TierStatus = CoD.StartMenu_Identity_SubTitle.new(f1_arg0, f1_arg1, 0.5, 0.5, -129, 129, 0, 0, 358, 388)
	TierStatus:setAlpha(0)
	TierStatus:linkToElementModel(self, "tierStatus", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TierStatus.SubtitleText:setText(f3_local0)
		end
	end)
	self:addElement(TierStatus)
	self.TierStatus = TierStatus
	local BMGoldBarMed = CoD.BM_GoldBarMed.new(f1_arg0, f1_arg1, 0, 0, 4, 522, 0, 0, 49, 94)
	BMGoldBarMed:setAlpha(0)
	self:addElement(BMGoldBarMed)
	self.BMGoldBarMed = BMGoldBarMed
	local blackMarketBrandIcon = LUI.UIImage.new(0.5, 0.5, -54, 49, 0, 0, 18, 121)
	blackMarketBrandIcon:setAlpha(0)
	blackMarketBrandIcon:setImage(RegisterImage(0x67440195ABD2B8C))
	self:addElement(blackMarketBrandIcon)
	self.blackMarketBrandIcon = blackMarketBrandIcon
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0.03, 0.97, 1, -1, 0, 0.03, 296, 294)
	DotTiledBacking:setAlpha(0.15)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local ProgressBarBase = LUI.UIImage.new(0.5, 0.5, -247.5, 247.5, 0, 0, 295, 318)
	ProgressBarBase:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ProgressBarBase:setAlpha(0.02)
	self:addElement(ProgressBarBase)
	self.ProgressBarBase = ProgressBarBase
	local ProgressBarBoarder = LUI.UIImage.new(0.5, 0.5, -247.5, 247.5, 0, 0, 294, 317)
	ProgressBarBoarder:setAlpha(0.1)
	ProgressBarBoarder:setImage(RegisterImage(0x185E11D74ECA3D7))
	ProgressBarBoarder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ProgressBarBoarder:setShaderVector(0, 0, 0, 0, 0)
	ProgressBarBoarder:setupNineSliceShader(12, 12)
	self:addElement(ProgressBarBoarder)
	self.ProgressBarBoarder = ProgressBarBoarder
	local ProgressBar = LUI.UIImage.new(0.03, 0.97, 1, -1, 0, 0.03, 296, 294)
	ProgressBar:setRGB(1, 0.36, 0)
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	ProgressBar:linkToElementModel(self, "percentComplete", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local ProgressFraction = LUI.UIText.new(1, 1, -58, -19, 0, 0, 298, 316)
	ProgressFraction:setTTF("default")
	ProgressFraction:setLetterSpacing(2)
	ProgressFraction:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ProgressFraction:linkToElementModel(self, "statFractionText", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ProgressFraction:setText(f5_local0)
		end
	end)
	self:addElement(ProgressFraction)
	self.ProgressFraction = ProgressFraction
	local TierList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	TierList:setLeftRight(0.5, 0.5, -135, 135)
	TierList:setTopBottom(0, 0, 474, 588)
	TierList:setWidgetType(CoD.Challenges_TierIcon)
	TierList:setHorizontalCount(5)
	TierList:setSpacing(0)
	TierList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TierList:setDataSource("TierIconList")
	self:addElement(TierList)
	self.TierList = TierList
	local TierNumber = LUI.UIText.new(0.5, 0.5, -129, 129, 0, 0, 442, 466)
	TierNumber:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TierNumber:setTTF("ttmussels_regular")
	TierNumber:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TierNumber:linkToElementModel(self, "tierStatus", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TierNumber:setText(ConvertToUpperString(f6_local0))
		end
	end)
	self:addElement(TierNumber)
	self.TierNumber = TierNumber
	local FrameBorder = LUI.UIImage.new(0.5, 0.5, -114.5, 115.5, 0, 0, 474, 528)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local ChallengeName = LUI.UIText.new(0, 0, 15, 510, 0, 0, 152.5, 185.5)
	ChallengeName:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ChallengeName:setTTF("ttmussels_regular")
	ChallengeName:setLetterSpacing(2)
	ChallengeName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ChallengeName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ChallengeName:linkToElementModel(self, "title", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ChallengeName:setText(ConvertToUpperString(f7_local0))
		end
	end)
	self:addElement(ChallengeName)
	self.ChallengeName = ChallengeName
	local ChallengeDescription = LUI.UIText.new(0, 1, 18, -18, 0, 0, 206, 224)
	ChallengeDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ChallengeDescription:setTTF("dinnext_regular")
	ChallengeDescription:setLetterSpacing(0.5)
	ChallengeDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ChallengeDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ChallengeDescription:linkToElementModel(self, "description", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ChallengeDescription:setText(f8_local0)
		end
	end)
	self:addElement(ChallengeDescription)
	self.ChallengeDescription = ChallengeDescription
	local LockedIcon = CoD.Challenges_ProfilerLock.new(f1_arg0, f1_arg1, 0.5, 0.5, -117.5, 117.5, 0, 0, 42, 87)
	LockedIcon:linkToElementModel(self, nil, false, function(model)
		LockedIcon:setModel(model, f1_arg1)
	end)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local TrialWidget = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -257.5, 257.5, 1, 1, -40, -5)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "trialLocked")
			end,
		},
	})
	TrialWidget:linkToElementModel(TrialWidget, "trialLocked", true, function(model)
		f1_arg0:updateElementState(TrialWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	TrialWidget:setAlpha(0)
	TrialWidget:linkToElementModel(self, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg1)
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	local XP = CoD.CallingCardProfilerXP.new(f1_arg0, f1_arg1, 0, 0, 183.5, 341.5, 0, 0, 473, 527)
	XP:setAlpha(0)
	XP:linkToElementModel(self, nil, false, function(model)
		XP:setModel(model, f1_arg1)
	end)
	self:addElement(XP)
	self.XP = XP
	self:mergeStateConditions({
		{
			stateName = "CTClassified",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.callingCardProfilingType", "ct") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "BMClassfied",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBMClassified")
			end,
		},
		{
			stateName = "LockedPrestige",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked") and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.callingCardProfilingType", "prestige")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked") and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "maxTier", 0)
			end,
		},
		{
			stateName = "LockedOneTierNoXP",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked") and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "xp", 0)
			end,
		},
		{
			stateName = "LockedOneTier",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
	})
	local f1_local19 = self
	local f1_local20 = self.subscribeToModel
	local f1_local21 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local20(f1_local19, f1_local21["hudItems.callingCardProfilingType"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "hudItems.callingCardProfilingType",
		})
	end, false)
	self:linkToElementModel(self, "isLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	self:linkToElementModel(self, "isBMClassified", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBMClassified",
		})
	end)
	self:linkToElementModel(self, "maxTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "maxTier",
		})
	end)
	self:linkToElementModel(self, "xp", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xp",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		UpdateDataSource(self, self.TierList, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.ChallengesUtility.ClearTierListDatasource(self)
	end)
	CardIcon.id = "CardIcon"
	TierList.id = "TierList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local20 = self
	CoD.ChallengesUtility.SetupTierListDatasource(self)
	return self
end
CoD.Challenges_CallingCardProfiler.__resetProperties = function(f27_arg0)
	f27_arg0.ProgressBar:completeAnimation()
	f27_arg0.TierList:completeAnimation()
	f27_arg0.TierStatus:completeAnimation()
	f27_arg0.ProgressFraction:completeAnimation()
	f27_arg0.ProgressBarBoarder:completeAnimation()
	f27_arg0.FrameBorder:completeAnimation()
	f27_arg0.TierNumber:completeAnimation()
	f27_arg0.ProgressBarBase:completeAnimation()
	f27_arg0.DotTiledBacking:completeAnimation()
	f27_arg0.LockedIcon:completeAnimation()
	f27_arg0.TrialWidget:completeAnimation()
	f27_arg0.CardIcon:completeAnimation()
	f27_arg0.CTClassifiedOverlay:completeAnimation()
	f27_arg0.blackMarketBrandIcon:completeAnimation()
	f27_arg0.BMGoldBarMed:completeAnimation()
	f27_arg0.XP:completeAnimation()
	f27_arg0.ProgressBar:setAlpha(1)
	f27_arg0.TierList:setAlpha(1)
	f27_arg0.TierStatus:setLeftRight(0.5, 0.5, -129, 129)
	f27_arg0.TierStatus:setTopBottom(0, 0, 358, 388)
	f27_arg0.TierStatus:setAlpha(0)
	f27_arg0.ProgressFraction:setAlpha(1)
	f27_arg0.ProgressBarBoarder:setAlpha(0.1)
	f27_arg0.FrameBorder:setAlpha(0.15)
	f27_arg0.TierNumber:setAlpha(1)
	f27_arg0.ProgressBarBase:setAlpha(0.02)
	f27_arg0.DotTiledBacking:setAlpha(0.15)
	f27_arg0.LockedIcon:setAlpha(1)
	f27_arg0.TrialWidget:setAlpha(0)
	f27_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0x62486486346EC3F))
	f27_arg0.CardIcon:setAlpha(1)
	f27_arg0.CTClassifiedOverlay:setRGB(0, 0, 0)
	f27_arg0.CTClassifiedOverlay:setAlpha(0)
	f27_arg0.blackMarketBrandIcon:setLeftRight(0.5, 0.5, -54, 49)
	f27_arg0.blackMarketBrandIcon:setTopBottom(0, 0, 18, 121)
	f27_arg0.blackMarketBrandIcon:setAlpha(0)
	f27_arg0.BMGoldBarMed:setLeftRight(0, 0, 4, 522)
	f27_arg0.BMGoldBarMed:setTopBottom(0, 0, 49, 94)
	f27_arg0.BMGoldBarMed:setAlpha(0)
	f27_arg0.XP:setAlpha(0)
end
CoD.Challenges_CallingCardProfiler.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(11)
			f28_arg0.TierStatus:completeAnimation()
			f28_arg0.TierStatus:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.TierStatus)
			f28_arg0.DotTiledBacking:completeAnimation()
			f28_arg0.DotTiledBacking:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.DotTiledBacking)
			f28_arg0.ProgressBarBase:completeAnimation()
			f28_arg0.ProgressBarBase:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ProgressBarBase)
			f28_arg0.ProgressBarBoarder:completeAnimation()
			f28_arg0.ProgressBarBoarder:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ProgressBarBoarder)
			f28_arg0.ProgressBar:completeAnimation()
			f28_arg0.ProgressBar:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ProgressBar)
			f28_arg0.ProgressFraction:completeAnimation()
			f28_arg0.ProgressFraction:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ProgressFraction)
			f28_arg0.TierList:completeAnimation()
			f28_arg0.TierList:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.TierList)
			f28_arg0.TierNumber:completeAnimation()
			f28_arg0.TierNumber:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.TierNumber)
			f28_arg0.FrameBorder:completeAnimation()
			f28_arg0.FrameBorder:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.FrameBorder)
			f28_arg0.LockedIcon:completeAnimation()
			f28_arg0.LockedIcon:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.LockedIcon)
			f28_arg0.TrialWidget:completeAnimation()
			f28_arg0.TrialWidget:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.TrialWidget)
		end,
	},
	CTClassified = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(8)
			f29_arg0.CardIcon:completeAnimation()
			f29_arg0.CardIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.CardIcon)
			f29_arg0.CTClassifiedOverlay:completeAnimation()
			f29_arg0.CTClassifiedOverlay:setRGB(1, 1, 1)
			f29_arg0.CTClassifiedOverlay:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.CTClassifiedOverlay)
			f29_arg0.TierStatus:completeAnimation()
			f29_arg0.TierStatus:setLeftRight(0.5, 0.5, 24, 201)
			f29_arg0.TierStatus:setTopBottom(0, 0, 338, 377)
			f29_arg0.TierStatus:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.TierStatus)
			f29_arg0.TierList:completeAnimation()
			f29_arg0.TierList:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.TierList)
			f29_arg0.TierNumber:completeAnimation()
			f29_arg0.TierNumber:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.TierNumber)
			f29_arg0.FrameBorder:completeAnimation()
			f29_arg0.FrameBorder:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.FrameBorder)
			f29_arg0.LockedIcon:completeAnimation()
			f29_arg0.LockedIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.LockedIcon)
			f29_arg0.TrialWidget:completeAnimation()
			f29_arg0.TrialWidget.InfoText:completeAnimation()
			f29_arg0.TrialWidget:setAlpha(1)
			f29_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0xB98899150D5FB25))
			f29_arg0.clipFinished(f29_arg0.TrialWidget)
		end,
	},
	BMClassfied = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(11)
			f30_arg0.CardIcon:completeAnimation()
			f30_arg0.CardIcon:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.CardIcon)
			f30_arg0.TierStatus:completeAnimation()
			f30_arg0.TierStatus:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TierStatus)
			f30_arg0.BMGoldBarMed:completeAnimation()
			f30_arg0.BMGoldBarMed:setLeftRight(0, 0, 23.5, 500.5)
			f30_arg0.BMGoldBarMed:setTopBottom(0, 0, 48, 93)
			f30_arg0.BMGoldBarMed:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.BMGoldBarMed)
			f30_arg0.blackMarketBrandIcon:completeAnimation()
			f30_arg0.blackMarketBrandIcon:setLeftRight(0.5, 0.5, -43, 54)
			f30_arg0.blackMarketBrandIcon:setTopBottom(0, 0, 21, 118)
			f30_arg0.blackMarketBrandIcon:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.blackMarketBrandIcon)
			f30_arg0.ProgressBar:completeAnimation()
			f30_arg0.ProgressBar:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ProgressBar)
			f30_arg0.ProgressFraction:completeAnimation()
			f30_arg0.ProgressFraction:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ProgressFraction)
			f30_arg0.TierList:completeAnimation()
			f30_arg0.TierList:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TierList)
			f30_arg0.TierNumber:completeAnimation()
			f30_arg0.TierNumber:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TierNumber)
			f30_arg0.FrameBorder:completeAnimation()
			f30_arg0.FrameBorder:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.FrameBorder)
			f30_arg0.LockedIcon:completeAnimation()
			f30_arg0.LockedIcon:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.LockedIcon)
			f30_arg0.TrialWidget:completeAnimation()
			f30_arg0.TrialWidget.InfoText:completeAnimation()
			f30_arg0.TrialWidget:setAlpha(1)
			f30_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0xB98899150D5FB25))
			f30_arg0.clipFinished(f30_arg0.TrialWidget)
		end,
	},
	LockedPrestige = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(10)
			f31_arg0.TierStatus:completeAnimation()
			f31_arg0.TierStatus:setLeftRight(0.5, 0.5, 24, 201)
			f31_arg0.TierStatus:setTopBottom(0, 0, 338, 377)
			f31_arg0.TierStatus:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TierStatus)
			f31_arg0.DotTiledBacking:completeAnimation()
			f31_arg0.DotTiledBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.DotTiledBacking)
			f31_arg0.ProgressBarBase:completeAnimation()
			f31_arg0.ProgressBarBase:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ProgressBarBase)
			f31_arg0.ProgressBarBoarder:completeAnimation()
			f31_arg0.ProgressBarBoarder:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ProgressBarBoarder)
			f31_arg0.ProgressBar:completeAnimation()
			f31_arg0.ProgressBar:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ProgressBar)
			f31_arg0.ProgressFraction:completeAnimation()
			f31_arg0.ProgressFraction:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ProgressFraction)
			f31_arg0.TierList:completeAnimation()
			f31_arg0.TierList:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TierList)
			f31_arg0.TierNumber:completeAnimation()
			f31_arg0.TierNumber:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TierNumber)
			f31_arg0.FrameBorder:completeAnimation()
			f31_arg0.FrameBorder:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.FrameBorder)
			f31_arg0.TrialWidget:completeAnimation()
			f31_arg0.TrialWidget.InfoText:completeAnimation()
			f31_arg0.TrialWidget:setAlpha(1)
			f31_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0xB98899150D5FB25))
			f31_arg0.clipFinished(f31_arg0.TrialWidget)
		end,
	},
	Locked = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.FrameBorder:completeAnimation()
			f32_arg0.FrameBorder:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.FrameBorder)
			f32_arg0.TrialWidget:completeAnimation()
			f32_arg0.TrialWidget.InfoText:completeAnimation()
			f32_arg0.TrialWidget:setAlpha(1)
			f32_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0xB98899150D5FB25))
			f32_arg0.clipFinished(f32_arg0.TrialWidget)
		end,
	},
	LockedOneTierNoXP = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(5)
			f33_arg0.TierStatus:completeAnimation()
			f33_arg0.TierStatus:setLeftRight(0.5, 0.5, 24, 201)
			f33_arg0.TierStatus:setTopBottom(0, 0, 338, 377)
			f33_arg0.TierStatus:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.TierStatus)
			f33_arg0.TierList:completeAnimation()
			f33_arg0.TierList:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.TierList)
			f33_arg0.FrameBorder:completeAnimation()
			f33_arg0.FrameBorder:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.FrameBorder)
			f33_arg0.TrialWidget:completeAnimation()
			f33_arg0.TrialWidget.InfoText:completeAnimation()
			f33_arg0.TrialWidget:setAlpha(1)
			f33_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0xB98899150D5FB25))
			f33_arg0.clipFinished(f33_arg0.TrialWidget)
			f33_arg0.XP:completeAnimation()
			f33_arg0.XP:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.XP)
		end,
	},
	LockedOneTier = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(4)
			f34_arg0.TierStatus:completeAnimation()
			f34_arg0.TierStatus:setLeftRight(0.5, 0.5, 24, 201)
			f34_arg0.TierStatus:setTopBottom(0, 0, 338, 377)
			f34_arg0.TierStatus:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.TierStatus)
			f34_arg0.TierList:completeAnimation()
			f34_arg0.TierList:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.TierList)
			f34_arg0.TrialWidget:completeAnimation()
			f34_arg0.TrialWidget.InfoText:completeAnimation()
			f34_arg0.TrialWidget:setAlpha(1)
			f34_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0xB98899150D5FB25))
			f34_arg0.clipFinished(f34_arg0.TrialWidget)
			f34_arg0.XP:completeAnimation()
			f34_arg0.XP:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.XP)
		end,
	},
}
CoD.Challenges_CallingCardProfiler.__onClose = function(f35_arg0)
	f35_arg0.CardIcon:close()
	f35_arg0.TierStatus:close()
	f35_arg0.BMGoldBarMed:close()
	f35_arg0.DotTiledBacking:close()
	f35_arg0.ProgressBar:close()
	f35_arg0.ProgressFraction:close()
	f35_arg0.TierList:close()
	f35_arg0.TierNumber:close()
	f35_arg0.ChallengeName:close()
	f35_arg0.ChallengeDescription:close()
	f35_arg0.LockedIcon:close()
	f35_arg0.TrialWidget:close()
	f35_arg0.XP:close()
end
