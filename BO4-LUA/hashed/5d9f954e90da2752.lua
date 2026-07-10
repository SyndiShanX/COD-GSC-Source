require("x64:aceb4896b7e1ae")
CoD.BM_SmallContractStatusContainer = InheritFrom(LUI.UIElement)
CoD.BM_SmallContractStatusContainer.__defaultWidth = 354
CoD.BM_SmallContractStatusContainer.__defaultHeight = 68
CoD.BM_SmallContractStatusContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_SmallContractStatusContainer)
	self.id = "BM_SmallContractStatusContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local ActiveContracts = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, false, false, false, false)
	ActiveContracts:setLeftRight(0.5, 0.5, -120, 114)
	ActiveContracts:setTopBottom(0.5, 0.5, -34, 34)
	ActiveContracts:setWidgetType(CoD.BM_SmallContractProgress)
	ActiveContracts:setHorizontalCount(3)
	ActiveContracts:setSpacing(15)
	ActiveContracts:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ActiveContracts:setDataSource("BlackMarketActiveContracts")
	ActiveContracts:subscribeToGlobalModel(f1_arg1, "PerController", "Contracts.updateActiveContracts", function(model)
		CoD.GridAndListUtility.UpdateDataSource(ActiveContracts, true, true, true)
	end)
	self:addElement(ActiveContracts)
	self.ActiveContracts = ActiveContracts
	ActiveContracts.id = "ActiveContracts"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_SmallContractStatusContainer.__onClose = function(f3_arg0)
	f3_arg0.ActiveContracts:close()
end
