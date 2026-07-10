CoD.AmmoWidgetMP_Ultimate_Progress_Pulse = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_Ultimate_Progress_Pulse.__defaultWidth = 110
CoD.AmmoWidgetMP_Ultimate_Progress_Pulse.__defaultHeight = 112
CoD.AmmoWidgetMP_Ultimate_Progress_Pulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_Ultimate_Progress_Pulse)
	self.id = "AmmoWidgetMP_Ultimate_Progress_Pulse"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UltimateRadialMeterPulseA = LUI.UIImage.new(0, 0, 0, 110, 0, 0, 0, 112)
	UltimateRadialMeterPulseA:setImage(RegisterImage(0x25ED9C7DA021F0D))
	UltimateRadialMeterPulseA:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	UltimateRadialMeterPulseA:setShaderVector(0, 0.06, 0, -0.68, 0)
	UltimateRadialMeterPulseA:setShaderVector(1, 0.5, 0, 0, 0)
	UltimateRadialMeterPulseA:setShaderVector(2, 0.5, 0, 0, 0)
	UltimateRadialMeterPulseA:setShaderVector(3, 0.5, 0, 0, 0)
	UltimateRadialMeterPulseA:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(UltimateRadialMeterPulseA)
	self.UltimateRadialMeterPulseA = UltimateRadialMeterPulseA
	local UltimateRadialMeterPulseA2 = LUI.UIImage.new(0, 0, 0, 110, 0, 0, 0, 112)
	UltimateRadialMeterPulseA2:setImage(RegisterImage(0x25ED9C7DA021F0D))
	UltimateRadialMeterPulseA2:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	UltimateRadialMeterPulseA2:setShaderVector(0, 0.06, 0, -0.68, 0)
	UltimateRadialMeterPulseA2:setShaderVector(1, 0.5, 0, 0, 0)
	UltimateRadialMeterPulseA2:setShaderVector(2, 0.5, 0, 0, 0)
	UltimateRadialMeterPulseA2:setShaderVector(3, 0.5, 0, 0, 0)
	UltimateRadialMeterPulseA2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(UltimateRadialMeterPulseA2)
	self.UltimateRadialMeterPulseA2 = UltimateRadialMeterPulseA2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetMP_Ultimate_Progress_Pulse.__resetProperties = function(f2_arg0)
	f2_arg0.UltimateRadialMeterPulseA:completeAnimation()
	f2_arg0.UltimateRadialMeterPulseA2:completeAnimation()
	f2_arg0.UltimateRadialMeterPulseA:setAlpha(1)
	f2_arg0.UltimateRadialMeterPulseA:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	f2_arg0.UltimateRadialMeterPulseA:setShaderVector(0, 0.06, 0, -0.68, 0)
	f2_arg0.UltimateRadialMeterPulseA:setShaderVector(1, 0.5, 0, 0, 0)
	f2_arg0.UltimateRadialMeterPulseA:setShaderVector(2, 0.5, 0, 0, 0)
	f2_arg0.UltimateRadialMeterPulseA:setShaderVector(3, 0.5, 0, 0, 0)
	f2_arg0.UltimateRadialMeterPulseA:setShaderVector(4, 0, 0, 0, 0)
	f2_arg0.UltimateRadialMeterPulseA2:setAlpha(1)
	f2_arg0.UltimateRadialMeterPulseA2:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	f2_arg0.UltimateRadialMeterPulseA2:setShaderVector(0, 0.06, 0, -0.68, 0)
	f2_arg0.UltimateRadialMeterPulseA2:setShaderVector(1, 0.5, 0, 0, 0)
	f2_arg0.UltimateRadialMeterPulseA2:setShaderVector(2, 0.5, 0, 0, 0)
	f2_arg0.UltimateRadialMeterPulseA2:setShaderVector(3, 0.5, 0, 0, 0)
	f2_arg0.UltimateRadialMeterPulseA2:setShaderVector(4, 0, 0, 0, 0)
end
CoD.AmmoWidgetMP_Ultimate_Progress_Pulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.UltimateRadialMeterPulseA:completeAnimation()
			f3_arg0.UltimateRadialMeterPulseA:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.UltimateRadialMeterPulseA)
		end,
		Pulse = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							f8_arg0:beginAnimation(19)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f7_arg0:beginAnimation(100)
						f7_arg0:setShaderVector(0, 0.06, 0, -1, 0)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(40)
					f6_arg0:setAlpha(0)
					f6_arg0:setShaderVector(0, 0.06, 0, -0.91, 0)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.UltimateRadialMeterPulseA:beginAnimation(950)
				f4_arg0.UltimateRadialMeterPulseA:setShaderVector(0, 0.06, 0, -0.87, 0)
				f4_arg0.UltimateRadialMeterPulseA:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.UltimateRadialMeterPulseA:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.UltimateRadialMeterPulseA:completeAnimation()
			f4_arg0.UltimateRadialMeterPulseA:setAlpha(1)
			f4_arg0.UltimateRadialMeterPulseA:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
			f4_arg0.UltimateRadialMeterPulseA:setShaderVector(0, 0.06, 0, 0, 0)
			f4_arg0.UltimateRadialMeterPulseA:setShaderVector(1, 0.5, 0, 0, 0)
			f4_arg0.UltimateRadialMeterPulseA:setShaderVector(2, 0.5, 0, 0, 0)
			f4_arg0.UltimateRadialMeterPulseA:setShaderVector(3, 0.5, 0, 0, 0)
			f4_arg0.UltimateRadialMeterPulseA:setShaderVector(4, 0, 0, 0, 0)
			f4_local0(f4_arg0.UltimateRadialMeterPulseA)
			local f4_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							f12_arg0:beginAnimation(19)
							f12_arg0:setShaderVector(0, 0.06, 0, -1, 0)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f11_arg0:beginAnimation(100)
						f11_arg0:setShaderVector(0, 0.06, 0, -0.98, 0)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(40)
					f10_arg0:setAlpha(0)
					f10_arg0:setShaderVector(0, 0.06, 0, -0.89, 0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f4_arg0.UltimateRadialMeterPulseA2:beginAnimation(950)
				f4_arg0.UltimateRadialMeterPulseA2:setShaderVector(0, 0.06, 0, -0.86, 0)
				f4_arg0.UltimateRadialMeterPulseA2:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.UltimateRadialMeterPulseA2:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f4_arg0.UltimateRadialMeterPulseA2:completeAnimation()
			f4_arg0.UltimateRadialMeterPulseA2:setAlpha(1)
			f4_arg0.UltimateRadialMeterPulseA2:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
			f4_arg0.UltimateRadialMeterPulseA2:setShaderVector(0, 0.06, 0, 0, 0)
			f4_arg0.UltimateRadialMeterPulseA2:setShaderVector(1, 0.5, 0, 0, 0)
			f4_arg0.UltimateRadialMeterPulseA2:setShaderVector(2, 0.5, 0, 0, 0)
			f4_arg0.UltimateRadialMeterPulseA2:setShaderVector(3, 0.5, 0, 0, 0)
			f4_arg0.UltimateRadialMeterPulseA2:setShaderVector(4, 0, 0, 0, 0)
			f4_local1(f4_arg0.UltimateRadialMeterPulseA2)
		end,
	},
}
