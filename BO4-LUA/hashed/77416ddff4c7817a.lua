CoD.AARTierRewardFocusIndicator = InheritFrom(LUI.UIElement)
CoD.AARTierRewardFocusIndicator.__defaultWidth = 310
CoD.AARTierRewardFocusIndicator.__defaultHeight = 5
CoD.AARTierRewardFocusIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardFocusIndicator)
	self.id = "AARTierRewardFocusIndicator"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusIndicator = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FocusIndicator:setRGB(0, 1, 0)
	self:addElement(FocusIndicator)
	self.FocusIndicator = FocusIndicator
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardFocusIndicator.__resetProperties = function(f2_arg0)
	f2_arg0.FocusIndicator:completeAnimation()
	f2_arg0.FocusIndicator:setAlpha(1)
end
CoD.AARTierRewardFocusIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.FocusIndicator:completeAnimation()
			f4_arg0.FocusIndicator:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.FocusIndicator)
		end,
	},
}
