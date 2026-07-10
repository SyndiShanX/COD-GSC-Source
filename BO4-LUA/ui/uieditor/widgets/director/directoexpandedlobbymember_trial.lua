require("x64:2d361ac3553c22a")
CoD.DirectoExpandedLobbyMember_Trial = InheritFrom(LUI.UIElement)
CoD.DirectoExpandedLobbyMember_Trial.__defaultWidth = 32
CoD.DirectoExpandedLobbyMember_Trial.__defaultHeight = 32
CoD.DirectoExpandedLobbyMember_Trial.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectoExpandedLobbyMember_Trial)
	self.id = "DirectoExpandedLobbyMember_Trial"
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
			stateName = "TrialMember",
			condition = function(menu, element, event)
				return CoD.SocialUtility.DirectorLobbyMemberIsTrial(element, f1_arg1)
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectoExpandedLobbyMember_Trial.__resetProperties = function(f5_arg0)
	f5_arg0.TrialWidget:completeAnimation()
	f5_arg0.TrialWidget:setAlpha(1)
end
CoD.DirectoExpandedLobbyMember_Trial.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.TrialWidget:completeAnimation()
			f6_arg0.TrialWidget:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TrialWidget)
		end,
	},
	TrialMember = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectoExpandedLobbyMember_Trial.__onClose = function(f8_arg0)
	f8_arg0.TrialWidget:close()
end
