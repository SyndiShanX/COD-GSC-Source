require("x64:59008baa8ed3c53")
CoD.FastLoadoutContainer = InheritFrom(LUI.UIElement)
CoD.FastLoadoutContainer.__defaultWidth = 380
CoD.FastLoadoutContainer.__defaultHeight = 100
CoD.FastLoadoutContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FastLoadoutContainer)
	self.id = "FastLoadoutContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local PCHUDFastLoadoutContainerTinyLoadoutList = nil
	PCHUDFastLoadoutContainerTinyLoadoutList = CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList.new(f1_arg0, f1_arg1, 0, 0, 0, 380, 0, 0, 0, 100)
	self:addElement(PCHUDFastLoadoutContainerTinyLoadoutList)
	self.PCHUDFastLoadoutContainerTinyLoadoutList = PCHUDFastLoadoutContainerTinyLoadoutList
	if CoD.isPC then
		PCHUDFastLoadoutContainerTinyLoadoutList.id = "PCHUDFastLoadoutContainerTinyLoadoutList"
	end
	self.__defaultFocus = PCHUDFastLoadoutContainerTinyLoadoutList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	if IsPC() then
		CoD.PCWidgetUtility.PrepareFastLoadoutContainer(self, f1_arg1, self.PCHUDFastLoadoutContainerTinyLoadoutList, f1_local2)
		DisableKeyboardNavigationByElement(self.PCHUDFastLoadoutContainerTinyLoadoutList)
	end
	return self
end
CoD.FastLoadoutContainer.__onClose = function(f2_arg0)
	f2_arg0.PCHUDFastLoadoutContainerTinyLoadoutList:close()
end
