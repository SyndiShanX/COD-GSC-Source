require("x64:ea9f9f19e68d4b4")
require("x64:b0cf638db063f63")
require("x64:c490b753d8f1aba")
require("x64:8c5b242b0609336")
require("x64:d038722d0aefd00")
require("x64:42b7a86223bead9")
require("x64:da828bb511b1220")
require("x64:75e2a524b093c12")
CoD.InspectionWidget = InheritFrom(LUI.UIElement)
CoD.InspectionWidget.__defaultWidth = 1920
CoD.InspectionWidget.__defaultHeight = 1080
CoD.InspectionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionWidget)
	self.id = "InspectionWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_arg0, f1_arg1, 0.5, 0.5, -190.5, 559.5, 0.5, 0.5, -478, 222)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local InspectionWeaponWidget = CoD.InspectionWeaponWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -825.5, -105.5, 0, 0, 263, 594)
	self:addElement(InspectionWeaponWidget)
	self.InspectionWeaponWidget = InspectionWeaponWidget
	local PlayerIdentityInfo = CoD.InspectionSelectedPlayerInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, 476, 824, 0, 0, 263, 711)
	self:addElement(PlayerIdentityInfo)
	self.PlayerIdentityInfo = PlayerIdentityInfo
	local LobbyPlayerLevel = CoD.LobbyPlayerInspectionPlayerLevel.new(f1_arg0, f1_arg1, 0.5, 0.5, 476, 824, 0, 0, 747, 909)
	LobbyPlayerLevel:linkToElementModel(self, "info", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LobbyPlayerLevel:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(LobbyPlayerLevel)
	self.LobbyPlayerLevel = LobbyPlayerLevel
	local InspectionSinglePlayerLevel = CoD.InspectionPlayerLevel.new(f1_arg0, f1_arg1, 0.5, 0.5, 476, 824, 0, 0, 747, 909)
	self:addElement(InspectionSinglePlayerLevel)
	self.InspectionSinglePlayerLevel = InspectionSinglePlayerLevel
	local InspectionBgElements = CoD.InspectionBgElements.new(f1_arg0, f1_arg1, 0.5, 0.5, -1098, 650, 0, 0, 443, 1061)
	self:addElement(InspectionBgElements)
	self.InspectionBgElements = InspectionBgElements
	local CallingCardDescriptionText = LUI.UIText.new(0.5, 0.5, -825.5, -477.5, 0, 0, 915, 933)
	CallingCardDescriptionText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	CallingCardDescriptionText:setTTF("ttmussels_regular")
	CallingCardDescriptionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardDescriptionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CallingCardDescriptionText:subscribeToGlobalModel(f1_arg1, "InspectionUtilityInfo", "callingCardDescriptionText", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CallingCardDescriptionText:setText(f3_local0)
		end
	end)
	self:addElement(CallingCardDescriptionText)
	self.CallingCardDescriptionText = CallingCardDescriptionText
	local CallingCardTitleText = LUI.UIText.new(0.5, 0.5, -825.5, -477.5, 0, 0, 596, 617)
	CallingCardTitleText:setRGB(0.92, 0.92, 0.92)
	CallingCardTitleText:setAlpha(0.5)
	CallingCardTitleText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2D993808FE84F8E0"))
	CallingCardTitleText:setTTF("ttmussels_regular")
	CallingCardTitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardTitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CallingCardTitleText)
	self.CallingCardTitleText = CallingCardTitleText
	local CallingCardShowcaseList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	CallingCardShowcaseList:setLeftRight(0.5, 0.5, -825.5, -477.5)
	CallingCardShowcaseList:setTopBottom(0, 0, 624, 905)
	CallingCardShowcaseList:setWidgetType(CoD.InspectCallingCardWidget)
	CallingCardShowcaseList:setVerticalCount(3)
	CallingCardShowcaseList:setSpacing(10)
	CallingCardShowcaseList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardShowcaseList:setDataSource("InspectionUtilityCallingCardOptions")
	CallingCardShowcaseList:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local InspectionTrophyWidget = CallingCardShowcaseList
	local TrophyTitleText = CallingCardShowcaseList.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	TrophyTitleText(InspectionTrophyWidget, f1_local12.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	CallingCardShowcaseList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.InspectionUtility.OnCallingCardFocusChange(f1_arg0, f1_arg1, element)
		return f6_local0
	end)
	CallingCardShowcaseList:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CallingCardShowcaseList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		PlaySoundAlias("uin_press_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(CallingCardShowcaseList, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if not IsPC() then
			CoD.InspectionUtility.ClearShowcaseCallingCard(menu, element, controller)
			PlaySoundAlias("cac_equipment_remove")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/clear", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CallingCardShowcaseList, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.InspectionUtility.ClearShowcaseCallingCard(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"menu/clear", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	CallingCardShowcaseList:linkToElementModel(self, "xuid", true, function(model)
		local f14_local0 = CallingCardShowcaseList
		CoD.InspectionUtility.UpdateCallingCardShowcaseList(f1_arg0, self.CallingCardShowcaseList)
	end)
	CallingCardShowcaseList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/clear", function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		return function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
			CoD.InspectionUtility.ClearShowcaseCallingCard(f16_arg1, f16_arg0, f16_arg2)
		end
	end)
	self:addElement(CallingCardShowcaseList)
	self.CallingCardShowcaseList = CallingCardShowcaseList
	TrophyTitleText = LUI.UIText.new(0.5, 0.5, -449.5, -199.5, 0, 0, 596, 617)
	TrophyTitleText:setRGB(0.92, 0.92, 0.92)
	TrophyTitleText:setAlpha(0)
	TrophyTitleText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/career_best"))
	TrophyTitleText:setTTF("ttmussels_regular")
	TrophyTitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TrophyTitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TrophyTitleText)
	self.TrophyTitleText = TrophyTitleText
	InspectionTrophyWidget = CoD.InspectionTrophyWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -449.5, -199.5, 0, 0, 624, 906)
	InspectionTrophyWidget:setAlpha(0)
	InspectionTrophyWidget:subscribeToGlobalModel(f1_arg1, "PlayerShowcase", "medal", function(model)
		InspectionTrophyWidget:setModel(model, f1_arg1)
	end)
	InspectionTrophyWidget:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f18_local0
	end)
	f1_arg0:AddButtonCallbackFunction(InspectionTrophyWidget, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.InspectionUtility.OnTrophyShowcaseSelected(menu, controller, element)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(InspectionTrophyWidget)
	self.InspectionTrophyWidget = InspectionTrophyWidget
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	PlayerIdentityInfo.id = "PlayerIdentityInfo"
	CallingCardShowcaseList.id = "CallingCardShowcaseList"
	InspectionTrophyWidget.id = "InspectionTrophyWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	CoD.InspectionUtility.SubscribeToCallingCardUpdateModels(f1_arg0, self.CallingCardShowcaseList)
	f1_local12 = CallingCardShowcaseList
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local12, f1_arg1, "name", "", "")
	end
	return self
end
CoD.InspectionWidget.__resetProperties = function(f21_arg0)
	f21_arg0.LobbyPlayerLevel:completeAnimation()
	f21_arg0.InspectionSinglePlayerLevel:completeAnimation()
	f21_arg0.CallingCardTitleText:completeAnimation()
	f21_arg0.CallingCardShowcaseList:completeAnimation()
	f21_arg0.CallingCardDescriptionText:completeAnimation()
	f21_arg0.InspectionWeaponWidget:completeAnimation()
	f21_arg0.LobbyPlayerLevel:setAlpha(1)
	f21_arg0.InspectionSinglePlayerLevel:setAlpha(1)
	f21_arg0.CallingCardTitleText:setAlpha(0.5)
	f21_arg0.CallingCardShowcaseList:setAlpha(1)
	f21_arg0.CallingCardDescriptionText:setAlpha(1)
	f21_arg0.InspectionWeaponWidget:setAlpha(1)
end
CoD.InspectionWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.LobbyPlayerLevel:completeAnimation()
			f22_arg0.LobbyPlayerLevel:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.LobbyPlayerLevel)
		end,
	},
	Offline = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			f23_arg0.LobbyPlayerLevel:completeAnimation()
			f23_arg0.LobbyPlayerLevel:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.LobbyPlayerLevel)
			f23_arg0.InspectionSinglePlayerLevel:completeAnimation()
			f23_arg0.InspectionSinglePlayerLevel:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.InspectionSinglePlayerLevel)
			f23_arg0.CallingCardDescriptionText:completeAnimation()
			f23_arg0.CallingCardDescriptionText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CallingCardDescriptionText)
			f23_arg0.CallingCardTitleText:completeAnimation()
			f23_arg0.CallingCardTitleText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CallingCardTitleText)
			f23_arg0.CallingCardShowcaseList:completeAnimation()
			f23_arg0.CallingCardShowcaseList:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CallingCardShowcaseList)
		end,
	},
	LobbyState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.LobbyPlayerLevel:completeAnimation()
			f24_arg0.LobbyPlayerLevel:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.LobbyPlayerLevel)
			f24_arg0.InspectionSinglePlayerLevel:completeAnimation()
			f24_arg0.InspectionSinglePlayerLevel:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.InspectionSinglePlayerLevel)
		end,
	},
	WZLobbyState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.InspectionWeaponWidget:completeAnimation()
			f25_arg0.InspectionWeaponWidget:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.InspectionWeaponWidget)
			f25_arg0.LobbyPlayerLevel:completeAnimation()
			f25_arg0.LobbyPlayerLevel:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.LobbyPlayerLevel)
			f25_arg0.InspectionSinglePlayerLevel:completeAnimation()
			f25_arg0.InspectionSinglePlayerLevel:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.InspectionSinglePlayerLevel)
		end,
	},
}
CoD.InspectionWidget.__onClose = function(f26_arg0)
	f26_arg0.XCamMouseControl:close()
	f26_arg0.InspectionWeaponWidget:close()
	f26_arg0.PlayerIdentityInfo:close()
	f26_arg0.LobbyPlayerLevel:close()
	f26_arg0.InspectionSinglePlayerLevel:close()
	f26_arg0.InspectionBgElements:close()
	f26_arg0.CallingCardDescriptionText:close()
	f26_arg0.CallingCardShowcaseList:close()
	f26_arg0.InspectionTrophyWidget:close()
end
