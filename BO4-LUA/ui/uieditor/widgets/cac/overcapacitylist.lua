require("x64:4c5f8b13130c111")
CoD.OverCapacityList = InheritFrom(LUI.UIElement)
CoD.OverCapacityList.__defaultWidth = 2280
CoD.OverCapacityList.__defaultHeight = 100
CoD.OverCapacityList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OverCapacityList)
	self.id = "OverCapacityList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local itemList = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	itemList:setLeftRight(0, 0, 0, 2072)
	itemList:setTopBottom(0, 0, 0, 100)
	itemList:setWidgetType(CoD.OverCapacityItem)
	itemList:setHorizontalCount(10)
	itemList:setSpacing(8)
	itemList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	itemList:setDataSource("OverCapacityList")
	itemList:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local2 = itemList
	local f1_local3 = itemList.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	itemList:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(itemList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			RemoveOverflowItemFromClass(menu, self, element, controller)
			CoD.CACUtility.EquippedItemsChanged(menu, controller)
			PlaySoundAlias("cac_overload_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(itemList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			RemoveOverflowItemFromClass(menu, self, element, controller)
			CoD.CACUtility.EquippedItemsChanged(menu, controller)
			PlaySoundAlias("cac_overload_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(itemList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsGamepad(controller) then
			RemoveOverflowItemFromClass(menu, self, element, controller)
			CoD.CACUtility.EquippedItemsChanged(menu, controller)
			PlaySoundAlias("cac_overload_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x679ACA6FFC6C8F3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(itemList)
	self.itemList = itemList
	itemList.id = "itemList"
	self.__defaultFocus = itemList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OverCapacityList.__onClose = function(f11_arg0)
	f11_arg0.itemList:close()
end
