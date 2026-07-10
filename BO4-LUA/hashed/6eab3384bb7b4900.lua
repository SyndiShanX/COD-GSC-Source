require("x64:bc87ac3fc76bb82")
require("x64:f791681246fe2b6")
require("x64:ac8a32561bb24f9")
require("x64:a390335687d572b")
require("x64:6225e991e55c7d6")
require("x64:19c1945d2e472b0")
CoD.SupplyChainDetails_InfoPanel = InheritFrom(LUI.UIElement)
CoD.SupplyChainDetails_InfoPanel.__defaultWidth = 558
CoD.SupplyChainDetails_InfoPanel.__defaultHeight = 246
CoD.SupplyChainDetails_InfoPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainDetails_InfoPanel)
	self.id = "SupplyChainDetails_InfoPanel"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 0, 6, 552, 0, 0, 6.5, 231.5)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Box = LUI.UIImage.new(0, 0, 6, 552, 0, 0, 6.5, 231.5)
	Box:setAlpha(0.01)
	self:addElement(Box)
	self.Box = Box
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 6, 552, 0, 0, 7, 232)
	DotTiledBacking:setAlpha(0.15)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local TitleAndDesc = CoD.SupplyChainDetails_InfoPanelTitleAndDesc.new(f1_arg0, f1_arg1, 0, 0, 27, 547, 0, 0, 15.5, 231.5)
	TitleAndDesc:linkToElementModel(self, nil, false, function(model)
		TitleAndDesc:setModel(model, f1_arg1)
	end)
	self:addElement(TitleAndDesc)
	self.TitleAndDesc = TitleAndDesc
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 0, 0, 558, 0, 0, 0, 20)
	ButtonTopLine9Slice:setAlpha(0.25)
	ButtonTopLine9Slice:setImage(RegisterImage(0xC752149A1FA1AAE))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	local ButtonBottomLine9Slice = LUI.UIImage.new(0, 0, 0, 558, 0, 0, 224, 244)
	ButtonBottomLine9Slice:setAlpha(0.25)
	ButtonBottomLine9Slice:setImage(RegisterImage(0xC752149A1FA1AAE))
	ButtonBottomLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ButtonBottomLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonBottomLine9Slice)
	self.ButtonBottomLine9Slice = ButtonBottomLine9Slice
	local HeaderGlow = LUI.UIImage.new(0, 0, 2, 556, 0, 0, 12, 44)
	HeaderGlow:setAlpha(0.1)
	HeaderGlow:setImage(RegisterImage(0xFAA6C81834660D3))
	HeaderGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	HeaderGlow:setShaderVector(0, 0, 0, 0, 0)
	HeaderGlow:setupNineSliceShader(12, 12)
	HeaderGlow:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HeaderGlow:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f3_local0))
		end
	end)
	self:addElement(HeaderGlow)
	self.HeaderGlow = HeaderGlow
	local ContractRarityHeaderBackground = LUI.UIImage.new(0.13, 0.13, -68.5, 477.5, 0, 0, 16, 40)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f4_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 5.5, 551.5, 0, 0, 16, 40)
	PixelGridTiledBacking:setAlpha(0.05)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local ContractRarityHeader = CoD.ContractRarityHeader.new(f1_arg0, f1_arg1, 0, 0, 28, 228, 0, 0, 17, 43)
	ContractRarityHeader:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeader:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeader)
	self.ContractRarityHeader = ContractRarityHeader
	local DupeStatus = CoD.DupeMarker.new(f1_arg0, f1_arg1, 0, 0, 4, 368, 0, 0, -25, -5)
	DupeStatus:linkToElementModel(self, nil, false, function(model)
		DupeStatus:setModel(model, f1_arg1)
	end)
	self:addElement(DupeStatus)
	self.DupeStatus = DupeStatus
	local ButtonPromptContainer = CoD.SupplyChainDetails_ButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1, 301, 0, 0, -39, 0)
	ButtonPromptContainer:setAlpha(0)
	ButtonPromptContainer:linkToElementModel(self, nil, false, function(model)
		ButtonPromptContainer:setModel(model, f1_arg1)
	end)
	self:addElement(ButtonPromptContainer)
	self.ButtonPromptContainer = ButtonPromptContainer
	local Seasonal = CoD.ContractSeasonalOverlay_MetadataPanel.new(f1_arg0, f1_arg1, 0, 0, 6, 552, 0, 0, 16, 41)
	Seasonal:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "seasonal")
			end,
		},
	})
	Seasonal:linkToElementModel(Seasonal, "seasonal", true, function(model)
		f1_arg0:updateElementState(Seasonal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "seasonal",
		})
	end)
	Seasonal:linkToElementModel(self, nil, false, function(model)
		Seasonal:setModel(model, f1_arg1)
	end)
	self:addElement(Seasonal)
	self.Seasonal = Seasonal
	self:mergeStateConditions({
		{
			stateName = "NoRarityWithButtons",
			condition = function(menu, element, event)
				local f11_local0
				if not MenuPropertyIsTrue(menu, "__hideSupplyChainDetailsButtons") then
					f11_local0 = CoD.BlackMarketUtility.ShowSupplyChainDetailsButtonPrompts(element, f1_arg1)
					if f11_local0 then
						f11_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180])
						if f11_local0 then
							f11_local0 = not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0x4F35AE761BD424)
						end
					end
				else
					f11_local0 = false
				end
				return f11_local0
			end,
		},
		{
			stateName = "ButtonPrompts",
			condition = function(menu, element, event)
				local f12_local0
				if not MenuPropertyIsTrue(menu, "__hideSupplyChainDetailsButtons") then
					f12_local0 = CoD.BlackMarketUtility.ShowSupplyChainDetailsButtonPrompts(element, f1_arg1)
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
		{
			stateName = "NoRarity",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0x4F35AE761BD424)
			end,
		},
	})
	self:linkToElementModel(self, "allowTogglePreview", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allowTogglePreview",
		})
	end)
	self:linkToElementModel(self, "gesture_index", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gesture_index",
		})
	end)
	self:linkToElementModel(self, "movieName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "movieName",
		})
	end)
	self:linkToElementModel(self, "allowFrozenMoment", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allowFrozenMoment",
		})
	end)
	self:linkToElementModel(self, "rarity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
		})
	end)
	self:linkToElementModel(self, "itemCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainDetails_InfoPanel.__resetProperties = function(f20_arg0)
	f20_arg0.DupeStatus:completeAnimation()
	f20_arg0.ButtonPromptContainer:completeAnimation()
	f20_arg0.ContractRarityHeaderBackground:completeAnimation()
	f20_arg0.PixelGridTiledBacking:completeAnimation()
	f20_arg0.ContractRarityHeader:completeAnimation()
	f20_arg0.HeaderGlow:completeAnimation()
	f20_arg0.DupeStatus:setTopBottom(0, 0, -25, -5)
	f20_arg0.ButtonPromptContainer:setAlpha(0)
	f20_arg0.ContractRarityHeaderBackground:setAlpha(1)
	f20_arg0.PixelGridTiledBacking:setAlpha(0.05)
	f20_arg0.ContractRarityHeader:setAlpha(1)
	f20_arg0.HeaderGlow:setAlpha(0.1)
end
CoD.SupplyChainDetails_InfoPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	NoRarityWithButtons = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(6)
			f22_arg0.HeaderGlow:completeAnimation()
			f22_arg0.HeaderGlow:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.HeaderGlow)
			f22_arg0.ContractRarityHeaderBackground:completeAnimation()
			f22_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ContractRarityHeaderBackground)
			f22_arg0.PixelGridTiledBacking:completeAnimation()
			f22_arg0.PixelGridTiledBacking:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.PixelGridTiledBacking)
			f22_arg0.ContractRarityHeader:completeAnimation()
			f22_arg0.ContractRarityHeader:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ContractRarityHeader)
			f22_arg0.DupeStatus:completeAnimation()
			f22_arg0.DupeStatus:setTopBottom(0, 0, -63, -43)
			f22_arg0.clipFinished(f22_arg0.DupeStatus)
			f22_arg0.ButtonPromptContainer:completeAnimation()
			f22_arg0.ButtonPromptContainer:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.ButtonPromptContainer)
		end,
	},
	ButtonPrompts = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.DupeStatus:completeAnimation()
			f23_arg0.DupeStatus:setTopBottom(0, 0, -63, -43)
			f23_arg0.clipFinished(f23_arg0.DupeStatus)
			f23_arg0.ButtonPromptContainer:completeAnimation()
			f23_arg0.ButtonPromptContainer:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.ButtonPromptContainer)
		end,
	},
	NoRarity = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.HeaderGlow:completeAnimation()
			f24_arg0.HeaderGlow:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.HeaderGlow)
			f24_arg0.ContractRarityHeaderBackground:completeAnimation()
			f24_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ContractRarityHeaderBackground)
			f24_arg0.PixelGridTiledBacking:completeAnimation()
			f24_arg0.PixelGridTiledBacking:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PixelGridTiledBacking)
			f24_arg0.ContractRarityHeader:completeAnimation()
			f24_arg0.ContractRarityHeader:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ContractRarityHeader)
		end,
	},
}
CoD.SupplyChainDetails_InfoPanel.__onClose = function(f25_arg0)
	f25_arg0.DotTiledBacking:close()
	f25_arg0.TitleAndDesc:close()
	f25_arg0.HeaderGlow:close()
	f25_arg0.ContractRarityHeaderBackground:close()
	f25_arg0.ContractRarityHeader:close()
	f25_arg0.DupeStatus:close()
	f25_arg0.ButtonPromptContainer:close()
	f25_arg0.Seasonal:close()
end
