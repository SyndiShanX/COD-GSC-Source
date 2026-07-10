require("x64:86032b1d01da41")
CoD.AARTierRewardColumnHeader = InheritFrom(LUI.UIElement)
CoD.AARTierRewardColumnHeader.__defaultWidth = 105
CoD.AARTierRewardColumnHeader.__defaultHeight = 40
CoD.AARTierRewardColumnHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardColumnHeader)
	self.id = "AARTierRewardColumnHeader"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonOuterGlowThinVert = LUI.UIImage.new(0, 1, -12, 12, 0, 0, -17.5, 10.5)
	CommonOuterGlowThinVert:setRGB(1, 0.33, 0)
	CommonOuterGlowThinVert:setAlpha(0)
	CommonOuterGlowThinVert:setImage(RegisterImage(0x931D6B9AE29B4A2))
	CommonOuterGlowThinVert:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	CommonOuterGlowThinVert:setShaderVector(0, 0, 0, 0, 0)
	CommonOuterGlowThinVert:setShaderVector(1, 1, 0, 0, 0)
	CommonOuterGlowThinVert:setupNineSliceShader(32, 32)
	self:addElement(CommonOuterGlowThinVert)
	self.CommonOuterGlowThinVert = CommonOuterGlowThinVert
	local CommonOuterGlow01 = LUI.UIImage.new(0, 1, -12, 12, 0, 1, -12, 12)
	CommonOuterGlow01:setRGB(1, 0.33, 0)
	CommonOuterGlow01:setAlpha(0)
	CommonOuterGlow01:setImage(RegisterImage(0xAE13B63B2001396))
	CommonOuterGlow01:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	CommonOuterGlow01:setShaderVector(0, 0, 0, 0, 0)
	CommonOuterGlow01:setShaderVector(1, 1, 0, 0, 0)
	CommonOuterGlow01:setupNineSliceShader(32, 32)
	self:addElement(CommonOuterGlow01)
	self.CommonOuterGlow01 = CommonOuterGlow01
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local brighten = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	brighten:setAlpha(0.1)
	self:addElement(brighten)
	self.brighten = brighten
	local CommonFrame01 = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	CommonFrame01:setAlpha(0)
	CommonFrame01:setImage(RegisterImage(0xCA6E5C175806396))
	CommonFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	CommonFrame01:setShaderVector(0, 0, 0, 0, 0)
	CommonFrame01:setupNineSliceShader(8, 8)
	self:addElement(CommonFrame01)
	self.CommonFrame01 = CommonFrame01
	local StripesBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	StripesBG:setRGB(0.11, 0.11, 0.13)
	StripesBG:setAlpha(0)
	self:addElement(StripesBG)
	self.StripesBG = StripesBG
	local StripesBGBtm = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -3, 0)
	StripesBGBtm:setRGB(0.11, 0.11, 0.13)
	StripesBGBtm:setAlpha(0)
	self:addElement(StripesBGBtm)
	self.StripesBGBtm = StripesBGBtm
	local StripesBGTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 3)
	StripesBGTop:setRGB(0.11, 0.11, 0.13)
	StripesBGTop:setAlpha(0)
	self:addElement(StripesBGTop)
	self.StripesBGTop = StripesBGTop
	local StripesBtm = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -3, 0)
	StripesBtm:setAlpha(0)
	StripesBtm:setImage(RegisterImage(0xC7A051F5EFC70E5))
	StripesBtm:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	StripesBtm:setShaderVector(0, 0, 0, 0, 0)
	StripesBtm:setupNineSliceShader(50, 8)
	self:addElement(StripesBtm)
	self.StripesBtm = StripesBtm
	local StripesTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 3)
	StripesTop:setAlpha(0)
	StripesTop:setImage(RegisterImage(0xC7A051F5EFC70E5))
	StripesTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	StripesTop:setShaderVector(0, 0, 0, 0, 0)
	StripesTop:setupNineSliceShader(50, 8)
	self:addElement(StripesTop)
	self.StripesTop = StripesTop
	local Line = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -4, -3)
	Line:setRGB(0.76, 0.93, 1)
	self:addElement(Line)
	self.Line = Line
	local Tier = LUI.UIText.new(0, 1, 3, -3, 0.5, 0.5, -9, 9)
	Tier:setRGB(0.73, 0.74, 0.76)
	Tier:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Tier:setTTF("ttmussels_demibold")
	Tier:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Tier:setShaderVector(0, 1, 0, 0, 0)
	Tier:setShaderVector(1, 0, 0, 0, 0)
	Tier:setShaderVector(2, 1, 0.32, 0, 0)
	Tier:setLetterSpacing(3)
	Tier:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Tier:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Tier)
	self.Tier = Tier
	local HighlightedHeader = CoD.AARTierRewardColumnHeaderHighlighted.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	HighlightedHeader:mergeStateConditions({
		{
			stateName = "Highlighted",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsTierColumnItemHighlighted(self, f1_arg1)
			end,
		},
	})
	local f1_local14 = HighlightedHeader
	local f1_local15 = HighlightedHeader.subscribeToModel
	local f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["AAR.tierReward.highlightedTier"], function(f3_arg0)
		f1_arg0:updateElementState(HighlightedHeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "AAR.tierReward.highlightedTier",
		})
	end, false)
	HighlightedHeader:linkToElementModel(HighlightedHeader, "tier", true, function(model)
		f1_arg0:updateElementState(HighlightedHeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tier",
		})
	end)
	HighlightedHeader:linkToElementModel(self, nil, false, function(model)
		HighlightedHeader:setModel(model, f1_arg1)
	end)
	self:addElement(HighlightedHeader)
	self.HighlightedHeader = HighlightedHeader
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardColumnHeader.__resetProperties = function(f6_arg0)
	f6_arg0.StripesBG:completeAnimation()
	f6_arg0.Line:completeAnimation()
	f6_arg0.StripesBtm:completeAnimation()
	f6_arg0.StripesTop:completeAnimation()
	f6_arg0.Tier:completeAnimation()
	f6_arg0.StripesBGTop:completeAnimation()
	f6_arg0.StripesBGBtm:completeAnimation()
	f6_arg0.StripesBG:setAlpha(0)
	f6_arg0.Line:setAlpha(1)
	f6_arg0.StripesBtm:setAlpha(0)
	f6_arg0.StripesTop:setAlpha(0)
	f6_arg0.Tier:setRGB(0.73, 0.74, 0.76)
	f6_arg0.Tier:setShaderVector(0, 1, 0, 0, 0)
	f6_arg0.Tier:setShaderVector(1, 0, 0, 0, 0)
	f6_arg0.Tier:setShaderVector(2, 1, 0.32, 0, 0)
	f6_arg0.StripesBGTop:setAlpha(0)
	f6_arg0.StripesBGBtm:setAlpha(0)
end
CoD.AARTierRewardColumnHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Locked = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(7)
			f8_arg0.StripesBG:completeAnimation()
			f8_arg0.StripesBG:setAlpha(0.8)
			f8_arg0.clipFinished(f8_arg0.StripesBG)
			f8_arg0.StripesBGBtm:completeAnimation()
			f8_arg0.StripesBGBtm:setAlpha(0.5)
			f8_arg0.clipFinished(f8_arg0.StripesBGBtm)
			f8_arg0.StripesBGTop:completeAnimation()
			f8_arg0.StripesBGTop:setAlpha(0.5)
			f8_arg0.clipFinished(f8_arg0.StripesBGTop)
			f8_arg0.StripesBtm:completeAnimation()
			f8_arg0.StripesBtm:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.StripesBtm)
			f8_arg0.StripesTop:completeAnimation()
			f8_arg0.StripesTop:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.StripesTop)
			f8_arg0.Line:completeAnimation()
			f8_arg0.Line:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Line)
			f8_arg0.Tier:completeAnimation()
			f8_arg0.Tier:setRGB(0.49, 0.49, 0.49)
			f8_arg0.Tier:setShaderVector(0, 1, 0, 0, 0)
			f8_arg0.Tier:setShaderVector(1, 0, 0, 0, 0)
			f8_arg0.Tier:setShaderVector(2, 0, 0, 0, 0)
			f8_arg0.clipFinished(f8_arg0.Tier)
		end,
	},
	Earned = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Line:completeAnimation()
			f9_arg0.Line:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Line)
		end,
	},
}
CoD.AARTierRewardColumnHeader.__onClose = function(f10_arg0)
	f10_arg0.HighlightedHeader:close()
end
