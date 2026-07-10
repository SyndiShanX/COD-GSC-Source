require("x64:f792a7ef58d5981")
require("x64:1827e15981384e2")
require("x64:81ed9d78c1f64c5")
require("x64:45111f049e24a81")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:ba5fa76d22ca8fe")
require("x64:6ee653ade3452f5")
require("x64:75e2a524b093c12")
CoD.Armory = InheritFrom(CoD.Menu)
LUI.createMenu.Armory = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Armory", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	SetControllerModelValue(f1_arg0, "Unlockables.listUpdate", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "CustomClassList.equippedItemsChanged", false)
	SetMenuProperty(f1_local1, "__ignoreUnlockablesDefaultSelectIndex", true)
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "VariantListShownUpdate")
	self:setClass(CoD.Armory)
	self.soundSet = "CAC_PrimaryWeapon"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
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
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 146, 646)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackgroundSlidePanel = CoD.cac_background_slide_panel.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 672, 1294)
	BackgroundSlidePanel:setZoom(70)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local CACHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/armory"))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	CACHeader:linkToElementModel(self, nil, false, function(model)
		CACHeader:setModel(model, f1_arg0)
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, -792, -292, 0, 0, 451.5, 558.5)
	ItemInfo:mergeStateConditions({
		{
			stateName = "Zombie",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	local WeaponLevel = CoD.ItemWeaponLevel.new(f1_local1, f1_arg0, 0.5, 0.5, -790, 790, 0, 0, 650, 662)
	self:addElement(WeaponLevel)
	self.WeaponLevel = WeaponLevel
	local WeaponAttributes = CoD.WeaponAttributes.new(f1_local1, f1_arg0, 0.5, 0.5, 450, 895, 0, 0, 425, 675)
	WeaponAttributes:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return MenuPropertyIsTrue(menu, "_showWeaponVariantList")
			end,
		},
	})
	WeaponAttributes:setZoom(85)
	self:addElement(WeaponAttributes)
	self.WeaponAttributes = WeaponAttributes
	local WeaponListWidget = CoD.Armory_WeaponListWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 673, 1163)
	self:addElement(WeaponListWidget)
	self.WeaponListWidget = WeaponListWidget
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f8_local0 = nil
		if element.menuLoaded then
			f8_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f8_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local TopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	TopBar:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(TopBar)
	self.TopBar = TopBar
	WeaponLevel:linkToElementModel(WeaponListWidget.weaponList, nil, false, function(model)
		WeaponLevel:setModel(model, f1_arg0)
	end)
	WeaponAttributes:linkToElementModel(WeaponListWidget.weaponList, "weaponAttributes", false, function(model)
		WeaponAttributes:setModel(model, f1_arg0)
	end)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f12_local0 = nil
		if self.OcclusionChange then
			f12_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f12_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
		else
			MenuHidesFreeCursor(f1_local1, f1_arg0)
		end
		if not f12_local0 then
			f12_local0 = self:dispatchEventToChildren(event)
		end
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if MenuPropertyIsTrue(menu, "_showWeaponVariantList") and IsPC() then
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			return true
		else
			PlaySoundAlias("uin_party_ease_slide_back")
			CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
			SaveLoadoutGeneric(controller)
			DelayGoBack(menu, controller, 200)
			CoD.LobbyUtility.SetMenuControllerRestriction(self, controller, 0)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.CACUtility.UpdateClassWeaponModel(f1_local1, element, f1_arg0)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "VariantListShownUpdate", function(model)
		local f16_local0 = self
		UpdateElementState(self, "WeaponAttributes", f1_arg0)
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	WeaponListWidget.id = "WeaponListWidget"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = WeaponListWidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local12 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", false)
	CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 1)
	CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg0, "ZMArmoryIntroduction")
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.Armory.__resetProperties = function(f17_arg0)
	f17_arg0.WeaponListWidget:completeAnimation()
	f17_arg0.BackgroundSlidePanel:completeAnimation()
	f17_arg0.WeaponListWidget:setTopBottom(0, 0, 673, 1163)
	f17_arg0.WeaponListWidget:setAlpha(1)
	f17_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
	f17_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.Armory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.BackgroundSlidePanel:completeAnimation()
			f18_arg0.BackgroundSlidePanel:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.BackgroundSlidePanel)
			f18_arg0.WeaponListWidget:completeAnimation()
			f18_arg0.WeaponListWidget:setTopBottom(0, 0, 1080, 1570)
			f18_arg0.clipFinished(f18_arg0.WeaponListWidget)
		end,
		Open = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f21_arg0:setTopBottom(0, 0, 672, 1294)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.BackgroundSlidePanel:beginAnimation(100)
				f19_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 872, 1494)
				f19_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.BackgroundSlidePanel:completeAnimation()
			f19_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
			f19_arg0.BackgroundSlidePanel:setAlpha(0)
			f19_local0(f19_arg0.BackgroundSlidePanel)
			local f19_local1 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(49)
					f23_arg0:setTopBottom(0, 0, 680, 1170)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.WeaponListWidget:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f19_arg0.WeaponListWidget:setTopBottom(0, 0, 700, 1190)
				f19_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f19_arg0.WeaponListWidget:completeAnimation()
			f19_arg0.WeaponListWidget:setTopBottom(0, 0, 1080, 1570)
			f19_arg0.WeaponListWidget:setAlpha(0)
			f19_local1(f19_arg0.WeaponListWidget)
		end,
		Close = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.BackgroundSlidePanel:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
				f24_arg0.BackgroundSlidePanel:setAlpha(0)
				f24_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.BackgroundSlidePanel:completeAnimation()
			f24_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
			f24_arg0.BackgroundSlidePanel:setAlpha(1)
			f24_local0(f24_arg0.BackgroundSlidePanel)
			local f24_local1 = function(f26_arg0)
				f24_arg0.WeaponListWidget:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.WeaponListWidget:setTopBottom(0, 0, 1080, 1570)
				f24_arg0.WeaponListWidget:setAlpha(0)
				f24_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.WeaponListWidget:completeAnimation()
			f24_arg0.WeaponListWidget:setTopBottom(0, 0, 680, 1170)
			f24_arg0.WeaponListWidget:setAlpha(1)
			f24_local1(f24_arg0.WeaponListWidget)
		end,
	},
}
CoD.Armory.__onClose = function(f27_arg0)
	f27_arg0.WeaponLevel:close()
	f27_arg0.WeaponAttributes:close()
	f27_arg0.ScorestreakAspectRatioFix:close()
	f27_arg0.XCamMouseControl:close()
	f27_arg0.BackgroundSlidePanel:close()
	f27_arg0.CACHeader:close()
	f27_arg0.ItemInfo:close()
	f27_arg0.WeaponListWidget:close()
	f27_arg0.FooterContainerFrontendRight:close()
	f27_arg0.TopBar:close()
end
