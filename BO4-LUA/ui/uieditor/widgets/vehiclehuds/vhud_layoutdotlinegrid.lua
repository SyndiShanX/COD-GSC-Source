require("x64:8dff6ee9505174e")
require("x64:6d4a92d6b62925f")
CoD.vhud_layoutDotlineGrid = InheritFrom(LUI.UIElement)
CoD.vhud_layoutDotlineGrid.__defaultWidth = 1920
CoD.vhud_layoutDotlineGrid.__defaultHeight = 1165
CoD.vhud_layoutDotlineGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_layoutDotlineGrid)
	self.id = "vhud_layoutDotlineGrid"
	self.soundSet = "default"
	local layoutDotlineH01 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 146.5, 150.5)
	self:addElement(layoutDotlineH01)
	self.layoutDotlineH01 = layoutDotlineH01
	local layoutDotlineH02 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 254.5, 258.5)
	self:addElement(layoutDotlineH02)
	self.layoutDotlineH02 = layoutDotlineH02
	local layoutDotlineH03 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 362.5, 366.5)
	self:addElement(layoutDotlineH03)
	self.layoutDotlineH03 = layoutDotlineH03
	local layoutDotlineH04 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 470.5, 474.5)
	self:addElement(layoutDotlineH04)
	self.layoutDotlineH04 = layoutDotlineH04
	local layoutDotlineH05 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 578.5, 582.5)
	self:addElement(layoutDotlineH05)
	self.layoutDotlineH05 = layoutDotlineH05
	local layoutDotlineH06 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 686.5, 690.5)
	self:addElement(layoutDotlineH06)
	self.layoutDotlineH06 = layoutDotlineH06
	local layoutDotlineH07 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 794, 798)
	self:addElement(layoutDotlineH07)
	self.layoutDotlineH07 = layoutDotlineH07
	local layoutDotlineH08 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 902.5, 906.5)
	self:addElement(layoutDotlineH08)
	self.layoutDotlineH08 = layoutDotlineH08
	local layoutDotlineH09 = CoD.vhud_layoutDotLine.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 1010.5, 1014.5)
	self:addElement(layoutDotlineH09)
	self.layoutDotlineH09 = layoutDotlineH09
	local layoutDotlineV01 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 95.5, 97.5, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV01)
	self.layoutDotlineV01 = layoutDotlineV01
	local layoutDotlineV02 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 203, 205, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV02)
	self.layoutDotlineV02 = layoutDotlineV02
	local layoutDotlineV03 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 311, 313, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV03)
	self.layoutDotlineV03 = layoutDotlineV03
	local layoutDotlineV04 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 527, 529, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV04)
	self.layoutDotlineV04 = layoutDotlineV04
	local layoutDotlineV05 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 635, 637, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV05)
	self.layoutDotlineV05 = layoutDotlineV05
	local layoutDotlineV06 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 635, 637, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV06)
	self.layoutDotlineV06 = layoutDotlineV06
	local layoutDotlineV07 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 743, 745, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV07)
	self.layoutDotlineV07 = layoutDotlineV07
	local layoutDotlineV08 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 743, 745, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV08)
	self.layoutDotlineV08 = layoutDotlineV08
	local layoutDotlineV09 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 851, 853, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV09)
	self.layoutDotlineV09 = layoutDotlineV09
	local layoutDotlineV10 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 959, 961, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV10)
	self.layoutDotlineV10 = layoutDotlineV10
	local layoutDotlineV11 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 1067, 1069, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV11)
	self.layoutDotlineV11 = layoutDotlineV11
	local layoutDotlineV12 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 1175, 1177, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV12)
	self.layoutDotlineV12 = layoutDotlineV12
	local layoutDotlineV13 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 1283, 1285, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV13)
	self.layoutDotlineV13 = layoutDotlineV13
	local layoutDotlineV14 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 1391, 1393, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV14)
	self.layoutDotlineV14 = layoutDotlineV14
	local layoutDotlineV15 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 1499, 1501, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV15)
	self.layoutDotlineV15 = layoutDotlineV15
	local layoutDotlineV16 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 1607, 1609, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV16)
	self.layoutDotlineV16 = layoutDotlineV16
	local layoutDotlineV17 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 1715, 1717, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV17)
	self.layoutDotlineV17 = layoutDotlineV17
	local layoutDotlineV18 = CoD.vhud_layoutDotLineVer.new(f1_arg0, f1_arg1, 0, 0, 1823, 1825, 0, 0, 0, 1165)
	self:addElement(layoutDotlineV18)
	self.layoutDotlineV18 = layoutDotlineV18
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_layoutDotlineGrid.__onClose = function(f2_arg0)
	f2_arg0.layoutDotlineH01:close()
	f2_arg0.layoutDotlineH02:close()
	f2_arg0.layoutDotlineH03:close()
	f2_arg0.layoutDotlineH04:close()
	f2_arg0.layoutDotlineH05:close()
	f2_arg0.layoutDotlineH06:close()
	f2_arg0.layoutDotlineH07:close()
	f2_arg0.layoutDotlineH08:close()
	f2_arg0.layoutDotlineH09:close()
	f2_arg0.layoutDotlineV01:close()
	f2_arg0.layoutDotlineV02:close()
	f2_arg0.layoutDotlineV03:close()
	f2_arg0.layoutDotlineV04:close()
	f2_arg0.layoutDotlineV05:close()
	f2_arg0.layoutDotlineV06:close()
	f2_arg0.layoutDotlineV07:close()
	f2_arg0.layoutDotlineV08:close()
	f2_arg0.layoutDotlineV09:close()
	f2_arg0.layoutDotlineV10:close()
	f2_arg0.layoutDotlineV11:close()
	f2_arg0.layoutDotlineV12:close()
	f2_arg0.layoutDotlineV13:close()
	f2_arg0.layoutDotlineV14:close()
	f2_arg0.layoutDotlineV15:close()
	f2_arg0.layoutDotlineV16:close()
	f2_arg0.layoutDotlineV17:close()
	f2_arg0.layoutDotlineV18:close()
end
