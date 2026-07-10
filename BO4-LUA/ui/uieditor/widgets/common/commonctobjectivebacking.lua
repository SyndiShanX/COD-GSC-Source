require("x64:19c1945d2e472b0")
CoD.CommonCTObjectiveBacking = InheritFrom(LUI.UIElement)
CoD.CommonCTObjectiveBacking.__defaultWidth = 600
CoD.CommonCTObjectiveBacking.__defaultHeight = 100
CoD.CommonCTObjectiveBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonCTObjectiveBacking)
	self.id = "CommonCTObjectiveBacking"
	self.soundSet = "default"
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	StoreCommonTextBacking.TiledShaderImage:setupNineSliceShader(30, 30)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local BackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 8, -8)
	BackingTint:setAlpha(0.05)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local BottomStroke = LUI.UIImage.new(0, 1, -6, 6, 0, 0, -8, 50)
	BottomStroke:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BottomStroke:setAlpha(0.6)
	BottomStroke:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	BottomStroke:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomStroke:setShaderVector(0, 0, 0, 0, 0)
	BottomStroke:setupNineSliceShader(120, 10)
	self:addElement(BottomStroke)
	self.BottomStroke = BottomStroke
	local BottomStroke2 = LUI.UIImage.new(0, 1, -6, 6, 1, 1, -7, 51)
	BottomStroke2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BottomStroke2:setAlpha(0.6)
	BottomStroke2:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	BottomStroke2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomStroke2:setShaderVector(0, 0, 0, 0, 0)
	BottomStroke2:setupNineSliceShader(120, 10)
	self:addElement(BottomStroke2)
	self.BottomStroke2 = BottomStroke2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonCTObjectiveBacking.__onClose = function(f2_arg0)
	f2_arg0.StoreCommonTextBacking:close()
end
