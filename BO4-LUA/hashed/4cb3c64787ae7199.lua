require("x64:4c6888ebce3d23e")
require("x64:fb9d9901b113614")
CoD.WZAARChallengeReward = InheritFrom(LUI.UIElement)
CoD.WZAARChallengeReward.__defaultWidth = 345
CoD.WZAARChallengeReward.__defaultHeight = 56
CoD.WZAARChallengeReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAARChallengeReward)
	self.id = "WZAARChallengeReward"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = CoD.WZAAR_Challenges_NearCompletion_CroppedImage.new(f1_arg0, f1_arg1, 0, 0, 0, 345, 0, 0, 0, 56)
	Icon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon.Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Background = CoD.WZAARContractReward.new(f1_arg0, f1_arg1, 0, 0, 0, 345, 0, 0, 0, 70)
	Background:setAlpha(0)
	Background:linkToElementModel(self, nil, false, function(model)
		Background:setModel(model, f1_arg1)
	end)
	self:addElement(Background)
	self.Background = Background
	self:mergeStateConditions({
		{
			stateName = "IsContract",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContract")
			end,
		},
	})
	self:linkToElementModel(self, "isContract", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isContract",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAARChallengeReward.__resetProperties = function(f6_arg0)
	f6_arg0.Icon:completeAnimation()
	f6_arg0.Background:completeAnimation()
	f6_arg0.Icon:setAlpha(1)
	f6_arg0.Background:setAlpha(0)
end
CoD.WZAARChallengeReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	IsContract = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Icon:completeAnimation()
			f8_arg0.Icon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Icon)
			f8_arg0.Background:completeAnimation()
			f8_arg0.Background:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Background)
		end,
	},
}
CoD.WZAARChallengeReward.__onClose = function(f9_arg0)
	f9_arg0.Icon:close()
	f9_arg0.Background:close()
end
