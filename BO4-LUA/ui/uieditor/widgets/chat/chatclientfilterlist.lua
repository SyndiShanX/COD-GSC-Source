require("x64:dfdca1daf33c8b0")
CoD.ChatClientFilterList = InheritFrom(LUI.UIElement)
CoD.ChatClientFilterList.__defaultWidth = 125
CoD.ChatClientFilterList.__defaultHeight = 120
CoD.ChatClientFilterList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientFilterList)
	self.id = "ChatClientFilterList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FiltersList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	FiltersList:setLeftRight(0, 0, 0, 125)
	FiltersList:setTopBottom(0, 0, 0, 240)
	FiltersList:setWidgetType(CoD.ChatClientFilterList_Item)
	FiltersList:setVerticalCount(8)
	FiltersList:setSpacing(0)
	FiltersList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FiltersList:setDataSource("ChatClientFiltersOptionsList")
	self:addElement(FiltersList)
	self.FiltersList = FiltersList
	FiltersList.id = "FiltersList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	MakeNotFocusable(self.FiltersList, f1_arg1)
	return self
end
CoD.ChatClientFilterList.__resetProperties = function(f2_arg0)
	f2_arg0.FiltersList:completeAnimation()
	f2_arg0.FiltersList:setAlpha(1)
end
CoD.ChatClientFilterList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.FiltersList:completeAnimation()
			f3_arg0.FiltersList:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.FiltersList)
		end,
		InputFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.FiltersList:completeAnimation()
			f4_arg0.FiltersList:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.FiltersList)
		end,
	},
	Closed = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.FiltersList:completeAnimation()
			f5_arg0.FiltersList:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.FiltersList)
		end,
	},
}
CoD.ChatClientFilterList.__onClose = function(f6_arg0)
	f6_arg0.FiltersList:close()
end
