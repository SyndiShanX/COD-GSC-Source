require("x64:994b39b700bc4fe")
CoD.ScoreboardMapRowHeadingsContainer = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapRowHeadingsContainer.__defaultWidth = 40
CoD.ScoreboardMapRowHeadingsContainer.__defaultHeight = 896
CoD.ScoreboardMapRowHeadingsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapRowHeadingsContainer)
	self.id = "ScoreboardMapRowHeadingsContainer"
	self.soundSet = "default"
	local RowHeadings = CoD.ScoreboardMapRowHeadings.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 0, 0, 0, 896)
	self:addElement(RowHeadings)
	self.RowHeadings = RowHeadings
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	CoD.WZUtility.InitRowHeadingsForScaleAndPan(f1_arg1, self, self.RowHeadings)
	return self
end
CoD.ScoreboardMapRowHeadingsContainer.__onClose = function(f2_arg0)
	f2_arg0.RowHeadings:close()
end
