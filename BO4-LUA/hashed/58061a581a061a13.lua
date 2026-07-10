require("x64:2675595fa323085")
require("x64:f02462d210e1771")
require("x64:d705ab885782def")
CoD.WarzoneSplitInventory_PC = InheritFrom(LUI.UIElement)
CoD.WarzoneSplitInventory_PC.__defaultWidth = 100
CoD.WarzoneSplitInventory_PC.__defaultHeight = 100
CoD.WarzoneSplitInventory_PC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneSplitInventory_PC)
	self.id = "WarzoneSplitInventory_PC"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0.5, 0.5, -52.5, 52.5, 0, 0, 20, 102)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = LUI.UIImage.new(0.5, 0.5, -52.5, 52.5, 0, 0, 20, 102)
	Background:setRGB(0.04, 0.04, 0.04)
	Background:setAlpha(0.96)
	self:addElement(Background)
	self.Background = Background
	local CounterBackground = LUI.UIImage.new(0.5, 0.5, -50, 50, 0, 0, 76, 99)
	CounterBackground:setRGB(0.55, 0.54, 0.49)
	self:addElement(CounterBackground)
	self.CounterBackground = CounterBackground
	local FocusBlocker = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, -20, 20, 0, 1, 0, 0)
	self:addElement(FocusBlocker)
	self.FocusBlocker = FocusBlocker
	local TotalCount = LUI.UIText.new(0.5, 0.5, 5.5, 30.5, 0, 0, 79, 100)
	TotalCount:setRGB(0.04, 0.04, 0.04)
	TotalCount:setTTF("dinnext_regular")
	TotalCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TotalCount:subscribeToGlobalModel(f1_arg1, "WarzoneSplitInventory", "max", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TotalCount:setText(f2_local0)
		end
	end)
	self:addElement(TotalCount)
	self.TotalCount = TotalCount
	local Slash = LUI.UIText.new(0.5, 0.5, -6.5, 6.5, 0, 0, 79, 100)
	Slash:setRGB(0.04, 0.04, 0.04)
	Slash:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/slash"))
	Slash:setTTF("dinnext_regular")
	Slash:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Slash:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Slash)
	self.Slash = Slash
	local DropCount = LUI.UIText.new(0.5, 0.5, -30.5, -5.5, 0, 0, 79, 100)
	DropCount:setRGB(0.04, 0.04, 0.04)
	DropCount:setTTF("dinnext_regular")
	DropCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	DropCount:subscribeToGlobalModel(f1_arg1, "WarzoneSplitInventory", "current", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DropCount:setText(f3_local0)
		end
	end)
	self:addElement(DropCount)
	self.DropCount = DropCount
	local ApplyButton = CoD.WarzoneSplitInventory_PC_TextButton.new(f1_arg0, f1_arg1, 0, 0, -1, 101, 0, 0, 22, 48)
	ApplyButton.Label:setText(LocalizeToUpperString(@"hash_67D14DF1D6CBE990"))
	ApplyButton:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ApplyButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		CoD.WZUtility.ApplyPCSplitterWidget(self, menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(ApplyButton)
	self.ApplyButton = ApplyButton
	local AddButton = CoD.WarzoneSplitInventory_PC_ImageButton.new(f1_arg0, f1_arg1, 0, 0, 50, 100, 0, 0, 50, 74)
	AddButton:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneSplitInventory", "canIncrement")
			end,
		},
	})
	local f1_local10 = AddButton
	local RemoveButton = AddButton.subscribeToModel
	local f1_local12 = DataSources.WarzoneSplitInventory.getModel(f1_arg1)
	RemoveButton(f1_local10, f1_local12.canIncrement, function(f8_arg0)
		f1_arg0:updateElementState(AddButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "canIncrement",
		})
	end, false)
	AddButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AddButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		CoD.WZUtility.IncrementSplitCount(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(AddButton)
	self.AddButton = AddButton
	RemoveButton = CoD.WarzoneSplitInventory_PC_ImageButton.new(f1_arg0, f1_arg1, 0, 0, 0, 50, 0, 0, 50, 74)
	RemoveButton:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneSplitInventory", "canDecrement")
			end,
		},
	})
	f1_local12 = RemoveButton
	f1_local10 = RemoveButton.subscribeToModel
	local f1_local13 = DataSources.WarzoneSplitInventory.getModel(f1_arg1)
	f1_local10(f1_local12, f1_local13.canDecrement, function(f13_arg0)
		f1_arg0:updateElementState(RemoveButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "canDecrement",
		})
	end, false)
	RemoveButton.Image:setImage(RegisterImage(@"uie_ui_menu_common_remove_minus"))
	RemoveButton.add:setImage(RegisterImage(@"uie_ui_menu_common_remove_minus"))
	RemoveButton:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RemoveButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		CoD.WZUtility.DecrementSplitCount(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(RemoveButton)
	self.RemoveButton = RemoveButton
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.WZUtility.ApplyPCSplitterWidget(self, menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "WarzoneInventory", "isOpen", function(model)
		local f21_local0 = self
		if not CoD.WZUtility.IsInventoryOpen(f1_arg1) then
			CoD.WZUtility.ClosePCSplitterWidget(self, f1_arg0, f1_arg1)
		end
	end)
	FocusBlocker.id = "FocusBlocker"
	ApplyButton.id = "ApplyButton"
	AddButton.id = "AddButton"
	RemoveButton.id = "RemoveButton"
	self.__defaultFocus = ApplyButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	DisableKeyboardNavigationByElement(FocusBlocker)
	return self
end
CoD.WarzoneSplitInventory_PC.__resetProperties = function(f22_arg0)
	f22_arg0.RemoveButton:completeAnimation()
	f22_arg0.AddButton:completeAnimation()
	f22_arg0.ApplyButton:completeAnimation()
	f22_arg0.DropCount:completeAnimation()
	f22_arg0.Slash:completeAnimation()
	f22_arg0.TotalCount:completeAnimation()
	f22_arg0.CounterBackground:completeAnimation()
	f22_arg0.FocusBlocker:completeAnimation()
	f22_arg0.Background:completeAnimation()
	f22_arg0.Blur:completeAnimation()
	f22_arg0.RemoveButton:setAlpha(1)
	f22_arg0.AddButton:setAlpha(1)
	f22_arg0.ApplyButton:setAlpha(1)
	f22_arg0.DropCount:setAlpha(1)
	f22_arg0.Slash:setAlpha(1)
	f22_arg0.TotalCount:setAlpha(1)
	f22_arg0.CounterBackground:setAlpha(1)
	f22_arg0.FocusBlocker:setAlpha(1)
	f22_arg0.Background:setAlpha(0.96)
	f22_arg0.Blur:setAlpha(1)
end
CoD.WarzoneSplitInventory_PC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(10)
			f23_arg0.Blur:completeAnimation()
			f23_arg0.Blur:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Blur)
			f23_arg0.Background:completeAnimation()
			f23_arg0.Background:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Background)
			f23_arg0.CounterBackground:completeAnimation()
			f23_arg0.CounterBackground:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CounterBackground)
			f23_arg0.FocusBlocker:completeAnimation()
			f23_arg0.FocusBlocker:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FocusBlocker)
			f23_arg0.TotalCount:completeAnimation()
			f23_arg0.TotalCount:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.TotalCount)
			f23_arg0.Slash:completeAnimation()
			f23_arg0.Slash:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Slash)
			f23_arg0.DropCount:completeAnimation()
			f23_arg0.DropCount:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.DropCount)
			f23_arg0.ApplyButton:completeAnimation()
			f23_arg0.ApplyButton:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ApplyButton)
			f23_arg0.AddButton:completeAnimation()
			f23_arg0.AddButton:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.AddButton)
			f23_arg0.RemoveButton:completeAnimation()
			f23_arg0.RemoveButton:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RemoveButton)
		end,
	},
	Open = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WarzoneSplitInventory_PC.__onClose = function(f25_arg0)
	f25_arg0.FocusBlocker:close()
	f25_arg0.TotalCount:close()
	f25_arg0.DropCount:close()
	f25_arg0.ApplyButton:close()
	f25_arg0.AddButton:close()
	f25_arg0.RemoveButton:close()
end
