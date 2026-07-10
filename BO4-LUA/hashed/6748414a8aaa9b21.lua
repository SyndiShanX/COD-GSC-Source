CoD.HealthBarWidgetPulse = InheritFrom(LUI.UIElement)
CoD.HealthBarWidgetPulse.__defaultWidth = 156
CoD.HealthBarWidgetPulse.__defaultHeight = 20
CoD.HealthBarWidgetPulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBarWidgetPulse)
	self.id = "HealthBarWidgetPulse"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PulseBar = LUI.UIImage.new(0.32, 0.32, -49, 107, 0.63, 0.63, -101.5, 97.5)
	PulseBar:setRGB(1, 0, 0)
	PulseBar:setImage(RegisterImage(@"hash_2D5B703C3B0F386D"))
	PulseBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	PulseBar:setShaderVector(0, 4, 1, 0, 0)
	PulseBar:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(PulseBar)
	self.PulseBar = PulseBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HealthBarWidgetPulse.__resetProperties = function(f2_arg0)
	f2_arg0.PulseBar:completeAnimation()
	f2_arg0.PulseBar:setLeftRight(0.32, 0.32, -49, 107)
	f2_arg0.PulseBar:setTopBottom(0.63, 0.63, -101.5, 97.5)
end
CoD.HealthBarWidgetPulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(299)
					f5_arg0:setTopBottom(0.63, 0.63, -12.5, 7.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.PulseBar:beginAnimation(50)
				f3_arg0.PulseBar:setTopBottom(0.63, 0.63, -502, 498)
				f3_arg0.PulseBar:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.PulseBar:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.PulseBar:completeAnimation()
			f3_arg0.PulseBar:setLeftRight(0.32, 0.32, -49, 107)
			f3_arg0.PulseBar:setTopBottom(0.63, 0.63, -12.5, 7.5)
			f3_local0(f3_arg0.PulseBar)
		end,
	},
}
