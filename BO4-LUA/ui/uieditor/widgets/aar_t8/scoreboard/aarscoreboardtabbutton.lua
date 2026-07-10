require("x64:734464c97e2e0ae")
CoD.AARScoreboardTabButton = InheritFrom(LUI.UIElement)
CoD.AARScoreboardTabButton.__defaultWidth = 678
CoD.AARScoreboardTabButton.__defaultHeight = 34
CoD.AARScoreboardTabButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARScoreboardTabButton)
	self.id = "AARScoreboardTabButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Tab = CoD.AARTabButtonInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -560, 560, 0, 0, 51.5, 86.5)
	self:addElement(Tab)
	self.Tab = Tab
	local TabBottomLine = LUI.UIImage.new(0.5, 0.5, -410, 410, 0, 0, 85.5, 89.5)
	TabBottomLine:setAlpha(0.08)
	TabBottomLine:setImage(RegisterImage(@"uie_ui_menu_common_tab_line_bottom"))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	self:mergeStateConditions({
		{
			stateName = "Offline",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Tab.id = "Tab"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	f1_local4 = Tab
	if IsPC() then
		CoD.PCUtility.SetHandleMouse(self, true)
	end
	return self
end
CoD.AARScoreboardTabButton.__onClose = function(f4_arg0)
	f4_arg0.Tab:close()
end
