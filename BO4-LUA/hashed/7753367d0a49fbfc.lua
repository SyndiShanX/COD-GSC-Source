require("x64:266118fa96f77c8")
require("x64:3c21aa1a96202c9")
require("x64:68036bda8abbe94")
require("x64:7935bd4c2250126")
require("x64:3e58edf544a2163")
CoD.SupplyChainStreamInternal = InheritFrom(LUI.UIElement)
CoD.SupplyChainStreamInternal.__defaultWidth = 349
CoD.SupplyChainStreamInternal.__defaultHeight = 158
CoD.SupplyChainStreamInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainStreamInternal)
	self.id = "SupplyChainStreamInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 1, -1, 0, 1, 1, -1)
	Background:setRGB(0.11, 0.18, 0.24)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	Background:setShaderVector(0, 1, 0, 0, 0)
	Background:setShaderVector(1, 0, 0, 0, 0)
	Background:setShaderVector(2, 1, 0, 0, 0)
	Background:setShaderVector(3, 0, 0, 0, 0)
	Background:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local Gradient = LUI.UIImage.new(0, 0, 1, 348, 0, 0, 1, 72)
	Gradient:setRGB(0.08, 0.21, 0.31)
	Gradient:setAlpha(0.94)
	Gradient:setImage(RegisterImage(0xB646BE73FB8838C))
	Gradient:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Gradient)
	self.Gradient = Gradient
	local NineSliceShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NineSliceShaderImage:setRGB(0.25, 0.36, 0.4)
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xE7BDCB879A5176D))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setShaderVector(1, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(1, 1)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	local TiledShaderImage = LUI.UIImage.new(0, 1, 1, -1, 0, 1, 1.5, -0.5)
	TiledShaderImage:setRGB(0, 0, 0)
	TiledShaderImage:setImage(RegisterImage(0x4B6FFA90272070E))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local GridTiled = LUI.UIImage.new(0.2, 0.2, -67, 280, 0.19, 0.19, 87.5, 127.5)
	GridTiled:setRGB(0.6, 0.89, 1)
	GridTiled:setAlpha(0.06)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xAC3234E1F71D1D6))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(8, 8)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local FocusGlow = LUI.UIImage.new(0, 1, -145, 145, 0.01, 0.99, -46, 46)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(0x8E79E4E42B6714C))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(300, 300)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local StreamImage = LUI.UIImage.new(0, 0, 1, 348, 0, 0, 0, 158)
	StreamImage:linkToElementModel(self, "streamImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StreamImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(StreamImage)
	self.StreamImage = StreamImage
	local EventTimeRemaining = LUI.UIText.new(0, 0, 14, 334, 0, 0, 111, 125)
	EventTimeRemaining:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EventTimeRemaining:setAlpha(0)
	EventTimeRemaining:setTTF("dinnext_regular")
	EventTimeRemaining:setLetterSpacing(1)
	EventTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EventTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	EventTimeRemaining:subscribeToGlobalModel(f1_arg1, "AutoEvents", "loot_event_stream_timer", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EventTimeRemaining:setText(LocalizeIntoStringIfNotEmpty(0xC0CE2452CF87DB1, f3_local0))
		end
	end)
	self:addElement(EventTimeRemaining)
	self.EventTimeRemaining = EventTimeRemaining
	local SeasonTimeRemaining = LUI.UIText.new(0, 0, 14, 343, 0, 0, 134, 148)
	SeasonTimeRemaining:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	SeasonTimeRemaining:setAlpha(0)
	SeasonTimeRemaining:setTTF("dinnext_regular")
	SeasonTimeRemaining:setLetterSpacing(1)
	SeasonTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SeasonTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SeasonTimeRemaining.__String_Reference = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			SeasonTimeRemaining:setText(CoD.BlackMarketUtility.GetSeasonTimerString(f1_arg1, f4_local0))
		end
	end
	SeasonTimeRemaining:subscribeToGlobalModel(f1_arg1, "AutoEvents", "loot_season_stream_timer", SeasonTimeRemaining.__String_Reference)
	SeasonTimeRemaining.__String_Reference_FullPath = function()
		local f5_local0 = DataSources.AutoEvents.getModel(f1_arg1)
		f5_local0 = f5_local0.loot_season_stream_timer
		if f5_local0 then
			SeasonTimeRemaining.__String_Reference(f5_local0)
		end
	end
	self:addElement(SeasonTimeRemaining)
	self.SeasonTimeRemaining = SeasonTimeRemaining
	local ContractTimeRemaining = LUI.UIText.new(0, 0, 14, 334, 0, 0, 134, 148)
	ContractTimeRemaining:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ContractTimeRemaining:setAlpha(0)
	ContractTimeRemaining:setTTF("dinnext_regular")
	ContractTimeRemaining:setLetterSpacing(1)
	ContractTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ContractTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ContractTimeRemaining:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot3_timer", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ContractTimeRemaining:setText(LocalizeIntoStringIfNotEmpty(0x890CD07DDE9B131, f6_local0))
		end
	end)
	self:addElement(ContractTimeRemaining)
	self.ContractTimeRemaining = ContractTimeRemaining
	local NextContractTimeRemaining = LUI.UIText.new(0, 0, 14, 334, 0, 0, 134, 148)
	NextContractTimeRemaining:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	NextContractTimeRemaining:setAlpha(0)
	NextContractTimeRemaining:setTTF("dinnext_regular")
	NextContractTimeRemaining:setLetterSpacing(1)
	NextContractTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	NextContractTimeRemaining:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	NextContractTimeRemaining:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot3_timer", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			NextContractTimeRemaining:setText(LocalizeIntoStringIfNotEmpty(0xAAA70C5480C51D2, f7_local0))
		end
	end)
	self:addElement(NextContractTimeRemaining)
	self.NextContractTimeRemaining = NextContractTimeRemaining
	local Price = LUI.UIText.new(0, 0, 14, 238, 0, 0, 108, 129)
	Price:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	Price:setText(Engine[0xF9F1239CFD921FE](0x93F12745A24670F))
	Price:setTTF("0arame_mono_stencil")
	Price:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Price:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Price)
	self.Price = Price
	local StreamSubtitle = LUI.UIText.new(0, 0, 14, 334, 0, 0, 96, 114)
	StreamSubtitle:setRGB(1, 0.36, 0)
	StreamSubtitle:setTTF("ttmussels_regular")
	StreamSubtitle:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	StreamSubtitle:setShaderVector(0, 1, 0, 0, 0)
	StreamSubtitle:setShaderVector(1, 0, 0, 0, 0)
	StreamSubtitle:setShaderVector(2, 0, 0, 0, 1)
	StreamSubtitle:setLetterSpacing(3)
	StreamSubtitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StreamSubtitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	StreamSubtitle:linkToElementModel(self, "streamSubtitle", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			StreamSubtitle:setText(LocalizeToUpperString(f8_local0))
		end
	end)
	self:addElement(StreamSubtitle)
	self.StreamSubtitle = StreamSubtitle
	local StreamName = LUI.UIText.new(0, 0, 14, 247, 0, 0, 48, 72)
	StreamName:setTTF("ttmussels_demibold")
	StreamName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	StreamName:setShaderVector(0, 1, 0, 0, 0)
	StreamName:setShaderVector(1, 0, 0, 0, 0)
	StreamName:setShaderVector(2, 0, 0, 0, 0.6)
	StreamName:setLetterSpacing(3)
	StreamName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StreamName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	StreamName:linkToElementModel(self, "streamName", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			StreamName:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	self:addElement(StreamName)
	self.StreamName = StreamName
	local ProgressBarBacking = CoD.ContractProgressBar.new(f1_arg0, f1_arg1, 0, 0, 7, 351, 0, 0, 130, 148)
	ProgressBarBacking:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContractComplete")
			end,
		},
	})
	ProgressBarBacking:linkToElementModel(ProgressBarBacking, "isContractComplete", true, function(model)
		f1_arg0:updateElementState(ProgressBarBacking, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isContractComplete",
		})
	end)
	ProgressBarBacking:setScale(0.96, 0.96)
	ProgressBarBacking:linkToElementModel(self, nil, false, function(model)
		ProgressBarBacking:setModel(model, f1_arg1)
	end)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local ActiveBanner = CoD.ContractActiveBanner.new(f1_arg0, f1_arg1, 0, 0, 22, 172, 0, 0, 100, 125)
	ActiveBanner:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContractComplete")
			end,
		},
	})
	ActiveBanner:linkToElementModel(ActiveBanner, "isContractComplete", true, function(model)
		f1_arg0:updateElementState(ActiveBanner, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isContractComplete",
		})
	end)
	ActiveBanner:linkToElementModel(self, nil, false, function(model)
		ActiveBanner:setModel(model, f1_arg1)
	end)
	self:addElement(ActiveBanner)
	self.ActiveBanner = ActiveBanner
	local CompleteBanner = CoD.ContractCompleteBanner.new(f1_arg0, f1_arg1, 0, 0, 22, 172, 0, 0, 128.5, 153.5)
	CompleteBanner:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContractComplete")
			end,
		},
	})
	CompleteBanner:linkToElementModel(CompleteBanner, "isContractComplete", true, function(model)
		f1_arg0:updateElementState(CompleteBanner, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isContractComplete",
		})
	end)
	CompleteBanner:linkToElementModel(self, nil, false, function(model)
		CompleteBanner:setModel(model, f1_arg1)
	end)
	self:addElement(CompleteBanner)
	self.CompleteBanner = CompleteBanner
	local Box = LUI.UIImage.new(0, 0, 1, 348, 0, 0, 7, 28)
	Box:setRGB(0, 0.04, 0.07)
	Box:setAlpha(0.7)
	self:addElement(Box)
	self.Box = Box
	local FeatureTitle = LUI.UIText.new(0, 0, 14, 320, 0, 0, 9, 26)
	FeatureTitle:setRGB(0.76, 0.93, 1)
	FeatureTitle:setTTF("ttmussels_demibold")
	FeatureTitle:setLetterSpacing(4)
	FeatureTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FeatureTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	FeatureTitle:linkToElementModel(self, "featureTitle", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			FeatureTitle:setText(LocalizeToUpperString(f19_local0))
		end
	end)
	self:addElement(FeatureTitle)
	self.FeatureTitle = FeatureTitle
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 0, 1, 348, 0, 0, 6.5, 27.5)
	ContractRarityHeaderBackground:setAlpha(0.94)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f20_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local ContractRarityHeaderTile = CoD.ContractRarityHeaderTile.new(f1_arg0, f1_arg1, 0, 0, 16, 216, 0, 0, 8.5, 34.5)
	ContractRarityHeaderTile.Contract:setText(LocalizeToUpperString(0x0))
	ContractRarityHeaderTile:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeaderTile:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeaderTile)
	self.ContractRarityHeaderTile = ContractRarityHeaderTile
	local RaritySideImage = LUI.UIImage.new(0, 0, 0, 3, 0, 0, 0, 158)
	RaritySideImage:setAlpha(0)
	RaritySideImage:linkToElementModel(self, "rarity", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			RaritySideImage:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f22_local0))
		end
	end)
	self:addElement(RaritySideImage)
	self.RaritySideImage = RaritySideImage
	local FocusBorder = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	FocusBorder:setRGB(0.96, 0.94, 0.78)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local SeasonalOverlay = CoD.ContractSeasonalOverlay_SupplyChain.new(f1_arg0, f1_arg1, 0, 0, 0, 349, 0, 0, 0, 158)
	SeasonalOverlay:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "seasonal")
			end,
		},
	})
	SeasonalOverlay:linkToElementModel(SeasonalOverlay, "seasonal", true, function(model)
		f1_arg0:updateElementState(SeasonalOverlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "seasonal",
		})
	end)
	SeasonalOverlay:linkToElementModel(self, nil, false, function(model)
		SeasonalOverlay:setModel(model, f1_arg1)
	end)
	self:addElement(SeasonalOverlay)
	self.SeasonalOverlay = SeasonalOverlay
	local f1_local25 = SeasonTimeRemaining
	local f1_local26 = SeasonTimeRemaining.subscribeToModel
	local f1_local27 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local26(f1_local25, f1_local27.LootStreamProgress, SeasonTimeRemaining.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "ContractsComplete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isSpecialEvent") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isUpsell")
			end,
		},
		{
			stateName = "Upsell",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isUpsell")
			end,
		},
		{
			stateName = "SpecialEvent",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isSpecialEvent")
			end,
		},
		{
			stateName = "ActiveContract",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContract")
			end,
		},
		{
			stateName = "ContrabandStream",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "unlocked", false)
			end,
		},
	})
	self:linkToElementModel(self, "isSpecialEvent", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isSpecialEvent",
		})
	end)
	self:linkToElementModel(self, "isUpsell", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isUpsell",
		})
	end)
	self:linkToElementModel(self, "isContract", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isContract",
		})
	end)
	self:linkToElementModel(self, "unlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainStreamInternal.__resetProperties = function(f36_arg0)
	f36_arg0.Price:completeAnimation()
	f36_arg0.ActiveBanner:completeAnimation()
	f36_arg0.CompleteBanner:completeAnimation()
	f36_arg0.ProgressBarBacking:completeAnimation()
	f36_arg0.FeatureTitle:completeAnimation()
	f36_arg0.ContractRarityHeaderBackground:completeAnimation()
	f36_arg0.ContractRarityHeaderTile:completeAnimation()
	f36_arg0.Box:completeAnimation()
	f36_arg0.RaritySideImage:completeAnimation()
	f36_arg0.ContractTimeRemaining:completeAnimation()
	f36_arg0.NextContractTimeRemaining:completeAnimation()
	f36_arg0.StreamName:completeAnimation()
	f36_arg0.StreamSubtitle:completeAnimation()
	f36_arg0.FocusGlow:completeAnimation()
	f36_arg0.FocusBorder:completeAnimation()
	f36_arg0.NineSliceShaderImage:completeAnimation()
	f36_arg0.SeasonTimeRemaining:completeAnimation()
	f36_arg0.EventTimeRemaining:completeAnimation()
	f36_arg0.Background:completeAnimation()
	f36_arg0.Gradient:completeAnimation()
	f36_arg0.GridTiled:completeAnimation()
	f36_arg0.Price:setAlpha(1)
	f36_arg0.ActiveBanner:setAlpha(1)
	f36_arg0.CompleteBanner:setLeftRight(0, 0, 22, 172)
	f36_arg0.CompleteBanner:setTopBottom(0, 0, 128.5, 153.5)
	f36_arg0.CompleteBanner:setAlpha(1)
	f36_arg0.ProgressBarBacking:setAlpha(1)
	f36_arg0.FeatureTitle:setAlpha(1)
	f36_arg0.ContractRarityHeaderBackground:setAlpha(0.94)
	f36_arg0.ContractRarityHeaderTile:setAlpha(1)
	f36_arg0.Box:setAlpha(0.7)
	f36_arg0.RaritySideImage:setAlpha(0)
	f36_arg0.ContractTimeRemaining:setAlpha(0)
	f36_arg0.NextContractTimeRemaining:setAlpha(0)
	f36_arg0.StreamName:setAlpha(1)
	f36_arg0.StreamSubtitle:setAlpha(1)
	f36_arg0.FocusGlow:setAlpha(0)
	f36_arg0.FocusBorder:setAlpha(0)
	f36_arg0.NineSliceShaderImage:setRGB(0.25, 0.36, 0.4)
	f36_arg0.SeasonTimeRemaining:setAlpha(0)
	f36_arg0.EventTimeRemaining:setTopBottom(0, 0, 111, 125)
	f36_arg0.EventTimeRemaining:setAlpha(0)
	f36_arg0.Background:setRGB(0.11, 0.18, 0.24)
	f36_arg0.Gradient:setAlpha(0.94)
	f36_arg0.GridTiled:setAlpha(0.06)
end
CoD.SupplyChainStreamInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			f37_arg0.Price:completeAnimation()
			f37_arg0.Price:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.Price)
			f37_arg0.ActiveBanner:completeAnimation()
			f37_arg0.ActiveBanner:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ActiveBanner)
			f37_arg0.CompleteBanner:completeAnimation()
			f37_arg0.CompleteBanner:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.CompleteBanner)
		end,
	},
	ContractsComplete = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(13)
			f38_arg0.ContractTimeRemaining:completeAnimation()
			f38_arg0.ContractTimeRemaining:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ContractTimeRemaining)
			f38_arg0.NextContractTimeRemaining:completeAnimation()
			f38_arg0.NextContractTimeRemaining:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.NextContractTimeRemaining)
			f38_arg0.Price:completeAnimation()
			f38_arg0.Price:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Price)
			f38_arg0.StreamSubtitle:completeAnimation()
			f38_arg0.StreamSubtitle:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.StreamSubtitle)
			f38_arg0.StreamName:completeAnimation()
			f38_arg0.StreamName:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.StreamName)
			f38_arg0.ProgressBarBacking:completeAnimation()
			f38_arg0.ProgressBarBacking:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ProgressBarBacking)
			f38_arg0.ActiveBanner:completeAnimation()
			f38_arg0.ActiveBanner:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ActiveBanner)
			f38_arg0.CompleteBanner:completeAnimation()
			f38_arg0.CompleteBanner:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.CompleteBanner)
			f38_arg0.Box:completeAnimation()
			f38_arg0.Box:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Box)
			f38_arg0.FeatureTitle:completeAnimation()
			f38_arg0.FeatureTitle:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.FeatureTitle)
			f38_arg0.ContractRarityHeaderBackground:completeAnimation()
			f38_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ContractRarityHeaderBackground)
			f38_arg0.ContractRarityHeaderTile:completeAnimation()
			f38_arg0.ContractRarityHeaderTile:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ContractRarityHeaderTile)
			f38_arg0.RaritySideImage:completeAnimation()
			f38_arg0.RaritySideImage:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.RaritySideImage)
		end,
	},
	Upsell = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(10)
			f39_arg0.ContractTimeRemaining:completeAnimation()
			f39_arg0.ContractTimeRemaining:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ContractTimeRemaining)
			f39_arg0.Price:completeAnimation()
			f39_arg0.Price:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.Price)
			f39_arg0.ProgressBarBacking:completeAnimation()
			f39_arg0.ProgressBarBacking:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ProgressBarBacking)
			f39_arg0.ActiveBanner:completeAnimation()
			f39_arg0.ActiveBanner:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ActiveBanner)
			f39_arg0.CompleteBanner:completeAnimation()
			f39_arg0.CompleteBanner:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.CompleteBanner)
			f39_arg0.Box:completeAnimation()
			f39_arg0.Box:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.Box)
			f39_arg0.FeatureTitle:completeAnimation()
			f39_arg0.FeatureTitle:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.FeatureTitle)
			f39_arg0.ContractRarityHeaderBackground:completeAnimation()
			f39_arg0.ContractRarityHeaderBackground:setAlpha(0.94)
			f39_arg0.clipFinished(f39_arg0.ContractRarityHeaderBackground)
			f39_arg0.ContractRarityHeaderTile:completeAnimation()
			f39_arg0.ContractRarityHeaderTile:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ContractRarityHeaderTile)
			f39_arg0.RaritySideImage:completeAnimation()
			f39_arg0.RaritySideImage:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.RaritySideImage)
		end,
		Focus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(13)
			f40_arg0.NineSliceShaderImage:completeAnimation()
			f40_arg0.NineSliceShaderImage:setRGB(0.2, 0.22, 0.24)
			f40_arg0.clipFinished(f40_arg0.NineSliceShaderImage)
			f40_arg0.FocusGlow:completeAnimation()
			f40_arg0.FocusGlow:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.FocusGlow)
			f40_arg0.ContractTimeRemaining:completeAnimation()
			f40_arg0.ContractTimeRemaining:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.ContractTimeRemaining)
			f40_arg0.Price:completeAnimation()
			f40_arg0.Price:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.Price)
			f40_arg0.ProgressBarBacking:completeAnimation()
			f40_arg0.ProgressBarBacking:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.ProgressBarBacking)
			f40_arg0.ActiveBanner:completeAnimation()
			f40_arg0.ActiveBanner:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.ActiveBanner)
			f40_arg0.CompleteBanner:completeAnimation()
			f40_arg0.CompleteBanner:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.CompleteBanner)
			f40_arg0.Box:completeAnimation()
			f40_arg0.Box:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.Box)
			f40_arg0.FeatureTitle:completeAnimation()
			f40_arg0.FeatureTitle:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.FeatureTitle)
			f40_arg0.ContractRarityHeaderBackground:completeAnimation()
			f40_arg0.ContractRarityHeaderBackground:setAlpha(0.94)
			f40_arg0.clipFinished(f40_arg0.ContractRarityHeaderBackground)
			f40_arg0.ContractRarityHeaderTile:completeAnimation()
			f40_arg0.ContractRarityHeaderTile:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.ContractRarityHeaderTile)
			f40_arg0.RaritySideImage:completeAnimation()
			f40_arg0.RaritySideImage:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.RaritySideImage)
			f40_arg0.FocusBorder:completeAnimation()
			f40_arg0.FocusBorder:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.FocusBorder)
		end,
	},
	SpecialEvent = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(9)
			f41_arg0.EventTimeRemaining:completeAnimation()
			f41_arg0.EventTimeRemaining:setTopBottom(0, 0, 106, 120)
			f41_arg0.EventTimeRemaining:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.EventTimeRemaining)
			f41_arg0.SeasonTimeRemaining:completeAnimation()
			f41_arg0.SeasonTimeRemaining:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.SeasonTimeRemaining)
			f41_arg0.ContractTimeRemaining:completeAnimation()
			f41_arg0.ContractTimeRemaining:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ContractTimeRemaining)
			f41_arg0.Price:completeAnimation()
			f41_arg0.Price:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.Price)
			f41_arg0.ProgressBarBacking:completeAnimation()
			f41_arg0.ProgressBarBacking:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.ProgressBarBacking)
			f41_arg0.ActiveBanner:completeAnimation()
			f41_arg0.ActiveBanner:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ActiveBanner)
			f41_arg0.Box:completeAnimation()
			f41_arg0.Box:setAlpha(0.7)
			f41_arg0.clipFinished(f41_arg0.Box)
			f41_arg0.ContractRarityHeaderBackground:completeAnimation()
			f41_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ContractRarityHeaderBackground)
			f41_arg0.ContractRarityHeaderTile:completeAnimation()
			f41_arg0.ContractRarityHeaderTile:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ContractRarityHeaderTile)
		end,
	},
	ActiveContract = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(8)
			f42_arg0.Price:completeAnimation()
			f42_arg0.Price:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Price)
			f42_arg0.ProgressBarBacking:completeAnimation()
			f42_arg0.ProgressBarBacking:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.ProgressBarBacking)
			f42_arg0.CompleteBanner:completeAnimation()
			f42_arg0.CompleteBanner:setLeftRight(0, 0, 22, 172)
			f42_arg0.CompleteBanner:setTopBottom(0, 0, 128.5, 153.5)
			f42_arg0.clipFinished(f42_arg0.CompleteBanner)
			f42_arg0.Box:completeAnimation()
			f42_arg0.Box:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Box)
			f42_arg0.FeatureTitle:completeAnimation()
			f42_arg0.FeatureTitle:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.FeatureTitle)
			f42_arg0.ContractRarityHeaderBackground:completeAnimation()
			f42_arg0.ContractRarityHeaderBackground:setAlpha(0.94)
			f42_arg0.clipFinished(f42_arg0.ContractRarityHeaderBackground)
			f42_arg0.ContractRarityHeaderTile:completeAnimation()
			f42_arg0.ContractRarityHeaderTile:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.ContractRarityHeaderTile)
			f42_arg0.RaritySideImage:completeAnimation()
			f42_arg0.RaritySideImage:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.RaritySideImage)
		end,
	},
	ContrabandStream = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(8)
			f43_arg0.SeasonTimeRemaining:completeAnimation()
			f43_arg0.SeasonTimeRemaining:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.SeasonTimeRemaining)
			f43_arg0.Price:completeAnimation()
			f43_arg0.Price:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.Price)
			f43_arg0.ProgressBarBacking:completeAnimation()
			f43_arg0.ProgressBarBacking:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ProgressBarBacking)
			f43_arg0.ActiveBanner:completeAnimation()
			f43_arg0.ActiveBanner:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ActiveBanner)
			f43_arg0.CompleteBanner:completeAnimation()
			f43_arg0.CompleteBanner:setTopBottom(0, 0, 100, 125)
			f43_arg0.CompleteBanner:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.CompleteBanner)
			f43_arg0.Box:completeAnimation()
			f43_arg0.Box:setAlpha(0.7)
			f43_arg0.clipFinished(f43_arg0.Box)
			f43_arg0.ContractRarityHeaderBackground:completeAnimation()
			f43_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ContractRarityHeaderBackground)
			f43_arg0.ContractRarityHeaderTile:completeAnimation()
			f43_arg0.ContractRarityHeaderTile:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.ContractRarityHeaderTile)
		end,
	},
	Locked = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(7)
			f44_arg0.Background:completeAnimation()
			f44_arg0.Background:setRGB(0.09, 0.11, 0.15)
			f44_arg0.clipFinished(f44_arg0.Background)
			f44_arg0.Gradient:completeAnimation()
			f44_arg0.Gradient:setAlpha(0.3)
			f44_arg0.clipFinished(f44_arg0.Gradient)
			f44_arg0.NineSliceShaderImage:completeAnimation()
			f44_arg0.NineSliceShaderImage:setRGB(0.2, 0.22, 0.24)
			f44_arg0.clipFinished(f44_arg0.NineSliceShaderImage)
			f44_arg0.GridTiled:completeAnimation()
			f44_arg0.GridTiled:setAlpha(0.03)
			f44_arg0.clipFinished(f44_arg0.GridTiled)
			f44_arg0.Price:completeAnimation()
			f44_arg0.Price:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.Price)
			f44_arg0.ActiveBanner:completeAnimation()
			f44_arg0.ActiveBanner:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.ActiveBanner)
			f44_arg0.CompleteBanner:completeAnimation()
			f44_arg0.CompleteBanner:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.CompleteBanner)
		end,
	},
}
CoD.SupplyChainStreamInternal.__onClose = function(f45_arg0)
	f45_arg0.StreamImage:close()
	f45_arg0.EventTimeRemaining:close()
	f45_arg0.SeasonTimeRemaining:close()
	f45_arg0.ContractTimeRemaining:close()
	f45_arg0.NextContractTimeRemaining:close()
	f45_arg0.StreamSubtitle:close()
	f45_arg0.StreamName:close()
	f45_arg0.ProgressBarBacking:close()
	f45_arg0.ActiveBanner:close()
	f45_arg0.CompleteBanner:close()
	f45_arg0.FeatureTitle:close()
	f45_arg0.ContractRarityHeaderBackground:close()
	f45_arg0.ContractRarityHeaderTile:close()
	f45_arg0.RaritySideImage:close()
	f45_arg0.SeasonalOverlay:close()
end
