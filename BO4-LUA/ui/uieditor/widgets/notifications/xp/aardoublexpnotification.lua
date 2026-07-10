require("x64:61ec42293adb27b")
CoD.AARDoubleXPNotification = InheritFrom(LUI.UIElement)
CoD.AARDoubleXPNotification.__defaultWidth = 1920
CoD.AARDoubleXPNotification.__defaultHeight = 1080
CoD.AARDoubleXPNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARDoubleXPNotification)
	self.id = "AARDoubleXPNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXPIcons = CoD.DoubleXPIconsRightAligned.new(f1_arg0, f1_arg1, 0.5, 0.5, 714, 930, 0, 0, 55, 127)
	self:addElement(DoubleXPIcons)
	self.DoubleXPIcons = DoubleXPIcons
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARDoubleXPNotification.__resetProperties = function(f2_arg0)
	f2_arg0.DoubleXPIcons:completeAnimation()
	f2_arg0.DoubleXPIcons:setAlpha(1)
end
CoD.AARDoubleXPNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.DoubleXPIcons:completeAnimation()
			f3_arg0.DoubleXPIcons:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.DoubleXPIcons)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.AARDoubleXPNotification.__onClose = function(f5_arg0)
	f5_arg0.DoubleXPIcons:close()
end
