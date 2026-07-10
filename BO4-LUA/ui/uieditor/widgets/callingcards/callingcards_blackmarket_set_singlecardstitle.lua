require("x64:dbb04b55fa27ac6")
CoD.CallingCards_BlackMarket_Set_SingleCardsTitle = InheritFrom(LUI.UIElement)
CoD.CallingCards_BlackMarket_Set_SingleCardsTitle.__defaultWidth = 350
CoD.CallingCards_BlackMarket_Set_SingleCardsTitle.__defaultHeight = 37
CoD.CallingCards_BlackMarket_Set_SingleCardsTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.CallingCards_BlackMarket_Set_SingleCardsTitle)
	self.id = "CallingCards_BlackMarket_Set_SingleCardsTitle"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local newIcon = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 1, 1, 12, 30, 0.5, 0.5, -9, 9)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
			end,
		},
	})
	newIcon:linkToElementModel(newIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	newIcon:linkToElementModel(self, "breadcrumb", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			newIcon:setModel(f4_local0, f1_arg1)
		end
	end)
	self:addElement(newIcon)
	self.newIcon = newIcon
	local SingleCardsTitle = LUI.UIText.new(0, 0, 0, 350, 0, 0, 0, 37)
	SingleCardsTitle:setText(LocalizeToUpperString(@"hash_7DB6CD62FFFD0EEF"))
	SingleCardsTitle:setTTF("ttmussels_demibold")
	SingleCardsTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SingleCardsTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(SingleCardsTitle)
	self.SingleCardsTitle = SingleCardsTitle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_BlackMarket_Set_SingleCardsTitle.__onClose = function(f5_arg0)
	f5_arg0.newIcon:close()
end
