require("x64:1394ae5e9cdcb54")
require("x64:81a24c5340caa1e")
require("x64:f05ce99c62baa19")
CoD.DirectorTabHeader = InheritFrom(LUI.UIElement)
CoD.DirectorTabHeader.__defaultWidth = 1920
CoD.DirectorTabHeader.__defaultHeight = 98
CoD.DirectorTabHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.DirectorTabHeader)
	self.id = "DirectorTabHeader"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -2, 3, 0, 0, 0, 0, 52, 89)
	self.__on_menuOpened_TabBacking = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = TabBacking
		if IsPC() then
			SizeToWidthOfScreen(f2_local0, f2_arg1)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_TabBacking)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, -50, 150, 0, 0, 53, 87)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local tabsList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	tabsList:setLeftRight(0, 0, 155, 1765)
	tabsList:setTopBottom(0, 0, 52, 87)
	tabsList:setWidgetType(CoD.DirectorSelectGlowTab)
	tabsList:setHorizontalCount(7)
	tabsList:setSpacing(0)
	tabsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	tabsList:setStaggeredIntroTime(50)
	self:addElement(tabsList)
	self.tabsList = tabsList
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 1770, 1970, 0, 0, 53, 87)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	tabsList.id = "tabsList"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_TabBacking)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	f1_local5 = tabsList
	DisableKeyboardNavigationByElement(f1_local5)
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local5, f1_arg1)
	return self
end
CoD.DirectorTabHeader.__onClose = function(f4_arg0)
	f4_arg0.__on_close_removeOverrides()
	f4_arg0.TabBacking:close()
	f4_arg0.LB:close()
	f4_arg0.tabsList:close()
	f4_arg0.RB:close()
end
