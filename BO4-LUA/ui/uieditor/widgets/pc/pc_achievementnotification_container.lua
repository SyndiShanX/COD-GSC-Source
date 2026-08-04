require("ui/uieditor/widgets/pc/pc_achievementnotification")
CoD.PC_AchievementNotification_Container = InheritFrom(LUI.UIElement)
CoD.PC_AchievementNotification_Container.__defaultWidth = 430
CoD.PC_AchievementNotification_Container.__defaultHeight = 80
CoD.PC_AchievementNotification_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_AchievementNotification_Container)
	self.id = "PC_AchievementNotification_Container"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AchievementNotification = CoD.PC_AchievementNotification.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(AchievementNotification)
	self.AchievementNotification = AchievementNotification
	self:mergeStateConditions({
		{
			stateName = "ShowNotification",
			condition = function(menu, element, event)
				return CoD.PCAchievementsUtility.ShowAchievementNotification(menu, f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.PCAchievementNotification.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.showNotification, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "showNotification",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_AchievementNotification_Container.__resetProperties = function(f4_arg0)
	f4_arg0.AchievementNotification:completeAnimation()
	f4_arg0.AchievementNotification:setLeftRight(0, 1, 0, 0)
	f4_arg0.AchievementNotification:setAlpha(1)
end
CoD.PC_AchievementNotification_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.AchievementNotification:completeAnimation()
			f5_arg0.AchievementNotification:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.AchievementNotification)
		end,
	},
	ShowNotification = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(90)
					f8_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Intro")
						f6_arg0.clipFinished(element, event)
					end)
				end
				f6_arg0.AchievementNotification:playClip("DefaultClip")
				f6_arg0.AchievementNotification:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_both"])
				f6_arg0.AchievementNotification:setLeftRight(0, 1, 0, 0)
				f6_arg0.AchievementNotification:setAlpha(1)
				f6_arg0.AchievementNotification:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.AchievementNotification:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.AchievementNotification:completeAnimation()
			f6_arg0.AchievementNotification:setLeftRight(0, 1, 50, 50)
			f6_arg0.AchievementNotification:setAlpha(0)
			f6_local0(f6_arg0.AchievementNotification)
		end,
		DefaultState = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.AchievementNotification:beginAnimation(200)
				f10_arg0.AchievementNotification:setLeftRight(0, 1, 50, 50)
				f10_arg0.AchievementNotification:setAlpha(0)
				f10_arg0.AchievementNotification:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.AchievementNotification:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.AchievementNotification:completeAnimation()
			f10_arg0.AchievementNotification:setLeftRight(0, 1, 0, 0)
			f10_arg0.AchievementNotification:setAlpha(1)
			f10_local0(f10_arg0.AchievementNotification)
		end,
	},
}
CoD.PC_AchievementNotification_Container.__onClose = function(f12_arg0)
	f12_arg0.AchievementNotification:close()
end
