require("x64:385eb39f564e254")
CoD.MatchStartWarning_TimerBkgd = InheritFrom(LUI.UIElement)
CoD.MatchStartWarning_TimerBkgd.__defaultWidth = 120
CoD.MatchStartWarning_TimerBkgd.__defaultHeight = 48
CoD.MatchStartWarning_TimerBkgd.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MatchStartWarning_TimerBkgd)
	self.id = "MatchStartWarning_TimerBkgd"
	self.soundSet = "default"
	local BackgroundPattern03 = CoD.BackgroundPattern03.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BackgroundPattern03)
	self.BackgroundPattern03 = BackgroundPattern03
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MatchStartWarning_TimerBkgd.__onClose = function(f2_arg0)
	f2_arg0.BackgroundPattern03:close()
end
