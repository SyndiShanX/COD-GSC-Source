require("x64:fd773d306b4ca26")
CoD.vhud_CenterFrame = InheritFrom(LUI.UIElement)
CoD.vhud_CenterFrame.__defaultWidth = 1920
CoD.vhud_CenterFrame.__defaultHeight = 920
CoD.vhud_CenterFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_CenterFrame)
	self.id = "vhud_CenterFrame"
	self.soundSet = "default"
	local FrameVlineLeft = CoD.vhud_CenterFrameLeft.new(f1_arg0, f1_arg1, 0, 0, 241, 616, 0.5, 0.5, -242, 242)
	self:addElement(FrameVlineLeft)
	self.FrameVlineLeft = FrameVlineLeft
	local FrameVlineRight = CoD.vhud_CenterFrameLeft.new(f1_arg0, f1_arg1, 1, 1, -607, -232, 0.5, 0.5, -242, 242)
	FrameVlineRight:setZRot(180)
	self:addElement(FrameVlineRight)
	self.FrameVlineRight = FrameVlineRight
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_CenterFrame.__onClose = function(f2_arg0)
	f2_arg0.FrameVlineLeft:close()
	f2_arg0.FrameVlineRight:close()
end
