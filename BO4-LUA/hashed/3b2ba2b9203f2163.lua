require("x64:bc87ac3fc76bb82")
require("x64:f791681246fe2b6")
require("x64:19c1945d2e472b0")
require("x64:246178cf189051b")
CoD.ContractSupplyChainDetails_InfoPanel = InheritFrom(LUI.UIElement)
CoD.ContractSupplyChainDetails_InfoPanel.__defaultWidth = 558
CoD.ContractSupplyChainDetails_InfoPanel.__defaultHeight = 246
CoD.ContractSupplyChainDetails_InfoPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractSupplyChainDetails_InfoPanel)
	self.id = "ContractSupplyChainDetails_InfoPanel"
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
	local Desc = LUI.UIText.new(0, 0, 27, 527, 0, 0, 90, 108)
	Desc:setTTF("dinnext_regular")
	Desc:setLetterSpacing(1)
	Desc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Desc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Desc:linkToElementModel(self, "contentsDesc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Desc:setText(f2_local0)
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	local SubExtraText = LUI.UIText.new(0, 0, 27, 527, 0, 0, 198.5, 216.5)
	SubExtraText:setTTF("dinnext_regular")
	SubExtraText:setLetterSpacing(1)
	SubExtraText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SubExtraText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SubExtraText:linkToElementModel(self, "subExtraText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SubExtraText:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(SubExtraText)
	self.SubExtraText = SubExtraText
	local MainExtraText = LUI.UIText.new(0, 0, 27, 527, 0, 0, 170.5, 190.5)
	MainExtraText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MainExtraText:setTTF("ttmussels_regular")
	MainExtraText:setLetterSpacing(2)
	MainExtraText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MainExtraText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MainExtraText:linkToElementModel(self, "mainExtraText", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MainExtraText:setText(ToUpper(f4_local0))
		end
	end)
	self:addElement(MainExtraText)
	self.MainExtraText = MainExtraText
	local Name = LUI.UIText.new(0, 0, 27, 527, 0, 0, 53, 83)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(4)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Name:linkToElementModel(self, "name", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 0, 0, 558, 0, 0, 0, 20)
	ButtonTopLine9Slice:setAlpha(0.25)
	ButtonTopLine9Slice:setImage(RegisterImage(0xC752149A1FA1AAE))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	local ButtonBottomLine9Slice = LUI.UIImage.new(0, 0, 0, 558, 0, 0, 223, 243)
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
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HeaderGlow:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f6_local0))
		end
	end)
	self:addElement(HeaderGlow)
	self.HeaderGlow = HeaderGlow
	local ContractRarityHeaderBackground = LUI.UIImage.new(0.13, 0.13, -68.5, 477.5, 0, 0, 16, 40)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f7_local0))
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
	local KeyPrompt = nil
	KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 2.5, 38.5, 0, 0, -38, -2)
	KeyPrompt:setAlpha(0)
	KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_1}]"))
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	local f1_local15 = nil
	self.togglePreviewButton = LUI.UIElement.createFake()
	local togglePreviewLabel = LUI.UIText.new(0, 0, 69, 117, 0.5, 0.5, -149.5, -131.5)
	togglePreviewLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	togglePreviewLabel:setAlpha(0)
	togglePreviewLabel:setText(Engine[0xF9F1239CFD921FE](0x32E3CA70AD7D0D0))
	togglePreviewLabel:setTTF("dinnext_regular")
	togglePreviewLabel:setLetterSpacing(2)
	togglePreviewLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(togglePreviewLabel)
	self.togglePreviewLabel = togglePreviewLabel
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
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Weapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xCC13B0F8EEFF726) and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "WeaponKBM",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xCC13B0F8EEFF726) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "itemCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f16_arg1)
	end)
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local19(f1_local18, f1_local20.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractSupplyChainDetails_InfoPanel.__resetProperties = function(f18_arg0)
	f18_arg0.togglePreviewLabel:completeAnimation()
	f18_arg0.togglePreviewButton:completeAnimation()
	f18_arg0.Seasonal:completeAnimation()
	f18_arg0.ContractRarityHeader:completeAnimation()
	f18_arg0.PixelGridTiledBacking:completeAnimation()
	f18_arg0.ContractRarityHeaderBackground:completeAnimation()
	f18_arg0.HeaderGlow:completeAnimation()
	f18_arg0.ButtonBottomLine9Slice:completeAnimation()
	f18_arg0.ButtonTopLine9Slice:completeAnimation()
	f18_arg0.Name:completeAnimation()
	f18_arg0.MainExtraText:completeAnimation()
	f18_arg0.SubExtraText:completeAnimation()
	f18_arg0.Desc:completeAnimation()
	f18_arg0.DotTiledBacking:completeAnimation()
	f18_arg0.Box:completeAnimation()
	f18_arg0.SceneBlur:completeAnimation()
	f18_arg0.KeyPrompt:completeAnimation()
	f18_arg0.togglePreviewLabel:setAlpha(0)
	f18_arg0.togglePreviewButton:setAlpha(0)
	f18_arg0.Seasonal:setAlpha(1)
	f18_arg0.ContractRarityHeader:setAlpha(1)
	f18_arg0.PixelGridTiledBacking:setAlpha(0.05)
	f18_arg0.ContractRarityHeaderBackground:setAlpha(1)
	f18_arg0.HeaderGlow:setAlpha(0.1)
	f18_arg0.ButtonBottomLine9Slice:setAlpha(0.25)
	f18_arg0.ButtonTopLine9Slice:setAlpha(0.25)
	f18_arg0.Name:setAlpha(1)
	f18_arg0.MainExtraText:setAlpha(1)
	f18_arg0.SubExtraText:setAlpha(1)
	f18_arg0.Desc:setAlpha(1)
	f18_arg0.DotTiledBacking:setAlpha(0.15)
	f18_arg0.Box:setAlpha(0.01)
	f18_arg0.SceneBlur:setAlpha(1)
	f18_arg0.KeyPrompt:setAlpha(0)
end
CoD.ContractSupplyChainDetails_InfoPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.togglePreviewButton:completeAnimation()
			f19_arg0.togglePreviewButton:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.togglePreviewButton)
			f19_arg0.togglePreviewLabel:completeAnimation()
			f19_arg0.togglePreviewLabel:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.togglePreviewLabel)
			f19_arg0.Seasonal:completeAnimation()
			f19_arg0.Seasonal:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Seasonal)
		end,
	},
	Hidden = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(15)
			f20_arg0.SceneBlur:completeAnimation()
			f20_arg0.SceneBlur:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SceneBlur)
			f20_arg0.Box:completeAnimation()
			f20_arg0.Box:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Box)
			f20_arg0.DotTiledBacking:completeAnimation()
			f20_arg0.DotTiledBacking:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DotTiledBacking)
			f20_arg0.Desc:completeAnimation()
			f20_arg0.Desc:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Desc)
			f20_arg0.SubExtraText:completeAnimation()
			f20_arg0.SubExtraText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SubExtraText)
			f20_arg0.MainExtraText:completeAnimation()
			f20_arg0.MainExtraText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.MainExtraText)
			f20_arg0.Name:completeAnimation()
			f20_arg0.Name:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Name)
			f20_arg0.ButtonTopLine9Slice:completeAnimation()
			f20_arg0.ButtonTopLine9Slice:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ButtonTopLine9Slice)
			f20_arg0.ButtonBottomLine9Slice:completeAnimation()
			f20_arg0.ButtonBottomLine9Slice:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ButtonBottomLine9Slice)
			f20_arg0.HeaderGlow:completeAnimation()
			f20_arg0.HeaderGlow:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.HeaderGlow)
			f20_arg0.ContractRarityHeaderBackground:completeAnimation()
			f20_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ContractRarityHeaderBackground)
			f20_arg0.PixelGridTiledBacking:completeAnimation()
			f20_arg0.PixelGridTiledBacking:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PixelGridTiledBacking)
			f20_arg0.ContractRarityHeader:completeAnimation()
			f20_arg0.ContractRarityHeader:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ContractRarityHeader)
			f20_arg0.togglePreviewButton:completeAnimation()
			f20_arg0.togglePreviewButton:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.togglePreviewButton)
			f20_arg0.togglePreviewLabel:completeAnimation()
			f20_arg0.togglePreviewLabel:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.togglePreviewLabel)
			f20_arg0.Seasonal:completeAnimation()
			f20_arg0.Seasonal:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Seasonal)
		end,
	},
	Weapon = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.togglePreviewButton:completeAnimation()
			f21_arg0.togglePreviewButton:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.togglePreviewButton)
			f21_arg0.togglePreviewLabel:completeAnimation()
			f21_arg0.togglePreviewLabel:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.togglePreviewLabel)
			f21_arg0.Seasonal:completeAnimation()
			f21_arg0.Seasonal:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Seasonal)
		end,
	},
	WeaponKBM = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.KeyPrompt:completeAnimation()
			f22_arg0.KeyPrompt:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.KeyPrompt)
			f22_arg0.togglePreviewLabel:completeAnimation()
			f22_arg0.togglePreviewLabel:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.togglePreviewLabel)
		end,
	},
}
CoD.ContractSupplyChainDetails_InfoPanel.__onClose = function(f23_arg0)
	f23_arg0.DotTiledBacking:close()
	f23_arg0.Desc:close()
	f23_arg0.SubExtraText:close()
	f23_arg0.MainExtraText:close()
	f23_arg0.Name:close()
	f23_arg0.HeaderGlow:close()
	f23_arg0.ContractRarityHeaderBackground:close()
	f23_arg0.ContractRarityHeader:close()
	f23_arg0.KeyPrompt:close()
	f23_arg0.togglePreviewButton:close()
	f23_arg0.Seasonal:close()
end
