require("x64:e983712ed0b95d3")
require("x64:f72d4606ccc678a")
CoD.DoubleXPPromotionalIcon = InheritFrom(LUI.UIElement)
CoD.DoubleXPPromotionalIcon.__defaultWidth = 72
CoD.DoubleXPPromotionalIcon.__defaultHeight = 72
CoD.DoubleXPPromotionalIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DoubleXPPromotionalIcon)
	self.id = "DoubleXPPromotionalIcon"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXPIcon = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, 0, 72)
	DoubleXPIcon:mergeStateConditions({
		{
			stateName = "VisibleWZ",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasDoubleXP(f1_arg1, element) and CoD.DoubleXPUtility.HasMainMode(f1_arg1, element, Enum[@"emodes"][@"mode_warzone"])
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasDoubleXP(f1_arg1, element)
			end,
		},
	})
	DoubleXPIcon:linkToElementModel(DoubleXPIcon, "hasDoubleXP", true, function(model)
		f1_arg0:updateElementState(DoubleXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasDoubleXP",
		})
	end)
	DoubleXPIcon:linkToElementModel(self, nil, false, function(model)
		DoubleXPIcon:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	local PromotionalDoubleXPIcon = CoD.DirectorFindGamePlaylistInfoTimed2xp.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, 0, 106)
	PromotionalDoubleXPIcon:setAlpha(0)
	PromotionalDoubleXPIcon:linkToElementModel(self, nil, false, function(model)
		PromotionalDoubleXPIcon:setModel(model, f1_arg1)
	end)
	self:addElement(PromotionalDoubleXPIcon)
	self.PromotionalDoubleXPIcon = PromotionalDoubleXPIcon
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasDoubleXP(f1_arg1, element)
			end,
		},
		{
			stateName = "Promotional",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasPromotionalDoubleXP(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "hasDoubleXP", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasDoubleXP",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.PromotionalDoubleXP.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.dailyDoubleXPTimeLeft, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "dailyDoubleXPTimeLeft",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f11_arg2, f11_arg3, f11_arg4)
		if not CoD.BaseUtility.IsSelfInEitherState(self, "Visible", "Promotional") then
			HideWidget(self)
		else
			ShowWidget(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPPromotionalIcon.__resetProperties = function(f12_arg0)
	f12_arg0.DoubleXPIcon:completeAnimation()
	f12_arg0.PromotionalDoubleXPIcon:completeAnimation()
	f12_arg0.DoubleXPIcon:setAlpha(1)
	f12_arg0.PromotionalDoubleXPIcon:setAlpha(0)
end
CoD.DoubleXPPromotionalIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.DoubleXPIcon:completeAnimation()
			f13_arg0.DoubleXPIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DoubleXPIcon)
			f13_arg0.PromotionalDoubleXPIcon:completeAnimation()
			f13_arg0.PromotionalDoubleXPIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PromotionalDoubleXPIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.DoubleXPIcon:completeAnimation()
			f14_arg0.DoubleXPIcon:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.DoubleXPIcon)
			f14_arg0.PromotionalDoubleXPIcon:completeAnimation()
			f14_arg0.PromotionalDoubleXPIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PromotionalDoubleXPIcon)
		end,
	},
	Promotional = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.DoubleXPIcon:completeAnimation()
			f15_arg0.DoubleXPIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DoubleXPIcon)
			f15_arg0.PromotionalDoubleXPIcon:completeAnimation()
			f15_arg0.PromotionalDoubleXPIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.PromotionalDoubleXPIcon)
		end,
	},
}
CoD.DoubleXPPromotionalIcon.__onClose = function(f16_arg0)
	f16_arg0.DoubleXPIcon:close()
	f16_arg0.PromotionalDoubleXPIcon:close()
end
