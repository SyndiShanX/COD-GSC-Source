require("x64:c01c702d0c9c363")
require("x64:2675595fa323085")
CoD.StartMenu_Contracts = InheritFrom(LUI.UIElement)
CoD.StartMenu_Contracts.__defaultWidth = 1920
CoD.StartMenu_Contracts.__defaultHeight = 1080
CoD.StartMenu_Contracts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f1_arg1, true)
	self:setClass(CoD.StartMenu_Contracts)
	self.id = "StartMenu_Contracts"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local AARContractsTabInternal = CoD.AARContractsTabInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	self:addElement(AARContractsTabInternal)
	self.AARContractsTabInternal = AARContractsTabInternal
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -390, 390)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	AARContractsTabInternal.id = "AARContractsTabInternal"
	emptyFocusable.id = "emptyFocusable"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Contracts.__onClose = function(f2_arg0)
	f2_arg0.AARContractsTabInternal:close()
	f2_arg0.emptyFocusable:close()
end
