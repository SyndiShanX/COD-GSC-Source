require("x64:2675595fa323085")
require("x64:18d56e190302ee4")
CoD.ReportDropdown_Container = InheritFrom(LUI.UIElement)
CoD.ReportDropdown_Container.__defaultWidth = 348
CoD.ReportDropdown_Container.__defaultHeight = 65
CoD.ReportDropdown_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PCWidgetUtility.PrepareReportPlayerDropdownProperties(self, f1_arg1)
	self:setClass(CoD.ReportDropdown_Container)
	self.id = "ReportDropdown_Container"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0, 0, 0)
	BG:setAlpha(0.2)
	self:addElement(BG)
	self.BG = BG
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:linkToElementModel(emptyFocusable, "refreshWidget", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emptyFocusable, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		if not CoD.PCUtility.IsUnavailable(self, controller) then
			CoD.PCWidgetUtility.CreateDropdown(self, self.DropdownList, controller, menu, "DropDown_ItemList")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.PCUtility.IsUnavailable(self, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local DropdownList = CoD.Dropdown_LeftAlign.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DropdownList:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
		{
			stateName = "Open",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOpen")
			end,
		},
		{
			stateName = "Close",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOpen")
			end,
		},
	})
	DropdownList:linkToElementModel(DropdownList, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(DropdownList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	DropdownList:linkToElementModel(DropdownList, "isOpen", true, function(model)
		f1_arg0:updateElementState(DropdownList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOpen",
		})
	end)
	DropdownList:linkToElementModel(self, nil, false, function(model)
		DropdownList:setModel(model, f1_arg1)
	end)
	DropdownList:linkToElementModel(self, "currentValue", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			DropdownList.TextBox:setText(CoD.BaseUtility.LocalizeIfXHash(CoD.PCWidgetUtility.ReportReasonToText(f1_arg1, f12_local0)))
		end
	end)
	self:addElement(DropdownList)
	self.DropdownList = DropdownList
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
		{
			stateName = "FadedOut",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.PCWidgetUtility.PrepareDropdownList(self, f1_arg1, f1_arg0, controller, self.DropdownList)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.PCWidgetUtility.ResetReportModel(f1_arg1)
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		local f18_local0 = self
		CoD.PCUtility.CallValueUpdateIfExist(self, f1_arg1)
	end)
	emptyFocusable.id = "emptyFocusable"
	DropdownList.id = "DropdownList"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReportDropdown_Container.__onClose = function(f19_arg0)
	f19_arg0.emptyFocusable:close()
	f19_arg0.DropdownList:close()
end
