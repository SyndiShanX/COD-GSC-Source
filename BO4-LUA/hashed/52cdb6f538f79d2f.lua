require("x64:acbf06924421e35")
require("x64:22cf74f6000102a")
require("x64:19c1945d2e472b0")
CoD.Prestige_UnlockTokenIndicatorBar = InheritFrom(LUI.UIElement)
CoD.Prestige_UnlockTokenIndicatorBar.__defaultWidth = 346
CoD.Prestige_UnlockTokenIndicatorBar.__defaultHeight = 57
CoD.Prestige_UnlockTokenIndicatorBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_UnlockTokenIndicatorBar)
	self.id = "Prestige_UnlockTokenIndicatorBar"
	self.soundSet = "none"
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 346, 0.09, 0.09, -5, 52)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BackgroundBlack = LUI.UIImage.new(0, 0, 0, 346, 0, 0, 0, 57)
	BackgroundBlack:setRGB(0, 0, 0)
	BackgroundBlack:setAlpha(0.2)
	BackgroundBlack:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BackgroundBlack)
	self.BackgroundBlack = BackgroundBlack
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking:setAlpha(0.5)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 0, 0, 346, 0.09, 0.09, -5, 52)
	NoiseTiledBackingAdd:setAlpha(0)
	NoiseTiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local CountText = LUI.UIText.new(0, 0, 48, 78, 0, 0, 16, 41)
	CountText:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	CountText:setText(1)
	CountText:setTTF("ttmussels_regular")
	CountText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(CountText)
	self.CountText = CountText
	local MainText = LUI.UIText.new(0, 0, 78, 337, 0, 0, 16, 41)
	MainText:setRGB(0.92, 0.92, 0.92)
	MainText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	MainText:setTTF("ttmussels_regular")
	MainText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MainText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(MainText)
	self.MainText = MainText
	local PrestigeUnlockTokenIndicator = CoD.Prestige_UnlockTokenIndicator.new(f1_arg0, f1_arg1, 0, 0, 11.5, 43.5, 0, 0, 12.5, 44.5)
	self:addElement(PrestigeUnlockTokenIndicator)
	self.PrestigeUnlockTokenIndicator = PrestigeUnlockTokenIndicator
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 0, 346, 0, 0, 0, 57)
	CommonCornerPips:setAlpha(0.2)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_UnlockTokenIndicatorBar.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
	f2_arg0.PrestigeUnlockTokenIndicator:close()
	f2_arg0.CommonCornerPips:close()
end
