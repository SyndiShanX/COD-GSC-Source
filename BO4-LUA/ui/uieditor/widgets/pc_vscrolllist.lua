require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/pc_vscrollbar")
require("ui/uieditor/widgets/pc/pc_vscrolllist_list")
CoD.PC_VScrollList = InheritFrom(LUI.UIElement)
CoD.PC_VScrollList.__defaultWidth = 1007
CoD.PC_VScrollList.__defaultHeight = 1080
CoD.PC_VScrollList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_VScrollList)
	self.id = "PC_VScrollList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local ScrollView = CoD.PC_VScrollList_List.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ScrollView)
	self.ScrollView = ScrollView
	local VScrollbar = CoD.PC_VScrollbar.new(f1_arg0, f1_arg1, 1, 1, 15, 29, 0, 1, 0, 0)
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
	CoD.PCWidgetUtility.PrepareVScrollWidget(self, f1_arg1, f1_arg0)
	CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	DisableKeyboardNavigationByElement(self.emptyFocusable)
	return self
end
CoD.PC_VScrollList.__resetProperties = function(f3_arg0)
	f3_arg0.VScrollbar:completeAnimation()
	f3_arg0.VScrollbar:setLeftRight(1, 1, 15, 29)
end
CoD.PC_VScrollList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	ClipToList = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.VScrollbar:completeAnimation()
			f5_arg0.VScrollbar:setLeftRight(1, 1, 0, 14)
			f5_arg0.clipFinished(f5_arg0.VScrollbar)
		end,
	},
}
CoD.PC_VScrollList.__onClose = function(f6_arg0)
	f6_arg0.emptyFocusable:close()
	f6_arg0.ScrollView:close()
	f6_arg0.VScrollbar:close()
end
