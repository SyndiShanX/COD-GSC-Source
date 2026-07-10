require("x64:a0ea5c4d6136584")
require("x64:d6fc714e834102b")
require("x64:520ac0ef70d2063")
CoD.BM_ActiveContractRewards = InheritFrom(LUI.UIElement)
CoD.BM_ActiveContractRewards.__defaultWidth = 440
CoD.BM_ActiveContractRewards.__defaultHeight = 50
CoD.BM_ActiveContractRewards.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 20, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.BM_ActiveContractRewards)
	self.id = "BM_ActiveContractRewards"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BMActiveContractXpReward = CoD.BM_ActiveContractXpReward.new(f1_arg0, f1_arg1, 0, 0, 5, 135, 0, 0, 0, 50)
	BMActiveContractXpReward:linkToElementModel(self, "xpReward", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BMActiveContractXpReward.RewardsAmount:setText(f2_local0)
		end
	end)
	self:addElement(BMActiveContractXpReward)
	self.BMActiveContractXpReward = BMActiveContractXpReward
	local GenericReward = CoD.BM_ActiveContractItemReward.new(f1_arg0, f1_arg1, 0, 0, 155, 285, 0, 0, 0, 50)
	GenericReward:linkToElementModel(self, "rewardIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GenericReward.RewardIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	GenericReward:linkToElementModel(self, "rewardAmount", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GenericReward.RewardsAmount:setText(f4_local0)
		end
	end)
	self:addElement(GenericReward)
	self.GenericReward = GenericReward
	local ZMTierSkip = CoD.BM_ActiveContractRewards_ZMTierSkip.new(f1_arg0, f1_arg1, 0, 0, 305, 435, 0, 0, 0, 50)
	ZMTierSkip:setAlpha(0)
	self:addElement(ZMTierSkip)
	self.ZMTierSkip = ZMTierSkip
	self:mergeStateConditions({
		{
			stateName = "All",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDailyZombies") and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "rewardAmount", 0)
			end,
		},
		{
			stateName = "TierSkip",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDailyZombies")
			end,
		},
		{
			stateName = "XPOnly",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "rewardAmount", 0)
			end,
		},
	})
	self:linkToElementModel(self, "isDailyZombies", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isDailyZombies",
		})
	end)
	self:linkToElementModel(self, "rewardAmount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardAmount",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ActiveContractRewards.__resetProperties = function(f10_arg0)
	f10_arg0.ZMTierSkip:completeAnimation()
	f10_arg0.GenericReward:completeAnimation()
	f10_arg0.ZMTierSkip:setAlpha(0)
	f10_arg0.GenericReward:setAlpha(1)
end
CoD.BM_ActiveContractRewards.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	All = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.ZMTierSkip:completeAnimation()
			f12_arg0.ZMTierSkip:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ZMTierSkip)
		end,
	},
	TierSkip = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.GenericReward:completeAnimation()
			f13_arg0.GenericReward:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.GenericReward)
			f13_arg0.ZMTierSkip:completeAnimation()
			f13_arg0.ZMTierSkip:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.ZMTierSkip)
		end,
	},
	XPOnly = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.GenericReward:completeAnimation()
			f14_arg0.GenericReward:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.GenericReward)
		end,
	},
}
CoD.BM_ActiveContractRewards.__onClose = function(f15_arg0)
	f15_arg0.BMActiveContractXpReward:close()
	f15_arg0.GenericReward:close()
	f15_arg0.ZMTierSkip:close()
end
