CoD.ZMTrialMedal = InheritFrom(LUI.UIElement)
CoD.ZMTrialMedal.__defaultWidth = 100
CoD.ZMTrialMedal.__defaultHeight = 100
CoD.ZMTrialMedal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMTrialMedal)
	self.id = "ZMTrialMedal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Medal = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Medal:setAlpha(0.2)
	self:addElement(Medal)
	self.Medal = Medal
	self:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTrialMedal.__resetProperties = function(f3_arg0)
	f3_arg0.Medal:completeAnimation()
	f3_arg0.Medal:setAlpha(0.2)
end
CoD.ZMTrialMedal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Complete = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Medal:completeAnimation()
			f5_arg0.Medal:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Medal)
		end,
	},
}
