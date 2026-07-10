require("x64:f78acfcbc465bba")
require("x64:94dab3a4d2d79b2")
require("x64:19c1945d2e472b0")
CoD.FTUEWZProgressionWidget = InheritFrom(LUI.UIElement)
CoD.FTUEWZProgressionWidget.__defaultWidth = 277
CoD.FTUEWZProgressionWidget.__defaultHeight = 300
CoD.FTUEWZProgressionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FTUEWZProgressionWidget)
	self.id = "FTUEWZProgressionWidget"
	self.soundSet = "default"
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.23, 0.23, 0.23)
	self:addElement(Background)
	self.Background = Background
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 277, 0.09, 0.09, -26, 274)
	NoiseTiledBacking:setAlpha(0.7)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 277, 0, 0, 218, 300)
	DotTiledBacking:setAlpha(0.69)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 0, 277, 0, 0, 218, 300)
	DotCorner9Slice:setAlpha(0.72)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local EchelonImage = LUI.UIImage.new(0, 0, 46, 231, 0, 0, 19.5, 204.5)
	self:addElement(EchelonImage)
	self.EchelonImage = EchelonImage
	local EchelonTitle = LUI.UIText.new(0, 0, 0, 277, 0, 0, 233, 262)
	EchelonTitle:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	EchelonTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	EchelonTitle:setTTF("ttmussels_demibold")
	EchelonTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EchelonTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EchelonTitle)
	self.EchelonTitle = EchelonTitle
	local EchelonIndex = LUI.UIText.new(0, 0, 0, 277, 0, 0, 261, 284)
	EchelonIndex:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EchelonIndex:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	EchelonIndex:setTTF("ttmussels_regular")
	EchelonIndex:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EchelonIndex:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EchelonIndex)
	self.EchelonIndex = EchelonIndex
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	self:addElement(Lines)
	self.Lines = Lines
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FTUEWZProgressionWidget.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
	f2_arg0.DotCorner9Slice:close()
	f2_arg0.Lines:close()
end
