CoD.AARTierRewardItemHighlight = InheritFrom(LUI.UIElement)
CoD.AARTierRewardItemHighlight.__defaultWidth = 105
CoD.AARTierRewardItemHighlight.__defaultHeight = 136
CoD.AARTierRewardItemHighlight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardItemHighlight)
	self.id = "AARTierRewardItemHighlight"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonOuterGlow = LUI.UIImage.new(0, 1, -12, 12, 0, 1, -12, 12)
	CommonOuterGlow:setRGB(1, 0.33, 0)
	CommonOuterGlow:setAlpha(0)
	CommonOuterGlow:setImage(RegisterImage(0xAE13B63B2001396))
	CommonOuterGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	CommonOuterGlow:setShaderVector(0, 0, 0, 0, 0)
	CommonOuterGlow:setShaderVector(1, 1, 0, 0, 0)
	CommonOuterGlow:setupNineSliceShader(32, 32)
	self:addElement(CommonOuterGlow)
	self.CommonOuterGlow = CommonOuterGlow
	local CommonFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	CommonFrame:setRGB(1, 0.89, 0.47)
	CommonFrame:setAlpha(0)
	CommonFrame:setImage(RegisterImage(0xCA6E5C175806396))
	CommonFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	CommonFrame:setShaderVector(0, 0, 0, 0, 0)
	CommonFrame:setupNineSliceShader(8, 8)
	self:addElement(CommonFrame)
	self.CommonFrame = CommonFrame
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardItemHighlight.__resetProperties = function(f2_arg0)
	f2_arg0.CommonFrame:completeAnimation()
	f2_arg0.CommonOuterGlow:completeAnimation()
	f2_arg0.CommonFrame:setAlpha(0)
	f2_arg0.CommonOuterGlow:setAlpha(0)
end
CoD.AARTierRewardItemHighlight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Highlighted = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f4_arg0.CommonOuterGlow:beginAnimation(200)
				f4_arg0.CommonOuterGlow:setAlpha(1)
				f4_arg0.CommonOuterGlow:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.CommonOuterGlow:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.CommonOuterGlow:completeAnimation()
			f4_arg0.CommonOuterGlow:setAlpha(0)
			f4_local0(f4_arg0.CommonOuterGlow)
			local f4_local1 = function(f6_arg0)
				f4_arg0.CommonFrame:beginAnimation(200)
				f4_arg0.CommonFrame:setAlpha(1)
				f4_arg0.CommonFrame:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.CommonFrame:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.CommonFrame:completeAnimation()
			f4_arg0.CommonFrame:setAlpha(0)
			f4_local1(f4_arg0.CommonFrame)
		end,
	},
	Highlighted = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.CommonOuterGlow:completeAnimation()
			f7_arg0.CommonOuterGlow:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.CommonOuterGlow)
			f7_arg0.CommonFrame:completeAnimation()
			f7_arg0.CommonFrame:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.CommonFrame)
		end,
		DefaultState = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CommonOuterGlow:beginAnimation(200)
				f8_arg0.CommonOuterGlow:setAlpha(0)
				f8_arg0.CommonOuterGlow:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CommonOuterGlow:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CommonOuterGlow:completeAnimation()
			f8_arg0.CommonOuterGlow:setAlpha(1)
			f8_local0(f8_arg0.CommonOuterGlow)
			local f8_local1 = function(f10_arg0)
				f8_arg0.CommonFrame:beginAnimation(200)
				f8_arg0.CommonFrame:setAlpha(0)
				f8_arg0.CommonFrame:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CommonFrame:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CommonFrame:completeAnimation()
			f8_arg0.CommonFrame:setAlpha(1)
			f8_local1(f8_arg0.CommonFrame)
		end,
	},
}
