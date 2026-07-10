CoD.EmblemLayerArrows = InheritFrom(LUI.UIElement)
CoD.EmblemLayerArrows.__defaultWidth = 135
CoD.EmblemLayerArrows.__defaultHeight = 135
CoD.EmblemLayerArrows.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemLayerArrows)
	self.id = "EmblemLayerArrows"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local leftArrow = LUI.UIImage.new(0.5, 0.5, -115.5, -67.5, 0.5, 0.5, -32, 32)
	leftArrow:setRGB(0.93, 0.45, 0.05)
	leftArrow:setAlpha(0)
	leftArrow:setImage(RegisterImage(0xB74F856BFDB37C1))
	self:addElement(leftArrow)
	self.leftArrow = leftArrow
	local rightArrow = LUI.UIImage.new(0.5, 0.5, 67.5, 115.5, 0.5, 0.5, -32, 32)
	rightArrow:setRGB(0.93, 0.45, 0.05)
	rightArrow:setAlpha(0)
	rightArrow:setZRot(180)
	rightArrow:setImage(RegisterImage(0xB74F856BFDB37C1))
	self:addElement(rightArrow)
	self.rightArrow = rightArrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemLayerArrows.__resetProperties = function(f2_arg0)
	f2_arg0.rightArrow:completeAnimation()
	f2_arg0.leftArrow:completeAnimation()
	f2_arg0.rightArrow:setAlpha(0)
	f2_arg0.leftArrow:setAlpha(0)
end
CoD.EmblemLayerArrows.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	RightButtonPressed = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f4_arg0.leftArrow:beginAnimation(1000)
				f4_arg0.leftArrow:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.leftArrow:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.leftArrow:completeAnimation()
			f4_arg0.leftArrow:setAlpha(0)
			f4_local0(f4_arg0.leftArrow)
			local f4_local1 = function(f6_arg0)
				f4_arg0.rightArrow:beginAnimation(1000)
				f4_arg0.rightArrow:setAlpha(0)
				f4_arg0.rightArrow:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.rightArrow:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.rightArrow:completeAnimation()
			f4_arg0.rightArrow:setAlpha(1)
			f4_local1(f4_arg0.rightArrow)
		end,
	},
	LeftButtonPressed = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.leftArrow:beginAnimation(1000)
				f7_arg0.leftArrow:setAlpha(0)
				f7_arg0.leftArrow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.leftArrow:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.leftArrow:completeAnimation()
			f7_arg0.leftArrow:setAlpha(1)
			f7_local0(f7_arg0.leftArrow)
			local f7_local1 = function(f9_arg0)
				f7_arg0.rightArrow:beginAnimation(1000)
				f7_arg0.rightArrow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.rightArrow:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.rightArrow:completeAnimation()
			f7_arg0.rightArrow:setAlpha(0)
			f7_local1(f7_arg0.rightArrow)
		end,
	},
}
