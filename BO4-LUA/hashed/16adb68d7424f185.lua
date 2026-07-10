require("x64:2c271d2907ed290")
require("x64:6ccfbdb45a2f1a0")
CoD.AARTierRewardColumn = InheritFrom(LUI.UIElement)
CoD.AARTierRewardColumn.__defaultWidth = 115
CoD.AARTierRewardColumn.__defaultHeight = 632
CoD.AARTierRewardColumn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardColumn)
	self.id = "AARTierRewardColumn"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Header = CoD.AARTierRewardColumnHeader.new(f1_arg0, f1_arg1, 0, 0, 5, 110, 0, 0, 0, 40)
	Header:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsTierColumnLocked(self, f1_arg1)
			end,
		},
	})
	local f1_local2 = Header
	local TierRewardGrid = Header.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	TierRewardGrid(f1_local2, f1_local4["AAR.tierReward.highlightedTier"], function(f3_arg0)
		f1_arg0:updateElementState(Header, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "AAR.tierReward.highlightedTier",
		})
	end, false)
	Header:linkToElementModel(Header, "tier", true, function(model)
		f1_arg0:updateElementState(Header, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tier",
		})
	end)
	Header:linkToElementModel(self, nil, false, function(model)
		Header:setModel(model, f1_arg1)
	end)
	Header:linkToElementModel(self, "tier", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Header.Tier:setText(f6_local0)
		end
	end)
	Header:linkToElementModel(self, "tier", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Header.HighlightedHeader.Tier:setText(f7_local0)
		end
	end)
	self:addElement(Header)
	self.Header = Header
	TierRewardGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 11, 0, nil, nil, false, false, false, false)
	TierRewardGrid:setLeftRight(0, 0, 5, 110)
	TierRewardGrid:setTopBottom(0, 0, 54, 631)
	TierRewardGrid:setWidgetType(CoD.AARTierRewardItem)
	TierRewardGrid:setVerticalCount(4)
	TierRewardGrid:setSpacing(11)
	TierRewardGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TierRewardGrid:linkToElementModel(self, "tierRewardDatasource", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			TierRewardGrid:setDataSource(f8_local0)
		end
	end)
	TierRewardGrid:linkToElementModel(self, "triggerUnlock", true, function(model)
		local f9_local0 = TierRewardGrid
		if CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "triggerUnlock") then
			CoD.AARUtility.UnlockTierRewards(f1_arg1, f9_local0)
		end
	end)
	TierRewardGrid:linkToElementModel(self, "tier", true, function(model)
		UpdateDataSource(self, TierRewardGrid, f1_arg1)
	end)
	self:addElement(TierRewardGrid)
	self.TierRewardGrid = TierRewardGrid
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "tier", 1)
			end,
		},
	})
	self:linkToElementModel(self, "tier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tier",
		})
	end)
	TierRewardGrid.id = "TierRewardGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardColumn.__resetProperties = function(f13_arg0)
	f13_arg0.TierRewardGrid:completeAnimation()
	f13_arg0.Header:completeAnimation()
	f13_arg0.TierRewardGrid:setAlpha(1)
	f13_arg0.Header:setAlpha(1)
end
CoD.AARTierRewardColumn.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.Header:completeAnimation()
			f15_arg0.Header:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Header)
			f15_arg0.TierRewardGrid:completeAnimation()
			f15_arg0.TierRewardGrid:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TierRewardGrid)
		end,
	},
}
CoD.AARTierRewardColumn.__onClose = function(f16_arg0)
	f16_arg0.Header:close()
	f16_arg0.TierRewardGrid:close()
end
