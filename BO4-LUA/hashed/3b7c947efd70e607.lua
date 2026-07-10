CoD.BM_ContractReveal = InheritFrom(LUI.UIElement)
CoD.BM_ContractReveal.__defaultWidth = 140
CoD.BM_ContractReveal.__defaultHeight = 158
CoD.BM_ContractReveal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ContractReveal)
	self.id = "BM_ContractReveal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusBorder = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	FocusBorder:setRGB(0.78, 0.91, 1)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local GlowBorder = LUI.UIImage.new(0, 1, -34, 34, 0.01, 1, -34, 34)
	GlowBorder:setRGB(0.29, 0.48, 0.62)
	GlowBorder:setAlpha(0)
	GlowBorder:setImage(RegisterImage(0x254D6690EDE327D))
	GlowBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	GlowBorder:setShaderVector(0, 0, 0, 0, 0)
	GlowBorder:setupNineSliceShader(70, 70)
	self:addElement(GlowBorder)
	self.GlowBorder = GlowBorder
	local GlowBorder2 = LUI.UIImage.new(0, 1, -4.5, 3.5, 0, 1, -4, 4)
	GlowBorder2:setRGB(0.89, 0.98, 0.99)
	GlowBorder2:setAlpha(0)
	GlowBorder2:setImage(RegisterImage(0x254D6690EDE327D))
	GlowBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	GlowBorder2:setShaderVector(0, 0, 0, 0, 0)
	GlowBorder2:setupNineSliceShader(12, 12)
	self:addElement(GlowBorder2)
	self.GlowBorder2 = GlowBorder2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ContractReveal.__resetProperties = function(f2_arg0)
	f2_arg0.FocusBorder:completeAnimation()
	f2_arg0.GlowBorder2:completeAnimation()
	f2_arg0.GlowBorder:completeAnimation()
	f2_arg0.FocusBorder:setAlpha(0)
	f2_arg0.GlowBorder2:setAlpha(0)
	f2_arg0.GlowBorder:setAlpha(0)
end
CoD.BM_ContractReveal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.FocusBorder:completeAnimation()
			f3_arg0.FocusBorder:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.FocusBorder)
		end,
		New = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.FocusBorder:completeAnimation()
			f4_arg0.FocusBorder:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.FocusBorder)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							f8_arg0:beginAnimation(1000)
							f8_arg0:setAlpha(0)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f7_arg0:beginAnimation(1000)
						f7_arg0:setAlpha(1)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(1000)
					f6_arg0:setAlpha(0.2)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.GlowBorder:beginAnimation(1000)
				f4_arg0.GlowBorder:setAlpha(1)
				f4_arg0.GlowBorder:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.GlowBorder:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.GlowBorder:completeAnimation()
			f4_arg0.GlowBorder:setAlpha(0.2)
			f4_local0(f4_arg0.GlowBorder)
			local f4_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							f12_arg0:beginAnimation(1000)
							f12_arg0:setAlpha(0)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f11_arg0:beginAnimation(1000)
						f11_arg0:setAlpha(1)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(1000)
					f10_arg0:setAlpha(0.2)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f4_arg0.GlowBorder2:beginAnimation(1000)
				f4_arg0.GlowBorder2:setAlpha(1)
				f4_arg0.GlowBorder2:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.GlowBorder2:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f4_arg0.GlowBorder2:completeAnimation()
			f4_arg0.GlowBorder2:setAlpha(0.2)
			f4_local1(f4_arg0.GlowBorder2)
		end,
	},
}
