require("x64:33f282490497d27")
require("x64:80cd6559c8c4ae9")
CoD.ScoreInfoEscortBar = InheritFrom(LUI.UIElement)
CoD.ScoreInfoEscortBar.__defaultWidth = 164
CoD.ScoreInfoEscortBar.__defaultHeight = 44
CoD.ScoreInfoEscortBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfoEscortBar)
	self.id = "ScoreInfoEscortBar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBar = CoD.ScoreInfoEscortBarProgress.new(f1_arg0, f1_arg1, 0, 0, 0, 164, 0, 0, 0, 6)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local Robot = CoD.ScoreInfoEscortRobot.new(f1_arg0, f1_arg1, 0, 0, -15, 15, 0, 0, 0, 40)
	Robot:subscribeToGlobalModel(f1_arg1, "Escort", "robotProgress", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Robot:setLeftPct(f2_local0)
		end
	end)
	self:addElement(Robot)
	self.Robot = Robot
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "Escort.robotObjective", function(model)
		local f3_local0 = self
		CoD.HUDUtility.SetEscortRobotObjective(self.ProgressBar)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoEscortBar.__onClose = function(f4_arg0)
	f4_arg0.ProgressBar:close()
	f4_arg0.Robot:close()
end
