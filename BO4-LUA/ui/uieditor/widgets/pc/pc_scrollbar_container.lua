require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/pc_scrollbar")
CoD.PC_Scrollbar_Container = InheritFrom(LUI.UIElement)
CoD.PC_Scrollbar_Container.__defaultWidth = 14
CoD.PC_Scrollbar_Container.__defaultHeight = 714
CoD.PC_Scrollbar_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Scrollbar_Container)
	self.id = "PC_Scrollbar_Container"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.79, 0.78, 0.78)
	self:addElement(Background)
	self.Background = Background
	local Bar = CoD.PC_Scrollbar.new(f1_arg0, f1_arg1, 0.5, 0.5, -6, 6, 0, 1, 0, 0)
	self:addElement(Bar)
	self.Bar = Bar
	Background.id = "Background"
	Bar.id = "Bar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Scrollbar_Container.__resetProperties = function(f2_arg0)
	f2_arg0.Bar:completeAnimation()
	f2_arg0.Bar:setAlpha(1)
end
CoD.PC_Scrollbar_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Bar:completeAnimation()
			f3_arg0.Bar:setAlpha(0.6)
			f3_arg0.clipFinished(f3_arg0.Bar)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Bar:completeAnimation()
			f4_arg0.Bar:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Bar)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Bar:beginAnimation(80)
				f5_arg0.Bar:setAlpha(1)
				f5_arg0.Bar:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Bar:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Bar:completeAnimation()
			f5_arg0.Bar:setAlpha(0.6)
			f5_local0(f5_arg0.Bar)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Bar:beginAnimation(110)
				f7_arg0.Bar:setAlpha(0.6)
				f7_arg0.Bar:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Bar:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Bar:completeAnimation()
			f7_arg0.Bar:setAlpha(1)
			f7_local0(f7_arg0.Bar)
		end,
	},
	AtTop = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	AtTopAndBottom = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	AtBottom = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.PC_Scrollbar_Container.__onClose = function(f12_arg0)
	f12_arg0.Background:close()
	f12_arg0.Bar:close()
end
