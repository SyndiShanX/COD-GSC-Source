require("x64:4064b08284c7dca")
CoD.MultiItemPickupTabBar = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupTabBar.__defaultWidth = 1920
CoD.MultiItemPickupTabBar.__defaultHeight = 34
CoD.MultiItemPickupTabBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.MultiItemPickupTabBar)
	self.id = "MultiItemPickupTabBar"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Tabs = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	Tabs:setLeftRight(0.5, 0.5, -250, 250)
	Tabs:setTopBottom(0, 0, 0, 34)
	Tabs:setWidgetType(CoD.MultiItemPickupTab)
	Tabs:setHorizontalCount(10)
	Tabs:setSpacing(0)
	Tabs:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Tabs:setDataSource("MultiItemPickupTab")
	self:addElement(Tabs)
	self.Tabs = Tabs
	Tabs.id = "Tabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MultiItemPickupTabBar.__onClose = function(f2_arg0)
	f2_arg0.Tabs:close()
end
