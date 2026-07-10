require("x64:d7ba7c36104672")
CoD.VoDViewerFooter = InheritFrom(LUI.UIElement)
CoD.VoDViewerFooter.__defaultWidth = 1920
CoD.VoDViewerFooter.__defaultHeight = 97
CoD.VoDViewerFooter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VoDViewerFooter)
	self.id = "VoDViewerFooter"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local blackleftBG = LUI.UIImage.new(0, 1, -185, 197, 1, 1, -60, 224)
	blackleftBG:setRGB(0, 0, 0)
	blackleftBG:setAlpha(0.6)
	self:addElement(blackleftBG)
	self.blackleftBG = blackleftBG
	local LineLeft = LUI.UIImage.new(0, 1, -185, 197, 1, 1, -63, -57)
	LineLeft:setAlpha(0.55)
	self:addElement(LineLeft)
	self.LineLeft = LineLeft
	local feLeftContainer = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0.5, 0.5, -937, -135, 1, 1, -72, -6)
	feLeftContainer:linkToElementModel(self, nil, false, function(model)
		feLeftContainer:setModel(model, f1_arg1)
	end)
	self:addElement(feLeftContainer)
	self.feLeftContainer = feLeftContainer
	if CoD.isPC then
		feLeftContainer.id = "feLeftContainer"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VoDViewerFooter.__onClose = function(f3_arg0)
	f3_arg0.feLeftContainer:close()
end
