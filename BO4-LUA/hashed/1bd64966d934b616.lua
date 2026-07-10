require("x64:ca5faac82324b65")
require("x64:af2dff4ae61e4b5")
require("x64:c96de52191fe142")
require("x64:50b038c79ef8c66")
require("x64:4a5097aa463512f")
require("x64:64d08790fc84eef")
require("x64:3ab95527d1d578")
require("x64:2d64ca9d3c705ce")
require("x64:ce1e6b6549d478c")
require("x64:43a18b0c952dcc0")
require("x64:c9a3c9eb5d5ac59")
require("x64:c7e896ee4bc3f8")
CoD.AARTierReward = InheritFrom(CoD.Menu)
LUI.createMenu.AARTierReward = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AARTierReward", f1_arg0)
	local f1_local1 = self
	CoD.AARUtility.SetupTierRewardModels(f1_local1, f1_arg0)
	CoD.BlackMarketUtility.UpdateAllRngUnlockedModel(f1_arg0)
	self:setClass(CoD.AARTierReward)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local EmptySlots = CoD.AARTierRewardSlotEmptyContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -842.5, 842.5, 0, 0, 170, 801)
	EmptySlots:setAlpha(0)
	self:addElement(EmptySlots)
	self.EmptySlots = EmptySlots
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_local1, f1_arg0, 0.5, 0.5, -851, 851, 0, 0, 122, 850)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local DottedLineBtm = LUI.UIImage.new(0.5, 0.5, -832, 832, 0, 0, 831, 835)
	DottedLineBtm:setAlpha(0.35)
	DottedLineBtm:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DottedLineBtm:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DottedLineBtm:setShaderVector(0, 0, 0, 0, 0)
	DottedLineBtm:setupNineSliceShader(16, 4)
	self:addElement(DottedLineBtm)
	self.DottedLineBtm = DottedLineBtm
	local DottedLineTop = LUI.UIImage.new(0.5, 0.5, -832, 832, 0, 0, 137, 141)
	DottedLineTop:setAlpha(0.35)
	DottedLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DottedLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DottedLineTop:setShaderVector(0, 0, 0, 0, 0)
	DottedLineTop:setupNineSliceShader(16, 4)
	self:addElement(DottedLineTop)
	self.DottedLineTop = DottedLineTop
	local NoiseTiledBackingLeft = LUI.UIImage.new(0.5, 0.5, -818, -566, 0.5, 0.5, -393.5, 269.5)
	NoiseTiledBackingLeft:setAlpha(0.4)
	NoiseTiledBackingLeft:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBackingLeft:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingLeft:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingLeft)
	self.NoiseTiledBackingLeft = NoiseTiledBackingLeft
	local NoiseTiledBackingRight = LUI.UIImage.new(0.5, 0.5, -544, 825, 0.5, 0.5, -393.5, 269.5)
	NoiseTiledBackingRight:setAlpha(0.4)
	NoiseTiledBackingRight:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBackingRight:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingRight:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingRight)
	self.NoiseTiledBackingRight = NoiseTiledBackingRight
	local TierBar = CoD.AARTierBar.new(f1_local1, f1_arg0, 0.5, 0.5, -675, 675, 1, 1, -143, -123)
	TierBar:subscribeToGlobalModel(f1_arg0, "AARTierReward", nil, function(model)
		TierBar:setModel(model, f1_arg0)
	end)
	TierBar:subscribeToGlobalModel(f1_arg0, "AARTierReward", "earnedBarProgress", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TierBar.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	TierBar:subscribeToGlobalModel(f1_arg0, "AARTierReward", "earnedBarProgress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TierBar.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	TierBar:subscribeToGlobalModel(f1_arg0, "AARTierReward", "earnedBarProgress", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TierBar.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	TierBar:subscribeToGlobalModel(f1_arg0, "AARTierReward", "previousBarProgress", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TierBar.PreviousXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	TierBar:subscribeToGlobalModel(f1_arg0, "AARTierReward", "previousBarProgress", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			TierBar.PreviousXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	TierBar:subscribeToGlobalModel(f1_arg0, "AARTierReward", "previousBarProgress", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			TierBar.PreviousXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	TierBar:linkToElementModel(self, "barCurrentTier", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			TierBar.CurrentTier:setText(LocalizeStringWithParameter(@"hash_1E743A7E5D0C37CD", f9_local0))
		end
	end)
	TierBar:linkToElementModel(self, "barNextTier", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			TierBar.NextTier:setText(LocalizeStringWithParameter(@"hash_1E743A7E5D0C37CD", f10_local0))
		end
	end)
	self:addElement(TierBar)
	self.TierBar = TierBar
	local ThinBarBG = LUI.UIImage.new(0.5, 0.5, -802, -584, 0, 0, 158, 159)
	ThinBarBG:setRGB(0.88, 0.9, 0.79)
	ThinBarBG:setAlpha(0.4)
	self:addElement(ThinBarBG)
	self.ThinBarBG = ThinBarBG
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f11_local0 = nil
		if element.menuLoaded then
			f11_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f11_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f11_local0 then
			f11_local0 = element:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CurrentTier = CoD.AARTierRewardColumn.new(f1_local1, f1_arg0, 0.5, 0.5, -808.5, -693.5, 0, 0, 162, 794)
	CurrentTier:subscribeToGlobalModel(f1_arg0, "AARTierReward", "currentTier", function(model)
		CurrentTier:setModel(model, f1_arg0)
	end)
	self:addElement(CurrentTier)
	self.CurrentTier = CurrentTier
	local NextTier = CoD.AARTierRewardColumn.new(f1_local1, f1_arg0, 0.5, 0.5, -693.5, -578.5, 0, 0, 162, 794)
	NextTier:subscribeToGlobalModel(f1_arg0, "AARTierReward", "nextTier", function(model)
		NextTier:setModel(model, f1_arg0)
	end)
	self:addElement(NextTier)
	self.NextTier = NextTier
	local ShowcaseList = LUI.UIList.new(f1_local1, f1_arg0, 30, 0, nil, false, false, false, false)
	ShowcaseList:setLeftRight(0.5, 0.5, -525.5, 804.5)
	ShowcaseList:setTopBottom(0, 0, 163.5, 794.5)
	ShowcaseList:setWidgetType(CoD.AARTierRewardShowcase)
	ShowcaseList:setHorizontalCount(4)
	ShowcaseList:setSpacing(30)
	ShowcaseList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ShowcaseList:subscribeToGlobalModel(f1_arg0, "AARTierReward", "showcaseDataSource", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			ShowcaseList:setDataSource(f14_local0)
		end
	end)
	ShowcaseList:subscribeToGlobalModel(f1_arg0, "AARTierReward", "currentTier.triggerUnlock", function(model)
		local f15_local0 = ShowcaseList
		if CoD.ModelUtility.IsModelValueTrue(f1_arg0, "AAR.tierReward.currentTier.triggerUnlock") then
			CoD.AARUtility.UnlockTierRewardShowcase(f1_arg0, f15_local0)
		end
	end)
	ShowcaseList:subscribeToGlobalModel(f1_arg0, "AARTierReward", "currentTier.tier", function(model)
		CoD.AARUtility.UnlockTierRewardShowcase(f1_arg0, ShowcaseList)
	end)
	ShowcaseList:subscribeToGlobalModel(f1_arg0, "AARTierReward", "lootCaseEarned", function(model)
		local f17_local0 = ShowcaseList
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg0, "AARTierReward", "lootCaseEarned") then
			CoD.AARUtility.UnlockTierRewardShowcase(f1_arg0, f17_local0)
		end
	end)
	self:addElement(ShowcaseList)
	self.ShowcaseList = ShowcaseList
	local Title = CoD.AARTierRewardTitle.new(f1_local1, f1_arg0, 0.5, 0.5, -729, 71, 0, 0, 75, 125)
	self:addElement(Title)
	self.Title = Title
	local CommonSearchingBar = CoD.CommonSearchingBar.new(f1_local1, f1_arg0, 0.5, 0.5, 774, 896, 0, 0, 113, 135)
	CommonSearchingBar:setAlpha(0.5)
	CommonSearchingBar:setScale(0.5, 0.5)
	self:addElement(CommonSearchingBar)
	self.CommonSearchingBar = CommonSearchingBar
	local DupeMeter = CoD.DupeMeter.new(f1_local1, f1_arg0, 0.5, 0.5, -818, -452, 1, 1, -230, -196)
	self:addElement(DupeMeter)
	self.DupeMeter = DupeMeter
	local BlackMarketIcon = LUI.UIImage.new(0.5, 0.5, -840, -740, 0, 0, 35, 135)
	BlackMarketIcon:setImage(RegisterImage(@"ui_icon_blackmarket_lockskull_256"))
	self:addElement(BlackMarketIcon)
	self.BlackMarketIcon = BlackMarketIcon
	local Rewards = LUI.UIText.new(0.5, 0.5, -728, -266, 0, 0, 54, 74)
	Rewards:setRGB(0.86, 0.74, 0.25)
	Rewards:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/black_market"))
	Rewards:setTTF("ttmussels_regular")
	Rewards:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Rewards:setShaderVector(0, 0.77, 0, 0, 0)
	Rewards:setShaderVector(1, 0, 0, 0, 0)
	Rewards:setShaderVector(2, 1, 0.31, 0, 0.3)
	Rewards:setLetterSpacing(8)
	Rewards:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Rewards:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Rewards)
	self.Rewards = Rewards
	local AARTierSkipNotification = CoD.AARTierSkipNotification.new(f1_local1, f1_arg0, 0.5, 0.5, 11.5, 269.5, 0, 0, 850, 930)
	AARTierSkipNotification:subscribeToGlobalModel(f1_arg0, "AARTierReward", nil, function(model)
		AARTierSkipNotification:setModel(model, f1_arg0)
	end)
	self:addElement(AARTierSkipNotification)
	self.AARTierSkipNotification = AARTierSkipNotification
	local TrialInfoBannerWidget = CoD.TrialInfoBannerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -723, 0, 0.5, 0.5, 425, 460)
	TrialInfoBannerWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
		{
			stateName = "ShownLarge",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysTrue()
			end,
		},
	})
	TrialInfoBannerWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6C0FFDDCA009994B"))
	self:addElement(TrialInfoBannerWidget)
	self.TrialInfoBannerWidget = TrialInfoBannerWidget
	local LootCaseMeter = CoD.AARTierRewardLootCaseMeter.new(f1_local1, f1_arg0, 0.5, 0.5, 700, 850, 0, 0, 10, 160)
	LootCaseMeter:setScale(0.7, 0.7)
	LootCaseMeter:subscribeToGlobalModel(f1_arg0, "AARTierReward", "lootCaseProgress", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			LootCaseMeter.CurrentProgressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4))
		end
	end)
	LootCaseMeter:subscribeToGlobalModel(f1_arg0, "AARTierReward", "previousLootCaseProgress", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			LootCaseMeter.PreviousProgressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f22_local0, 1), CoD.GetVectorComponentFromString(f22_local0, 2), CoD.GetVectorComponentFromString(f22_local0, 3), CoD.GetVectorComponentFromString(f22_local0, 4))
		end
	end)
	LootCaseMeter:subscribeToGlobalModel(f1_arg0, "AARTierReward", "lootCaseCount", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			LootCaseMeter.CaseCount:setText(f23_local0)
		end
	end)
	LootCaseMeter:subscribeToGlobalModel(f1_arg0, "AARTierReward", "lootCaseEarned", function(model)
		local f24_local0 = LootCaseMeter
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg0, "AARTierReward", "lootCaseEarned") then
			PlayClipOnElement(self, {
				elementName = "LootCaseMeter",
				clipName = "GetCase",
			}, f1_arg0)
		end
	end)
	self:addElement(LootCaseMeter)
	self.LootCaseMeter = LootCaseMeter
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.AARUtility.CloseTierRewardOverlay(menu, controller)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "ui_confirm")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsPC() then
			CoD.AARUtility.CloseTierRewardOverlay(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "AARTierReward", "allAnimationsFinished", function(model)
		local f29_local0 = self
		if CoD.ModelUtility.IsModelValueTrue(f1_arg0, "AAR.tierReward.allAnimationsFinished") then
			CoD.AARUtility.SetShowcaseInputState(self, f1_arg0)
			CoD.AARUtility.SetShowcaseInputState(self.ShowcaseList, f1_arg0)
			CoD.AARUtility.AddHorizontalCounterToList(self.ShowcaseList, f1_arg0)
		end
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	CurrentTier.id = "CurrentTier"
	NextTier.id = "NextTier"
	ShowcaseList.id = "ShowcaseList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ShowcaseList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local24 = self
	SetMenuProperty(f1_local1, "m_disableNavigation", true)
	SetElementProperty(self.ShowcaseList, "m_disableNavigation", true)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "hasAnimatedLootCaseProgress", true)
	return self
end
CoD.AARTierReward.__onClose = function(f30_arg0)
	f30_arg0.EmptySlots:close()
	f30_arg0.FramingCornerBrackets:close()
	f30_arg0.TierBar:close()
	f30_arg0.FooterContainerFrontendRight:close()
	f30_arg0.CurrentTier:close()
	f30_arg0.NextTier:close()
	f30_arg0.ShowcaseList:close()
	f30_arg0.Title:close()
	f30_arg0.CommonSearchingBar:close()
	f30_arg0.DupeMeter:close()
	f30_arg0.AARTierSkipNotification:close()
	f30_arg0.TrialInfoBannerWidget:close()
	f30_arg0.LootCaseMeter:close()
end
