require("x64:8b53d2ba8e4b74c")
require("x64:330d3ffa470e968")
require("x64:1827e15981384e2")
require("x64:341ce33d59fafd1")
require("x64:78eb499a96d6585")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
CoD.PerkTalentSelect = InheritFrom(CoD.Menu)
LUI.createMenu.PerkTalentSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PerkTalentSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.PerkTalentSelect)
	self.soundSet = "CAC_Gear"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BackgroundSlidePanel = CoD.cac_background_slide_panel_short.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 639, 1261)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local PerkTalentListWidget = CoD.PerkTalentListWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -1100, 1100, 0, 0, 482, 982)
	self:addElement(PerkTalentListWidget)
	self.PerkTalentListWidget = PerkTalentListWidget
	local ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, -740, -240, 0, 0, 489.5, 596.5)
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	local CACHeader = CoD.CACHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.CACUtility.GetHeaderNameForLoadoutSlot(self, @"hash_E2669E63163D964")))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	CACHeader:linkToElementModel(self, nil, false, function(model)
		CACHeader:setModel(model, f1_arg0)
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local SelectedImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -256, 256, 0.25, 0.25, -76.5, 435.5)
	SelectedImage.__Alpha = function()
		SelectedImage:setAlpha(ZeroIfNoSelection(f1_arg0, 0.95))
	end
	SelectedImage.__Alpha()
	SelectedImage:setZoom(40)
	SelectedImage:setScale(0.8, 0.8)
	self:addElement(SelectedImage)
	self.SelectedImage = SelectedImage
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0.5, 0.5, 85, 115)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	ItemInfo:linkToElementModel(PerkTalentListWidget.itemList, nil, false, function(model)
		ItemInfo:setModel(model, f1_arg0)
	end)
	SelectedImage:linkToElementModel(PerkTalentListWidget.itemList, "imageLarge", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			SelectedImage:setImage(CoD.BaseUtility.AlreadyRegistered(f9_local0))
		end
	end)
	local f1_local10 = SelectedImage
	local f1_local11 = SelectedImage.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local11(f1_local10, f1_local12.CACHasSelection, SelectedImage.__Alpha)
	RestrictedText:linkToElementModel(PerkTalentListWidget.itemList, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if not IsPC() then
			PlaySoundAlias("uin_party_ease_slide_back")
			CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
			DelayUnhideFreecursorGoBack(menu, controller, 200)
			return true
		elseif IsPC() then
			PlaySoundAlias("uin_party_ease_slide_back")
			CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "ClosePC")
			DelayGoBack(menu, controller, 70)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.CACUtility.UpdateClassWeaponModel(f1_local1, element, f1_arg0)
		ClearMenuSavedState(f1_local1)
	end)
	PerkTalentListWidget.id = "PerkTalentListWidget"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = PerkTalentListWidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local11 = self
	if not IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	elseif IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "OpenPC", true)
	end
	return self
end
CoD.PerkTalentSelect.__resetProperties = function(f14_arg0, f14_arg1)
	f14_arg0.PerkTalentListWidget:completeAnimation()
	f14_arg0.BackgroundSlidePanel:completeAnimation()
	f14_arg0.SelectedImage:completeAnimation()
	f14_arg0.PerkTalentListWidget:setTopBottom(0, 0, 482, 982)
	f14_arg0.PerkTalentListWidget:setAlpha(1)
	f14_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 639, 1261)
	f14_arg0.BackgroundSlidePanel:setAlpha(1)
	f14_arg0.SelectedImage:setAlpha(ZeroIfNoSelection(f14_arg1, 0.95))
end
CoD.PerkTalentSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties(f15_arg1)
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.PerkTalentListWidget:completeAnimation()
			f15_arg0.PerkTalentListWidget:setTopBottom(0, 0, 1080, 1580)
			f15_arg0.clipFinished(f15_arg0.PerkTalentListWidget)
		end,
		Open = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties(f16_arg1)
			f16_arg0:setupElementClipCounter(2)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f18_arg0:setTopBottom(0, 0, 672, 1294)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.BackgroundSlidePanel:beginAnimation(100)
				f16_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 872, 1494)
				f16_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.BackgroundSlidePanel:completeAnimation()
			f16_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
			f16_arg0.BackgroundSlidePanel:setAlpha(0)
			f16_local0(f16_arg0.BackgroundSlidePanel)
			local f16_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(49, Enum[@"luitween"][@"luitween_ease_both"])
					f20_arg0:setTopBottom(0, 0, 515, 1015)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.PerkTalentListWidget:beginAnimation(200)
				f16_arg0.PerkTalentListWidget:setTopBottom(0, 0, 535, 1035)
				f16_arg0.PerkTalentListWidget:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.PerkTalentListWidget:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f16_arg0.PerkTalentListWidget:completeAnimation()
			f16_arg0.PerkTalentListWidget:setTopBottom(0, 0, 1080, 1580)
			f16_arg0.PerkTalentListWidget:setAlpha(0.01)
			f16_local1(f16_arg0.PerkTalentListWidget)
		end,
		Close = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties(f21_arg1)
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				f21_arg0.BackgroundSlidePanel:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f21_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
				f21_arg0.BackgroundSlidePanel:setAlpha(0)
				f21_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.BackgroundSlidePanel:completeAnimation()
			f21_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
			f21_arg0.BackgroundSlidePanel:setAlpha(1)
			f21_local0(f21_arg0.BackgroundSlidePanel)
			local f21_local1 = function(f23_arg0)
				f21_arg0.PerkTalentListWidget:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f21_arg0.PerkTalentListWidget:setTopBottom(0, 0, 915, 1415)
				f21_arg0.PerkTalentListWidget:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.PerkTalentListWidget:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.PerkTalentListWidget:completeAnimation()
			f21_arg0.PerkTalentListWidget:setTopBottom(0, 0, 515, 1015)
			f21_local1(f21_arg0.PerkTalentListWidget)
			f21_arg0.SelectedImage:completeAnimation()
			f21_arg0.SelectedImage:setAlpha(ZeroIfNoSelection(f21_arg1, 0))
			f21_arg0.clipFinished(f21_arg0.SelectedImage)
		end,
		OpenPC = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties(f24_arg1)
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.BackgroundSlidePanel:beginAnimation(70)
				f24_arg0.BackgroundSlidePanel:setAlpha(1)
				f24_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.BackgroundSlidePanel:completeAnimation()
			f24_arg0.BackgroundSlidePanel:setAlpha(0)
			f24_local0(f24_arg0.BackgroundSlidePanel)
			local f24_local1 = function(f26_arg0)
				f24_arg0.PerkTalentListWidget:beginAnimation(70)
				f24_arg0.PerkTalentListWidget:setAlpha(1)
				f24_arg0.PerkTalentListWidget:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.PerkTalentListWidget:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.PerkTalentListWidget:completeAnimation()
			f24_arg0.PerkTalentListWidget:setAlpha(0)
			f24_local1(f24_arg0.PerkTalentListWidget)
		end,
		ClosePC = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties(f27_arg1)
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.BackgroundSlidePanel:beginAnimation(40)
				f27_arg0.BackgroundSlidePanel:setAlpha(0)
				f27_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.BackgroundSlidePanel:completeAnimation()
			f27_arg0.BackgroundSlidePanel:setAlpha(1)
			f27_local0(f27_arg0.BackgroundSlidePanel)
			local f27_local1 = function(f29_arg0)
				f27_arg0.PerkTalentListWidget:beginAnimation(40)
				f27_arg0.PerkTalentListWidget:setAlpha(0)
				f27_arg0.PerkTalentListWidget:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.PerkTalentListWidget:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.PerkTalentListWidget:completeAnimation()
			f27_arg0.PerkTalentListWidget:setAlpha(1)
			f27_local1(f27_arg0.PerkTalentListWidget)
		end,
	},
}
CoD.PerkTalentSelect.__onClose = function(f30_arg0)
	f30_arg0.ItemInfo:close()
	f30_arg0.SelectedImage:close()
	f30_arg0.RestrictedText:close()
	f30_arg0.BackgroundSlidePanel:close()
	f30_arg0.PerkTalentListWidget:close()
	f30_arg0.CACHeader:close()
	f30_arg0.BackingGrayMediumLeft:close()
	f30_arg0.FooterContainerFrontendRight:close()
end
