require("x64:8b53d2ba8e4b74c")
require("x64:330d3ffa470e968")
require("x64:b6f6e647f494e0b")
require("x64:d1b72c431d2cbb7")
require("x64:1827e15981384e2")
require("x64:341ce33d59fafd1")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:75e2a524b093c12")
CoD.SpecialistEquipmentSelect = InheritFrom(CoD.Menu)
LUI.createMenu.SpecialistEquipmentSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SpecialistEquipmentSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.SpecialistEquipmentSelect)
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
	local BackgroundSlidePanel = CoD.cac_background_slide_panel_short.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 639, 1261)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local EquipmentListWidget = CoD.EquipmentListWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -1100, 1100, 0, 0, 547, 1047)
	self:addElement(EquipmentListWidget)
	self.EquipmentListWidget = EquipmentListWidget
	local CACHeader = CoD.CACHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.CACUtility.GetHeaderNameForLoadoutSlot(self, @"hash_15C60F77B9332E5B")))
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
	local ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, -740, -240, 0, 0, 489.5, 596.5)
	ItemInfo:mergeStateConditions({
		{
			stateName = "NotVisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "refHash", CoDShared.DefaultSpecialistEquipment)
			end,
		},
	})
	ItemInfo:linkToElementModel(ItemInfo, "refHash", true, function(model)
		f1_local1:updateElementState(ItemInfo, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "refHash",
		})
	end)
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local SpecialistEquipmentTabs = CoD.SpecialistEquipmentTabListWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	SpecialistEquipmentTabs:mergeStateConditions({
		{
			stateName = "NotVisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "refHash", CoDShared.DefaultSpecialistEquipment)
			end,
		},
	})
	SpecialistEquipmentTabs:linkToElementModel(SpecialistEquipmentTabs, "refHash", true, function(model)
		f1_local1:updateElementState(SpecialistEquipmentTabs, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "refHash",
		})
	end)
	SpecialistEquipmentTabs:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(SpecialistEquipmentTabs)
	self.SpecialistEquipmentTabs = SpecialistEquipmentTabs
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0.5, 0.5, 85, 115)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	ItemInfo:linkToElementModel(EquipmentListWidget.itemList, nil, false, function(model)
		ItemInfo:setModel(model, f1_arg0)
	end)
	SpecialistEquipmentTabs:linkToElementModel(EquipmentListWidget.itemList, nil, false, function(model)
		SpecialistEquipmentTabs:setModel(model, f1_arg0)
	end)
	RestrictedText:linkToElementModel(EquipmentListWidget.itemList, nil, false, function(model)
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
		ClearMenuSavedState(f1_local1)
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	EquipmentListWidget.id = "EquipmentListWidget"
	SpecialistEquipmentTabs.id = "SpecialistEquipmentTabs"
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
	local f1_local11 = self
	if not IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	elseif IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "OpenPC", true)
	end
	return self
end
CoD.SpecialistEquipmentSelect.__resetProperties = function(f18_arg0)
	f18_arg0.EquipmentListWidget:completeAnimation()
	f18_arg0.BackgroundSlidePanel:completeAnimation()
	f18_arg0.EquipmentListWidget:setTopBottom(0, 0, 547, 1047)
	f18_arg0.EquipmentListWidget:setAlpha(1)
	f18_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 639, 1261)
	f18_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.SpecialistEquipmentSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.BackgroundSlidePanel:completeAnimation()
			f19_arg0.BackgroundSlidePanel:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.BackgroundSlidePanel)
			f19_arg0.EquipmentListWidget:completeAnimation()
			f19_arg0.EquipmentListWidget:setTopBottom(0, 0, 1080, 1580)
			f19_arg0.EquipmentListWidget:setAlpha(0.01)
			f19_arg0.clipFinished(f19_arg0.EquipmentListWidget)
		end,
		Open = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f22_arg0:setTopBottom(0, 0, 639, 1261)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.BackgroundSlidePanel:beginAnimation(100)
				f20_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 872, 1494)
				f20_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.BackgroundSlidePanel:completeAnimation()
			f20_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
			f20_arg0.BackgroundSlidePanel:setAlpha(0)
			f20_local0(f20_arg0.BackgroundSlidePanel)
			local f20_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(49, Enum[@"luitween"][@"luitween_ease_both"])
					f24_arg0:setTopBottom(0, 0, 547, 1047)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.EquipmentListWidget:beginAnimation(200)
				f20_arg0.EquipmentListWidget:setTopBottom(0, 0, 600, 1100)
				f20_arg0.EquipmentListWidget:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.EquipmentListWidget:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f20_arg0.EquipmentListWidget:completeAnimation()
			f20_arg0.EquipmentListWidget:setTopBottom(0, 0, 1080, 1580)
			f20_arg0.EquipmentListWidget:setAlpha(0.01)
			f20_local1(f20_arg0.EquipmentListWidget)
		end,
		Close = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.BackgroundSlidePanel:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f25_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
				f25_arg0.BackgroundSlidePanel:setAlpha(0)
				f25_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.BackgroundSlidePanel:completeAnimation()
			f25_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 639, 1261)
			f25_arg0.BackgroundSlidePanel:setAlpha(1)
			f25_local0(f25_arg0.BackgroundSlidePanel)
			local f25_local1 = function(f27_arg0)
				f25_arg0.EquipmentListWidget:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f25_arg0.EquipmentListWidget:setTopBottom(0, 0, 1080, 1580)
				f25_arg0.EquipmentListWidget:setAlpha(0)
				f25_arg0.EquipmentListWidget:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.EquipmentListWidget:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.EquipmentListWidget:completeAnimation()
			f25_arg0.EquipmentListWidget:setTopBottom(0, 0, 547, 1047)
			f25_arg0.EquipmentListWidget:setAlpha(1)
			f25_local1(f25_arg0.EquipmentListWidget)
		end,
		OpenPC = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			local f28_local0 = function(f29_arg0)
				f28_arg0.BackgroundSlidePanel:beginAnimation(70)
				f28_arg0.BackgroundSlidePanel:setAlpha(1)
				f28_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.BackgroundSlidePanel:completeAnimation()
			f28_arg0.BackgroundSlidePanel:setAlpha(0)
			f28_local0(f28_arg0.BackgroundSlidePanel)
			local f28_local1 = function(f30_arg0)
				f28_arg0.EquipmentListWidget:beginAnimation(70)
				f28_arg0.EquipmentListWidget:setAlpha(1)
				f28_arg0.EquipmentListWidget:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.EquipmentListWidget:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.EquipmentListWidget:completeAnimation()
			f28_arg0.EquipmentListWidget:setAlpha(0)
			f28_local1(f28_arg0.EquipmentListWidget)
		end,
		ClosePC = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			local f31_local0 = function(f32_arg0)
				f31_arg0.BackgroundSlidePanel:beginAnimation(40)
				f31_arg0.BackgroundSlidePanel:setAlpha(0)
				f31_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.BackgroundSlidePanel:completeAnimation()
			f31_arg0.BackgroundSlidePanel:setAlpha(1)
			f31_local0(f31_arg0.BackgroundSlidePanel)
			local f31_local1 = function(f33_arg0)
				f31_arg0.EquipmentListWidget:beginAnimation(40)
				f31_arg0.EquipmentListWidget:setAlpha(0)
				f31_arg0.EquipmentListWidget:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.EquipmentListWidget:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.EquipmentListWidget:completeAnimation()
			f31_arg0.EquipmentListWidget:setAlpha(1)
			f31_local1(f31_arg0.EquipmentListWidget)
		end,
	},
}
CoD.SpecialistEquipmentSelect.__onClose = function(f34_arg0)
	f34_arg0.ItemInfo:close()
	f34_arg0.SpecialistEquipmentTabs:close()
	f34_arg0.RestrictedText:close()
	f34_arg0.XCamMouseControl:close()
	f34_arg0.BackgroundSlidePanel:close()
	f34_arg0.EquipmentListWidget:close()
	f34_arg0.CACHeader:close()
	f34_arg0.BackingGrayMediumLeft:close()
	f34_arg0.FooterContainerFrontendRight:close()
end
