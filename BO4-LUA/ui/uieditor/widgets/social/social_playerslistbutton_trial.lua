require("x64:2d361ac3553c22a")
CoD.Social_PlayersListButton_Trial = InheritFrom(LUI.UIElement)
CoD.Social_PlayersListButton_Trial.__defaultWidth = 36
CoD.Social_PlayersListButton_Trial.__defaultHeight = 36
CoD.Social_PlayersListButton_Trial.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PlayersListButton_Trial)
	self.id = "Social_PlayersListButton_Trial"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "Trial",
			condition = function(menu, element, event)
				return CoD.SocialUtility.SocialPlayerInfoIsTrial(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "trial", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trial",
		})
	end)
	self:linkToElementModel(self, "presence", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "presence",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PlayersListButton_Trial.__resetProperties = function(f6_arg0)
	f6_arg0.TrialWidget:completeAnimation()
	f6_arg0.TrialWidget:setAlpha(1)
end
CoD.Social_PlayersListButton_Trial.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.TrialWidget:completeAnimation()
			f7_arg0.TrialWidget:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TrialWidget)
		end,
	},
	Trial = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.TrialWidget:completeAnimation()
			f8_arg0.TrialWidget:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.TrialWidget)
		end,
	},
}
CoD.Social_PlayersListButton_Trial.__onClose = function(f9_arg0)
	f9_arg0.TrialWidget:close()
end
