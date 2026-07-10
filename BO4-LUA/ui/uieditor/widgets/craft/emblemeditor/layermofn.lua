require("x64:19c1945d2e472b0")
CoD.layermofn = InheritFrom(LUI.UIElement)
CoD.layermofn.__defaultWidth = 240
CoD.layermofn.__defaultHeight = 45
CoD.layermofn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.layermofn)
	self.id = "layermofn"
	self.soundSet = "CustomizationEditor"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local numberbkg = LUI.UIImage.new(0.5, 0.5, -120, 120, 0.5, 0.5, -22.5, 22.5)
	numberbkg:setRGB(0, 0, 0)
	numberbkg:setAlpha(0.5)
	self:addElement(numberbkg)
	self.numberbkg = numberbkg
	local BackingPattern = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 240, 0, 1, 0, 0)
	BackingPattern:setAlpha(0.5)
	self:addElement(BackingPattern)
	self.BackingPattern = BackingPattern
	local TiledBackingAdd = LUI.UIImage.new(0, 0, 0, 240, 0.09, 0.09, -4, 41)
	TiledBackingAdd:setAlpha(0.2)
	TiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingAdd)
	self.TiledBackingAdd = TiledBackingAdd
	local layerMOfN = LUI.UIText.new(0.5, 0.5, -191, 192, 0.5, 0.5, -12, 13)
	layerMOfN:setText(Engine[0xF9F1239CFD921FE](0x2769909B839C4BC))
	layerMOfN:setTTF("ttmussels_regular")
	layerMOfN:setLetterSpacing(2)
	layerMOfN:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	layerMOfN:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(layerMOfN)
	self.layerMOfN = layerMOfN
	local DotPipTR = LUI.UIImage.new(1, 1, -2, 2, 0, 0, -2, 2)
	DotPipTR:setAlpha(0.5)
	DotPipTR:setImage(RegisterImage(0x3854665C02218EF))
	DotPipTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipTR)
	self.DotPipTR = DotPipTR
	local DotPipTL = LUI.UIImage.new(0, 0, -2, 2, 0, 0, -2, 2)
	DotPipTL:setAlpha(0.5)
	DotPipTL:setImage(RegisterImage(0x3854665C02218EF))
	DotPipTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipTL)
	self.DotPipTL = DotPipTL
	local DotPipBL = LUI.UIImage.new(0, 0, -2, 2, 1, 1, -2, 2)
	DotPipBL:setAlpha(0.5)
	DotPipBL:setImage(RegisterImage(0x3854665C02218EF))
	DotPipBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipBL)
	self.DotPipBL = DotPipBL
	local DotPipBR = LUI.UIImage.new(1, 1, -2, 2, 1, 1, -2, 2)
	DotPipBR:setAlpha(0.5)
	DotPipBR:setImage(RegisterImage(0x3854665C02218EF))
	DotPipBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipBR)
	self.DotPipBR = DotPipBR
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.layermofn.__resetProperties = function(f2_arg0)
	f2_arg0.numberbkg:completeAnimation()
	f2_arg0.layerMOfN:completeAnimation()
	f2_arg0.DotPipBR:completeAnimation()
	f2_arg0.DotPipBL:completeAnimation()
	f2_arg0.DotPipTL:completeAnimation()
	f2_arg0.DotPipTR:completeAnimation()
	f2_arg0.BackingPattern:completeAnimation()
	f2_arg0.TiledBackingAdd:completeAnimation()
	f2_arg0.numberbkg:setAlpha(0.5)
	f2_arg0.layerMOfN:setAlpha(1)
	f2_arg0.DotPipBR:setAlpha(0.5)
	f2_arg0.DotPipBL:setAlpha(0.5)
	f2_arg0.DotPipTL:setAlpha(0.5)
	f2_arg0.DotPipTR:setAlpha(0.5)
	f2_arg0.BackingPattern:setAlpha(0.5)
	f2_arg0.TiledBackingAdd:setAlpha(0.2)
end
CoD.layermofn.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	EmptyLayer = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(8)
			f4_arg0.numberbkg:completeAnimation()
			f4_arg0.numberbkg:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.numberbkg)
			f4_arg0.BackingPattern:completeAnimation()
			f4_arg0.BackingPattern:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.BackingPattern)
			f4_arg0.TiledBackingAdd:completeAnimation()
			f4_arg0.TiledBackingAdd:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TiledBackingAdd)
			f4_arg0.layerMOfN:completeAnimation()
			f4_arg0.layerMOfN:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.layerMOfN)
			f4_arg0.DotPipTR:completeAnimation()
			f4_arg0.DotPipTR:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DotPipTR)
			f4_arg0.DotPipTL:completeAnimation()
			f4_arg0.DotPipTL:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DotPipTL)
			f4_arg0.DotPipBL:completeAnimation()
			f4_arg0.DotPipBL:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DotPipBL)
			f4_arg0.DotPipBR:completeAnimation()
			f4_arg0.DotPipBR:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DotPipBR)
		end,
	},
}
CoD.layermofn.__onClose = function(f5_arg0)
	f5_arg0.BackingPattern:close()
end
