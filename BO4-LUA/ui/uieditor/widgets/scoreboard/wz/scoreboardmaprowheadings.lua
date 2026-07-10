require("x64:37fad1f640b1c10")
CoD.ScoreboardMapRowHeadings = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapRowHeadings.__defaultWidth = 40
CoD.ScoreboardMapRowHeadings.__defaultHeight = 896
CoD.ScoreboardMapRowHeadings.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapRowHeadings)
	self.id = "ScoreboardMapRowHeadings"
	self.soundSet = "default"
	local MapGridRowHeading = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapGridRowHeading:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	MapGridRowHeading:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(MapGridRowHeading)
	self.MapGridRowHeading = MapGridRowHeading
	local MapGridRowHeadingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapGridRowHeadingTint:setRGB(0, 0, 0)
	MapGridRowHeadingTint:setAlpha(0.9)
	MapGridRowHeadingTint:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	MapGridRowHeadingTint:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(MapGridRowHeadingTint)
	self.MapGridRowHeadingTint = MapGridRowHeadingTint
	local Row1 = CoD.ScoreboardMapRowHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0, 0.12, 0, 0)
	self:addElement(Row1)
	self.Row1 = Row1
	local Row2 = CoD.ScoreboardMapRowHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.12, 0.25, 0, 0)
	Row2.TextBox:setText(Engine[0xF9F1239CFD921FE](0x9088B4202CB718))
	self:addElement(Row2)
	self.Row2 = Row2
	local Row3 = CoD.ScoreboardMapRowHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.25, 0.38, 0, 0)
	Row3.TextBox:setText(Engine[0xF9F1239CFD921FE](0x9089B4202CB8CB))
	self:addElement(Row3)
	self.Row3 = Row3
	local Row4 = CoD.ScoreboardMapRowHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.38, 0.5, 0, 0)
	Row4.TextBox:setText(Engine[0xF9F1239CFD921FE](0x908EB4202CC14A))
	self:addElement(Row4)
	self.Row4 = Row4
	local Row5 = CoD.ScoreboardMapRowHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.5, 0.62, 0, 0)
	Row5.TextBox:setText(Engine[0xF9F1239CFD921FE](0x908FB4202CC2FD))
	self:addElement(Row5)
	self.Row5 = Row5
	local Row6 = CoD.ScoreboardMapRowHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.62, 0.75, 0, 0)
	Row6.TextBox:setText(Engine[0xF9F1239CFD921FE](0x908CB4202CBDE4))
	self:addElement(Row6)
	self.Row6 = Row6
	local Row7 = CoD.ScoreboardMapRowHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.75, 0.88, 0, 0)
	Row7.TextBox:setText(Engine[0xF9F1239CFD921FE](0x908DB4202CBF97))
	self:addElement(Row7)
	self.Row7 = Row7
	local Row8 = CoD.ScoreboardMapRowHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.88, 1, 0, 0)
	Row8.TextBox:setText(Engine[0xF9F1239CFD921FE](0x9082B4202CACE6))
	self:addElement(Row8)
	self.Row8 = Row8
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardMapRowHeadings.__onClose = function(f2_arg0)
	f2_arg0.Row1:close()
	f2_arg0.Row2:close()
	f2_arg0.Row3:close()
	f2_arg0.Row4:close()
	f2_arg0.Row5:close()
	f2_arg0.Row6:close()
	f2_arg0.Row7:close()
	f2_arg0.Row8:close()
end
