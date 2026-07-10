require("x64:a4a7ab0f18d6539")
CoD.GameEndScore_WZ_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.GameEndScore_WZ_SafeAreaContainer.__defaultWidth = 1920
CoD.GameEndScore_WZ_SafeAreaContainer.__defaultHeight = 1080
CoD.GameEndScore_WZ_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_WZ_SafeAreaContainer)
	self.id = "GameEndScore_WZ_SafeAreaContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local MatchEndTimer = CoD.GameEndScore_MatchEndTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, 508, 884, 1, 1, -150, -81)
	MatchEndTimer:subscribeToGlobalModel(f1_arg1, "GameScore", nil, function(model)
		MatchEndTimer:setModel(model, f1_arg1)
	end)
	self:addElement(MatchEndTimer)
	self.MatchEndTimer = MatchEndTimer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_WZ_SafeAreaContainer.__onClose = function(f3_arg0)
	f3_arg0.MatchEndTimer:close()
end
