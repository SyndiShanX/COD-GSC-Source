CoD.WZAARChallengeOrContract = InheritFrom(LUI.UIElement)
CoD.WZAARChallengeOrContract.__defaultWidth = 36
CoD.WZAARChallengeOrContract.__defaultHeight = 36
CoD.WZAARChallengeOrContract.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAARChallengeOrContract)
	self.id = "WZAARChallengeOrContract"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ContractOrChallenge = LUI.UIImage.new(0, 0, 0, 36, 0, 0, 0, 36)
	ContractOrChallenge:setRGB(0.61, 0.61, 0.61)
	ContractOrChallenge:setImage(RegisterImage(0xE6A039E47F76367))
	self:addElement(ContractOrChallenge)
	self.ContractOrChallenge = ContractOrChallenge
	self:mergeStateConditions({
		{
			stateName = "Contract",
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
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAARChallengeOrContract.__resetProperties = function(f4_arg0)
	f4_arg0.ContractOrChallenge:completeAnimation()
	f4_arg0.ContractOrChallenge:setImage(RegisterImage(0xE6A039E47F76367))
end
CoD.WZAARChallengeOrContract.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Contract = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ContractOrChallenge:completeAnimation()
			f6_arg0.ContractOrChallenge:setImage(RegisterImage(0xB2CE4A74953F52E))
			f6_arg0.clipFinished(f6_arg0.ContractOrChallenge)
		end,
	},
}
