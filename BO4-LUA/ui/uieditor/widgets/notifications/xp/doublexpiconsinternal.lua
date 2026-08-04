require("ui/uieditor/widgets/notifications/notificationqueuewidgets/notificationrewardqueuewidgets/notification2xpblackmarketreward")
require("ui/uieditor/widgets/notifications/notificationqueuewidgets/notificationrewardqueuewidgets/notification2xpreward")
require("ui/uieditor/widgets/notifications/notificationqueuewidgets/notificationrewardqueuewidgets/notification2xpweaponreward")
require("ui/uieditor/widgets/zmfrontend/zmdoublenpwidget")
CoD.DoubleXPIconsInternal = InheritFrom(LUI.UIElement)
CoD.DoubleXPIconsInternal.__defaultWidth = 216
CoD.DoubleXPIconsInternal.__defaultHeight = 72
CoD.DoubleXPIconsInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.DoubleXPIconsInternal)
	self.id = "DoubleXPIconsInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DoubleXPIcon = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, 0, 72)
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	local DoubleWeaponXPIcon = CoD.Notification2xpWeaponReward.new(f1_arg0, f1_arg1, 0, 0, 72, 144, 0, 0, 0, 72)
	self:addElement(DoubleWeaponXPIcon)
	self.DoubleWeaponXPIcon = DoubleWeaponXPIcon
	local TierBoost = CoD.Notification2xpBlackMarketReward.new(f1_arg0, f1_arg1, 0, 0, 144, 216, 0, 0, 0, 72)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	local ZMDoubleNPWidget = CoD.ZMDoubleNPWidget.new(f1_arg0, f1_arg1, 0, 0, 216, 288, 0, 0, 0, 72)
	self:addElement(ZMDoubleNPWidget)
	self.ZMDoubleNPWidget = ZMDoubleNPWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPIconsInternal.__onClose = function(f2_arg0)
	f2_arg0.DoubleXPIcon:close()
	f2_arg0.DoubleWeaponXPIcon:close()
	f2_arg0.TierBoost:close()
	f2_arg0.ZMDoubleNPWidget:close()
end
