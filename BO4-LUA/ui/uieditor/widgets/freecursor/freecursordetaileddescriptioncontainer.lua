require("ui/uieditor/widgets/pc/freecursor/freecursordetaileddescriptionpc")
CoD.freeCursorDetailedDescriptionContainer = InheritFrom(LUI.UIElement)
CoD.freeCursorDetailedDescriptionContainer.__defaultWidth = 405
CoD.freeCursorDetailedDescriptionContainer.__defaultHeight = 200
CoD.freeCursorDetailedDescriptionContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorDetailedDescriptionContainer)
	self.id = "freeCursorDetailedDescriptionContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local detailedDescriptionPC = nil
	detailedDescriptionPC = CoD.freeCursorDetailedDescriptionPC.new(f1_arg0, f1_arg1, 0, 0, 0, 430, 0, 0, 0, 200)
	detailedDescriptionPC:linkToElementModel(self, nil, false, function(model)
		detailedDescriptionPC:setModel(model, f1_arg1)
	end)
	self:addElement(detailedDescriptionPC)
	self.detailedDescriptionPC = detailedDescriptionPC
	local f1_local2 = nil
	self.detailedDescription = LUI.UIElement.createFake()
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.FreeCursorUtility.UseLocalHeight(self)
	return self
end
CoD.freeCursorDetailedDescriptionContainer.__onClose = function(f3_arg0)
	f3_arg0.detailedDescriptionPC:close()
	f3_arg0.detailedDescription:close()
end
