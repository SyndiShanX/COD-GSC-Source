require("x64:9f968d7bee3f220")
CoD.StageNotificationPositionContainer = InheritFrom(LUI.UIElement)
CoD.StageNotificationPositionContainer.__defaultWidth = 1920
CoD.StageNotificationPositionContainer.__defaultHeight = 40
CoD.StageNotificationPositionContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StageNotificationPositionContainer)
	self.id = "StageNotificationPositionContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorStageIndicator = CoD.DirectorStageIndicator.new(f1_arg0, f1_arg1, 0, 0, 12, 872, 0, 0, 0, 40)
	self:addElement(DirectorStageIndicator)
	self.DirectorStageIndicator = DirectorStageIndicator
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StageNotificationPositionContainer.__resetProperties = function(f3_arg0)
	f3_arg0.DirectorStageIndicator:completeAnimation()
	f3_arg0.DirectorStageIndicator:setLeftRight(0, 0, 12, 872)
end
CoD.StageNotificationPositionContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.DirectorStageIndicator:completeAnimation()
			f5_arg0.DirectorStageIndicator:setLeftRight(0.5, 0.5, -948, -88)
			f5_arg0.clipFinished(f5_arg0.DirectorStageIndicator)
		end,
	},
}
CoD.StageNotificationPositionContainer.__onClose = function(f6_arg0)
	f6_arg0.DirectorStageIndicator:close()
end
