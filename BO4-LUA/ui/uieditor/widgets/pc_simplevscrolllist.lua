require("x64:2675595fa323085")
require("x64:aed1ac7f246af18")
require("x64:baff2229992d7b6")
CoD.PC_SimpleVScrollList = InheritFrom(LUI.UIElement)
CoD.PC_SimpleVScrollList.__defaultWidth = 1007
CoD.PC_SimpleVScrollList.__defaultHeight = 1080
CoD.PC_SimpleVScrollList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_SimpleVScrollList)
	self.id = "PC_SimpleVScrollList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1.03, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local ScrollView = CoD.PC_SimpleVScrollList_List.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ScrollView)
	self.ScrollView = ScrollView
	local VScrollbar = CoD.PC_VScrollbar.new(f1_arg0, f1_arg1, 1, 1, 2, 16, 0, 1, 0, 0)
	self:addElement(VScrollbar)
	self.VScrollbar = VScrollbar
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f2_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_7C72FFE9CF2F9FFA") then
			CoD.PCWidgetUtility.ScrollUpDown(self, f1_arg1, f1_arg0, model)
		end
	end)
	emptyFocusable.id = "emptyFocusable"
	ScrollView.id = "ScrollView"
	VScrollbar.id = "VScrollbar"
	self.__defaultFocus = ScrollView
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.PCWidgetUtility.PrepareSimpleVScrollWidget(self, f1_arg1, f1_arg0)
	CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	DisableKeyboardNavigationByElement(self.emptyFocusable)
	return self
end
CoD.PC_SimpleVScrollList.__onClose = function(f3_arg0)
	f3_arg0.emptyFocusable:close()
	f3_arg0.ScrollView:close()
	f3_arg0.VScrollbar:close()
end
