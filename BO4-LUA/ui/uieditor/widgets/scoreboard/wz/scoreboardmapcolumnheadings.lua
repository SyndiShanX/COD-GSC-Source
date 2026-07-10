require("x64:89ff5ea5fff41b0")
CoD.ScoreboardMapColumnHeadings = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapColumnHeadings.__defaultWidth = 896
CoD.ScoreboardMapColumnHeadings.__defaultHeight = 40
CoD.ScoreboardMapColumnHeadings.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapColumnHeadings)
	self.id = "ScoreboardMapColumnHeadings"
	self.soundSet = "default"
	local MapGridColumnHeading = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapGridColumnHeading:setRGB(0, 0, 0)
	MapGridColumnHeading:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	MapGridColumnHeading:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(MapGridColumnHeading)
	self.MapGridColumnHeading = MapGridColumnHeading
	local MapGridColumnHeadingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapGridColumnHeadingTint:setRGB(0, 0, 0)
	MapGridColumnHeadingTint:setAlpha(0.9)
	MapGridColumnHeadingTint:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	MapGridColumnHeadingTint:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(MapGridColumnHeadingTint)
	self.MapGridColumnHeadingTint = MapGridColumnHeadingTint
	local ColA = CoD.ScoreboardMapColumnHeadingWZ.new(f1_arg0, f1_arg1, 0, 0.12, 0, 0, 0, 0, 0, 40)
	ColA.Section:setText(Engine[0xF9F1239CFD921FE](0xF4D63A16D831F6F))
	self:addElement(ColA)
	self.ColA = ColA
	local ColA2 = CoD.ScoreboardMapColumnHeadingWZ.new(f1_arg0, f1_arg1, 0.12, 0.25, 0, 0, 0, 0, 0, 40)
	ColA2.Section:setText(Engine[0xF9F1239CFD921FE](0xF4D64A16D832122))
	self:addElement(ColA2)
	self.ColA2 = ColA2
	local ColA3 = CoD.ScoreboardMapColumnHeadingWZ.new(f1_arg0, f1_arg1, 0.25, 0.38, 0, 0, 0, 0, 0, 40)
	ColA3.Section:setText(Engine[0xF9F1239CFD921FE](0xF4D65A16D8322D5))
	self:addElement(ColA3)
	self.ColA3 = ColA3
	local ColA4 = CoD.ScoreboardMapColumnHeadingWZ.new(f1_arg0, f1_arg1, 0.38, 0.5, 0, 0, 0, 0, 0, 40)
	ColA4.Section:setText(Engine[0xF9F1239CFD921FE](0xF4D5EA16D8316F0))
	self:addElement(ColA4)
	self.ColA4 = ColA4
	local ColA5 = CoD.ScoreboardMapColumnHeadingWZ.new(f1_arg0, f1_arg1, 0.5, 0.62, 0, 0, 0, 0, 0, 40)
	ColA5.Section:setText(Engine[0xF9F1239CFD921FE](0xF4D5FA16D8318A3))
	self:addElement(ColA5)
	self.ColA5 = ColA5
	local ColA6 = CoD.ScoreboardMapColumnHeadingWZ.new(f1_arg0, f1_arg1, 0.62, 0.75, 0, 0, 0, 0, 0, 40)
	ColA6.Section:setText(Engine[0xF9F1239CFD921FE](0xF4D60A16D831A56))
	self:addElement(ColA6)
	self.ColA6 = ColA6
	local ColA7 = CoD.ScoreboardMapColumnHeadingWZ.new(f1_arg0, f1_arg1, 0.75, 0.88, 0, 0, 0, 0, 0, 40)
	ColA7.Section:setText(Engine[0xF9F1239CFD921FE](0xF4D61A16D831C09))
	self:addElement(ColA7)
	self.ColA7 = ColA7
	local ColA8 = CoD.ScoreboardMapColumnHeadingWZ.new(f1_arg0, f1_arg1, 0.88, 1, 0, 0, 0, 0, 0, 40)
	ColA8.Section:setText(Engine[0xF9F1239CFD921FE](0xF4D6AA16D832B54))
	self:addElement(ColA8)
	self.ColA8 = ColA8
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardMapColumnHeadings.__onClose = function(f2_arg0)
	f2_arg0.ColA:close()
	f2_arg0.ColA2:close()
	f2_arg0.ColA3:close()
	f2_arg0.ColA4:close()
	f2_arg0.ColA5:close()
	f2_arg0.ColA6:close()
	f2_arg0.ColA7:close()
	f2_arg0.ColA8:close()
end
