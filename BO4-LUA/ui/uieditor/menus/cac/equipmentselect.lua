require("x64:8b53d2ba8e4b74c")
require("x64:330d3ffa470e968")
require("x64:b6f6e647f494e0b")
require("x64:1827e15981384e2")
require("x64:341ce33d59fafd1")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:75e2a524b093c12")
CoD.EquipmentSelect = InheritFrom(CoD.Menu)
LUI.createMenu.EquipmentSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EquipmentSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.EquipmentSelect)
	self.soundSet = "CAC_Gear"
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
	local BackgroundSlidePanel = CoD.cac_background_slide_panel_short.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 672, 1294)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local EquipmentListWidget = CoD.EquipmentListWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -1100, 1100, 0, 0, 580, 1080)
	self:addElement(EquipmentListWidget)
	self.EquipmentListWidget = EquipmentListWidget
	local ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, -740, -240, 0, 0, 489.5, 596.5)
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	local CACHeader = CoD.CACHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.CACUtility.GetHeaderNameForLoadoutSlot(self, 0x305E03714EE77FC)))
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
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0.5, 0.5, 85, 115)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	ItemInfo:linkToElementModel(EquipmentListWidget.itemList, nil, false, function(model)
		ItemInfo:setModel(model, f1_arg0)
	end)
	RestrictedText:linkToElementModel(EquipmentListWidget.itemList, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
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
		CoD.CACUtility.UpdateClassWeaponModel(f1_local1, element, f1_arg0)
		ClearMenuSavedState(f1_local1)
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	EquipmentListWidget.id = "EquipmentListWidget"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = EquipmentListWidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local10 = self
	if not IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	elseif IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "OpenPC", true)
	end
	return self
end
CoD.EquipmentSelect.__resetProperties = function(f12_arg0)
	f12_arg0.EquipmentListWidget:completeAnimation()
	f12_arg0.BackgroundSlidePanel:completeAnimation()
	f12_arg0.EquipmentListWidget:setTopBottom(0, 0, 580, 1080)
	f12_arg0.EquipmentListWidget:setAlpha(1)
	f12_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
	f12_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.EquipmentSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.BackgroundSlidePanel:completeAnimation()
			f13_arg0.BackgroundSlidePanel:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BackgroundSlidePanel)
			f13_arg0.EquipmentListWidget:completeAnimation()
			f13_arg0.EquipmentListWidget:setTopBottom(0, 0, 1080, 1580)
			f13_arg0.clipFinished(f13_arg0.EquipmentListWidget)
		end,
		Open = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f16_arg0:setTopBottom(0, 0, 672, 1294)
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.BackgroundSlidePanel:beginAnimation(100)
				f14_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.BackgroundSlidePanel:completeAnimation()
			f14_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 872, 1494)
			f14_arg0.BackgroundSlidePanel:setAlpha(0)
			f14_local0(f14_arg0.BackgroundSlidePanel)
			local f14_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(49)
					f18_arg0:setTopBottom(0, 0, 580, 1080)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.EquipmentListWidget:beginAnimation(200)
				f14_arg0.EquipmentListWidget:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.EquipmentListWidget:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f14_arg0.EquipmentListWidget:completeAnimation()
			f14_arg0.EquipmentListWidget:setTopBottom(0, 0, 600, 1100)
			f14_arg0.EquipmentListWidget:setAlpha(0.01)
			f14_local1(f14_arg0.EquipmentListWidget)
		end,
		Close = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				f19_arg0.BackgroundSlidePanel:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f19_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
				f19_arg0.BackgroundSlidePanel:setAlpha(0)
				f19_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.BackgroundSlidePanel:completeAnimation()
			f19_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
			f19_arg0.BackgroundSlidePanel:setAlpha(1)
			f19_local0(f19_arg0.BackgroundSlidePanel)
			local f19_local1 = function(f21_arg0)
				f19_arg0.EquipmentListWidget:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f19_arg0.EquipmentListWidget:setTopBottom(0, 0, 980, 1480)
				f19_arg0.EquipmentListWidget:setAlpha(0)
				f19_arg0.EquipmentListWidget:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.EquipmentListWidget:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.EquipmentListWidget:completeAnimation()
			f19_arg0.EquipmentListWidget:setTopBottom(0, 0, 580, 1080)
			f19_arg0.EquipmentListWidget:setAlpha(1)
			f19_local1(f19_arg0.EquipmentListWidget)
		end,
		OpenPC = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.BackgroundSlidePanel:beginAnimation(70)
				f22_arg0.BackgroundSlidePanel:setAlpha(1)
				f22_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.BackgroundSlidePanel:completeAnimation()
			f22_arg0.BackgroundSlidePanel:setAlpha(0)
			f22_local0(f22_arg0.BackgroundSlidePanel)
			local f22_local1 = function(f24_arg0)
				f22_arg0.EquipmentListWidget:beginAnimation(70)
				f22_arg0.EquipmentListWidget:setAlpha(1)
				f22_arg0.EquipmentListWidget:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.EquipmentListWidget:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.EquipmentListWidget:completeAnimation()
			f22_arg0.EquipmentListWidget:setAlpha(0)
			f22_local1(f22_arg0.EquipmentListWidget)
		end,
		ClosePC = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.BackgroundSlidePanel:beginAnimation(40)
				f25_arg0.BackgroundSlidePanel:setAlpha(0)
				f25_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.BackgroundSlidePanel:completeAnimation()
			f25_arg0.BackgroundSlidePanel:setAlpha(1)
			f25_local0(f25_arg0.BackgroundSlidePanel)
			local f25_local1 = function(f27_arg0)
				f25_arg0.EquipmentListWidget:beginAnimation(40)
				f25_arg0.EquipmentListWidget:setAlpha(0)
				f25_arg0.EquipmentListWidget:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.EquipmentListWidget:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.EquipmentListWidget:completeAnimation()
			f25_arg0.EquipmentListWidget:setAlpha(1)
			f25_local1(f25_arg0.EquipmentListWidget)
		end,
	},
}
CoD.EquipmentSelect.__onClose = function(f28_arg0)
	f28_arg0.ItemInfo:close()
	f28_arg0.RestrictedText:close()
	f28_arg0.XCamMouseControl:close()
	f28_arg0.BackgroundSlidePanel:close()
	f28_arg0.EquipmentListWidget:close()
	f28_arg0.CACHeader:close()
	f28_arg0.BackingGrayMediumLeft:close()
	f28_arg0.FooterContainerFrontendRight:close()
end
