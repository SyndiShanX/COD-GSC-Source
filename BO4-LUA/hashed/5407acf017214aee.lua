require("x64:2ddcac99acf8248")
CoD.ContractSeasonalOverlay_MetadataPanel = InheritFrom(LUI.UIElement)
CoD.ContractSeasonalOverlay_MetadataPanel.__defaultWidth = 546
CoD.ContractSeasonalOverlay_MetadataPanel.__defaultHeight = 25
CoD.ContractSeasonalOverlay_MetadataPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractSeasonalOverlay_MetadataPanel)
	self.id = "ContractSeasonalOverlay_MetadataPanel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ContractRarityHeaderBackground2 = LUI.UIImage.new(0, 0, 0, 546, 0, 0, 0, 24)
	ContractRarityHeaderBackground2:setRGB(0.13, 0.13, 0.13)
	self:addElement(ContractRarityHeaderBackground2)
	self.ContractRarityHeaderBackground2 = ContractRarityHeaderBackground2
	local PixelGridTiledBacking2 = LUI.UIImage.new(0, 0, 0, 546, 0, 0, 0.5, 24.5)
	PixelGridTiledBacking2:setAlpha(0.05)
	PixelGridTiledBacking2:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PixelGridTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking2:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking2)
	self.PixelGridTiledBacking2 = PixelGridTiledBacking2
	local Seasonal = LUI.UIText.new(0, 0, 13.5, 384.5, 0, 0, 3.5, 20.5)
	Seasonal:setRGB(1, 0.82, 0)
	Seasonal:setText(LocalizeToUpperString(@"hash_366847BAEBB3A887"))
	Seasonal:setTTF("ttmussels_demibold")
	Seasonal:setLetterSpacing(4)
	Seasonal:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Seasonal:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
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
CoD.ContractSeasonalOverlay_MetadataPanel.__resetProperties = function(f2_arg0)
	f2_arg0.Seasonal:completeAnimation()
	f2_arg0.PixelGridTiledBacking2:completeAnimation()
	f2_arg0.ContractRarityHeaderBackground2:completeAnimation()
	f2_arg0.Seasonal:setAlpha(1)
	f2_arg0.PixelGridTiledBacking2:setAlpha(0.05)
	f2_arg0.ContractRarityHeaderBackground2:setAlpha(1)
end
CoD.ContractSeasonalOverlay_MetadataPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
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
			f4_arg0:setupElementClipCounter(3)
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
