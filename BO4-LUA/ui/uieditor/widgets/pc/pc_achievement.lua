require("ui/uieditor/widgets/pc/pc_achievement_container")
CoD.PC_Achievement = InheritFrom(LUI.UIElement)
CoD.PC_Achievement.__defaultWidth = 960
CoD.PC_Achievement.__defaultHeight = 120
CoD.PC_Achievement.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Achievement)
	self.id = "PC_Achievement"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Achievement = CoD.PC_Achievement_Container.new(f1_arg0, f1_arg1, 1, 1, -870, -20, 0.5, 0.5, -47.5, 47.5)
	Achievement:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.PCAchievementsUtility.IsAchievementCompleted(self, f1_arg1)
			end,
		},
	})
	Achievement:linkToElementModel(Achievement, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(Achievement, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	Achievement:appendEventHandler("<datasourceChange>PCAchievement", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(Achievement, f4_arg1)
	end)
	self:addElement(Achievement)
	self.Achievement = Achievement
	self.Achievement:linkToElementModel(self, "progressBarRatio", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Achievement.ProgressBarFiller:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	self.Achievement:linkToElementModel(self, "image", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Achievement.AchievementIcon:setImage(RegisterImage(f6_local0))
		end
	end)
	self.Achievement:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Achievement.Name:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	self.Achievement:linkToElementModel(self, "score", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Achievement.ScoreValue:setText(f8_local0)
		end
	end)
	Achievement.id = "Achievement"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Achievement.__resetProperties = function(f9_arg0)
	f9_arg0.Achievement:completeAnimation()
	f9_arg0.Achievement:setAlpha(1)
	f9_arg0.Achievement:setScale(1, 1)
end
CoD.PC_Achievement.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Achievement:completeAnimation()
			f11_arg0.Achievement:setScale(1.02, 1.02)
			f11_arg0.clipFinished(f11_arg0.Achievement)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Achievement:beginAnimation(200)
				f12_arg0.Achievement:setScale(1.02, 1.02)
				f12_arg0.Achievement:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Achievement:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Achievement:completeAnimation()
			f12_arg0.Achievement:setScale(1, 1)
			f12_local0(f12_arg0.Achievement)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Achievement:beginAnimation(200)
				f14_arg0.Achievement:setScale(1, 1)
				f14_arg0.Achievement:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Achievement:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Achievement:completeAnimation()
			f14_arg0.Achievement:setScale(1.02, 1.02)
			f14_local0(f14_arg0.Achievement)
		end,
		Active = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Achievement:completeAnimation()
			f16_arg0.Achievement:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.Achievement)
		end,
		ActiveAndChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.Achievement:completeAnimation()
			f17_arg0.Achievement:setScale(1.02, 1.02)
			f17_arg0.clipFinished(f17_arg0.Achievement)
		end,
		GainActiveAndChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.Achievement:beginAnimation(200)
				f18_arg0.Achievement:setScale(1.02, 1.02)
				f18_arg0.Achievement:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Achievement:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Achievement:completeAnimation()
			f18_arg0.Achievement:setScale(1, 1)
			f18_local0(f18_arg0.Achievement)
		end,
		LoseActiveAndChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.Achievement:beginAnimation(200)
				f20_arg0.Achievement:setScale(1, 1)
				f20_arg0.Achievement:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Achievement:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Achievement:completeAnimation()
			f20_arg0.Achievement:setScale(1.02, 1.02)
			f20_local0(f20_arg0.Achievement)
		end,
		ChildFocusToActiveAndChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.Achievement:completeAnimation()
			f22_arg0.Achievement:setScale(1.02, 1.02)
			f22_arg0.clipFinished(f22_arg0.Achievement)
		end,
	},
}
CoD.PC_Achievement.__onClose = function(f23_arg0)
	f23_arg0.Achievement:close()
end
