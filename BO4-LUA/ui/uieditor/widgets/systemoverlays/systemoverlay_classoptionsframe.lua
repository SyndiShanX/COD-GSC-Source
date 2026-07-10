require("x64:24aaadeea0348c")
require("x64:a9d9ad002907d62")
CoD.systemOverlay_ClassOptionsFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_ClassOptionsFrame.__defaultWidth = 1920
CoD.systemOverlay_ClassOptionsFrame.__defaultHeight = 480
CoD.systemOverlay_ClassOptionsFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_ClassOptionsFrame)
	self.id = "systemOverlay_ClassOptionsFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local f1_local1 = nil
	self.largeImage = LUI.UIElement.createFake()
	local foreground = CoD.systemOverlay_Layout_ClassOptions.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	foreground:linkToElementModel(self, nil, false, function(model)
		foreground:setModel(model, f1_arg1)
	end)
	self:addElement(foreground)
	self.foreground = foreground
	local supportInfo = CoD.systemOverlay_supportWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 528, 1, 1, -36, 0)
	supportInfo:linkToElementModel(self, nil, false, function(model)
		supportInfo:setModel(model, f1_arg1)
	end)
	self:addElement(supportInfo)
	self.supportInfo = supportInfo
	foreground.id = "foreground"
	self.__defaultFocus = foreground
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_ClassOptionsFrame.__onClose = function(f4_arg0)
	f4_arg0.largeImage:close()
	f4_arg0.foreground:close()
	f4_arg0.supportInfo:close()
end
