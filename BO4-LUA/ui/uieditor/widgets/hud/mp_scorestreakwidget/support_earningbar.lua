CoD.Support_EarningBar = InheritFrom(LUI.UIElement)
CoD.Support_EarningBar.__defaultWidth = 9
CoD.Support_EarningBar.__defaultHeight = 2
CoD.Support_EarningBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Support_EarningBar)
	self.id = "Support_EarningBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bar = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -1, 1)
	self:addElement(Bar)
	self.Bar = Bar
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "rewardImage")
			end,
		},
		{
			stateName = "Inactive",
			condition = function(menu, element, event)
				return not CoD.ScorestreakInGameUtility.EarningTowardsThisScorestreak(f1_arg1, self)
			end,
		},
		{
			stateName = "ProgressingTowards",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "rewardImage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardImage",
		})
	end)
	self:linkToElementModel(self, "rewardAmmo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardAmmo",
		})
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.rewardMomentum, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "rewardMomentum",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Support_EarningBar.__resetProperties = function(f8_arg0)
	f8_arg0.Bar:completeAnimation()
	f8_arg0.Bar:setLeftRight(0, 1, 0, 0)
	f8_arg0.Bar:setTopBottom(0.5, 0.5, -1, 1)
	f8_arg0.Bar:setAlpha(1)
end
CoD.Support_EarningBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Bar:completeAnimation()
			f9_arg0.Bar:setLeftRight(0, 1, 0, 0)
			f9_arg0.Bar:setTopBottom(0, 0, 0, 2)
			f9_arg0.clipFinished(f9_arg0.Bar)
		end,
	},
	Empty = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Bar:completeAnimation()
			f10_arg0.Bar:setLeftRight(1, 1, -9, 0)
			f10_arg0.Bar:setTopBottom(0.5, 0.5, -1, 1)
			f10_arg0.Bar:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Bar)
		end,
	},
	Inactive = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Bar:completeAnimation()
			f11_arg0.Bar:setLeftRight(1, 1, -9, 0)
			f11_arg0.Bar:setTopBottom(0.5, 0.5, -1, 1)
			f11_arg0.Bar:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Bar)
		end,
	},
	ProgressingTowards = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Bar:completeAnimation()
			f12_arg0.Bar:setLeftRight(0, 1, 0, 0)
			f12_arg0.Bar:setTopBottom(0.5, 0.5, -1, 1)
			f12_arg0.clipFinished(f12_arg0.Bar)
		end,
	},
}
