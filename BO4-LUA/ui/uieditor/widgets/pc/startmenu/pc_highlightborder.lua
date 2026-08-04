CoD.PC_HighlightBorder = InheritFrom(LUI.UIElement)
CoD.PC_HighlightBorder.__defaultWidth = 336
CoD.PC_HighlightBorder.__defaultHeight = 65
CoD.PC_HighlightBorder.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_HighlightBorder)
	self.id = "PC_HighlightBorder"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.8, 0.76, 0.7)
	Border:setImage(RegisterImage("uie_highlight_border_line"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(6, 6)
	self:addElement(Border)
	self.Border = Border
	local Dots = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Dots:setRGB(0.92, 0.92, 0.92)
	Dots:setImage(RegisterImage("uie_highlight_border_dot"))
	Dots:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	Dots:setShaderVector(0, 0, 0, 0, 0)
	Dots:setupNineSliceShader(6, 6)
	self:addElement(Dots)
	self.Dots = Dots
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_HighlightBorder.__resetProperties = function(f2_arg0)
	f2_arg0.Border:completeAnimation()
	f2_arg0.Dots:completeAnimation()
	f2_arg0.Border:setAlpha(1)
	f2_arg0.Dots:setLeftRight(0, 1, 0, 0)
	f2_arg0.Dots:setTopBottom(0, 1, 0, 0)
	f2_arg0.Dots:setAlpha(1)
end
CoD.PC_HighlightBorder.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Border:completeAnimation()
			f3_arg0.Border:setAlpha(0.05)
			f3_arg0.clipFinished(f3_arg0.Border)
			f3_arg0.Dots:completeAnimation()
			f3_arg0.Dots:setLeftRight(0, 1, 0, 0)
			f3_arg0.Dots:setTopBottom(0, 1, 0, 0)
			f3_arg0.clipFinished(f3_arg0.Dots)
		end,
		cFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Border:completeAnimation()
			f4_arg0.Border:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Border)
			f4_arg0.Dots:completeAnimation()
			f4_arg0.Dots:setLeftRight(0, 1, 6, -6)
			f4_arg0.Dots:setTopBottom(0, 1, 6, -6)
			f4_arg0.clipFinished(f4_arg0.Dots)
		end,
		cLoseFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Border:beginAnimation(150)
				f5_arg0.Border:setAlpha(0.05)
				f5_arg0.Border:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Border:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Border:completeAnimation()
			f5_arg0.Border:setAlpha(1)
			f5_local0(f5_arg0.Border)
			local f5_local1 = function(f7_arg0)
				f5_arg0.Dots:beginAnimation(150)
				f5_arg0.Dots:setLeftRight(0, 1, 0, 0)
				f5_arg0.Dots:setTopBottom(0, 1, 0, 0)
				f5_arg0.Dots:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Dots:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Dots:completeAnimation()
			f5_arg0.Dots:setLeftRight(0, 1, 6, -6)
			f5_arg0.Dots:setTopBottom(0, 1, 6, -6)
			f5_local1(f5_arg0.Dots)
		end,
		cGainFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Border:beginAnimation(150)
				f8_arg0.Border:setAlpha(1)
				f8_arg0.Border:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Border:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Border:completeAnimation()
			f8_arg0.Border:setAlpha(0.05)
			f8_local0(f8_arg0.Border)
			local f8_local1 = function(f10_arg0)
				f8_arg0.Dots:beginAnimation(150)
				f8_arg0.Dots:setLeftRight(0, 1, 6, -6)
				f8_arg0.Dots:setTopBottom(0, 1, 6, -6)
				f8_arg0.Dots:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Dots:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Dots:completeAnimation()
			f8_arg0.Dots:setLeftRight(0, 1, 0, 0)
			f8_arg0.Dots:setTopBottom(0, 1, 0, 0)
			f8_local1(f8_arg0.Dots)
		end,
	},
	Disabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Border:completeAnimation()
			f11_arg0.Border:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Border)
			f11_arg0.Dots:completeAnimation()
			f11_arg0.Dots:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Dots)
		end,
	},
}
