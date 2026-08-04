require("ui/uieditor/widgets/playercard/selfidentitybadge")
CoD.IdentityBadgeUpperRightSafe = InheritFrom(LUI.UIElement)
CoD.IdentityBadgeUpperRightSafe.__defaultWidth = 1920
CoD.IdentityBadgeUpperRightSafe.__defaultHeight = 1080
CoD.IdentityBadgeUpperRightSafe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IdentityBadgeUpperRightSafe)
	self.id = "IdentityBadgeUpperRightSafe"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local SelfIdentityBadge = CoD.SelfIdentityBadge.new(f1_arg0, f1_arg1, 1, 1, -336, -5, 0, 0, 15, 80)
	SelfIdentityBadge:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		SelfIdentityBadge:setModel(model, f1_arg1)
	end)
	self:addElement(SelfIdentityBadge)
	self.SelfIdentityBadge = SelfIdentityBadge
	self.__on_menuOpened_self = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = self
		SizeToSafeArea(self, f3_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	SelfIdentityBadge.id = "SelfIdentityBadge"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IdentityBadgeUpperRightSafe.__onClose = function(f5_arg0)
	f5_arg0.__on_close_removeOverrides()
	f5_arg0.SelfIdentityBadge:close()
end
