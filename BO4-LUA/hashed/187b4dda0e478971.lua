require("x64:bc87ac3fc76bb82")
CoD.ContractDetailsPanelHeader = InheritFrom(LUI.UIElement)
CoD.ContractDetailsPanelHeader.__defaultWidth = 768
CoD.ContractDetailsPanelHeader.__defaultHeight = 36
CoD.ContractDetailsPanelHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractDetailsPanelHeader)
	self.id = "ContractDetailsPanelHeader"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 0, 5, 764, 0, 0, 4, 28)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f2_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 0, 761, 0, 0, 5, 29)
	PixelGridTiledBacking:setAlpha(0.05)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local ContractRarityHeader = CoD.ContractRarityHeader.new(f1_arg0, f1_arg1, 0, 0, 27, 227, 0, 0, 5, 31)
	ContractRarityHeader:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeader:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeader)
	self.ContractRarityHeader = ContractRarityHeader
	local Linker2 = LUI.UIImage.new(0, 0, 762, 766, 0, 0, 0.5, 34.5)
	Linker2:setAlpha(0.08)
	Linker2:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker2:setShaderVector(0, 0, 0, 0, 0)
	Linker2:setupNineSliceShader(4, 8)
	self:addElement(Linker2)
	self.Linker2 = Linker2
	local HeaderGlow = LUI.UIImage.new(0, 0, 0, 768, 0, 0, 0, 32)
	HeaderGlow:setAlpha(0.1)
	HeaderGlow:setImage(RegisterImage(0xFAA6C81834660D3))
	HeaderGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	HeaderGlow:setShaderVector(0, 0, 0, 0, 0)
	HeaderGlow:setupNineSliceShader(12, 12)
	HeaderGlow:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			HeaderGlow:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f4_local0))
		end
	end)
	self:addElement(HeaderGlow)
	self.HeaderGlow = HeaderGlow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractDetailsPanelHeader.__onClose = function(f5_arg0)
	f5_arg0.ContractRarityHeaderBackground:close()
	f5_arg0.ContractRarityHeader:close()
	f5_arg0.HeaderGlow:close()
end
