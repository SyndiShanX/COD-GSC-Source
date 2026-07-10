require("x64:33f282490497d27")
require("x64:80cd6559c8c4ae9")
CoD.CodCasterObjectiveStatusSafeGuard = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusSafeGuard.__defaultWidth = 164
CoD.CodCasterObjectiveStatusSafeGuard.__defaultHeight = 44
CoD.CodCasterObjectiveStatusSafeGuard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusSafeGuard)
	self.id = "CodCasterObjectiveStatusSafeGuard"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBar = CoD.ScoreInfoEscortBarProgress.new(f1_arg0, f1_arg1, 0, 0, 0, 164, 0, 0, 19, 25)
	ProgressBar:setScale(0.9, 0.9)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local Robot = CoD.ScoreInfoEscortRobot.new(f1_arg0, f1_arg1, 0, 0, -8, 22, 0, 0, -1, 39)
	Robot:setScale(1.5, 1.5)
	Robot.Marker:setAlpha(0)
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
CoD.CodCasterObjectiveStatusSafeGuard.__resetProperties = function(f4_arg0)
	f4_arg0.Robot:completeAnimation()
	f4_arg0.ProgressBar:completeAnimation()
	f4_arg0.Robot:setAlpha(1)
	f4_arg0.ProgressBar:setAlpha(1)
end
CoD.CodCasterObjectiveStatusSafeGuard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenCodcaster = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.ProgressBar:completeAnimation()
			f6_arg0.ProgressBar:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ProgressBar)
			f6_arg0.Robot:completeAnimation()
			f6_arg0.Robot:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Robot)
		end,
	},
}
CoD.CodCasterObjectiveStatusSafeGuard.__onClose = function(f7_arg0)
	f7_arg0.ProgressBar:close()
	f7_arg0.Robot:close()
end
