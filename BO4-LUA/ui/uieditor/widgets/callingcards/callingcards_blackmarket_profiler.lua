require("x64:fa3f15fd69b38b3")
require("x64:726ee02b8bfc586")
require("x64:228a7baa572b047")
require("x64:bc87ac3fc76bb82")
CoD.CallingCards_BlackMarket_Profiler = InheritFrom(LUI.UIElement)
CoD.CallingCards_BlackMarket_Profiler.__defaultWidth = 525
CoD.CallingCards_BlackMarket_Profiler.__defaultHeight = 732
CoD.CallingCards_BlackMarket_Profiler.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_BlackMarket_Profiler)
	self.id = "CallingCards_BlackMarket_Profiler"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 131)
	CardIcon:linkToElementModel(self, nil, false, function(model)
		CardIcon:setModel(model, f1_arg1)
	end)
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local ChallengeName = LUI.UIText.new(0, 0, 15, 510, 0, 0, 148.5, 181.5)
	ChallengeName:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ChallengeName:setTTF("ttmussels_regular")
	ChallengeName:setLetterSpacing(2)
	ChallengeName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ChallengeName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ChallengeName:linkToElementModel(self, "displayName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ChallengeName:setText(ToUpper(f3_local0))
		end
	end)
	self:addElement(ChallengeName)
	self.ChallengeName = ChallengeName
	local SetInfo = LUI.UIText.new(0, 1, 18, -18, 0, 0, 195, 213)
	SetInfo:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SetInfo:setTTF("dinnext_regular")
	SetInfo:setLetterSpacing(0.5)
	SetInfo:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SetInfo:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SetInfo:linkToElementModel(self, "setInfo", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SetInfo:setText(f4_local0)
		end
	end)
	self:addElement(SetInfo)
	self.SetInfo = SetInfo
	local UnlockInfo = LUI.UIText.new(0, 1, 18, -18, 0, 0, 220, 238)
	UnlockInfo:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	UnlockInfo:setTTF("dinnext_regular")
	UnlockInfo:setLetterSpacing(0.5)
	UnlockInfo:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	UnlockInfo:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	UnlockInfo:linkToElementModel(self, "unlockInfo", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			UnlockInfo:setText(f5_local0)
		end
	end)
	self:addElement(UnlockInfo)
	self.UnlockInfo = UnlockInfo
	local LockedIcon = CoD.BM_ProfilerLock.new(f1_arg0, f1_arg1, 0.5, 0.5, -26, 26, 0, 0, 42, 87)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local HeaderGlow = LUI.UIImage.new(0.01, 1.01, -10, 0, 1, 1, -89, -55)
	HeaderGlow:setAlpha(0.1)
	HeaderGlow:setImage(RegisterImage(@"uie_ui_menu_common_box_glow"))
	HeaderGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
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
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -84, -60)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(ColorMultiply(0.5, CoD.BlackMarketUtility.LootRarityToColor(f7_local0)))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local PixelGridTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -84, -60)
	PixelGridTiledBacking:setAlpha(0.3)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local ContractRarityHeader = CoD.ContractRarityHeader.new(f1_arg0, f1_arg1, 0, 0, 21, 221, 1, 1, -83, -57)
	ContractRarityHeader:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ContractRarityHeader:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeader:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeader)
	self.ContractRarityHeader = ContractRarityHeader
	local BMGoldBar = CoD.BM_GoldBarMed.new(f1_arg0, f1_arg1, 0, 1, 1, -1, 0, 0, 60, 90)
	BMGoldBar:setAlpha(0)
	self:addElement(BMGoldBar)
	self.BMGoldBar = BMGoldBar
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "owned")
			end,
		},
	})
	self:linkToElementModel(self, "available", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	self:linkToElementModel(self, "owned", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	CardIcon.id = "CardIcon"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_BlackMarket_Profiler.__resetProperties = function(f13_arg0)
	f13_arg0.LockedIcon:completeAnimation()
	f13_arg0.CardIcon:completeAnimation()
	f13_arg0.HeaderGlow:completeAnimation()
	f13_arg0.ContractRarityHeaderBackground:completeAnimation()
	f13_arg0.PixelGridTiledBacking:completeAnimation()
	f13_arg0.ContractRarityHeader:completeAnimation()
	f13_arg0.BMGoldBar:completeAnimation()
	f13_arg0.LockedIcon:setAlpha(1)
	f13_arg0.CardIcon:setAlpha(1)
	f13_arg0.HeaderGlow:setAlpha(0.1)
	f13_arg0.ContractRarityHeaderBackground:setAlpha(1)
	f13_arg0.PixelGridTiledBacking:setAlpha(0.3)
	f13_arg0.ContractRarityHeader:setAlpha(1)
	f13_arg0.BMGoldBar:setAlpha(0)
end
CoD.CallingCards_BlackMarket_Profiler.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.LockedIcon:completeAnimation()
			f14_arg0.LockedIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.LockedIcon)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			f15_arg0.CardIcon:completeAnimation()
			f15_arg0.CardIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CardIcon)
			f15_arg0.LockedIcon:completeAnimation()
			f15_arg0.LockedIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.LockedIcon)
			f15_arg0.HeaderGlow:completeAnimation()
			f15_arg0.HeaderGlow:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.HeaderGlow)
			f15_arg0.ContractRarityHeaderBackground:completeAnimation()
			f15_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ContractRarityHeaderBackground)
			f15_arg0.PixelGridTiledBacking:completeAnimation()
			f15_arg0.PixelGridTiledBacking:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PixelGridTiledBacking)
			f15_arg0.ContractRarityHeader:completeAnimation()
			f15_arg0.ContractRarityHeader:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ContractRarityHeader)
			f15_arg0.BMGoldBar:completeAnimation()
			f15_arg0.BMGoldBar:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.BMGoldBar)
		end,
	},
	Locked = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CallingCards_BlackMarket_Profiler.__onClose = function(f17_arg0)
	f17_arg0.CardIcon:close()
	f17_arg0.ChallengeName:close()
	f17_arg0.SetInfo:close()
	f17_arg0.UnlockInfo:close()
	f17_arg0.LockedIcon:close()
	f17_arg0.HeaderGlow:close()
	f17_arg0.ContractRarityHeaderBackground:close()
	f17_arg0.ContractRarityHeader:close()
	f17_arg0.BMGoldBar:close()
end
