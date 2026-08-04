CoD.PC_Scrollbar = InheritFrom(LUI.UIElement)
CoD.PC_Scrollbar.__defaultWidth = 9
CoD.PC_Scrollbar.__defaultHeight = 714
CoD.PC_Scrollbar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Scrollbar)
	self.id = "PC_Scrollbar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Scrollbar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Scrollbar:setRGB(0.62, 0.62, 0.61)
	self:addElement(Scrollbar)
	self.Scrollbar = Scrollbar
	local Image = LUI.UIImage.new(0, 0, 1, 2, 0, 0, 1, 2)
	Image:setRGB(0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(1, 1, -2, -1, 0, 0, 1, 2)
	Image2:setRGB(0, 0, 0)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(1, 1, -2, -1, 1, 1, -2, -1)
	Image3:setRGB(0, 0, 0)
	self:addElement(Image3)
	self.Image3 = Image3
	local Image4 = LUI.UIImage.new(0, 0, 1, 2, 1, 1, -2, -1)
	Image4:setRGB(0, 0, 0)
	self:addElement(Image4)
	self.Image4 = Image4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Scrollbar.__resetProperties = function(f2_arg0)
	f2_arg0.Scrollbar:completeAnimation()
	f2_arg0.Scrollbar:setLeftRight(0, 1, 0, 0)
	f2_arg0.Scrollbar:setTopBottom(0, 1, 0, 0)
	f2_arg0.Scrollbar:setRGB(0.62, 0.62, 0.61)
end
CoD.PC_Scrollbar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Scrollbar:completeAnimation()
			f4_arg0.Scrollbar:setLeftRight(0, 1, 0, 0)
			f4_arg0.Scrollbar:setTopBottom(0, 1, 0, 0)
			f4_arg0.Scrollbar:setRGB(0.77, 0.77, 0.77)
			f4_arg0.clipFinished(f4_arg0.Scrollbar)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Scrollbar:beginAnimation(100)
				f5_arg0.Scrollbar:setRGB(0.77, 0.77, 0.77)
				f5_arg0.Scrollbar:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Scrollbar:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Scrollbar:completeAnimation()
			f5_arg0.Scrollbar:setLeftRight(0, 1, 0, 0)
			f5_arg0.Scrollbar:setTopBottom(0, 1, 0, 0)
			f5_arg0.Scrollbar:setRGB(0.62, 0.62, 0.61)
			f5_local0(f5_arg0.Scrollbar)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Scrollbar:beginAnimation(100)
				f7_arg0.Scrollbar:setRGB(0.62, 0.62, 0.61)
				f7_arg0.Scrollbar:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Scrollbar:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Scrollbar:completeAnimation()
			f7_arg0.Scrollbar:setLeftRight(0, 1, 0, 0)
			f7_arg0.Scrollbar:setTopBottom(0, 1, 0, 0)
			f7_arg0.Scrollbar:setRGB(0.77, 0.77, 0.77)
			f7_local0(f7_arg0.Scrollbar)
		end,
	},
}
