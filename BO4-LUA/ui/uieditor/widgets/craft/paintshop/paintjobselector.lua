require("x64:b69a99001e4d485")
require("x64:d297bcb2563a5d")
require("x64:38c11a77e96e48c")
CoD.PaintjobSelector = InheritFrom(LUI.UIElement)
CoD.PaintjobSelector.__defaultWidth = 1920
CoD.PaintjobSelector.__defaultHeight = 1080
CoD.PaintjobSelector.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintjobSelector)
	self.id = "PaintjobSelector"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local paintjobsList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, true, false, false, false)
	paintjobsList:mergeStateConditions({
		{
			stateName = "EmptySlot",
			condition = function(menu, element, event)
				return not Paintjobs_IsOccupied(element, f1_arg1)
			end,
		},
	})
	paintjobsList:linkToElementModel(paintjobsList, "paintjobSlot", true, function(model)
		f1_arg0:updateElementState(paintjobsList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "paintjobSlot",
		})
	end)
	paintjobsList:setLeftRight(0.5, 0.5, -721, 721)
	paintjobsList:setTopBottom(1, 1, -384, -114)
	paintjobsList:setWidgetType(CoD.PaintjobSelectorItem)
	paintjobsList:setHorizontalCount(5)
	paintjobsList:setVerticalCount(2)
	paintjobsList:setSpacing(18)
	paintjobsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	paintjobsList:setVerticalCounter(CoD.verticalCounter)
	paintjobsList:setDataSource("PaintjobList")
	paintjobsList:linkToElementModel(paintjobsList, "paintjobSlot", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end)
	paintjobsList:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end)
	local f1_local2 = paintjobsList
	local f1_local3 = paintjobsList.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end, false)
	paintjobsList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f7_local0 = nil
		PaintjobSelector_GainFocus(self, element, f1_arg1)
		return f7_local0
	end)
	paintjobsList:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(paintjobsList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CraftItemIsReadOnly(element, controller) then
			OpenPaintjobEditor(element, menu, controller, model)
			PlaySoundAlias("uin_menu_action")
			return true
		elseif CraftItemIsReadOnly(element, controller) then
			CoD.FileshareUtility.ShowSimpleToast(controller, CoD.FileshareUtility.ToastTypes.READONLY)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CraftItemIsReadOnly(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif CraftItemIsReadOnly(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(paintjobsList, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], "ui_contextual_2", function(element, menu, controller, model)
		if Paintjobs_IsOccupied(element, controller) and not IsMouseOrKeyboard(controller) then
			OpenPopup(self, "PaintjobSelectorOptions", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if Paintjobs_IsOccupied(element, controller) and not IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x543AEFED5923E39, nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	paintjobsList:AddContextualMenuAction(f1_arg0, f1_arg1, 0x8ADA48E694BFE2C, function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		if Paintjobs_IsOccupied(f13_arg0, f13_arg2) then
			return function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
				CoD.CraftUtility.PaintjobClear(self, f14_arg0, f14_arg2, "", f14_arg1)
			end
		else
		end
	end)
	paintjobsList:AddContextualMenuAction(f1_arg0, f1_arg1, 0x5AEC3D591F4359E, function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		if Paintjobs_IsOccupied(f15_arg0, f15_arg2) then
			return function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
				PaintjobSelector_CopyPaintjob(self, f16_arg0, f16_arg2, "", f16_arg1)
			end
		else
		end
	end)
	paintjobsList:AddContextualMenuAction(f1_arg0, f1_arg1, 0x543AEFED5923E39, function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
		if Paintjobs_IsOccupied(f17_arg0, f17_arg2) then
			return function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
				OpenPopup(self, "PaintjobSelectorOptions", f18_arg2, nil)
			end
		else
		end
	end)
	self:addElement(paintjobsList)
	self.paintjobsList = paintjobsList
	paintjobsList.id = "paintjobsList"
	self.__defaultFocus = paintjobsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintjobSelector.__onClose = function(f19_arg0)
	f19_arg0.paintjobsList:close()
end
