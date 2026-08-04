require("ui/uieditor/widgets/pc/sliderbar_barhandle")
require("ui/uieditor/widgets/pc/startmenu/pc_highlightborder")
CoD.SliderBar_Slider = InheritFrom(LUI.UIElement)
CoD.SliderBar_Slider.__defaultWidth = 281
CoD.SliderBar_Slider.__defaultHeight = 65
CoD.SliderBar_Slider.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SliderBar_Slider)
	self.id = "SliderBar_Slider"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FilledPartBg = LUI.UIImage.new(0, 0, 0.5, 281.5, 0, 1, 0, 0)
	FilledPartBg:setRGB(0.55, 0.55, 0.55)
	FilledPartBg:setAlpha(0)
	self:addElement(FilledPartBg)
	self.FilledPartBg = FilledPartBg
	local FilledPart = LUI.UIImage.new(0, 0, 0, 104, 0.05, 1.05, -3.5, -3.5)
	FilledPart:setRGB(0.87, 0.87, 0.87)
	FilledPart:setAlpha(0.02)
	self:addElement(FilledPart)
	self.FilledPart = FilledPart
	local Bar = CoD.SliderBar_BarHandle.new(f1_arg0, f1_arg1, 0, 0, 105, 106, 0, 1, 0, 0)
	Bar:setRGB(0.87, 0.87, 0.87)
	self:addElement(Bar)
	self.Bar = Bar
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SliderBar_Slider.__resetProperties = function(f2_arg0)
	f2_arg0.PCHighlightBorder:completeAnimation()
	f2_arg0.Bar:completeAnimation()
	f2_arg0.Bar:setRGB(0.87, 0.87, 0.87)
end
CoD.SliderBar_Slider.__clipsPerState = {
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
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Bar:completeAnimation()
			f4_arg0.Bar:setRGB(1, 1, 1)
			f4_arg0.clipFinished(f4_arg0.Bar)
			f4_arg0.PCHighlightBorder:completeAnimation()
			f4_arg0.PCHighlightBorder:playClip("cFocus")
			f4_arg0.clipFinished(f4_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Bar:beginAnimation(150)
				f5_arg0.Bar:setRGB(1, 1, 1)
				f5_arg0.Bar:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Bar:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Bar:completeAnimation()
			f5_arg0.Bar:setRGB(0.87, 0.87, 0.87)
			f5_local0(f5_arg0.Bar)
			f5_arg0.PCHighlightBorder:completeAnimation()
			f5_arg0.PCHighlightBorder:playClip("cGainFocus")
			f5_arg0.clipFinished(f5_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Bar:beginAnimation(150)
				f7_arg0.Bar:setRGB(0.87, 0.87, 0.87)
				f7_arg0.Bar:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Bar:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Bar:completeAnimation()
			f7_arg0.Bar:setRGB(1, 1, 1)
			f7_local0(f7_arg0.Bar)
			f7_arg0.PCHighlightBorder:completeAnimation()
			f7_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f7_arg0.clipFinished(f7_arg0.PCHighlightBorder)
		end,
	},
	Unavailable = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Bar:completeAnimation()
			f9_arg0.Bar:setRGB(0.3, 0.3, 0.3)
			f9_arg0.clipFinished(f9_arg0.Bar)
		end,
	},
}
CoD.SliderBar_Slider.__onClose = function(f10_arg0)
	f10_arg0.Bar:close()
	f10_arg0.PCHighlightBorder:close()
end
