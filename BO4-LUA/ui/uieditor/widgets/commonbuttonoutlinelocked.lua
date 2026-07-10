require("x64:3e426332d66c91e")
CoD.CommonButtonOutlineLocked = InheritFrom(LUI.UIElement)
CoD.CommonButtonOutlineLocked.__defaultWidth = 100
CoD.CommonButtonOutlineLocked.__defaultHeight = 100
CoD.CommonButtonOutlineLocked.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonButtonOutlineLocked)
	self.id = "CommonButtonOutlineLocked"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DarkenedOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DarkenedOverlay:setRGB(0, 0, 0)
	DarkenedOverlay:setAlpha(0.5)
	self:addElement(DarkenedOverlay)
	self.DarkenedOverlay = DarkenedOverlay
	local FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -10, 10, 0, 1, -10, 10)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonButtonOutlineLocked.__resetProperties = function(f2_arg0)
	f2_arg0.FocusBrackets:completeAnimation()
	f2_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
	f2_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
	f2_arg0.FocusBrackets:setAlpha(0)
end
CoD.CommonButtonOutlineLocked.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.FocusBrackets:completeAnimation()
			f4_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f4_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f4_arg0.FocusBrackets:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.FocusBrackets)
		end,
		LoseFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.FocusBrackets:beginAnimation(60)
				f5_arg0.FocusBrackets:setAlpha(0)
				f5_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.FocusBrackets:completeAnimation()
			f5_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f5_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f5_arg0.FocusBrackets:setAlpha(1)
			f5_local0(f5_arg0.FocusBrackets)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(50, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f9_arg0:setLeftRight(0, 1, -10, 10)
					f9_arg0:setTopBottom(0, 1, -10, 10)
					f9_arg0:setAlpha(1)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.FocusBrackets:beginAnimation(100)
				f7_arg0.FocusBrackets:setLeftRight(0, 1, -8, 8)
				f7_arg0.FocusBrackets:setTopBottom(0, 1, -8, 8)
				f7_arg0.FocusBrackets:setAlpha(0.75)
				f7_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.FocusBrackets:completeAnimation()
			f7_arg0.FocusBrackets:setLeftRight(0, 1, -40, 40)
			f7_arg0.FocusBrackets:setTopBottom(0, 1, -40, 40)
			f7_arg0.FocusBrackets:setAlpha(0)
			f7_local0(f7_arg0.FocusBrackets)
		end,
	},
}
CoD.CommonButtonOutlineLocked.__onClose = function(f10_arg0)
	f10_arg0.FocusBrackets:close()
end
