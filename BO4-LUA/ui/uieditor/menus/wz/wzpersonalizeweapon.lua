require("x64:f792a7ef58d5981")
require("x64:1827e15981384e2")
require("x64:8a564360a773656")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:e91724b6a77f8c9")
require("x64:75e2a524b093c12")
CoD.WZPersonalizeWeapon = InheritFrom(CoD.Menu)
LUI.createMenu.WZPersonalizeWeapon = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WZPersonalizeWeapon", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	SetControllerModelValue(f1_arg0, "Unlockables.listUpdate", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "CustomClassList.equippedItemsChanged", false)
	SetControllerModelValue(f1_arg0, "WeaponPersonalization.listUpdate", 0)
	CoD.WeaponOptionsUtility.InitPaintCansCountModel(f1_arg0)
	SetMenuProperty(f1_local1, "__ignoreUnlockablesDefaultSelectIndex", true)
	self:setClass(CoD.WZPersonalizeWeapon)
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
	local CACHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x94122F68876E5D9))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
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
		SizeToSafeArea(element, f1_arg0)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, -792, -292, 0, 0, 451.5, 558.5)
	ItemInfo:mergeStateConditions({
		{
			stateName = "WZArmory",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	local WeaponListWidget = CoD.WZPersonalizeWeapon_WeaponListWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 673, 1163)
	self:addElement(WeaponListWidget)
	self.WeaponListWidget = WeaponListWidget
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
	local TopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	TopBar:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(TopBar)
	self.TopBar = TopBar
	local PaintCanCount = CoD.PaintCanCount.new(f1_local1, f1_arg0, 0.5, 0.5, -798, -618, 0, 0, 115.5, 247.5)
	PaintCanCount:mergeStateConditions({
		{
			stateName = "VisibleMaxed",
			condition = function(menu, element, event)
				local f8_local0
				if not IsLocal() then
					f8_local0 = CoD.WZUtility.IsPaintCansMaxed(f1_arg0)
					if f8_local0 then
						f8_local0 = IsBooleanDvarSet("ui_ShowWZPersonalization")
					end
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f9_local0
				if not IsLocal() then
					f9_local0 = IsBooleanDvarSet("ui_ShowWZPersonalization")
				else
					f9_local0 = false
				end
				return f9_local0
			end,
		},
	})
	local f1_local10 = PaintCanCount
	local f1_local11 = PaintCanCount.subscribeToModel
	local f1_local12 = Engine[0x8DF2E5447F384B9]()
	f1_local11(f1_local10, f1_local12["lobbyRoot.lobbyNetworkMode"], function(f10_arg0)
		f1_local1:updateElementState(PaintCanCount, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local10 = PaintCanCount
	f1_local11 = PaintCanCount.subscribeToModel
	f1_local12 = Engine[0x8DF2E5447F384B9]()
	f1_local11(f1_local10, f1_local12["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_local1:updateElementState(PaintCanCount, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local10 = PaintCanCount
	f1_local11 = PaintCanCount.subscribeToModel
	f1_local12 = DataSources.PerController.getModel(f1_arg0)
	f1_local11(f1_local10, f1_local12.paintCanCount, function(f12_arg0)
		f1_local1:updateElementState(PaintCanCount, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "paintCanCount",
		})
	end, false)
	self:addElement(PaintCanCount)
	self.PaintCanCount = PaintCanCount
	self:registerEventHandler("occlusion_change", function(self, event)
		local f13_local0 = nil
		if self.OcclusionChange then
			f13_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f13_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
		else
			MenuHidesFreeCursor(f1_local1, f1_arg0)
		end
		if not f13_local0 then
			f13_local0 = self:dispatchEventToChildren(event)
		end
		return f13_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
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
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
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
	f1_local11 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", false)
	CoD.LobbyUtility.SetMenuControllerRestriction(self, f1_arg0, 1)
	CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg0, "ZMArmoryIntroduction")
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.WZPersonalizeWeapon.__resetProperties = function(f19_arg0)
	f19_arg0.WeaponListWidget:completeAnimation()
	f19_arg0.BackgroundSlidePanel:completeAnimation()
	f19_arg0.WeaponListWidget:setTopBottom(0, 0, 673, 1163)
	f19_arg0.WeaponListWidget:setAlpha(1)
	f19_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
	f19_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.WZPersonalizeWeapon.__clipsPerState = {
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
					f23_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
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
				f21_arg0.WeaponListWidget:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f21_arg0.WeaponListWidget:setTopBottom(0, 0, 700, 1190)
				f21_arg0.WeaponListWidget:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.WeaponListWidget:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f21_arg0.WeaponListWidget:completeAnimation()
			f21_arg0.WeaponListWidget:setTopBottom(0, 0, 1080, 1570)
			f21_arg0.WeaponListWidget:setAlpha(0)
			f21_local1(f21_arg0.WeaponListWidget)
		end,
		Close = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			local f26_local0 = function(f27_arg0)
				f26_arg0.BackgroundSlidePanel:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
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
				f26_arg0.WeaponListWidget:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
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
	},
}
CoD.WZPersonalizeWeapon.__onClose = function(f29_arg0)
	f29_arg0.XCamMouseControl:close()
	f29_arg0.BackgroundSlidePanel:close()
	f29_arg0.CACHeader:close()
	f29_arg0.ItemInfo:close()
	f29_arg0.WeaponListWidget:close()
	f29_arg0.FooterContainerFrontendRight:close()
	f29_arg0.TopBar:close()
	f29_arg0.PaintCanCount:close()
end
