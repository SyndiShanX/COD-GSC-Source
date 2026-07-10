require("x64:cc602f6a26ae0d6")
require("x64:9c626a0110d2a99")
require("x64:60c2e1500e11f2b")
require("x64:ae9782574bd3e55")
require("x64:3b14753712b858f")
CoD.ChooseClass_InGame = InheritFrom(LUI.UIElement)
CoD.ChooseClass_InGame.__defaultWidth = 1920
CoD.ChooseClass_InGame.__defaultHeight = 1080
CoD.ChooseClass_InGame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.SetInGameMenuSessionMode(f1_arg0)
	self:setClass(CoD.ChooseClass_InGame)
	self.id = "ChooseClass_InGame"
	self.soundSet = "Loadout"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local primary = CoD.LoadoutClassItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -633, -277, 0, 0, 305, 509)
	primary:setZoom(90)
	self:addElement(primary)
	self.primary = primary
	local secondary = CoD.LoadoutClassItemSecondary.new(f1_arg0, f1_arg1, 0.5, 0.5, 7, 381, 0, 0, 305, 615)
	secondary:setZoom(90)
	self:addElement(secondary)
	self.secondary = secondary
	local killstreak = CoD.LoadoutClassItemEquipment.new(f1_arg0, f1_arg1, 0.5, 0.5, 391, 604, 0, 0, 305, 475)
	killstreak:setZoom(90)
	self:addElement(killstreak)
	self.killstreak = killstreak
	local customClasssList = LUI.UIList.new(f1_arg0, f1_arg1, 5, 0, nil, false, false, false, false)
	customClasssList:setLeftRight(0.5, 0.5, -763, -593)
	customClasssList:setTopBottom(0, 0, 318, 513)
	customClasssList:setZoom(90)
	customClasssList:setWidgetType(CoD.CustomClassListButton)
	customClasssList:setVerticalCount(5)
	customClasssList:setSpacing(5)
	customClasssList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	customClasssList:setDataSource("ChooseClass_InGame")
	customClasssList:linkToElementModel(customClasssList, "disabled", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	customClasssList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		SetMenuCustomClassData(f1_arg0, element, f1_arg1)
		return f3_local0
	end)
	customClasssList:registerEventHandler("lose_list_focus", function(element, event)
		local f4_local0 = nil
		CoD.CACUtility.SetActiveListItemToSelectedClass(f1_arg1, f1_arg0, element)
		return f4_local0
	end)
	customClasssList:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(customClasssList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsPerControllerTablePropertyValue(controller, "isInMobileArmory", true) then
			ChangeClass(menu, self, element, controller)
			LockInput(self, controller, false)
			Close(self, controller)
			SetPerControllerTableProperty(controller, "isInMobileArmory", false)
			return true
		elseif IsCurrentMenu(menu, "PositionDraft") then
			ChangeClass(menu, self, element, controller)
			SetMenuState(menu, "CharacterSelected", controller)
			return true
		elseif not IsDisabled(element, controller) then
			ChangeClass(menu, self, element, controller)
			CloseStartMenu(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPerControllerTablePropertyValue(controller, "isInMobileArmory", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], nil)
			return true
		elseif IsCurrentMenu(menu, "PositionDraft") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], nil)
			return true
		elseif not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], nil)
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_customClasssList = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		CoD.CACUtility.SetActiveListItemToSelectedClass(f8_arg1, f8_arg2, customClasssList)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_customClasssList)
	self:addElement(customClasssList)
	self.customClasssList = customClasssList
	local customClassName = LUI.UIText.new(0.5, 0.5, -633, -200, 0, 0, 214, 246)
	customClassName:setZoom(80)
	customClassName:setTTF("ttmussels_demibold")
	customClassName:setLetterSpacing(14)
	customClassName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	customClassName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(customClassName)
	self.customClassName = customClassName
	local primaryAttachments = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 10, 0, nil, nil, false, false, false, false)
	primaryAttachments:setLeftRight(0.5, 0.5, -633, -43)
	primaryAttachments:setTopBottom(0, 0, 620, 700)
	primaryAttachments:setZoom(90)
	primaryAttachments:setWidgetType(CoD.AttachmentLoadoutClassListItem)
	primaryAttachments:setHorizontalCount(5)
	primaryAttachments:setSpacing(10)
	primaryAttachments:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(primaryAttachments)
	self.primaryAttachments = primaryAttachments
	local secondaryAttachments = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 10, 0, nil, nil, false, false, false, false)
	secondaryAttachments:setLeftRight(0.5, 0.5, 7, 357)
	secondaryAttachments:setTopBottom(0, 0, 620, 700)
	secondaryAttachments:setZoom(90)
	secondaryAttachments:setWidgetType(CoD.AttachmentLoadoutClassListItem)
	secondaryAttachments:setHorizontalCount(3)
	secondaryAttachments:setSpacing(10)
	secondaryAttachments:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(secondaryAttachments)
	self.secondaryAttachments = secondaryAttachments
	primary:linkToElementModel(customClasssList, "primary", false, function(model)
		primary:setModel(model, f1_arg1)
	end)
	secondary:linkToElementModel(customClasssList, "secondary", false, function(model)
		secondary:setModel(model, f1_arg1)
	end)
	customClassName:linkToElementModel(customClasssList, "customClassName", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			customClassName:setText(ConvertToUpperString(f11_local0))
		end
	end)
	primaryAttachments:linkToElementModel(customClasssList, "primaryattachments", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			primaryAttachments:setDataSource(f12_local0)
		end
	end)
	secondaryAttachments:linkToElementModel(customClasssList, "secondaryattachments", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			secondaryAttachments:setDataSource(f13_local0)
		end
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getglobalmodel"]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rb"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if IsCurrentMenu(menu, "PositionDraft") then
			SetMenuState(menu, "CharacterSelected", controller)
			return true
		else
			SendMenuResponse(self, "ChooseClass_InGame", "cancel", controller)
			LockInput(self, controller, false)
			ClearMenuSavedState(menu)
			PlaySoundSetSound(self, "menu_go_back")
			Close(self, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_lb"], nil, function(element, menu, controller, model)
		if IsMultiplayer() and not IsCACCustomClassCountDefault(controller) then
			chooseClass_TabMPClassesListLeft(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMultiplayer() and not IsCACCustomClassCountDefault(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_rb"], nil, function(element, menu, controller, model)
		if IsMultiplayer() and not IsCACCustomClassCountDefault(controller) then
			chooseClass_TabMPClassesListRight(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMultiplayer() and not IsCACCustomClassCountDefault(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	primary.id = "primary"
	secondary.id = "secondary"
	killstreak.id = "killstreak"
	customClasssList.id = "customClasssList"
	primaryAttachments.id = "primaryAttachments"
	secondaryAttachments.id = "secondaryAttachments"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_customClasssList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChooseClass_InGame.__onClose = function(f22_arg0)
	f22_arg0.__on_close_removeOverrides()
	f22_arg0.primary:close()
	f22_arg0.secondary:close()
	f22_arg0.customClassName:close()
	f22_arg0.primaryAttachments:close()
	f22_arg0.secondaryAttachments:close()
	f22_arg0.killstreak:close()
	f22_arg0.customClasssList:close()
end
