require("ui/uieditor/widgets/border")
local f0_local0 = function(f1_arg0, f1_arg1)
	f1_arg0:setHandleMouse(true)
	f1_arg0:registerEventHandler("button_action", function(element, event) end)
end
local PostLoadFunc = function(self, controller)
	if CoD.isPC then
		f0_local0(self, controller)
	end
end
CoD.verticalScrollbar = InheritFrom(LUI.UIElement)
CoD.verticalScrollbar.__defaultWidth = 15
CoD.verticalScrollbar.__defaultHeight = 750
CoD.verticalScrollbar.new = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	local self = LUI.UIElement.new(f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	self:setClass(CoD.verticalScrollbar)
	self.id = "verticalScrollbar"
	self.soundSet = "none"
	f4_arg0:addElementToPendingUpdateStateList(self)
	local topArrow = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 15)
	topArrow:setImage(RegisterImage("uie_ui_arrow_up"))
	self:addElement(topArrow)
	self.topArrow = topArrow
	local bottomArrow = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -15, 0)
	bottomArrow:setImage(RegisterImage("uie_ui_arrow_down"))
	self:addElement(bottomArrow)
	self.bottomArrow = bottomArrow
	local sliderBorder = CoD.Border.new(f4_arg0, f4_arg1, 0, 1, 0, 0, 0, 1, 15, -15)
	sliderBorder:setRGB(0.79, 0.78, 0.78)
	self:addElement(sliderBorder)
	self.sliderBorder = sliderBorder
	local slider = LUI.UIImage.new(0, 1, 3, -3, 0, 1, 18, -18)
	self:addElement(slider)
	self.slider = slider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f4_arg1, f4_arg0)
	end
	return self
end
CoD.verticalScrollbar.__resetProperties = function(f5_arg0)
	f5_arg0.topArrow:completeAnimation()
	f5_arg0.bottomArrow:completeAnimation()
	f5_arg0.sliderBorder:completeAnimation()
	f5_arg0.slider:completeAnimation()
	f5_arg0.topArrow:setAlpha(1)
	f5_arg0.bottomArrow:setAlpha(1)
	f5_arg0.sliderBorder:setAlpha(1)
	f5_arg0.slider:setAlpha(1)
end
CoD.verticalScrollbar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	AtTop = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.topArrow:completeAnimation()
			f7_arg0.topArrow:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.topArrow)
		end,
	},
	AtTopAndBottom = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.topArrow:completeAnimation()
			f8_arg0.topArrow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.topArrow)
			f8_arg0.bottomArrow:completeAnimation()
			f8_arg0.bottomArrow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.bottomArrow)
			f8_arg0.sliderBorder:completeAnimation()
			f8_arg0.sliderBorder:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.sliderBorder)
			f8_arg0.slider:completeAnimation()
			f8_arg0.slider:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.slider)
		end,
	},
	AtBottom = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.bottomArrow:completeAnimation()
			f9_arg0.bottomArrow:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.bottomArrow)
		end,
	},
}
CoD.verticalScrollbar.__onClose = function(f10_arg0)
	f10_arg0.sliderBorder:close()
end
