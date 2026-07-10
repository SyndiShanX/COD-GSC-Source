CoD.InspectionEmblemInternalWidget = InheritFrom(LUI.UIElement)
CoD.InspectionEmblemInternalWidget.__defaultWidth = 348
CoD.InspectionEmblemInternalWidget.__defaultHeight = 348
CoD.InspectionEmblemInternalWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionEmblemInternalWidget)
	self.id = "InspectionEmblemInternalWidget"
	self.soundSet = "ModeSelection"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emblem = LUI.UIImage.new(0, 0, 0, 348, 0, 0, 0, 348)
	self:addElement(emblem)
	self.emblem = emblem
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
