CoD.InGameTrialsRulesColumn = InheritFrom(LUI.UIElement)
CoD.InGameTrialsRulesColumn.__defaultWidth = 388
CoD.InGameTrialsRulesColumn.__defaultHeight = 696
CoD.InGameTrialsRulesColumn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InGameTrialsRulesColumn)
	self.id = "InGameTrialsRulesColumn"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 388, 0.5, 0.5, -346, 350)
	Background:setImage(RegisterImage(@"uie_trial_rules_bronze_normal"))
	self:addElement(Background)
	self.Background = Background
	local Medal = LUI.UIImage.new(0, 0, 141, 233, 0, 0, 0, 92)
	Medal:setAlpha(0.5)
	Medal:setImage(RegisterImage(@"uie_trial_medal_bronze"))
	self:addElement(Medal)
	self.Medal = Medal
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InGameTrialsRulesColumn.__resetProperties = function(f2_arg0)
	f2_arg0.Medal:completeAnimation()
	f2_arg0.Medal:setAlpha(0.5)
end
CoD.InGameTrialsRulesColumn.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	AwardedCopy = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Medal:completeAnimation()
			f4_arg0.Medal:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Medal)
		end,
	},
	Awarded = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Medal:completeAnimation()
			f5_arg0.Medal:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Medal)
		end,
	},
}
