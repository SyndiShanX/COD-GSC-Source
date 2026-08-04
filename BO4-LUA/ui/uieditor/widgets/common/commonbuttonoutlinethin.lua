require("ui/uieditor/widgets/common/commonfocusbrackets")
require("ui/uieditor/widgets/director/directorselectbuttonlines")
CoD.CommonButtonOutlineThin = InheritFrom(LUI.UIElement)
CoD.CommonButtonOutlineThin.__defaultWidth = 100
CoD.CommonButtonOutlineThin.__defaultHeight = 60
CoD.CommonButtonOutlineThin.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonButtonOutlineThin)
	self.id = "CommonButtonOutlineThin"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusGlow = LUI.UIImage.new(0, 1, -29, 29, 0, 1, -33, 33)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage("uie_ui_menu_common_focus_glow_small"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.6)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(60, 40)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -10, 10, 0, 1, -10, 10)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	Lines:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	self:addElement(Lines)
	self.Lines = Lines
	local FocusBorder = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FocusBorder:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage("uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonButtonOutlineThin.__resetProperties = function(f2_arg0)
	f2_arg0.FocusBorder:completeAnimation()
	f2_arg0.FocusBrackets:completeAnimation()
	f2_arg0.FocusGlow:completeAnimation()
	f2_arg0.FocusBorder:setAlpha(0)
	f2_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
	f2_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
	f2_arg0.FocusBrackets:setAlpha(0)
	f2_arg0.FocusGlow:setAlpha(0)
end
CoD.CommonButtonOutlineThin.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.FocusGlow:completeAnimation()
			f4_arg0.FocusGlow:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.FocusGlow)
			f4_arg0.FocusBrackets:completeAnimation()
			f4_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f4_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f4_arg0.FocusBrackets:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.FocusBrackets)
			f4_arg0.FocusBorder:completeAnimation()
			f4_arg0.FocusBorder:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.FocusBorder)
		end,
		LoseFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			local f5_local0 = function(f6_arg0)
				f5_arg0.FocusGlow:beginAnimation(200)
				f5_arg0.FocusGlow:setAlpha(0)
				f5_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.FocusGlow:completeAnimation()
			f5_arg0.FocusGlow:setAlpha(1)
			f5_local0(f5_arg0.FocusGlow)
			local f5_local1 = function(f7_arg0)
				f5_arg0.FocusBrackets:beginAnimation(60)
				f5_arg0.FocusBrackets:setAlpha(0)
				f5_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.FocusBrackets:completeAnimation()
			f5_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f5_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f5_arg0.FocusBrackets:setAlpha(1)
			f5_local1(f5_arg0.FocusBrackets)
			local f5_local2 = function(f8_arg0)
				f5_arg0.FocusBorder:beginAnimation(200)
				f5_arg0.FocusBorder:setAlpha(0)
				f5_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.FocusBorder:completeAnimation()
			f5_arg0.FocusBorder:setAlpha(1)
			f5_local2(f5_arg0.FocusBorder)
		end,
		GainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				f9_arg0.FocusGlow:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f9_arg0.FocusGlow:setAlpha(1)
				f9_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.FocusGlow:completeAnimation()
			f9_arg0.FocusGlow:setAlpha(0)
			f9_local0(f9_arg0.FocusGlow)
			local f9_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(50, Enum[@"luitween"][@"luitween_ease_out"])
					f12_arg0:setLeftRight(0, 1, -10, 10)
					f12_arg0:setTopBottom(0, 1, -10, 10)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.FocusBrackets:beginAnimation(100)
				f9_arg0.FocusBrackets:setLeftRight(0, 1, -8, 8)
				f9_arg0.FocusBrackets:setTopBottom(0, 1, -8, 8)
				f9_arg0.FocusBrackets:setAlpha(0.75)
				f9_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f9_arg0.FocusBrackets:completeAnimation()
			f9_arg0.FocusBrackets:setLeftRight(0, 1, -40, 40)
			f9_arg0.FocusBrackets:setTopBottom(0, 1, -40, 40)
			f9_arg0.FocusBrackets:setAlpha(0)
			f9_local1(f9_arg0.FocusBrackets)
			local f9_local2 = function(f13_arg0)
				f9_arg0.FocusBorder:beginAnimation(200)
				f9_arg0.FocusBorder:setAlpha(1)
				f9_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.FocusBorder:completeAnimation()
			f9_arg0.FocusBorder:setAlpha(0)
			f9_local2(f9_arg0.FocusBorder)
		end,
	},
	Disabled = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CommonButtonOutlineThin.__onClose = function(f15_arg0)
	f15_arg0.FocusBrackets:close()
	f15_arg0.Lines:close()
end
