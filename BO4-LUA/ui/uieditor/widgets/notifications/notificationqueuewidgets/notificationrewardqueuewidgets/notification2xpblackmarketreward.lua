CoD.Notification2xpBlackMarketReward = InheritFrom(LUI.UIElement)
CoD.Notification2xpBlackMarketReward.__defaultWidth = 72
CoD.Notification2xpBlackMarketReward.__defaultHeight = 72
CoD.Notification2xpBlackMarketReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Notification2xpBlackMarketReward)
	self.id = "Notification2xpBlackMarketReward"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XpSmall = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	XpSmall:setImage(RegisterImage("ui_icon_2xp_blackmarket_small"))
	self:addElement(XpSmall)
	self.XpSmall = XpSmall
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsTierBoostActive(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		if not IsSelfInState(self, "Visible") then
			HideWidget(self)
		else
			ShowWidget(self)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
