require("x64:21a3ca9a40980c0")
CoD.ContractFrame = InheritFrom(LUI.UIElement)
CoD.ContractFrame.__defaultWidth = 1920
CoD.ContractFrame.__defaultHeight = 1080
CoD.ContractFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractFrame)
	self.id = "ContractFrame"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PurchasableContractList = CoD.ContractFrameInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -841, 230, 0, 0, 140, 991)
	self:addElement(PurchasableContractList)
	self.PurchasableContractList = PurchasableContractList
	PurchasableContractList.id = "PurchasableContractList"
	self.__defaultFocus = PurchasableContractList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	if not ListElementHasElements(self.PurchasableContractList) then
		SetFocusToElement(self, "PurchasedContractList", f1_arg1)
	end
	return self
end
CoD.ContractFrame.__onClose = function(f2_arg0)
	f2_arg0.PurchasableContractList:close()
end
