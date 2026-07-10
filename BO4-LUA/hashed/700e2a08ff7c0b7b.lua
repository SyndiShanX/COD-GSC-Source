require("x64:3f67573d4de18d5")
CoD.ArenaGauntletLossTracker = InheritFrom(LUI.UIElement)
CoD.ArenaGauntletLossTracker.__defaultWidth = 150
CoD.ArenaGauntletLossTracker.__defaultHeight = 80
CoD.ArenaGauntletLossTracker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaGauntletLossTracker)
	self.id = "ArenaGauntletLossTracker"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
	self:addElement(Backing)
	self.Backing = Backing
	local LossesLabel = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 3, 27)
	LossesLabel:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
	LossesLabel:setText(LocalizeToUpperString(@"menu/lb_losses"))
	LossesLabel:setTTF("default")
	LossesLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	LossesLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(LossesLabel)
	self.LossesLabel = LossesLabel
	local LossesList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	LossesList:mergeStateConditions({
		{
			stateName = "Filled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "active")
			end,
		},
	})
	LossesList:linkToElementModel(LossesList, "active", true, function(model)
		f1_arg0:updateElementState(LossesList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "active",
		})
	end)
	LossesList:setLeftRight(0.5, 0.5, -70, 70)
	LossesList:setTopBottom(0.5, 0.5, -7, 33)
	LossesList:setWidgetType(CoD.ArenaGauntletLossSlot)
	LossesList:setHorizontalCount(3)
	LossesList:setSpacing(10)
	LossesList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(LossesList)
	self.LossesList = LossesList
	LossesList.id = "LossesList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaGauntletLossTracker.__onClose = function(f4_arg0)
	f4_arg0.LossesList:close()
end
