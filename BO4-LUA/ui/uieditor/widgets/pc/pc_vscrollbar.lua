require("ui/uieditor/widgets/border")
require("ui/uieditor/widgets/pc/pc_scrollbar_container")
require("ui/uieditor/widgets/pc/pc_scrolldown")
require("ui/uieditor/widgets/pc/pc_scrollup")
CoD.PC_VScrollbar = InheritFrom(LUI.UIElement)
CoD.PC_VScrollbar.__defaultWidth = 14
CoD.PC_VScrollbar.__defaultHeight = 750
CoD.PC_VScrollbar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_VScrollbar)
	self.id = "PC_VScrollbar"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local sliderBorder = CoD.Border.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	sliderBorder:setRGB(0.79, 0.78, 0.78)
	sliderBorder:setAlpha(0)
	self:addElement(sliderBorder)
	self.sliderBorder = sliderBorder
	local HLineBottom = LUI.UIImage.new(0.5, 0.5, -14, 14, 1, 1, -24, -23)
	HLineBottom:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
	HLineBottom:setAlpha(0)
	self:addElement(HLineBottom)
	self.HLineBottom = HLineBottom
	local HLineTop = LUI.UIImage.new(0.5, 0.5, -14, 14, 0, 0, 23, 24)
	HLineTop:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
	HLineTop:setAlpha(0)
	self:addElement(HLineTop)
	self.HLineTop = HLineTop
	local ScrollbarBG = LUI.UIImage.new(0.5, 0.5, -7, 7, 0, 1, 0, 0)
	ScrollbarBG:setRGB(0.82, 0.82, 0.82)
	ScrollbarBG:setAlpha(0.02)
	ScrollbarBG:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(ScrollbarBG)
	self.ScrollbarBG = ScrollbarBG
	local VLineLeft = LUI.UIImage.new(0, 0, 10.5, 11.5, 0, 1, 24, -24)
	VLineLeft:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
	VLineLeft:setAlpha(0)
	self:addElement(VLineLeft)
	self.VLineLeft = VLineLeft
	local VLineRight = LUI.UIImage.new(0, 0, 16.5, 17.5, 0, 1, 24, -24)
	VLineRight:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
	VLineRight:setAlpha(0)
	self:addElement(VLineRight)
	self.VLineRight = VLineRight
	local DotBR = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -24, -23)
	DotBR:setAlpha(0)
	self:addElement(DotBR)
	self.DotBR = DotBR
	local DotTR = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 23, 24)
	DotTR:setAlpha(0)
	self:addElement(DotTR)
	self.DotTR = DotTR
	local DotTL = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 23, 24)
	DotTL:setAlpha(0)
	self:addElement(DotTL)
	self.DotTL = DotTL
	local DotBL = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -24, -23)
	DotBL:setAlpha(0)
	self:addElement(DotBL)
	self.DotBL = DotBL
	local ScrollDown = CoD.PC_ScrollDown.new(f1_arg0, f1_arg1, 0.5, 0.5, -14, 14, 1, 1, -25, 3)
	ScrollDown:setAlpha(0)
	self:addElement(ScrollDown)
	self.ScrollDown = ScrollDown
	local ScrollUp = CoD.PC_ScrollUp.new(f1_arg0, f1_arg1, 0.5, 0.5, -14, 14, 0, 0, -3, 25)
	ScrollUp:setAlpha(0)
	self:addElement(ScrollUp)
	self.ScrollUp = ScrollUp
	local Scrollbar = CoD.PC_Scrollbar_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, -7, 7, 0, 1, 0, 0)
	self:addElement(Scrollbar)
	self.Scrollbar = Scrollbar
	ScrollDown.id = "ScrollDown"
	ScrollUp.id = "ScrollUp"
	Scrollbar.id = "Scrollbar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local14 = self
	DisableKeyboardNavigationByElement(self.ScrollDown)
	DisableKeyboardNavigationByElement(self.ScrollUp)
	DisableKeyboardNavigationByElement(self.Scrollbar)
	return self
end
CoD.PC_VScrollbar.__resetProperties = function(f2_arg0)
	f2_arg0.ScrollbarBG:completeAnimation()
	f2_arg0.ScrollUp:completeAnimation()
	f2_arg0.ScrollDown:completeAnimation()
	f2_arg0.sliderBorder:completeAnimation()
	f2_arg0.ScrollbarBG:setAlpha(0.02)
	f2_arg0.ScrollUp:setAlpha(0)
	f2_arg0.ScrollDown:setAlpha(0)
	f2_arg0.sliderBorder:setAlpha(0)
end
CoD.PC_VScrollbar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.ScrollbarBG:completeAnimation()
			f3_arg0.ScrollbarBG:setAlpha(0.01)
			f3_arg0.clipFinished(f3_arg0.ScrollbarBG)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ScrollbarBG:completeAnimation()
			f4_arg0.ScrollbarBG:setAlpha(0.02)
			f4_arg0.clipFinished(f4_arg0.ScrollbarBG)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.ScrollbarBG:beginAnimation(80)
				f5_arg0.ScrollbarBG:setAlpha(0.02)
				f5_arg0.ScrollbarBG:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ScrollbarBG:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.ScrollbarBG:completeAnimation()
			f5_arg0.ScrollbarBG:setAlpha(0.01)
			f5_local0(f5_arg0.ScrollbarBG)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ScrollbarBG:beginAnimation(110)
				f7_arg0.ScrollbarBG:setAlpha(0.01)
				f7_arg0.ScrollbarBG:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ScrollbarBG:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ScrollbarBG:completeAnimation()
			f7_arg0.ScrollbarBG:setAlpha(0.02)
			f7_local0(f7_arg0.ScrollbarBG)
		end,
		Disabled_ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.ScrollbarBG:completeAnimation()
			f9_arg0.ScrollbarBG:setAlpha(0.02)
			f9_arg0.clipFinished(f9_arg0.ScrollbarBG)
			f9_arg0.ScrollDown:completeAnimation()
			f9_arg0.ScrollDown:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ScrollDown)
			f9_arg0.ScrollUp:completeAnimation()
			f9_arg0.ScrollUp:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ScrollUp)
		end,
		Disabled_LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			local f10_local0 = function(f11_arg0)
				f10_arg0.ScrollbarBG:beginAnimation(110)
				f10_arg0.ScrollbarBG:setAlpha(0.01)
				f10_arg0.ScrollbarBG:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ScrollbarBG:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ScrollbarBG:completeAnimation()
			f10_arg0.ScrollbarBG:setAlpha(0.02)
			f10_local0(f10_arg0.ScrollbarBG)
			local f10_local1 = function(f12_arg0)
				f10_arg0.ScrollDown:beginAnimation(110)
				f10_arg0.ScrollDown:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ScrollDown:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ScrollDown:completeAnimation()
			f10_arg0.ScrollDown:setAlpha(0)
			f10_local1(f10_arg0.ScrollDown)
			local f10_local2 = function(f13_arg0)
				f10_arg0.ScrollUp:beginAnimation(110)
				f10_arg0.ScrollUp:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ScrollUp:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ScrollUp:completeAnimation()
			f10_arg0.ScrollUp:setAlpha(0)
			f10_local2(f10_arg0.ScrollUp)
		end,
		Disabled_GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			local f14_local0 = function(f15_arg0)
				f14_arg0.ScrollbarBG:beginAnimation(80)
				f14_arg0.ScrollbarBG:setAlpha(0.02)
				f14_arg0.ScrollbarBG:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ScrollbarBG:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ScrollbarBG:completeAnimation()
			f14_arg0.ScrollbarBG:setAlpha(0.01)
			f14_local0(f14_arg0.ScrollbarBG)
			local f14_local1 = function(f16_arg0)
				f14_arg0.ScrollDown:beginAnimation(80)
				f14_arg0.ScrollDown:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ScrollDown:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ScrollDown:completeAnimation()
			f14_arg0.ScrollDown:setAlpha(0)
			f14_local1(f14_arg0.ScrollDown)
			local f14_local2 = function(f17_arg0)
				f14_arg0.ScrollUp:beginAnimation(80)
				f14_arg0.ScrollUp:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ScrollUp:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ScrollUp:completeAnimation()
			f14_arg0.ScrollUp:setAlpha(0)
			f14_local2(f14_arg0.ScrollUp)
		end,
		Disabled_DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.ScrollbarBG:completeAnimation()
			f18_arg0.ScrollbarBG:setAlpha(0.01)
			f18_arg0.clipFinished(f18_arg0.ScrollbarBG)
			f18_arg0.ScrollDown:completeAnimation()
			f18_arg0.ScrollDown:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ScrollDown)
			f18_arg0.ScrollUp:completeAnimation()
			f18_arg0.ScrollUp:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ScrollUp)
		end,
	},
	AtTop = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	AtTopAndBottom = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.sliderBorder:completeAnimation()
			f20_arg0.sliderBorder:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.sliderBorder)
		end,
	},
	AtBottom = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.PC_VScrollbar.__onClose = function(f22_arg0)
	f22_arg0.sliderBorder:close()
	f22_arg0.ScrollDown:close()
	f22_arg0.ScrollUp:close()
	f22_arg0.Scrollbar:close()
end
