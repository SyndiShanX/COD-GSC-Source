CoD.PC_ScrollUp = InheritFrom(LUI.UIElement)
CoD.PC_ScrollUp.__defaultWidth = 28
CoD.PC_ScrollUp.__defaultHeight = 28
CoD.PC_ScrollUp.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_ScrollUp)
	self.id = "PC_ScrollUp"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glow = LUI.UIImage.new(0.5, 0.5, -14, 14, 0.5, 0.5, -14, 14)
	Glow:setRGB(0.77, 0.77, 0.77)
	Glow:setAlpha(0)
	Glow:setZRot(180)
	Glow:setImage(RegisterImage(@"hash_38097835ABD36837"))
	self:addElement(Glow)
	self.Glow = Glow
	local topArrow = LUI.UIImage.new(0.5, 0.5, -14, 14, 0.5, 0.5, -14, 14)
	topArrow:setRGB(0.62, 0.62, 0.61)
	topArrow:setXRot(180)
	topArrow:setImage(RegisterImage(@"hash_58EBD33D94FD1BCF"))
	self:addElement(topArrow)
	self.topArrow = topArrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_ScrollUp.__resetProperties = function(f2_arg0)
	f2_arg0.topArrow:completeAnimation()
	f2_arg0.topArrow:setLeftRight(0.5, 0.5, -14, 14)
	f2_arg0.topArrow:setTopBottom(0.5, 0.5, -14, 14)
	f2_arg0.topArrow:setRGB(0.62, 0.62, 0.61)
end
CoD.PC_ScrollUp.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.topArrow:completeAnimation()
			f4_arg0.topArrow:setLeftRight(0.5, 0.5, -14, 14)
			f4_arg0.topArrow:setTopBottom(0.5, 0.5, -14, 14)
			f4_arg0.topArrow:setRGB(0.77, 0.77, 0.77)
			f4_arg0.clipFinished(f4_arg0.topArrow)
		end,
		LoseFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.topArrow:beginAnimation(100)
				f5_arg0.topArrow:setRGB(0.62, 0.62, 0.61)
				f5_arg0.topArrow:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.topArrow:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.topArrow:completeAnimation()
			f5_arg0.topArrow:setLeftRight(0.5, 0.5, -14, 14)
			f5_arg0.topArrow:setTopBottom(0.5, 0.5, -14, 14)
			f5_arg0.topArrow:setRGB(0.77, 0.77, 0.77)
			f5_local0(f5_arg0.topArrow)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.topArrow:beginAnimation(100)
				f7_arg0.topArrow:setRGB(0.77, 0.77, 0.77)
				f7_arg0.topArrow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.topArrow:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.topArrow:completeAnimation()
			f7_arg0.topArrow:setLeftRight(0.5, 0.5, -14, 14)
			f7_arg0.topArrow:setTopBottom(0.5, 0.5, -14, 14)
			f7_arg0.topArrow:setRGB(0.62, 0.62, 0.61)
			f7_local0(f7_arg0.topArrow)
		end,
	},
}
