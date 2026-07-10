require("x64:f792a7ef58d5981")
require("x64:330d3ffa470e968")
require("x64:1827e15981384e2")
require("x64:103d565b59f1a18")
require("x64:81ed9d78c1f64c5")
require("x64:341ce33d59fafd1")
require("x64:45111f049e24a81")
require("x64:6b510bc5f01b8c5")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:db0d043e3841f5c")
require("x64:75e2a524b093c12")
CoD.WeaponSelectFlyout = InheritFrom(CoD.Menu)
LUI.createMenu.WeaponSelectFlyout = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WeaponSelectFlyout", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "hudItems.previewingMK2Weapon", 0)
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "VariantListShownUpdate")
	self:setClass(CoD.WeaponSelectFlyout)
	self.soundSet = "CAC_PrimaryWeapon"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 146, 646)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackgroundSlidePanel = CoD.cac_background_slide_panel.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 672, 1294)
	BackgroundSlidePanel:setZoom(70)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local CACHeader = CoD.CACHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_493CE015442D7E04"))
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
	local Mark2BonusExpLongBadge = CoD.Mark2BonusExpLongBadge.new(f1_local1, f1_arg0, 0.5, 0.5, -790, -530, 0, 0, 600, 618)
	Mark2BonusExpLongBadge:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f5_local0
				if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
					f5_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
					if f5_local0 then
						f5_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg0, "hudItems.previewingMK2Weapon", 0)
					end
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
	})
	local ItemInfo = Mark2BonusExpLongBadge
	local WeaponLevel = Mark2BonusExpLongBadge.subscribeToModel
	local WeaponAttributes = Engine[@"getmodelforcontroller"](f1_arg0)
	WeaponLevel(ItemInfo, WeaponAttributes["hudItems.previewingMK2Weapon"], function(f6_arg0)
		f1_local1:updateElementState(Mark2BonusExpLongBadge, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.previewingMK2Weapon",
		})
	end, false)
	Mark2BonusExpLongBadge:linkToElementModel(Mark2BonusExpLongBadge, "weaponModelSlot", true, function(model)
		f1_local1:updateElementState(Mark2BonusExpLongBadge, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "weaponModelSlot",
		})
	end)
	Mark2BonusExpLongBadge:linkToElementModel(Mark2BonusExpLongBadge, "itemIndex", true, function(model)
		f1_local1:updateElementState(Mark2BonusExpLongBadge, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	self:addElement(Mark2BonusExpLongBadge)
	self.Mark2BonusExpLongBadge = Mark2BonusExpLongBadge
	WeaponLevel = CoD.ItemWeaponLevel.new(f1_local1, f1_arg0, 0.5, 0.5, -790, 790, 0, 0, 650, 662)
	self:addElement(WeaponLevel)
	self.WeaponLevel = WeaponLevel
	ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, -792, -292, 0, 0, 451.5, 558.5)
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	WeaponAttributes = CoD.WeaponAttributes.new(f1_local1, f1_arg0, 0.5, 0.5, 450, 895, 0, 0, 425, 675)
	WeaponAttributes:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return MenuPropertyIsTrue(menu, "_showWeaponVariantList")
			end,
		},
	})
	self:addElement(WeaponAttributes)
	self.WeaponAttributes = WeaponAttributes
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0, 0, 635, 665)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	local DoubleWeaponXPIcon = CoD.DoubleWeaponXPIcon.new(f1_local1, f1_arg0, 0.5, 0.5, -881, -809, 0, 0, 600, 672)
	self:addElement(DoubleWeaponXPIcon)
	self.DoubleWeaponXPIcon = DoubleWeaponXPIcon
	local WeaponListWidget = CoD.WeaponListWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 680, 1170)
	self:addElement(WeaponListWidget)
	self.WeaponListWidget = WeaponListWidget
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f10_local0 = nil
		if element.menuLoaded then
			f10_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f10_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f10_local0 then
			f10_local0 = element:dispatchEventToChildren(event)
		end
		return f10_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local TopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	TopBar:registerEventHandler("menu_loaded", function(element, event)
		local f11_local0 = nil
		if element.menuLoaded then
			f11_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f11_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f11_local0 then
			f11_local0 = element:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	self:addElement(TopBar)
	self.TopBar = TopBar
	WeaponLevel:linkToElementModel(WeaponListWidget.weaponList, nil, false, function(model)
		WeaponLevel:setModel(model, f1_arg0)
	end)
	WeaponAttributes:linkToElementModel(WeaponListWidget.weaponList, "weaponAttributes", false, function(model)
		WeaponAttributes:setModel(model, f1_arg0)
	end)
	RestrictedText:linkToElementModel(WeaponListWidget.weaponList, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if MenuPropertyIsTrue(menu, "_showWeaponVariantList") and IsPC() then
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			return true
		elseif not IsPC() then
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
		if MenuPropertyIsTrue(menu, "_showWeaponVariantList") and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif not IsPC() then
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
		SetControllerModelValue(f1_arg0, "hudItems.previewingMK2Weapon", 0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "VariantListShownUpdate", function(model)
		local f18_local0 = self
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
	local f1_local14 = self
	if not IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", false)
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	elseif IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "OpenPC", false)
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	end
	return self
end
CoD.WeaponSelectFlyout.__resetProperties = function(f19_arg0)
	f19_arg0.WeaponListWidget:completeAnimation()
	f19_arg0.BackgroundSlidePanel:completeAnimation()
	f19_arg0.WeaponListWidget:setTopBottom(0, 0, 680, 1170)
	f19_arg0.WeaponListWidget:setAlpha(1)
	f19_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
	f19_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.WeaponSelectFlyout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.BackgroundSlidePanel:completeAnimation()
			f20_arg0.BackgroundSlidePanel:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.BackgroundSlidePanel)
			f20_arg0.WeaponListWidget:completeAnimation()
			f20_arg0.WeaponListWidget:setTopBottom(0, 0, 1080, 1570)
			f20_arg0.clipFinished(f20_arg0.WeaponListWidget)
		end,
		Open = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f23_arg0:setTopBottom(0, 0, 672, 1294)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.BackgroundSlidePanel:beginAnimation(100)
				f21_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 872, 1494)
				f21_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.BackgroundSlidePanel:completeAnimation()
			f21_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
			f21_arg0.BackgroundSlidePanel:setAlpha(0)
			f21_local0(f21_arg0.BackgroundSlidePanel)
			local f21_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(49)
					f25_arg0:setTopBottom(0, 0, 680, 1170)
					f25_arg0:setAlpha(1)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.WeaponListWidget:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f21_arg0.WeaponListWidget:setTopBottom(0, 0, 700, 1190)
				f21_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f21_arg0.WeaponListWidget:completeAnimation()
			f21_arg0.WeaponListWidget:setTopBottom(0, 0, 1080, 1570)
			f21_arg0.WeaponListWidget:setAlpha(0.01)
			f21_local1(f21_arg0.WeaponListWidget)
		end,
		Close = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			local f26_local0 = function(f27_arg0)
				f26_arg0.BackgroundSlidePanel:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f26_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
				f26_arg0.BackgroundSlidePanel:setAlpha(0)
				f26_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.BackgroundSlidePanel:completeAnimation()
			f26_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
			f26_arg0.BackgroundSlidePanel:setAlpha(1)
			f26_local0(f26_arg0.BackgroundSlidePanel)
			local f26_local1 = function(f28_arg0)
				f26_arg0.WeaponListWidget:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f26_arg0.WeaponListWidget:setTopBottom(0, 0, 1080, 1570)
				f26_arg0.WeaponListWidget:setAlpha(0)
				f26_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.WeaponListWidget:completeAnimation()
			f26_arg0.WeaponListWidget:setTopBottom(0, 0, 680, 1170)
			f26_arg0.WeaponListWidget:setAlpha(1)
			f26_local1(f26_arg0.WeaponListWidget)
		end,
		OpenPC = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			local f29_local0 = function(f30_arg0)
				f29_arg0.BackgroundSlidePanel:beginAnimation(70)
				f29_arg0.BackgroundSlidePanel:setAlpha(1)
				f29_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.BackgroundSlidePanel:completeAnimation()
			f29_arg0.BackgroundSlidePanel:setAlpha(0)
			f29_local0(f29_arg0.BackgroundSlidePanel)
			local f29_local1 = function(f31_arg0)
				f29_arg0.WeaponListWidget:beginAnimation(70)
				f29_arg0.WeaponListWidget:setAlpha(1)
				f29_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.WeaponListWidget:completeAnimation()
			f29_arg0.WeaponListWidget:setAlpha(0)
			f29_local1(f29_arg0.WeaponListWidget)
		end,
		ClosePC = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			local f32_local0 = function(f33_arg0)
				f32_arg0.BackgroundSlidePanel:beginAnimation(40)
				f32_arg0.BackgroundSlidePanel:setAlpha(0)
				f32_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.BackgroundSlidePanel:completeAnimation()
			f32_arg0.BackgroundSlidePanel:setAlpha(1)
			f32_local0(f32_arg0.BackgroundSlidePanel)
			local f32_local1 = function(f34_arg0)
				f32_arg0.WeaponListWidget:beginAnimation(40)
				f32_arg0.WeaponListWidget:setAlpha(0)
				f32_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.WeaponListWidget:completeAnimation()
			f32_arg0.WeaponListWidget:setAlpha(1)
			f32_local1(f32_arg0.WeaponListWidget)
		end,
	},
}
CoD.WeaponSelectFlyout.__onClose = function(f35_arg0)
	f35_arg0.WeaponLevel:close()
	f35_arg0.WeaponAttributes:close()
	f35_arg0.RestrictedText:close()
	f35_arg0.XCamMouseControl:close()
	f35_arg0.BackgroundSlidePanel:close()
	f35_arg0.CACHeader:close()
	f35_arg0.Mark2BonusExpLongBadge:close()
	f35_arg0.ItemInfo:close()
	f35_arg0.DoubleWeaponXPIcon:close()
	f35_arg0.WeaponListWidget:close()
	f35_arg0.FooterContainerFrontendRight:close()
	f35_arg0.TopBar:close()
end
