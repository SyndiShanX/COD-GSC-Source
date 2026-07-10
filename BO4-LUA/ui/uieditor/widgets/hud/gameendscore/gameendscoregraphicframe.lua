require("x64:ca2cf2bbe06281b")
CoD.GameEndScoreGraphicFrame = InheritFrom(LUI.UIElement)
CoD.GameEndScoreGraphicFrame.__defaultWidth = 76
CoD.GameEndScoreGraphicFrame.__defaultHeight = 31
CoD.GameEndScoreGraphicFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreGraphicFrame)
	self.id = "GameEndScoreGraphicFrame"
	self.soundSet = "default"
	local DiamondFuiRight2 = CoD.PositionDraft_DiamondFUI.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, -6, 0.5, 0.5, -15.5, 15.5)
	DiamondFuiRight2:setAlpha(0.5)
	DiamondFuiRight2:setZRot(45)
	DiamondFuiRight2:linkToElementModel(self, nil, false, function(model)
		DiamondFuiRight2:setModel(model, f1_arg1)
	end)
	self:addElement(DiamondFuiRight2)
	self.DiamondFuiRight2 = DiamondFuiRight2
	local lineR4 = LUI.UIImage.new(0.5, 0.5, 5, 29, 0.5, 0.5, -0.5, 0.5)
	lineR4:setAlpha(0.5)
	self:addElement(lineR4)
	self.lineR4 = lineR4
	local dotR6 = LUI.UIImage.new(0.5, 0.5, 34, 38, 0.5, 0.5, -2, 2)
	dotR6:setAlpha(0.5)
	dotR6:setImage(RegisterImage(0xDA0056D17A8AC89))
	self:addElement(dotR6)
	self.dotR6 = dotR6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreGraphicFrame.__onClose = function(f3_arg0)
	f3_arg0.DiamondFuiRight2:close()
end
