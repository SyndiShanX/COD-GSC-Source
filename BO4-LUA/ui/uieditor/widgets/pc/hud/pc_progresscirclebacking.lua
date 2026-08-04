CoD.PC_ProgressCircleBacking = InheritFrom(LUI.UIElement)
CoD.PC_ProgressCircleBacking.__defaultWidth = 60
CoD.PC_ProgressCircleBacking.__defaultHeight = 60
CoD.PC_ProgressCircleBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_ProgressCircleBacking)
	self.id = "PC_ProgressCircleBacking"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Panel = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Panel:setRGB(0.11, 0.11, 0.11)
	Panel:setAlpha(0.86)
	Panel:setImage(RegisterImage("uie_progresscirclepanel"))
	self:addElement(Panel)
	self.Panel = Panel
	local Texture = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Texture:setAlpha(0.01)
	Texture:setImage(RegisterImage("uie_progresscircletexture"))
	self:addElement(Texture)
	self.Texture = Texture
	local Arrow = LUI.UIImage.new(0.5, 0.5, -30, 30, 0.5, 0.5, -28, 32)
	Arrow:setScale(0.6, 0.6)
	Arrow:setImage(RegisterImage(@"hash_58EBD33D94FD1BCF"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local Arrow2 = LUI.UIImage.new(0.5, 0.5, -30, 30, 0.5, 0.5, -28, 32)
	Arrow2:setAlpha(0)
	Arrow2:setScale(0.6, 0.6)
	Arrow2:setImage(RegisterImage(@"hash_58EBD33D94FD1BCF"))
	self:addElement(Arrow2)
	self.Arrow2 = Arrow2
	local Frame = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setScale(1.08, 1.08)
	Frame:setImage(RegisterImage("uie_progresscircleframe"))
	self:addElement(Frame)
	self.Frame = Frame
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_ProgressCircleBacking.__resetProperties = function(f2_arg0)
	f2_arg0.Arrow2:completeAnimation()
	f2_arg0.Arrow:completeAnimation()
	f2_arg0.Arrow2:setTopBottom(0.5, 0.5, -28, 32)
	f2_arg0.Arrow2:setAlpha(0)
	f2_arg0.Arrow2:setScale(0.6, 0.6)
	f2_arg0.Arrow:setTopBottom(0.5, 0.5, -28, 32)
	f2_arg0.Arrow:setAlpha(1)
	f2_arg0.Arrow:setScale(0.6, 0.6)
end
CoD.PC_ProgressCircleBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	SeekerMine = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						f7_arg0:beginAnimation(199)
						f7_arg0:setAlpha(0)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f6_arg0:beginAnimation(150)
					f6_arg0:setTopBottom(0.5, 0.5, -26, 34)
					f6_arg0:setAlpha(0.05)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.Arrow:beginAnimation(150)
				f4_arg0.Arrow:setTopBottom(0.5, 0.5, -28, 32)
				f4_arg0.Arrow:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Arrow:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.Arrow:completeAnimation()
			f4_arg0.Arrow:setTopBottom(0.5, 0.5, -32, 28)
			f4_arg0.Arrow:setAlpha(1)
			f4_arg0.Arrow:setScale(0.8, 0.8)
			f4_local0(f4_arg0.Arrow)
			local f4_local1 = function(f8_arg0)
				f4_arg0.Arrow2:beginAnimation(230)
				f4_arg0.Arrow2:setAlpha(0)
				f4_arg0.Arrow2:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Arrow2:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.Arrow2:completeAnimation()
			f4_arg0.Arrow2:setTopBottom(0.5, 0.5, -32, 28)
			f4_arg0.Arrow2:setAlpha(1)
			f4_arg0.Arrow2:setScale(0.8, 0.8)
			f4_local1(f4_arg0.Arrow2)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
}
