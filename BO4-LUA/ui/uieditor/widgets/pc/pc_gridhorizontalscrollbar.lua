require("x64:2675595fa323085")
require("x64:8be685c4f3b19a0")
CoD.PC_GridHorizontalScrollbar = InheritFrom(LUI.UIElement)
CoD.PC_GridHorizontalScrollbar.__defaultWidth = 714
CoD.PC_GridHorizontalScrollbar.__defaultHeight = 34
CoD.PC_GridHorizontalScrollbar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_GridHorizontalScrollbar)
	self.id = "PC_GridHorizontalScrollbar"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(background)
	self.background = background
	local slider = CoD.PC_Scrollbar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -12, 0)
	self:addElement(slider)
	self.slider = slider
	background.id = "background"
	slider.id = "slider"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.GridAndListUtility.SetupDraggableScrollbar(f1_arg0, f1_local3, f1_arg1, false)
	SetElementCanBeNavigatedTo(f1_local3, false)
	return self
end
CoD.PC_GridHorizontalScrollbar.__resetProperties = function(f2_arg0)
	f2_arg0.slider:completeAnimation()
	f2_arg0.slider:setAlpha(1)
end
CoD.PC_GridHorizontalScrollbar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.slider:completeAnimation()
			f3_arg0.slider:setAlpha(0.6)
			f3_arg0.clipFinished(f3_arg0.slider)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.slider:completeAnimation()
			f4_arg0.slider:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.slider)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.slider:beginAnimation(80)
				f5_arg0.slider:setAlpha(1)
				f5_arg0.slider:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.slider:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.slider:completeAnimation()
			f5_arg0.slider:setAlpha(0.6)
			f5_local0(f5_arg0.slider)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.slider:beginAnimation(80)
				f7_arg0.slider:setAlpha(0.6)
				f7_arg0.slider:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.slider:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.slider:completeAnimation()
			f7_arg0.slider:setAlpha(1)
			f7_local0(f7_arg0.slider)
		end,
	},
	AtLeft = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.slider:completeAnimation()
			f9_arg0.slider:setAlpha(0.6)
			f9_arg0.clipFinished(f9_arg0.slider)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.slider:completeAnimation()
			f10_arg0.slider:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.slider)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.slider:beginAnimation(80)
				f11_arg0.slider:setAlpha(1)
				f11_arg0.slider:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.slider:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.slider:completeAnimation()
			f11_arg0.slider:setAlpha(0.6)
			f11_local0(f11_arg0.slider)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.slider:beginAnimation(80)
				f13_arg0.slider:setAlpha(0.6)
				f13_arg0.slider:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.slider:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.slider:completeAnimation()
			f13_arg0.slider:setAlpha(1)
			f13_local0(f13_arg0.slider)
		end,
	},
	AtRight = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.slider:completeAnimation()
			f15_arg0.slider:setAlpha(0.6)
			f15_arg0.clipFinished(f15_arg0.slider)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.slider:completeAnimation()
			f16_arg0.slider:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.slider)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.slider:beginAnimation(80)
				f17_arg0.slider:setAlpha(1)
				f17_arg0.slider:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.slider:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.slider:completeAnimation()
			f17_arg0.slider:setAlpha(0.6)
			f17_local0(f17_arg0.slider)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.slider:beginAnimation(80)
				f19_arg0.slider:setAlpha(0.6)
				f19_arg0.slider:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.slider:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.slider:completeAnimation()
			f19_arg0.slider:setAlpha(1)
			f19_local0(f19_arg0.slider)
		end,
	},
	AtLeftAndRight = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.slider:completeAnimation()
			f21_arg0.slider:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.slider)
		end,
	},
}
CoD.PC_GridHorizontalScrollbar.__onClose = function(f22_arg0)
	f22_arg0.background:close()
	f22_arg0.slider:close()
end
