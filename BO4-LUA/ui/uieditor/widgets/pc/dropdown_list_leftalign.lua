require("x64:2675595fa323085")
require("x64:70f1229dabae38")
require("x64:baff2229992d7b6")
require("x64:59648045a39f73a")
CoD.Dropdown_List_LeftAlign = InheritFrom(LUI.UIElement)
CoD.Dropdown_List_LeftAlign.__defaultWidth = 364
CoD.Dropdown_List_LeftAlign.__defaultHeight = 246
CoD.Dropdown_List_LeftAlign.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Dropdown_List_LeftAlign)
	self.id = "Dropdown_List_LeftAlign"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local ScrollView = CoD.PC_VScrollList_List.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ScrollView.View:setWidgetType(CoD.Dropdown_ListItem_LeftAlign)
	ScrollView.View:setVerticalCount(20)
	ScrollView.View:setSpacing(0)
	ScrollView:linkToElementModel(self, "optionsDatasource", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ScrollView.View:setDataSource(f2_local0)
		end
	end)
	self:addElement(ScrollView)
	self.ScrollView = ScrollView
	local VScrollbar = CoD.PC_VScrollbar.new(f1_arg0, f1_arg1, 0, 0, 336, 350, 0, 1, 0, 0)
	VScrollbar:setAlpha(0)
	self:addElement(VScrollbar)
	self.VScrollbar = VScrollbar
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.PCWidgetUtility.DropdownClose(self)
		CoD.PCWidgetUtility.DropdownGiveFocusBack(self, menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, nil)
		return false
	end, false)
	self:linkToElementModel(self, "isOpen", true, function(model)
		local f5_local0 = self
		CoD.PCWidgetUtility.OnDropdownIsOpenChange(self, model)
	end)
	emptyFocusable.id = "emptyFocusable"
	ScrollView.id = "ScrollView"
	VScrollbar.id = "VScrollbar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	DisableKeyboardNavigationByElement(self.emptyFocusable)
	CoD.PCWidgetUtility.PrepareContextList(self, f1_arg1, f1_arg0)
	return self
end
CoD.Dropdown_List_LeftAlign.__onClose = function(f6_arg0)
	f6_arg0.emptyFocusable:close()
	f6_arg0.ScrollView:close()
	f6_arg0.VScrollbar:close()
end
