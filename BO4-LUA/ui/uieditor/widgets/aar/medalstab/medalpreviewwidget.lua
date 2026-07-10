require("x64:56ade4b150b7be")
require("x64:a2c4a319ea5353")
require("x64:564ca313abeb19a")
CoD.MedalPreviewWidget = InheritFrom(LUI.UIElement)
CoD.MedalPreviewWidget.__defaultWidth = 550
CoD.MedalPreviewWidget.__defaultHeight = 714
CoD.MedalPreviewWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MedalPreviewWidget)
	self.id = "MedalPreviewWidget"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.05, 0.05, 0.05)
	Backing:setAlpha(0.98)
	self:addElement(Backing)
	self.Backing = Backing
	local XPBacking = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -100, 0)
	XPBacking:setRGB(0.17, 0.17, 0.17)
	XPBacking:setAlpha(0.2)
	self:addElement(XPBacking)
	self.XPBacking = XPBacking
	local PixelGridTiledBacking = LUI.UIImage.new(0.02, 0.02, -9.5, 540.5, 0.31, 0.31, -220, 492)
	PixelGridTiledBacking:setAlpha(0.07)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local MedalImage = LUI.UIImage.new(0, 0, 107, 441, 0, 0, 63, 396)
	MedalImage:setupUIStreamedImage(0)
	MedalImage:linkToElementModel(self, "iconLarge", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MedalImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(MedalImage)
	self.MedalImage = MedalImage
	local GridTiled = LUI.UIImage.new(0.2, 0.2, -105, 442, 0.19, 0.19, -131, 478)
	GridTiled:setAlpha(0.05)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local DescriptionBox = LUI.UIImage.new(0, 0, 15, 534, 0, 0, 472.5, 601.5)
	DescriptionBox:setRGB(0.09, 0.09, 0.09)
	DescriptionBox:setAlpha(0.9)
	self:addElement(DescriptionBox)
	self.DescriptionBox = DescriptionBox
	local MedalCount = LUI.UIText.new(0, 0, 17.5, 533.5, 0, 0, 395, 446)
	MedalCount:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	MedalCount:setTTF("ttmussels_demibold")
	MedalCount:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	MedalCount:setShaderVector(0, 1, 0, 0, 0)
	MedalCount:setShaderVector(1, 0, 0, 0, 0)
	MedalCount:setShaderVector(2, 1, 1, 0.6, 0.12)
	MedalCount:setLetterSpacing(4)
	MedalCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MedalCount:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	MedalCount:linkToElementModel(self, "timesEarned", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MedalCount:setText(GetAARMedalHitCount(f3_local0))
		end
	end)
	self:addElement(MedalCount)
	self.MedalCount = MedalCount
	local MedalName = LUI.UIText.new(0, 0, 14, 534, 0, 0, 477, 522)
	MedalName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MedalName:setTTF("ttmussels_regular")
	MedalName:setLetterSpacing(4)
	MedalName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MedalName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	MedalName:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MedalName:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(MedalName)
	self.MedalName = MedalName
	local MedalDescription = LUI.UIText.new(0, 0, 52.5, 499.5, 0, 0, 522, 547)
	MedalDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MedalDescription:setTTF("ttmussels_regular")
	MedalDescription:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	MedalDescription:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	MedalDescription:linkToElementModel(self, "description", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MedalDescription:setText(Engine[0xF9F1239CFD921FE](f5_local0))
		end
	end)
	self:addElement(MedalDescription)
	self.MedalDescription = MedalDescription
	local DotPip = LUI.UIImage.new(0, 0, 548, 552, 0, 0, 712, 716)
	DotPip:setAlpha(0.5)
	DotPip:setImage(RegisterImage(0x3854665C02218EF))
	DotPip:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPip)
	self.DotPip = DotPip
	local DotPip2 = LUI.UIImage.new(0, 0, -2, 2, 0, 0, 712, 716)
	DotPip2:setAlpha(0.5)
	DotPip2:setImage(RegisterImage(0x3854665C02218EF))
	DotPip2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPip2)
	self.DotPip2 = DotPip2
	local DotPip4 = LUI.UIImage.new(0, 0, 548, 552, 0, 0, -2, 2)
	DotPip4:setAlpha(0.5)
	DotPip4:setImage(RegisterImage(0x3854665C02218EF))
	DotPip4:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPip4)
	self.DotPip4 = DotPip4
	local DotPip3 = LUI.UIImage.new(0, 0, -2, 2, 0, 0, -2, 2)
	DotPip3:setAlpha(0.5)
	DotPip3:setImage(RegisterImage(0x3854665C02218EF))
	DotPip3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPip3)
	self.DotPip3 = DotPip3
	local RightArrow = CoD.TabletConnectionArrow.new(f1_arg0, f1_arg1, 0, 0, -6, 59, 0, 0, 214, 245)
	RightArrow:setAlpha(0.3)
	RightArrow:setZRot(180)
	RightArrow:setScale(0.6, 0.6)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	local RightArrow2 = CoD.TabletConnectionArrow.new(f1_arg0, f1_arg1, 0, 0, 491, 556, 0, 0, 214, 245)
	RightArrow2:setAlpha(0.3)
	RightArrow2:setScale(0.6, 0.6)
	self:addElement(RightArrow2)
	self.RightArrow2 = RightArrow2
	local FETitleNumBrdr00 = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 0, 15, 534, 0, 0, 472.5, 601.5)
	FETitleNumBrdr00:setAlpha(0.2)
	self:addElement(FETitleNumBrdr00)
	self.FETitleNumBrdr00 = FETitleNumBrdr00
	local Image = LUI.UIImage.new(0, 0, 0, 550, 0, 0, 0, 9)
	Image:setAlpha(0.02)
	self:addElement(Image)
	self.Image = Image
	local MedalXpWidget = CoD.MedalXpWidget.new(f1_arg0, f1_arg1, 0, 0, 17.5, 417.5, 0, 0, 629.5, 698.5)
	MedalXpWidget:linkToElementModel(self, "xpValue", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MedalXpWidget.XpValue:setText(CoD.BaseUtility.AlreadyLocalized(f6_local0))
		end
	end)
	self:addElement(MedalXpWidget)
	self.MedalXpWidget = MedalXpWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MedalPreviewWidget.__onClose = function(f7_arg0)
	f7_arg0.MedalImage:close()
	f7_arg0.MedalCount:close()
	f7_arg0.MedalName:close()
	f7_arg0.MedalDescription:close()
	f7_arg0.RightArrow:close()
	f7_arg0.RightArrow2:close()
	f7_arg0.FETitleNumBrdr00:close()
	f7_arg0.MedalXpWidget:close()
end
