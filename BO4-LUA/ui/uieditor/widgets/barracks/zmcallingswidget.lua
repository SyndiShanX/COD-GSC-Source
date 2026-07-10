require("x64:3b9fcb643fbe613")
require("x64:46728994d8c06c0")
CoD.ZMCallingsWidget = InheritFrom(LUI.UIElement)
CoD.ZMCallingsWidget.__defaultWidth = 477
CoD.ZMCallingsWidget.__defaultHeight = 382
CoD.ZMCallingsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("AutoEvents.cycled")
	self:setClass(CoD.ZMCallingsWidget)
	self.id = "ZMCallingsWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 0, 0, 382)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local SpecialEventWidget = CoD.SpecialEventWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 0, 0, 382)
	SpecialEventWidget:mergeStateConditions({
		{
			stateName = "DailyCompleteLayoutSmall",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showDailyLayout")
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allTasksComplete")
					if f2_local0 then
						f2_local0 = CoD.BaseUtility.IsSelfInState(self, "DailyCallingSmall")
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "DailyLayoutSmall",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showDailyLayout") and CoD.BaseUtility.IsSelfInState(self, "DailyCallingSmall")
			end,
		},
	})
	SpecialEventWidget:linkToElementModel(SpecialEventWidget, "showDailyLayout", true, function(model)
		f1_arg0:updateElementState(SpecialEventWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showDailyLayout",
		})
	end)
	SpecialEventWidget:linkToElementModel(SpecialEventWidget, "allTasksComplete", true, function(model)
		f1_arg0:updateElementState(SpecialEventWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allTasksComplete",
		})
	end)
	SpecialEventWidget.RewardQuantityText.RewardGrid:setDataSource("DailyCallingRewards")
	SpecialEventWidget.SpecialEventPips:setAlpha(0)
	SpecialEventWidget:subscribeToGlobalModel(f1_arg1, "DailyCallingInfo", nil, function(model)
		SpecialEventWidget:setModel(model, f1_arg1)
	end)
	self:addElement(SpecialEventWidget)
	self.SpecialEventWidget = SpecialEventWidget
	self:mergeStateConditions({
		{
			stateName = "DailyCallingSmall",
			condition = function(menu, element, event)
				return IsIntDvarNonZero("zm_active_daily_calling") and AlwaysFalse()
			end,
		},
		{
			stateName = "DailyCalling",
			condition = function(menu, element, event)
				return IsIntDvarNonZero("zm_active_daily_calling")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		UpdateElementState(self, "SpecialEventWidget", controller)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "AutoEvents.cycled", function(model)
		local f10_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	SpecialEventWidget.id = "SpecialEventWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMCallingsWidget.__resetProperties = function(f11_arg0)
	f11_arg0.SpecialEventWidget:completeAnimation()
	f11_arg0.CommonDetailPanel2:completeAnimation()
	f11_arg0.SpecialEventWidget:setAlpha(1)
	f11_arg0.CommonDetailPanel2:setTopBottom(0, 0, 0, 382)
end
CoD.ZMCallingsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.SpecialEventWidget:completeAnimation()
			f12_arg0.SpecialEventWidget:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SpecialEventWidget)
		end,
	},
	DailyCallingSmall = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.CommonDetailPanel2:completeAnimation()
			f13_arg0.CommonDetailPanel2:setTopBottom(0, 0, 0, 269)
			f13_arg0.clipFinished(f13_arg0.CommonDetailPanel2)
			f13_arg0.SpecialEventWidget:completeAnimation()
			f13_arg0.SpecialEventWidget:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.SpecialEventWidget)
		end,
	},
	DailyCalling = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.SpecialEventWidget:completeAnimation()
			f14_arg0.SpecialEventWidget:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.SpecialEventWidget)
		end,
	},
}
CoD.ZMCallingsWidget.__onClose = function(f15_arg0)
	f15_arg0.CommonDetailPanel2:close()
	f15_arg0.SpecialEventWidget:close()
end
