require("x64:a0ea5c4d6136584")
require("x64:520ac0ef70d2063")
CoD.WZAARContractReward = InheritFrom(LUI.UIElement)
CoD.WZAARContractReward.__defaultWidth = 345
CoD.WZAARContractReward.__defaultHeight = 56
CoD.WZAARContractReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAARContractReward)
	self.id = "WZAARContractReward"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 345, 0, 0, 0, 56)
	Background:setRGB(0.2, 0.2, 0.2)
	Background:setAlpha(0.7)
	self:addElement(Background)
	self.Background = Background
	local BMActiveContractXpReward = CoD.BM_ActiveContractXpReward.new(f1_arg0, f1_arg1, 0, 0, 42.5, 172.5, 0, 0, 3, 53)
	BMActiveContractXpReward:linkToElementModel(self, "xp", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BMActiveContractXpReward.RewardsAmount:setText(f2_local0)
		end
	end)
	self:addElement(BMActiveContractXpReward)
	self.BMActiveContractXpReward = BMActiveContractXpReward
	local GenericReward = CoD.BM_ActiveContractItemReward.new(f1_arg0, f1_arg1, 0, 0, 192.5, 322.5, 0, 0, 3, 53)
	GenericReward:linkToElementModel(self, "cases", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GenericReward.RewardsAmount:setText(f3_local0)
		end
	end)
	self:addElement(GenericReward)
	self.GenericReward = GenericReward
	self:mergeStateConditions({
		{
			stateName = "XPOnly",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "cases", 0)
			end,
		},
	})
	self:linkToElementModel(self, "cases", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cases",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAARContractReward.__resetProperties = function(f6_arg0)
	f6_arg0.GenericReward:completeAnimation()
	f6_arg0.BMActiveContractXpReward:completeAnimation()
	f6_arg0.GenericReward:setAlpha(1)
	f6_arg0.BMActiveContractXpReward:setLeftRight(0, 0, 42.5, 172.5)
end
CoD.WZAARContractReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	XPOnly = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.BMActiveContractXpReward:completeAnimation()
			f8_arg0.BMActiveContractXpReward:setLeftRight(0, 0, 131.5, 261.5)
			f8_arg0.clipFinished(f8_arg0.BMActiveContractXpReward)
			f8_arg0.GenericReward:completeAnimation()
			f8_arg0.GenericReward:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GenericReward)
		end,
	},
}
CoD.WZAARContractReward.__onClose = function(f9_arg0)
	f9_arg0.BMActiveContractXpReward:close()
	f9_arg0.GenericReward:close()
end
