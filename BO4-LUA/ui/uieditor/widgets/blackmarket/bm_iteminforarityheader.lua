require("x64:bc87ac3fc76bb82")
CoD.BM_ItemInfoRarityHeader = InheritFrom(LUI.UIElement)
CoD.BM_ItemInfoRarityHeader.__defaultWidth = 545
CoD.BM_ItemInfoRarityHeader.__defaultHeight = 36
CoD.BM_ItemInfoRarityHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ItemInfoRarityHeader)
	self.id = "BM_ItemInfoRarityHeader"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeaderGlow = LUI.UIImage.new(0, 0, 0, 545, 0, 0, 0, 32)
	HeaderGlow:setAlpha(0.1)
	HeaderGlow:setImage(RegisterImage(0xFAA6C81834660D3))
	HeaderGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	HeaderGlow:setShaderVector(0, 0, 0, 0, 0)
	HeaderGlow:setupNineSliceShader(12, 12)
	HeaderGlow:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HeaderGlow:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f2_local0))
		end
	end)
	self:addElement(HeaderGlow)
	self.HeaderGlow = HeaderGlow
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 0, 5, 545, 0, 0, 4, 28)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f3_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 7, 545, 0, 0, 4, 28)
	PixelGridTiledBacking:setAlpha(0.1)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local ContractRarityHeader = CoD.ContractRarityHeader.new(f1_arg0, f1_arg1, 0, 0, 26, 226, 0, 0, 5, 31)
	ContractRarityHeader:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeader:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeader)
	self.ContractRarityHeader = ContractRarityHeader
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "hideRarity")
			end,
		},
	})
	self:linkToElementModel(self, "hideRarity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hideRarity",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ItemInfoRarityHeader.__resetProperties = function(f7_arg0)
	f7_arg0.ContractRarityHeader:completeAnimation()
	f7_arg0.PixelGridTiledBacking:completeAnimation()
	f7_arg0.HeaderGlow:completeAnimation()
	f7_arg0.ContractRarityHeaderBackground:completeAnimation()
	f7_arg0.ContractRarityHeader:setAlpha(1)
	f7_arg0.PixelGridTiledBacking:setAlpha(0.1)
	f7_arg0.HeaderGlow:setAlpha(0.1)
	f7_arg0.ContractRarityHeaderBackground:setAlpha(1)
end
CoD.BM_ItemInfoRarityHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.HeaderGlow:completeAnimation()
			f8_arg0.HeaderGlow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.HeaderGlow)
			f8_arg0.ContractRarityHeaderBackground:completeAnimation()
			f8_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ContractRarityHeaderBackground)
			f8_arg0.PixelGridTiledBacking:completeAnimation()
			f8_arg0.PixelGridTiledBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PixelGridTiledBacking)
			f8_arg0.ContractRarityHeader:completeAnimation()
			f8_arg0.ContractRarityHeader:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ContractRarityHeader)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.BM_ItemInfoRarityHeader.__onClose = function(f10_arg0)
	f10_arg0.HeaderGlow:close()
	f10_arg0.ContractRarityHeaderBackground:close()
	f10_arg0.ContractRarityHeader:close()
end
