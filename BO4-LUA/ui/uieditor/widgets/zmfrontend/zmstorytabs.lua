require("x64:36eac97d208251e")
require("x64:194a3c2b978e81")
CoD.ZMStoryTabs = InheritFrom(LUI.UIElement)
CoD.ZMStoryTabs.__defaultWidth = 1920
CoD.ZMStoryTabs.__defaultHeight = 60
CoD.ZMStoryTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMStoryTabs)
	self.id = "ZMStoryTabs"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ZMStoryList = CoD.CommonSecondaryTabBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 0, 60)
	ZMStoryList.Tabs.grid:setWidgetType(CoD.ZMStoryListButton)
	ZMStoryList.Tabs.grid:setDataSource("ZMStoryLoadouts")
	ZMStoryList:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		CoD.ZMStoryUtility.UpdateSelectedStory(element, f1_arg1)
		UpdateButtonPromptState(f1_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		return f2_local0
	end)
	self:addElement(ZMStoryList)
	self.ZMStoryList = ZMStoryList
	ZMStoryList.id = "ZMStoryList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMStoryTabs.__onClose = function(f3_arg0)
	f3_arg0.ZMStoryList:close()
end
