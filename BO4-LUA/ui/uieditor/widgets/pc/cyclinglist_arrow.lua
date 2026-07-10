require("x64:b79410dc8d1ea84")
CoD.CyclingList_Arrow = InheritFrom(LUI.UIElement)
CoD.CyclingList_Arrow.__defaultWidth = 65
CoD.CyclingList_Arrow.__defaultHeight = 65
CoD.CyclingList_Arrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CyclingList_Arrow)
	self.id = "CyclingList_Arrow"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Up = LUI.UIImage.new(0.5, 0.5, -1, 1, 0.5, 0.5, -14.5, 2.5)
	Up:setRGB(0.58, 0.58, 0.58)
	Up:setAlpha(0)
	Up:setZRot(45)
	self:addElement(Up)
	self.Up = Up
	local Down = LUI.UIImage.new(0.5, 0.5, -1, 1, 0.5, 0.5, -3.5, 13.5)
	Down:setRGB(0.58, 0.58, 0.58)
	Down:setAlpha(0)
	Down:setZRot(-45)
	self:addElement(Down)
	self.Down = Down
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	local Image = LUI.UIImage.new(-0.03, 0.97, 2, 2, 0, 1, 0, 0)
	Image:setRGB(0.58, 0.58, 0.58)
	Image:setScale(0.4, 0.4)
	Image:setImage(RegisterImage(0x5E74D00B45D12B6))
	self:addElement(Image)
	self.Image = Image
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CyclingList_Arrow.__resetProperties = function(f2_arg0)
	f2_arg0.PCHighlightBorder:completeAnimation()
	f2_arg0.Up:completeAnimation()
	f2_arg0.Down:completeAnimation()
	f2_arg0.PCHighlightBorder:setAlpha(1)
	f2_arg0.Up:setRGB(0.58, 0.58, 0.58)
	f2_arg0.Down:setRGB(0.58, 0.58, 0.58)
end
CoD.CyclingList_Arrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.PCHighlightBorder:completeAnimation()
			f3_arg0.PCHighlightBorder:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.PCHighlightBorder)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Up:completeAnimation()
			f4_arg0.Up:setRGB(1, 1, 1)
			f4_arg0.clipFinished(f4_arg0.Up)
			f4_arg0.Down:completeAnimation()
			f4_arg0.Down:setRGB(1, 1, 1)
			f4_arg0.clipFinished(f4_arg0.Down)
			f4_arg0.PCHighlightBorder:completeAnimation()
			f4_arg0.PCHighlightBorder:playClip("cFocus")
			f4_arg0.clipFinished(f4_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Up:beginAnimation(150)
				f5_arg0.Up:setRGB(0.58, 0.58, 0.58)
				f5_arg0.Up:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Up:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Up:completeAnimation()
			f5_arg0.Up:setRGB(1, 1, 1)
			f5_local0(f5_arg0.Up)
			local f5_local1 = function(f7_arg0)
				f5_arg0.Down:beginAnimation(150)
				f5_arg0.Down:setRGB(0.58, 0.58, 0.58)
				f5_arg0.Down:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Down:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Down:completeAnimation()
			f5_arg0.Down:setRGB(1, 1, 1)
			f5_local1(f5_arg0.Down)
			f5_arg0.PCHighlightBorder:completeAnimation()
			f5_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f5_arg0.clipFinished(f5_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Up:beginAnimation(150)
				f8_arg0.Up:setRGB(1, 1, 1)
				f8_arg0.Up:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Up:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Up:completeAnimation()
			f8_arg0.Up:setRGB(0.58, 0.58, 0.58)
			f8_local0(f8_arg0.Up)
			local f8_local1 = function(f10_arg0)
				f8_arg0.Down:beginAnimation(150)
				f8_arg0.Down:setRGB(1, 1, 1)
				f8_arg0.Down:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Down:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Down:completeAnimation()
			f8_arg0.Down:setRGB(0.58, 0.58, 0.58)
			f8_local1(f8_arg0.Down)
			f8_arg0.PCHighlightBorder:completeAnimation()
			f8_arg0.PCHighlightBorder:playClip("cGainFocus")
			f8_arg0.clipFinished(f8_arg0.PCHighlightBorder)
		end,
	},
	Unavailable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.PCHighlightBorder:completeAnimation()
			f12_arg0.PCHighlightBorder:playClip("DefaultClip")
			f12_arg0.clipFinished(f12_arg0.PCHighlightBorder)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	NoHighlight = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.PCHighlightBorder:completeAnimation()
			f14_arg0.PCHighlightBorder:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PCHighlightBorder)
		end,
	},
}
CoD.CyclingList_Arrow.__onClose = function(f15_arg0)
	f15_arg0.PCHighlightBorder:close()
end
