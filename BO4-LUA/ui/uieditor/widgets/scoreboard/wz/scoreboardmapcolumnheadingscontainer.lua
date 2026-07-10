require("x64:73a9d7c1ffff91e")
CoD.ScoreboardMapColumnHeadingsContainer = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapColumnHeadingsContainer.__defaultWidth = 896
CoD.ScoreboardMapColumnHeadingsContainer.__defaultHeight = 40
CoD.ScoreboardMapColumnHeadingsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapColumnHeadingsContainer)
	self.id = "ScoreboardMapColumnHeadingsContainer"
	self.soundSet = "default"
	local ColumnHeadings = CoD.ScoreboardMapColumnHeadings.new(f1_arg0, f1_arg1, 0, 0, 0, 896, 0, 0, 0, 40)
	self:addElement(ColumnHeadings)
	self.ColumnHeadings = ColumnHeadings
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	CoD.WZUtility.InitColumnHeadingsForScaleAndPan(f1_arg1, self, self.ColumnHeadings)
	return self
end
CoD.ScoreboardMapColumnHeadingsContainer.__onClose = function(f2_arg0)
	f2_arg0.ColumnHeadings:close()
end
