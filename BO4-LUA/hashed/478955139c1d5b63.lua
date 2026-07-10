require("x64:884fad5277b3107")
CoD.ActiveCamoListSelectionWidget = InheritFrom(LUI.UIElement)
CoD.ActiveCamoListSelectionWidget.__defaultWidth = 1254
CoD.ActiveCamoListSelectionWidget.__defaultHeight = 400
CoD.ActiveCamoListSelectionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ActiveCamoListSelectionWidget)
	self.id = "ActiveCamoListSelectionWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local ActiveCamoGrid = CoD.ActiveCamoGrid.new(f1_arg0, f1_arg1, 0, 0, 0, 1254, 0, 0, 25, 375)
	self:addElement(ActiveCamoGrid)
	self.ActiveCamoGrid = ActiveCamoGrid
	ActiveCamoGrid.id = "ActiveCamoGrid"
	self.__defaultFocus = ActiveCamoGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.ActiveCamoListSelectionWidget.__onClose = function(f2_arg0)
	f2_arg0.ActiveCamoGrid:close()
end
