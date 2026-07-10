require("x64:7758a114327c316")
require("x64:c2fb0e3af1fb313")
CoD.TabletHealthBoost = InheritFrom(LUI.UIElement)
CoD.TabletHealthBoost.__defaultWidth = 1080
CoD.TabletHealthBoost.__defaultHeight = 608
CoD.TabletHealthBoost.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletHealthBoost)
	self.id = "TabletHealthBoost"
	self.soundSet = "none"
	Engine[@"setupui3dwindow"](f1_arg1, 1, 1080, 608)
	self:setUI3DWindow(1)
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local HealthBoostGameMap = CoD.HealthBoostGameMap.new(f1_arg0, f1_arg1, 0, 0, 219.5, 860.5, 0, 0, 0, 405)
	self:addElement(HealthBoostGameMap)
	self.HealthBoostGameMap = HealthBoostGameMap
	local PlayerListWidget = CoD.HealthBoostPlayerList.new(f1_arg0, f1_arg1, 0, 0, 10, 1070, 0, 0, 418, 608)
	self:addElement(PlayerListWidget)
	self.PlayerListWidget = PlayerListWidget
	PlayerListWidget.id = "PlayerListWidget"
	self.__defaultFocus = PlayerListWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.PlayerListWidget)
	return self
end
CoD.TabletHealthBoost.__onClose = function(f2_arg0)
	f2_arg0.HealthBoostGameMap:close()
	f2_arg0.PlayerListWidget:close()
end
