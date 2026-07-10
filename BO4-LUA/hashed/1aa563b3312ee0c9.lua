require("x64:2bf3da84e7ff2d3")
require("x64:7a9f0ac9904eceb")
require("x64:85d753343a290f2")
CoD.EquippedBGBContainer = InheritFrom(LUI.UIElement)
CoD.EquippedBGBContainer.__defaultWidth = 350
CoD.EquippedBGBContainer.__defaultHeight = 350
CoD.EquippedBGBContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EquippedBGBContainer)
	self.id = "EquippedBGBContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local UpBGB = CoD.EquippedBGB.new(f1_arg0, f1_arg1, 0.5, 0.5, -60, 60, 0, 0, 16, 136)
	UpBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Up", function(model)
		UpBGB:setModel(model, f1_arg1)
	end)
	local DownBGB = UpBGB
	local RightBGB = UpBGB.subscribeToModel
	local LeftBGB = DataSources.BGBLoadout.getModel(f1_arg1)
	RightBGB(DownBGB, LeftBGB.selectedIndex, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	UpBGB:linkToElementModel(UpBGB, "slotIndex", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	UpBGB:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(UpBGB, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsCurrentMenu(menu, "BubblegumBuffSelect") then
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, element, "BGBLoadout.selectedIndex", "slotIndex")
			CoD.ZMLoadoutUtility.OpenBGBSelectionMenu(self, menu, controller, self)
			return true
		elseif not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "BGBLoadout", "selectedIndex", "slotIndex") then
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, element, "BGBLoadout.selectedIndex", "slotIndex")
			PlaySoundAlias("uin_zcac_elixir_slot")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsCurrentMenu(menu, "BubblegumBuffSelect") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "BGBLoadout", "selectedIndex", "slotIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(UpBGB, "childFocusGained", function(element)
		if IsCurrentMenu(f1_arg0, "BubblegumBuffSelect") then
			CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots(f1_arg0, element, f1_arg1)
			CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_arg0, self, element, f1_arg1)
		end
	end)
	self:addElement(UpBGB)
	self.UpBGB = UpBGB
	RightBGB = CoD.EquippedBGB.new(f1_arg0, f1_arg1, 1, 1, -134, -14, 0.5, 0.5, -60, 60)
	RightBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Right", function(model)
		RightBGB:setModel(model, f1_arg1)
	end)
	LeftBGB = RightBGB
	DownBGB = RightBGB.subscribeToModel
	local ButtonPrompt = DataSources.BGBLoadout.getModel(f1_arg1)
	DownBGB(LeftBGB, ButtonPrompt.selectedIndex, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	RightBGB:linkToElementModel(RightBGB, "slotIndex", true, function(model, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	RightBGB:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightBGB, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsCurrentMenu(menu, "BubblegumBuffSelect") then
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, element, "BGBLoadout.selectedIndex", "slotIndex")
			CoD.ZMLoadoutUtility.OpenBGBSelectionMenu(self, menu, controller, self)
			return true
		elseif not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "BGBLoadout", "selectedIndex", "slotIndex") then
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, element, "BGBLoadout.selectedIndex", "slotIndex")
			PlaySoundAlias("uin_zcac_elixir_slot")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsCurrentMenu(menu, "BubblegumBuffSelect") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "BGBLoadout", "selectedIndex", "slotIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(RightBGB, "childFocusGained", function(element)
		if IsCurrentMenu(f1_arg0, "BubblegumBuffSelect") then
			CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots(f1_arg0, element, f1_arg1)
			CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_arg0, self, element, f1_arg1)
		end
	end)
	self:addElement(RightBGB)
	self.RightBGB = RightBGB
	DownBGB = CoD.EquippedBGB.new(f1_arg0, f1_arg1, 0.5, 0.5, -60, 60, 1, 1, -134, -14)
	DownBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Down", function(model)
		DownBGB:setModel(model, f1_arg1)
	end)
	ButtonPrompt = DownBGB
	LeftBGB = DownBGB.subscribeToModel
	local Name = DataSources.BGBLoadout.getModel(f1_arg1)
	LeftBGB(ButtonPrompt, Name.selectedIndex, function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	DownBGB:linkToElementModel(DownBGB, "slotIndex", true, function(model, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	DownBGB:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DownBGB, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsCurrentMenu(menu, "BubblegumBuffSelect") then
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, element, "BGBLoadout.selectedIndex", "slotIndex")
			CoD.ZMLoadoutUtility.OpenBGBSelectionMenu(self, menu, controller, self)
			return true
		elseif not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "BGBLoadout", "selectedIndex", "slotIndex") then
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, element, "BGBLoadout.selectedIndex", "slotIndex")
			PlaySoundAlias("uin_zcac_elixir_slot")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsCurrentMenu(menu, "BubblegumBuffSelect") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "BGBLoadout", "selectedIndex", "slotIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(DownBGB, "childFocusGained", function(element)
		if IsCurrentMenu(f1_arg0, "BubblegumBuffSelect") then
			CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots(f1_arg0, element, f1_arg1)
			CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_arg0, self, element, f1_arg1)
		end
	end)
	self:addElement(DownBGB)
	self.DownBGB = DownBGB
	LeftBGB = CoD.EquippedBGB.new(f1_arg0, f1_arg1, 0, 0, 14, 134, 0.5, 0.5, -60, 60)
	LeftBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Left", function(model)
		LeftBGB:setModel(model, f1_arg1)
	end)
	Name = LeftBGB
	ButtonPrompt = LeftBGB.subscribeToModel
	local f1_local7 = DataSources.BGBLoadout.getModel(f1_arg1)
	ButtonPrompt(Name, f1_local7.selectedIndex, function(f24_arg0, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LeftBGB:linkToElementModel(LeftBGB, "slotIndex", true, function(model, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	LeftBGB:registerEventHandler("gain_focus", function(element, event)
		local f26_local0 = nil
		if element.gainFocus then
			f26_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f26_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f26_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeftBGB, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsCurrentMenu(menu, "BubblegumBuffSelect") then
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, element, "BGBLoadout.selectedIndex", "slotIndex")
			CoD.ZMLoadoutUtility.OpenBGBSelectionMenu(self, menu, controller, self)
			return true
		elseif not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "BGBLoadout", "selectedIndex", "slotIndex") then
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, element, "BGBLoadout.selectedIndex", "slotIndex")
			PlaySoundAlias("uin_zcac_elixir_slot")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsCurrentMenu(menu, "BubblegumBuffSelect") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, controller, "BGBLoadout", "selectedIndex", "slotIndex") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(LeftBGB, "childFocusGained", function(element)
		if IsCurrentMenu(f1_arg0, "BubblegumBuffSelect") then
			CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots(f1_arg0, element, f1_arg1)
			CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_arg0, self, element, f1_arg1)
		end
	end)
	self:addElement(LeftBGB)
	self.LeftBGB = LeftBGB
	ButtonPrompt = CoD.BGBSelectButtonPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 32, 0.5, 0.5, -39, 31)
	self:addElement(ButtonPrompt)
	self.ButtonPrompt = ButtonPrompt
	Name = CoD.onOffText.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 0, 0, 390.5, 411.5)
	Name:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not IsCurrentMenu(menu, "BubblegumBuffSelect")
			end,
		},
	})
	Name:setRGB(0.58, 0.85, 1)
	Name.TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Name:subscribeToGlobalModel(f1_arg1, "BGBLoadout", nil, function(model)
		Name:setModel(model, f1_arg1)
	end)
	Name:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "selectedEquippedBGBName", function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			Name.TextBox:setText(LocalizeToUpperString(f32_local0))
		end
	end)
	Name:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Up.displayName", function(model)
		CoD.ZMLoadoutUtility.UpdateBGBEquippedSelectedName(Name, model, f1_arg1)
	end)
	Name:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Right.displayName", function(model)
		CoD.ZMLoadoutUtility.UpdateBGBEquippedSelectedName(Name, model, f1_arg1)
	end)
	Name:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Down.displayName", function(model)
		CoD.ZMLoadoutUtility.UpdateBGBEquippedSelectedName(Name, model, f1_arg1)
	end)
	Name:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Left.displayName", function(model)
		CoD.ZMLoadoutUtility.UpdateBGBEquippedSelectedName(Name, model, f1_arg1)
	end)
	Name:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "selectedIndex", function(model)
		CoD.ZMLoadoutUtility.UpdateBGBNameFromSelectedIndex(f1_arg0, Name, model, f1_arg1)
	end)
	self:addElement(Name)
	self.Name = Name
	UpBGB.id = "UpBGB"
	RightBGB.id = "RightBGB"
	DownBGB.id = "DownBGB"
	LeftBGB.id = "LeftBGB"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	f1_local7 = UpBGB
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, f1_local7, self.LeftBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local7, self.UpBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local7, self.RightBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local7, self.DownBGB)
	f1_local7 = RightBGB
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, f1_local7, self.LeftBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local7, self.DownBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local7, self.UpBGB)
	f1_local7 = DownBGB
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, f1_local7, self.LeftBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local7, self.UpBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local7, self.RightBGB)
	f1_local7 = LeftBGB
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, f1_local7, self.LeftBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local7, self.UpBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local7, self.RightBGB)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local7, self.DownBGB)
	return self
end
CoD.EquippedBGBContainer.__onClose = function(f38_arg0)
	f38_arg0.UpBGB:close()
	f38_arg0.RightBGB:close()
	f38_arg0.DownBGB:close()
	f38_arg0.LeftBGB:close()
	f38_arg0.ButtonPrompt:close()
	f38_arg0.Name:close()
end
