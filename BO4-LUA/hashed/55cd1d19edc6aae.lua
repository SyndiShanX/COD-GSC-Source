require("x64:f00a10fc8301da2")
require("x64:83191d27680770c")
require("x64:8db0854efb0eb48")
require("x64:9d4a19cc877873b")
require("x64:ce1e6b6549d478c")
require("x64:b1b346e32476a2e")
require("x64:c7e896ee4bc3f8")
require("x64:2675595fa323085")
require("x64:6ee653ade3452f5")
CoD.AARMissionRewardOverlay = InheritFrom(CoD.Menu)
LUI.createMenu.AARMissionRewardOverlay = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AARMissionRewardOverlay", f1_arg0)
	local f1_local1 = self
	CoD.AARUtility.SetupMissionRewardModels(f1_local1, f1_arg0)
	self:setClass(CoD.AARMissionRewardOverlay)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_local1, f1_arg0, 0.5, 0.5, 243, 1003, 0, 0, 299, 799)
	AarMpBacking.Backer:setRGB(0, 0, 0)
	AarMpBacking.Backer:setAlpha(0.5)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
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
	local AmbientCornerR = LUI.UIImage.new(0.5, 0.5, 960, 850, 0, 0, 689, 799)
	AmbientCornerR:setAlpha(0.2)
	AmbientCornerR:setZRot(-180)
	AmbientCornerR:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_ambientcorner"))
	AmbientCornerR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(AmbientCornerR)
	self.AmbientCornerR = AmbientCornerR
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local Placement = CoD.AARMissionReward_PlayerRank.new(f1_local1, f1_arg0, 0.5, 0.5, 67, 803, 0, 0, 497.5, 758.5)
	self:addElement(Placement)
	self.Placement = Placement
	local DirectorDividerWithGradient = CoD.AARMissionReward_CharacterName.new(f1_local1, f1_arg0, 0.5, 0.5, 263, 916, 0, 0, 336.5, 450.5)
	self:addElement(DirectorDividerWithGradient)
	self.DirectorDividerWithGradient = DirectorDividerWithGradient
	local CharacterUnlocked = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 53.5, 104.5)
	CharacterUnlocked:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	CharacterUnlocked:setTTF("ttmussels_regular")
	CharacterUnlocked:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	CharacterUnlocked:setLetterSpacing(12)
	CharacterUnlocked:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(CharacterUnlocked)
	self.CharacterUnlocked = CharacterUnlocked
	local CharacterUnlocks = LUI.UIList.new(f1_local1, f1_arg0, 2, 0, nil, false, false, false, false)
	CharacterUnlocks:setLeftRight(0.5, 0.5, -50, 50)
	CharacterUnlocks:setTopBottom(0, 0, 24, 124)
	CharacterUnlocks:setWidgetType(CoD.AARMissionReward_CharacterListItem)
	CharacterUnlocks:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CharacterUnlocks:setHorizontalCounter(CoD.horizontalCounter)
	CharacterUnlocks:setDataSource("CharacterUnlock")
	LUI.OverrideFunction_CallOriginalFirst(CharacterUnlocks, "setModel", function(element, controller)
		CoD.AARUtility.WarzoneUnlockedCharacterFocusChanged(f1_local1, element, f1_arg0)
	end)
	self:addElement(CharacterUnlocks)
	self.CharacterUnlocks = CharacterUnlocks
	local TrialInfoBannerWidget = CoD.TrialInfoBannerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 243, 947, 0, 0, 811, 846)
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
	TrialInfoBannerWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29D0049BA4C6168A"))
	self:addElement(TrialInfoBannerWidget)
	self.TrialInfoBannerWidget = TrialInfoBannerWidget
	local focusBlocker = nil
	focusBlocker = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0, 1, -59, 59, 0, 0, 24, 124)
	self:addElement(focusBlocker)
	self.focusBlocker = focusBlocker
	DirectorDividerWithGradient:linkToElementModel(CharacterUnlocks, nil, false, function(model)
		DirectorDividerWithGradient:setModel(model, f1_arg0)
	end)
	CharacterUnlocked:linkToElementModel(CharacterUnlocks, "unlockTitle", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CharacterUnlocked:setText(LocalizeToUpperString(f8_local0))
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.AARUtility.CloseMissionRewardOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if IsPC() then
			CoD.AARUtility.CloseMissionRewardOverlay(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	CharacterUnlocks.id = "CharacterUnlocks"
	if CoD.isPC then
		focusBlocker.id = "focusBlocker"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = CharacterUnlocks
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local12 = self
	PlaySoundAlias("uin_wz_aar_char_unlock")
	f1_local12 = focusBlocker
	if IsPC() then
		DisableKeyboardNavigationByElement(f1_local12)
		SetIgnorePlaySoundSetSound(f1_local12, true)
		SetElementProperty(f1_local12, "_yieldFocus")
		SetElementProperty(f1_local12, "__forceCursorTypeNormal", true)
	end
	return self
end
CoD.AARMissionRewardOverlay.__resetProperties = function(f13_arg0)
	f13_arg0.CharacterUnlocked:completeAnimation()
	f13_arg0.DirectorDividerWithGradient:completeAnimation()
	f13_arg0.Placement:completeAnimation()
	f13_arg0.AmbientCornerR:completeAnimation()
	f13_arg0.CharacterUnlocked:setAlpha(1)
	f13_arg0.DirectorDividerWithGradient:setAlpha(1)
	f13_arg0.Placement:setAlpha(1)
	f13_arg0.AmbientCornerR:setAlpha(0.2)
end
CoD.AARMissionRewardOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			local f14_local0 = function(f15_arg0)
				f15_arg0:beginAnimation(200)
				f15_arg0:setAlpha(1)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.AmbientCornerR:beginAnimation(200)
			f14_arg0.AmbientCornerR:setAlpha(0)
			f14_arg0.AmbientCornerR:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
			f14_arg0.AmbientCornerR:registerEventHandler("transition_complete_keyframe", f14_local0)
			local f14_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.Placement:beginAnimation(200)
				f14_arg0.Placement:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Placement:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f14_arg0.Placement:completeAnimation()
			f14_arg0.Placement:setAlpha(0)
			f14_local1(f14_arg0.Placement)
			local f14_local2 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(200)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.DirectorDividerWithGradient:beginAnimation(100)
				f14_arg0.DirectorDividerWithGradient:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.DirectorDividerWithGradient:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f14_arg0.DirectorDividerWithGradient:completeAnimation()
			f14_arg0.DirectorDividerWithGradient:setAlpha(0)
			f14_local2(f14_arg0.DirectorDividerWithGradient)
			local f14_local3 = function(f20_arg0)
				f14_arg0.CharacterUnlocked:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.CharacterUnlocked:setAlpha(1)
				f14_arg0.CharacterUnlocked:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.CharacterUnlocked:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.CharacterUnlocked:completeAnimation()
			f14_arg0.CharacterUnlocked:setAlpha(0)
			f14_local3(f14_arg0.CharacterUnlocked)
		end,
	},
}
CoD.AARMissionRewardOverlay.__onClose = function(f21_arg0)
	f21_arg0.DirectorDividerWithGradient:close()
	f21_arg0.CharacterUnlocked:close()
	f21_arg0.AarMpBacking:close()
	f21_arg0.ScorestreakAspectRatioFix:close()
	f21_arg0.FooterContainerFrontendRight:close()
	f21_arg0.Placement:close()
	f21_arg0.CharacterUnlocks:close()
	f21_arg0.TrialInfoBannerWidget:close()
	f21_arg0.focusBlocker:close()
end
