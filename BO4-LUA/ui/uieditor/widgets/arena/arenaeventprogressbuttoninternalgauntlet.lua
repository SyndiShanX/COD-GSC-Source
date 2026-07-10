require("x64:3f67573d4de18d5")
CoD.ArenaEventProgressButtonInternalGauntlet = InheritFrom(LUI.UIElement)
CoD.ArenaEventProgressButtonInternalGauntlet.__defaultWidth = 382
CoD.ArenaEventProgressButtonInternalGauntlet.__defaultHeight = 70
CoD.ArenaEventProgressButtonInternalGauntlet.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaEventProgressButtonInternalGauntlet)
	self.id = "ArenaEventProgressButtonInternalGauntlet"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local EventTitle = LUI.UIText.new(0, 0, 9, 285, 0, 0, 10, 30)
	EventTitle:setRGB(ColorSet.RewardChallenge.r, ColorSet.RewardChallenge.g, ColorSet.RewardChallenge.b)
	EventTitle:setText(LocalizeToUpperString(@"hash_A5CBEE1298159B6"))
	EventTitle:setTTF("default")
	EventTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EventTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EventTitle)
	self.EventTitle = EventTitle
	local Wins = LUI.UIText.new(0, 0, 9, 167, 0, 0, 35, 67)
	Wins:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	Wins:setTTF("default")
	Wins:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Wins:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Wins:subscribeToGlobalModel(f1_arg1, "ArenaGauntlet", "wins", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Wins:setText(f2_local0)
		end
	end)
	self:addElement(Wins)
	self.Wins = Wins
	local Losses = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	Losses:mergeStateConditions({
		{
			stateName = "Filled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "active")
			end,
		},
	})
	Losses:linkToElementModel(Losses, "active", true, function(model)
		f1_arg0:updateElementState(Losses, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "active",
		})
	end)
	Losses:setLeftRight(1, 1, -140, -16)
	Losses:setTopBottom(0.5, 0.5, -20, 20)
	Losses:setWidgetType(CoD.ArenaGauntletLossSlot)
	Losses:setHorizontalCount(3)
	Losses:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Losses:subscribeToGlobalModel(f1_arg1, "ArenaGauntlet", "lossesListDataSource", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Losses:setDataSource(f5_local0)
		end
	end)
	self:addElement(Losses)
	self.Losses = Losses
	Losses.id = "Losses"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventProgressButtonInternalGauntlet.__onClose = function(f6_arg0)
	f6_arg0.Wins:close()
	f6_arg0.Losses:close()
end
