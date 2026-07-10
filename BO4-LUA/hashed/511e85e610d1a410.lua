CoD.KillcamHealthBarPulse = InheritFrom(LUI.UIElement)
CoD.KillcamHealthBarPulse.__defaultWidth = 130
CoD.KillcamHealthBarPulse.__defaultHeight = 16
CoD.KillcamHealthBarPulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamHealthBarPulse)
	self.id = "KillcamHealthBarPulse"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PulseBar = LUI.UIImage.new(0, 1.03, -2, -2, 0, 0, 2.5, 12.5)
	PulseBar:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	PulseBar:setImage(RegisterImage(0xD5B703C3B0F386D))
	PulseBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x7EA4827662D4CD4))
	PulseBar:setShaderVector(0, 4, 1, 0, 0)
	PulseBar:setShaderVector(1, 0, 1, -0, 1)
	self:addElement(PulseBar)
	self.PulseBar = PulseBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamHealthBarPulse.__resetProperties = function(f2_arg0)
	f2_arg0.PulseBar:completeAnimation()
	f2_arg0.PulseBar:setTopBottom(0, 0, 2.5, 12.5)
	f2_arg0.PulseBar:setAlpha(1)
end
CoD.KillcamHealthBarPulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(59)
						f6_arg0:setTopBottom(0, 0, -292.5, 307.5)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(60)
					f5_arg0:setTopBottom(0, 0, -155, 170)
					f5_arg0:setAlpha(0.25)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.PulseBar:beginAnimation(40)
				f3_arg0.PulseBar:setTopBottom(0, 0, -17.5, 32.5)
				f3_arg0.PulseBar:setAlpha(1)
				f3_arg0.PulseBar:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.PulseBar:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.PulseBar:completeAnimation()
			f3_arg0.PulseBar:setTopBottom(0, 0, 2.5, 12.5)
			f3_arg0.PulseBar:setAlpha(0)
			f3_local0(f3_arg0.PulseBar)
		end,
	},
}
