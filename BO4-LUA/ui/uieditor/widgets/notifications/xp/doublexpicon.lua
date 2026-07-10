require("x64:f72d4606ccc678a")
CoD.DoubleXPIcon = InheritFrom(LUI.UIElement)
CoD.DoubleXPIcon.__defaultWidth = 72
CoD.DoubleXPIcon.__defaultHeight = 72
CoD.DoubleXPIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DoubleXPIcon)
	self.id = "DoubleXPIcon"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXpIcon = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, 0, 72)
	self:addElement(DoubleXpIcon)
	self.DoubleXpIcon = DoubleXpIcon
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsDoubleXP(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPIcon.__resetProperties = function(f3_arg0)
	f3_arg0.DoubleXpIcon:completeAnimation()
	f3_arg0.DoubleXpIcon:setAlpha(1)
end
CoD.DoubleXPIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.DoubleXpIcon:completeAnimation()
			f4_arg0.DoubleXpIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DoubleXpIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DoubleXPIcon.__onClose = function(f6_arg0)
	f6_arg0.DoubleXpIcon:close()
end
