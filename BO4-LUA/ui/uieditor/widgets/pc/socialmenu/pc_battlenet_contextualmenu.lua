require("ui/uieditor/widgets/emptyfocusable")
CoD.PC_Battlenet_ContextualMenu = InheritFrom(LUI.UIElement)
CoD.PC_Battlenet_ContextualMenu.__defaultWidth = 450
CoD.PC_Battlenet_ContextualMenu.__defaultHeight = 150
CoD.PC_Battlenet_ContextualMenu.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "_yieldFocus", true)
	self:setClass(CoD.PC_Battlenet_ContextualMenu)
	self.id = "PC_Battlenet_ContextualMenu"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:linkToElementModel(self, nil, false, function(model)
		emptyFocusable:setModel(model, f1_arg1)
	end)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	emptyFocusable.id = "emptyFocusable"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	return self
end
CoD.PC_Battlenet_ContextualMenu.__onClose = function(f3_arg0)
	f3_arg0.emptyFocusable:close()
end
