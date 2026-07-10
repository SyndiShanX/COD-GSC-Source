require("x64:ae56105956b945c")
CoD.ScoreInfoEscortRobot = InheritFrom(LUI.UIElement)
CoD.ScoreInfoEscortRobot.__defaultWidth = 30
CoD.ScoreInfoEscortRobot.__defaultHeight = 40
CoD.ScoreInfoEscortRobot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfoEscortRobot)
	self.id = "ScoreInfoEscortRobot"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Marker = LUI.UIImage.new(0.5, 0.5, -1, 1, 0, 0, 0, 8)
	self:addElement(Marker)
	self.Marker = Marker
	local RobotObjective = CoD.ScoreInfoEscortRobotObjective.new(f1_arg0, f1_arg1, 0, 0, -23, 53, 0, 0, -17, 59)
	RobotObjective:setScale(0.85, 0.85)
	self:addElement(RobotObjective)
	self.RobotObjective = RobotObjective
	local MovingImage = LUI.UIImage.new(0, 0, 28, 44, 1, 1, -27, -11)
	MovingImage:setImage(RegisterImage(0xA6EF6D2C1A5DF0E))
	self:addElement(MovingImage)
	self.MovingImage = MovingImage
	self:mergeStateConditions({
		{
			stateName = "Moving",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("Escort.robotMoving", 0)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["Escort.robotMoving"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "Escort.robotMoving",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "Escort.robotObjective", function(model)
		local f4_local0 = self
		CoD.HUDUtility.SetEscortRobotObjective(self.RobotObjective)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoEscortRobot.__resetProperties = function(f5_arg0)
	f5_arg0.MovingImage:completeAnimation()
	f5_arg0.MovingImage:setAlpha(1)
end
CoD.ScoreInfoEscortRobot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.MovingImage:completeAnimation()
			f6_arg0.MovingImage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.MovingImage)
		end,
	},
	Moving = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ScoreInfoEscortRobot.__onClose = function(f8_arg0)
	f8_arg0.RobotObjective:close()
end
