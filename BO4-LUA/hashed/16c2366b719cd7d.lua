require("x64:2ddcac99acf8248")
CoD.ContractTallSeasonalOverlay = InheritFrom(LUI.UIElement)
CoD.ContractTallSeasonalOverlay.__defaultWidth = 236
CoD.ContractTallSeasonalOverlay.__defaultHeight = 506
CoD.ContractTallSeasonalOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractTallSeasonalOverlay)
	self.id = "ContractTallSeasonalOverlay"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.67, 0.67, 0.67)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0xE7BDCB879A5176D))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setShaderVector(1, 0, 0, 0, 0)
	Border:setupNineSliceShader(1, 1)
	self:addElement(Border)
	self.Border = Border
	local ContractRarityHeaderBackground2 = LUI.UIImage.new(0, 0, 1, 237, 0, 0, 6.5, 27.5)
	ContractRarityHeaderBackground2:setRGB(0.13, 0.13, 0.13)
	self:addElement(ContractRarityHeaderBackground2)
	self.ContractRarityHeaderBackground2 = ContractRarityHeaderBackground2
	local PixelGridTiledBacking2 = LUI.UIImage.new(0, 0, 1, 237, 0, 0, 8.5, 25.5)
	PixelGridTiledBacking2:setAlpha(0.05)
	PixelGridTiledBacking2:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking2:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking2)
	self.PixelGridTiledBacking2 = PixelGridTiledBacking2
	local Seasonal = LUI.UIText.new(0, 0, 14.5, 250.5, 0, 0, 8.5, 25.5)
	Seasonal:setRGB(1, 0.82, 0)
	Seasonal:setText(LocalizeToUpperString(0x66847BAEBB3A887))
	Seasonal:setTTF("ttmussels_demibold")
	Seasonal:setLetterSpacing(4)
	Seasonal:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Seasonal:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Seasonal:setBackingType(1)
	Seasonal:setBackingWidget(CoD.ContractSeasonalBacker, f1_arg0, f1_arg1)
	Seasonal:setBackingXPadding(17)
	self:addElement(Seasonal)
	self.Seasonal = Seasonal
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractTallSeasonalOverlay.__resetProperties = function(f2_arg0)
	f2_arg0.ContractRarityHeaderBackground2:completeAnimation()
	f2_arg0.PixelGridTiledBacking2:completeAnimation()
	f2_arg0.Border:completeAnimation()
	f2_arg0.Seasonal:completeAnimation()
	f2_arg0.ContractRarityHeaderBackground2:setAlpha(1)
	f2_arg0.PixelGridTiledBacking2:setAlpha(0.05)
	f2_arg0.Border:setAlpha(1)
	f2_arg0.Seasonal:setAlpha(1)
end
CoD.ContractTallSeasonalOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			f3_arg0.Border:completeAnimation()
			f3_arg0.Border:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Border)
			f3_arg0.ContractRarityHeaderBackground2:completeAnimation()
			f3_arg0.ContractRarityHeaderBackground2:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ContractRarityHeaderBackground2)
			f3_arg0.PixelGridTiledBacking2:completeAnimation()
			f3_arg0.PixelGridTiledBacking2:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.PixelGridTiledBacking2)
			f3_arg0.Seasonal:completeAnimation()
			f3_arg0.Seasonal:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Seasonal)
		end,
	},
	Show = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.Border:completeAnimation()
			f4_arg0.Border:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Border)
			f4_arg0.ContractRarityHeaderBackground2:completeAnimation()
			f4_arg0.ContractRarityHeaderBackground2:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.ContractRarityHeaderBackground2)
			f4_arg0.PixelGridTiledBacking2:completeAnimation()
			f4_arg0.PixelGridTiledBacking2:setAlpha(0.05)
			f4_arg0.clipFinished(f4_arg0.PixelGridTiledBacking2)
			f4_arg0.Seasonal:completeAnimation()
			f4_arg0.Seasonal:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Seasonal)
		end,
	},
}
