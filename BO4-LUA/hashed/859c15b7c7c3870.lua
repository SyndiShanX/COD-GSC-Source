require("x64:60a00002b58880b")
CoD.BountyHunterTrackBuy = InheritFrom(LUI.UIElement)
CoD.BountyHunterTrackBuy.__defaultWidth = 127
CoD.BountyHunterTrackBuy.__defaultHeight = 127
CoD.BountyHunterTrackBuy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterTrackBuy)
	self.id = "BountyHunterTrackBuy"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PackageTiers = LUI.UIList.new(f1_arg0, f1_arg1, 28, 0, nil, false, false, false, false)
	PackageTiers:setLeftRight(0, 0, 0, 1091)
	PackageTiers:setTopBottom(0, 0, 0, 127)
	PackageTiers:setWidgetType(CoD.BountyHunterPackageTier)
	PackageTiers:setHorizontalCount(3)
	PackageTiers:setSpacing(28)
	PackageTiers:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PackageTiers:setDataSource("BountyHunterPackages")
	self:addElement(PackageTiers)
	self.PackageTiers = PackageTiers
	local Header = LUI.UIText.new(0, 0, 3, 153, 0, 0, -21, -4)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(4)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Header)
	self.Header = Header
	PackageTiers.id = "PackageTiers"
	self.__defaultFocus = PackageTiers
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterTrackBuy.__onClose = function(f2_arg0)
	f2_arg0.PackageTiers:close()
end
