require("x64:f8d92c0f20bd8f6")
CoD.ZMInvChallenges = InheritFrom(LUI.UIElement)
CoD.ZMInvChallenges.__defaultWidth = 320
CoD.ZMInvChallenges.__defaultHeight = 70
CoD.ZMInvChallenges.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvChallenges)
	self.id = "ZMInvChallenges"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMInvChallenges = CoD.ZMInvChallengesInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 320, 0, 0, 0, 69)
	ZMInvChallenges:linkToElementModel(self, nil, false, function(model)
		ZMInvChallenges:setModel(model, f1_arg1)
	end)
	self:addElement(ZMInvChallenges)
	self.ZMInvChallenges = ZMInvChallenges
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "stage", 0)
			end,
		},
	})
	self:linkToElementModel(self, "stage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stage",
		})
	end)
	self:linkToElementModel(self, "stage", true, function(model)
		local f5_local0 = self
		CoD.ZMInventoryUtility.HandleChallengesStageChange(self, model)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvChallenges.__resetProperties = function(f6_arg0)
	f6_arg0.ZMInvChallenges:completeAnimation()
	f6_arg0.ZMInvChallenges:setAlpha(1)
end
CoD.ZMInvChallenges.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ZMInvChallenges:completeAnimation()
			f7_arg0.ZMInvChallenges:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ZMInvChallenges)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ZMInvChallenges.__onClose = function(f9_arg0)
	f9_arg0.ZMInvChallenges:close()
end
