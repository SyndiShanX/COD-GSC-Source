require("x64:683120446682173")
CoD.StartMenu_SmallTierBoostNotification = InheritFrom(LUI.UIElement)
CoD.StartMenu_SmallTierBoostNotification.__defaultWidth = 50
CoD.StartMenu_SmallTierBoostNotification.__defaultHeight = 50
CoD.StartMenu_SmallTierBoostNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_SmallTierBoostNotification)
	self.id = "StartMenu_SmallTierBoostNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TierBoost = CoD.Notification2xpBlackMarketReward.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_SmallTierBoostNotification.__resetProperties = function(f2_arg0)
	f2_arg0.TierBoost:completeAnimation()
	f2_arg0.TierBoost:setAlpha(1)
end
CoD.StartMenu_SmallTierBoostNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.TierBoost:completeAnimation()
			f3_arg0.TierBoost:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.TierBoost)
		end,
	},
	TierBoost = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TierBoost:completeAnimation()
			f4_arg0.TierBoost:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.TierBoost)
		end,
	},
}
CoD.StartMenu_SmallTierBoostNotification.__onClose = function(f5_arg0)
	f5_arg0.TierBoost:close()
end
