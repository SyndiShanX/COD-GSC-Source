CoD.ContractRarityBackground = InheritFrom(LUI.UIElement)
CoD.ContractRarityBackground.__defaultWidth = 32
CoD.ContractRarityBackground.__defaultHeight = 32
CoD.ContractRarityBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractRarityBackground)
	self.id = "ContractRarityBackground"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Background:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f2_local0))
		end
	end)
	self:addElement(Background)
	self.Background = Background
	local UltraBacker = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	UltraBacker:setImage(RegisterImage(0xFADCB0E46A61031))
	UltraBacker:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	UltraBacker:setShaderVector(0, 0, 0, 0, 0)
	UltraBacker:setupNineSliceShader(14, 14)
	self:addElement(UltraBacker)
	self.UltraBacker = UltraBacker
	local PixelGridTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGridTiledBacking:setAlpha(0.3)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local BottomLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -2, 2)
	BottomLine:setAlpha(0.3)
	BottomLine:setImage(RegisterImage(0x5526CF3733E24C4))
	BottomLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BottomLine)
	self.BottomLine = BottomLine
	local TopLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -2, 2)
	TopLine:setAlpha(0.3)
	TopLine:setImage(RegisterImage(0x5526CF3733E24C4))
	TopLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(TopLine)
	self.TopLine = TopLine
	self:mergeStateConditions({
		{
			stateName = "Ultra",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x3006FE890A202D9])
			end,
		},
	})
	self:linkToElementModel(self, "rarity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractRarityBackground.__resetProperties = function(f5_arg0)
	f5_arg0.UltraBacker:completeAnimation()
	f5_arg0.Background:completeAnimation()
	f5_arg0.UltraBacker:setAlpha(1)
	f5_arg0.Background:setAlpha(1)
end
CoD.ContractRarityBackground.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.UltraBacker:completeAnimation()
			f6_arg0.UltraBacker:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.UltraBacker)
		end,
	},
	Ultra = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Background:completeAnimation()
			f7_arg0.Background:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Background)
		end,
	},
}
CoD.ContractRarityBackground.__onClose = function(f8_arg0)
	f8_arg0.Background:close()
end
