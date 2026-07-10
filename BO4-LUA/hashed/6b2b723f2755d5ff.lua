CoD.PositionDraft_ReadyPulse = InheritFrom(LUI.UIElement)
CoD.PositionDraft_ReadyPulse.__defaultWidth = 60
CoD.PositionDraft_ReadyPulse.__defaultHeight = 75
CoD.PositionDraft_ReadyPulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_ReadyPulse)
	self.id = "PositionDraft_ReadyPulse"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PulseR01 = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 0, 75)
	PulseR01:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	PulseR01:setAlpha(0)
	PulseR01:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	PulseR01:setShaderVector(0, 0.08, 1, 0, 0)
	PulseR01:setShaderVector(1, 1.01, 0, 0, 0)
	PulseR01:setShaderVector(2, 0, 1, 0, 0)
	PulseR01:setShaderVector(3, 0, 0, 0, 0)
	PulseR01:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(PulseR01)
	self.PulseR01 = PulseR01
	local PulseR02 = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 0, 75)
	PulseR02:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	PulseR02:setAlpha(0)
	PulseR02:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	PulseR02:setShaderVector(0, 0.08, 1, 0, 0)
	PulseR02:setShaderVector(1, 1.01, 0, 0, 0)
	PulseR02:setShaderVector(2, 0, 1, 0, 0)
	PulseR02:setShaderVector(3, 0, 0, 0, 0)
	PulseR02:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(PulseR02)
	self.PulseR02 = PulseR02
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_ReadyPulse.__resetProperties = function(f2_arg0)
	f2_arg0.PulseR01:completeAnimation()
	f2_arg0.PulseR02:completeAnimation()
	f2_arg0.PulseR01:setLeftRight(0, 0, 0, 10)
	f2_arg0.PulseR01:setTopBottom(0, 0, 0, 75)
	f2_arg0.PulseR01:setAlpha(0)
	f2_arg0.PulseR02:setLeftRight(0, 0, 0, 10)
	f2_arg0.PulseR02:setTopBottom(0, 0, 0, 75)
	f2_arg0.PulseR02:setAlpha(0)
end
CoD.PositionDraft_ReadyPulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(500)
						f6_arg0:setLeftRight(0, 0, 0, 10)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(700)
					f5_arg0:setLeftRight(0, 0, 38, 48)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.PulseR01:beginAnimation(300)
				f3_arg0.PulseR01:setLeftRight(0, 0, 11.4, 21.4)
				f3_arg0.PulseR01:setAlpha(1)
				f3_arg0.PulseR01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.PulseR01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.PulseR01:completeAnimation()
			f3_arg0.PulseR01:setLeftRight(0, 0, 0, 10)
			f3_arg0.PulseR01:setTopBottom(0, 0, 0, 75)
			f3_arg0.PulseR01:setAlpha(0)
			f3_local0(f3_arg0.PulseR01)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(500)
						f9_arg0:setLeftRight(0, 0, 0, 10)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(700)
					f8_arg0:setLeftRight(0, 0, 38, 48)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f7_arg0:beginAnimation(300)
				f7_arg0:setLeftRight(0, 0, 11.4, 21.4)
				f7_arg0:setAlpha(1)
				f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.PulseR02:beginAnimation(500)
			f3_arg0.PulseR02:setLeftRight(0, 0, 0, 10)
			f3_arg0.PulseR02:setTopBottom(0, 0, 0, 75)
			f3_arg0.PulseR02:setAlpha(0)
			f3_arg0.PulseR02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.PulseR02:registerEventHandler("transition_complete_keyframe", f3_local1)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
