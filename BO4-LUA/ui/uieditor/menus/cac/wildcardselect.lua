require("x64:330d3ffa470e968")
require("x64:429658aa9575f79")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:80e4f83e25db76c")
CoD.WildcardSelect = InheritFrom(CoD.Menu)
LUI.createMenu.WildcardSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WildcardSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SetProperty(self, "_showItemNameOnButtonHold", true)
	SetProperty(self, "preserveLuiButton", {
		[Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC]] = true,
	})
	SetControllerModelValue(f1_arg0, "WildcardMenuOpen", true)
	self:setClass(CoD.WildcardSelect)
	self.soundSet = "CAC"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local CloseOnClickOutside = nil
	CloseOnClickOutside = CoD.WilcardSelect_PC_EmptyFocusable.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	CloseOnClickOutside:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(CloseOnClickOutside, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.CACUtility.AnimatedMenuClose(menu, controller, "Close", 200, "cac_loadout_edit_select_primary")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(CloseOnClickOutside)
	self.CloseOnClickOutside = CloseOnClickOutside
	local WildcardSelectionWidget = CoD.WildcardSelectionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, -30, 570)
	self:addElement(WildcardSelectionWidget)
	self.WildcardSelectionWidget = WildcardSelectionWidget
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CACHeader = CoD.CACHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.BGSceneBlur:setAlpha(0)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x8DEB3201AB34D8E))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f6_local0))
		end
	end)
	CACHeader:linkToElementModel(self, nil, false, function(model)
		CACHeader:setModel(model, f1_arg0)
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local TopBar = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	TopBar:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(TopBar)
	self.TopBar = TopBar
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		PlaySoundAlias("uin_party_ease_slide_back")
		SetControllerModelValue(controller, "WildcardMenuOpen", false)
		CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
		DelayUnhideFreecursorGoBack(menu, controller, 200)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], nil, function(element, menu, controller, model)
		if not IsPC() then
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x37FD8BAF8499F87, nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg0, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.NONE)
		SetControllerModelValue(f1_arg0, "WildcardMenuOpen", false)
		ClearMenuSavedState(f1_local1)
	end)
	if CoD.isPC then
		CloseOnClickOutside.id = "CloseOnClickOutside"
	end
	WildcardSelectionWidget.id = "WildcardSelectionWidget"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = WildcardSelectionWidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local7 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	return self
end
CoD.WildcardSelect.__resetProperties = function(f15_arg0)
	f15_arg0.WildcardSelectionWidget:completeAnimation()
	f15_arg0.CACHeader:completeAnimation()
	f15_arg0.TopBar:completeAnimation()
	f15_arg0.WildcardSelectionWidget:setTopBottom(0, 0, -30, 570)
	f15_arg0.WildcardSelectionWidget:setAlpha(1)
	f15_arg0.CACHeader:setAlpha(1)
	f15_arg0.CACHeader.BGSceneBlur:setAlpha(0)
	f15_arg0.TopBar:setAlpha(1)
end
CoD.WildcardSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.WildcardSelectionWidget:completeAnimation()
			f16_arg0.WildcardSelectionWidget:setTopBottom(0, 0, -600, 0)
			f16_arg0.clipFinished(f16_arg0.WildcardSelectionWidget)
			f16_arg0.CACHeader:completeAnimation()
			f16_arg0.CACHeader:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CACHeader)
		end,
		Open = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f19_arg0:setTopBottom(0, 0, -30, 570)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.WildcardSelectionWidget:beginAnimation(10)
				f17_arg0.WildcardSelectionWidget:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.WildcardSelectionWidget:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.WildcardSelectionWidget:completeAnimation()
			f17_arg0.WildcardSelectionWidget:setTopBottom(0, 0, -50, 550)
			f17_arg0.WildcardSelectionWidget:setAlpha(0)
			f17_local0(f17_arg0.WildcardSelectionWidget)
			local f17_local1 = function(f20_arg0)
				f17_arg0.CACHeader:beginAnimation(10)
				f17_arg0.CACHeader:setAlpha(1)
				f17_arg0.CACHeader:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.CACHeader:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.CACHeader:completeAnimation()
			f17_arg0.CACHeader.BGSceneBlur:completeAnimation()
			f17_arg0.CACHeader:setAlpha(0)
			f17_arg0.CACHeader.BGSceneBlur:setAlpha(0)
			f17_local1(f17_arg0.CACHeader)
			local f17_local2 = function(f21_arg0)
				f17_arg0.TopBar:beginAnimation(10)
				f17_arg0.TopBar:setAlpha(1)
				f17_arg0.TopBar:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.TopBar:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.TopBar:completeAnimation()
			f17_arg0.TopBar:setAlpha(0)
			f17_local2(f17_arg0.TopBar)
		end,
		Close = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f24_arg0:setTopBottom(0, 0, -50, 550)
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.WildcardSelectionWidget:beginAnimation(100)
				f22_arg0.WildcardSelectionWidget:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.WildcardSelectionWidget:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.WildcardSelectionWidget:completeAnimation()
			f22_arg0.WildcardSelectionWidget:setTopBottom(0, 0, -30, 570)
			f22_arg0.WildcardSelectionWidget:setAlpha(1)
			f22_local0(f22_arg0.WildcardSelectionWidget)
			local f22_local1 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(9)
					f26_arg0:setAlpha(0)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.CACHeader:beginAnimation(200)
				f22_arg0.CACHeader:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.CACHeader:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f22_arg0.CACHeader:completeAnimation()
			f22_arg0.CACHeader.BGSceneBlur:completeAnimation()
			f22_arg0.CACHeader:setAlpha(1)
			f22_arg0.CACHeader.BGSceneBlur:setAlpha(0)
			f22_local1(f22_arg0.CACHeader)
			local f22_local2 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(9)
					f28_arg0:setAlpha(0)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.TopBar:beginAnimation(200)
				f22_arg0.TopBar:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.TopBar:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f22_arg0.TopBar:completeAnimation()
			f22_arg0.TopBar:setAlpha(1)
			f22_local2(f22_arg0.TopBar)
		end,
	},
}
CoD.WildcardSelect.__onClose = function(f29_arg0)
	f29_arg0.CloseOnClickOutside:close()
	f29_arg0.WildcardSelectionWidget:close()
	f29_arg0.FooterContainerFrontendRight:close()
	f29_arg0.CACHeader:close()
	f29_arg0.TopBar:close()
end
