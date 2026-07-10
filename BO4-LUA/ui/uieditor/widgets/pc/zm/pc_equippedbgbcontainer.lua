require("x64:b57564707d9eb98")
CoD.PC_EquippedBGBContainer = InheritFrom(LUI.UIElement)
CoD.PC_EquippedBGBContainer.__defaultWidth = 127
CoD.PC_EquippedBGBContainer.__defaultHeight = 464
CoD.PC_EquippedBGBContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_EquippedBGBContainer)
	self.id = "PC_EquippedBGBContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local FourthBGB = CoD.PC_EquippedBGB.new(f1_arg0, f1_arg1, 0.5, 0.5, -55, 55, 0.5, 0.5, 117, 227)
	FourthBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Left", function(model)
		FourthBGB:setModel(model, f1_arg1)
	end)
	FourthBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Left.promptPC", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FourthBGB.PCkeybind:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	local SecondBGB = FourthBGB
	local ThirdBGB = FourthBGB.subscribeToModel
	local FirstBGB = DataSources.BGBLoadout.getModel(f1_arg1)
	ThirdBGB(SecondBGB, FirstBGB.selectedIndex, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	FourthBGB:linkToElementModel(FourthBGB, "slotIndex", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	FourthBGB:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		if IsCurrentMenu(f1_arg0, "BubblegumBuffSelect") then
			CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots(f1_arg0, element, f1_arg1)
			CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_arg0, self, element, f1_arg1)
		else
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		end
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FourthBGB, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
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
	self:addElement(FourthBGB)
	self.FourthBGB = FourthBGB
	ThirdBGB = CoD.PC_EquippedBGB.new(f1_arg0, f1_arg1, 0.5, 0.5, -55, 55, 0.5, 0.5, 3, 113)
	ThirdBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Down", function(model)
		ThirdBGB:setModel(model, f1_arg1)
	end)
	ThirdBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Down.promptPC", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ThirdBGB.PCkeybind:setText(Engine[@"hash_4F9F1239CFD921FE"](f10_local0))
		end
	end)
	FirstBGB = ThirdBGB
	SecondBGB = ThirdBGB.subscribeToModel
	local f1_local5 = DataSources.BGBLoadout.getModel(f1_arg1)
	SecondBGB(FirstBGB, f1_local5.selectedIndex, function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ThirdBGB:linkToElementModel(ThirdBGB, "slotIndex", true, function(model, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ThirdBGB:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		if IsCurrentMenu(f1_arg0, "BubblegumBuffSelect") then
			CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots(f1_arg0, element, f1_arg1)
			CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_arg0, self, element, f1_arg1)
		else
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		end
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ThirdBGB, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
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
	self:addElement(ThirdBGB)
	self.ThirdBGB = ThirdBGB
	SecondBGB = CoD.PC_EquippedBGB.new(f1_arg0, f1_arg1, 0.5, 0.5, -55, 55, 0.5, 0.5, -111, -1)
	SecondBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Right", function(model)
		SecondBGB:setModel(model, f1_arg1)
	end)
	SecondBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Right.promptPC", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			SecondBGB.PCkeybind:setText(Engine[@"hash_4F9F1239CFD921FE"](f17_local0))
		end
	end)
	f1_local5 = SecondBGB
	FirstBGB = SecondBGB.subscribeToModel
	local f1_local6 = DataSources.BGBLoadout.getModel(f1_arg1)
	FirstBGB(f1_local5, f1_local6.selectedIndex, function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	SecondBGB:linkToElementModel(SecondBGB, "slotIndex", true, function(model, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	SecondBGB:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		if IsCurrentMenu(f1_arg0, "BubblegumBuffSelect") then
			CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots(f1_arg0, element, f1_arg1)
			CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_arg0, self, element, f1_arg1)
		else
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		end
		return f20_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SecondBGB, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
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
	self:addElement(SecondBGB)
	self.SecondBGB = SecondBGB
	FirstBGB = CoD.PC_EquippedBGB.new(f1_arg0, f1_arg1, 0.5, 0.5, -55, 55, 0.5, 0.5, -225, -115)
	FirstBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Up", function(model)
		FirstBGB:setModel(model, f1_arg1)
	end)
	FirstBGB:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Up.promptPC", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			FirstBGB.PCkeybind:setText(Engine[@"hash_4F9F1239CFD921FE"](f24_local0))
		end
	end)
	f1_local6 = FirstBGB
	f1_local5 = FirstBGB.subscribeToModel
	local f1_local7 = DataSources.BGBLoadout.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.selectedIndex, function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	FirstBGB:linkToElementModel(FirstBGB, "slotIndex", true, function(model, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	FirstBGB:registerEventHandler("gain_focus", function(element, event)
		local f27_local0 = nil
		if element.gainFocus then
			f27_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f27_local0 = element.super:gainFocus(event)
		end
		if IsCurrentMenu(f1_arg0, "BubblegumBuffSelect") then
			CoD.ZMLoadoutUtility.UpdateBGBInfoFromEquippedSlots(f1_arg0, element, f1_arg1)
			CoD.ZMLoadoutUtility.ShowBubblegumBuffModel(f1_arg0, self, element, f1_arg1)
		else
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		end
		return f27_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FirstBGB, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
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
	self:addElement(FirstBGB)
	self.FirstBGB = FirstBGB
	FourthBGB.id = "FourthBGB"
	ThirdBGB.id = "ThirdBGB"
	SecondBGB.id = "SecondBGB"
	FirstBGB.id = "FirstBGB"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_EquippedBGBContainer.__onClose = function(f30_arg0)
	f30_arg0.FourthBGB:close()
	f30_arg0.ThirdBGB:close()
	f30_arg0.SecondBGB:close()
	f30_arg0.FirstBGB:close()
end
