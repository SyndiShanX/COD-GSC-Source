require("x64:f792a7ef58d5981")
require("x64:1827e15981384e2")
require("x64:81ed9d78c1f64c5")
require("x64:341ce33d59fafd1")
require("x64:45111f049e24a81")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:ba5fa76d22ca8fe")
require("x64:75e2a524b093c12")
CoD.ZMStartWeaponSelect = InheritFrom(CoD.Menu)
LUI.createMenu.ZMStartWeaponSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ZMStartWeaponSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "VariantListShownUpdate")
	self:setClass(CoD.ZMStartWeaponSelect)
	self.soundSet = "CAC_PrimaryWeapon"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 0.5, -392, 108)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackgroundSlidePanel = CoD.cac_background_slide_panel.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 0.5, 132, 754)
	BackgroundSlidePanel:setZoom(70)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0.5, 0.5, 54, 84)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	local WeaponLevel = CoD.ItemWeaponLevel.new(f1_local1, f1_arg0, 0.5, 0.5, -790, 790, 0, 0, 650, 662)
	self:addElement(WeaponLevel)
	self.WeaponLevel = WeaponLevel
	local WeaponListWidget = CoD.Armory_WeaponListWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, 133, 623)
	WeaponListWidget.weaponCategoryList.Tabs.grid:setDataSource("ZMStartingWeaponGroups")
	self:addElement(WeaponListWidget)
	self.WeaponListWidget = WeaponListWidget
	local ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, -792, -292, 0.5, 0.5, -88.5, 18.5)
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
	local WeaponAttributes = CoD.WeaponAttributes.new(f1_local1, f1_arg0, 0.5, 0.5, 461, 906, 0.5, 0.5, -120, 130)
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
	local CACHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x93CE015442D7E04))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	CACHeader:linkToElementModel(self, nil, false, function(model)
		CACHeader:setModel(model, f1_arg0)
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
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
	RestrictedText:linkToElementModel(WeaponListWidget.weaponList, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg0)
	end)
	WeaponLevel:linkToElementModel(WeaponListWidget.weaponList, nil, false, function(model)
		WeaponLevel:setModel(model, f1_arg0)
	end)
	ItemInfo:linkToElementModel(WeaponListWidget.weaponList, nil, false, function(model)
		ItemInfo:setModel(model, f1_arg0)
	end)
	WeaponAttributes:linkToElementModel(WeaponListWidget.weaponList, "weaponAttributes", false, function(model)
		WeaponAttributes:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if MenuPropertyIsTrue(menu, "_showWeaponVariantList") and IsPC() then
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			return true
		elseif not IsPC() then
			CoD.CACUtility.UpdateClassModelWeaponIfPrimary(self, controller)
			CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
			DelayGoBack(menu, controller, 200)
			return true
		elseif IsPC() then
			CoD.CACUtility.UpdateClassModelWeaponIfPrimary(self, controller)
			CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "ClosePC")
			DelayGoBack(menu, controller, 200)
			return true
		else
		end
	end, function(element, menu, controller)
		if MenuPropertyIsTrue(menu, "_showWeaponVariantList") and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		CoD.CACUtility.ClearClassWeaponModel(f1_local1, f1_arg0)
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
	if not IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", false)
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	elseif IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "OpenPC", true)
	end
	return self
end
CoD.ZMStartWeaponSelect.__resetProperties = function(f17_arg0)
	f17_arg0.WeaponListWidget:completeAnimation()
	f17_arg0.BackgroundSlidePanel:completeAnimation()
	f17_arg0.WeaponListWidget:setTopBottom(0.5, 0.5, 133, 623)
	f17_arg0.WeaponListWidget:setAlpha(1)
	f17_arg0.BackgroundSlidePanel:setTopBottom(0.5, 0.5, 132, 754)
	f17_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.ZMStartWeaponSelect.__clipsPerState = {
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
					f21_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
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
				f19_arg0.WeaponListWidget:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
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
				f24_arg0.BackgroundSlidePanel:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
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
				f24_arg0.WeaponListWidget:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
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
		OpenPC = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.BackgroundSlidePanel:beginAnimation(70)
				f27_arg0.BackgroundSlidePanel:setAlpha(1)
				f27_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.BackgroundSlidePanel:completeAnimation()
			f27_arg0.BackgroundSlidePanel:setAlpha(0)
			f27_local0(f27_arg0.BackgroundSlidePanel)
			local f27_local1 = function(f29_arg0)
				f27_arg0.WeaponListWidget:beginAnimation(70)
				f27_arg0.WeaponListWidget:setAlpha(1)
				f27_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.WeaponListWidget:completeAnimation()
			f27_arg0.WeaponListWidget:setAlpha(0)
			f27_local1(f27_arg0.WeaponListWidget)
		end,
		ClosePC = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			local f30_local0 = function(f31_arg0)
				f30_arg0.BackgroundSlidePanel:beginAnimation(40)
				f30_arg0.BackgroundSlidePanel:setAlpha(0)
				f30_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.BackgroundSlidePanel:completeAnimation()
			f30_arg0.BackgroundSlidePanel:setAlpha(1)
			f30_local0(f30_arg0.BackgroundSlidePanel)
			local f30_local1 = function(f32_arg0)
				f30_arg0.WeaponListWidget:beginAnimation(40)
				f30_arg0.WeaponListWidget:setAlpha(0)
				f30_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.WeaponListWidget:completeAnimation()
			f30_arg0.WeaponListWidget:setAlpha(1)
			f30_local1(f30_arg0.WeaponListWidget)
		end,
	},
}
CoD.ZMStartWeaponSelect.__onClose = function(f33_arg0)
	f33_arg0.RestrictedText:close()
	f33_arg0.WeaponLevel:close()
	f33_arg0.ItemInfo:close()
	f33_arg0.WeaponAttributes:close()
	f33_arg0.XCamMouseControl:close()
	f33_arg0.BackgroundSlidePanel:close()
	f33_arg0.WeaponListWidget:close()
	f33_arg0.CACHeader:close()
	f33_arg0.BackingGrayMediumLeft:close()
	f33_arg0.FooterContainerFrontendRight:close()
end
