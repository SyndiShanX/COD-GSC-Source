require("x64:19c1945d2e472b0")
CoD.DiscountDetailsInfoPanel = InheritFrom(LUI.UIElement)
CoD.DiscountDetailsInfoPanel.__defaultWidth = 558
CoD.DiscountDetailsInfoPanel.__defaultHeight = 246
CoD.DiscountDetailsInfoPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DiscountDetailsInfoPanel)
	self.id = "DiscountDetailsInfoPanel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 0, 6, 552, 0, 0, 6.5, 231.5)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
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
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 0, 0, 558, 0, 0, 0, 20)
	ButtonTopLine9Slice:setAlpha(0.25)
	ButtonTopLine9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	local ButtonBottomLine9Slice = LUI.UIImage.new(0, 0, 0, 558, 0, 0, 224, 244)
	ButtonBottomLine9Slice:setAlpha(0.25)
	ButtonBottomLine9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	ButtonBottomLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonBottomLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonBottomLine9Slice)
	self.ButtonBottomLine9Slice = ButtonBottomLine9Slice
	local SubExtraText = LUI.UIText.new(0, 0, 27, 527, 0, 0, 191, 209)
	SubExtraText:setTTF("dinnext_regular")
	SubExtraText:setLetterSpacing(1)
	SubExtraText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SubExtraText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SubExtraText:linkToElementModel(self, "subExtraText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SubExtraText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(SubExtraText)
	self.SubExtraText = SubExtraText
	local MainExtraText = LUI.UIText.new(0, 0, 27, 527, 0, 0, 165, 185)
	MainExtraText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MainExtraText:setTTF("ttmussels_regular")
	MainExtraText:setLetterSpacing(2)
	MainExtraText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MainExtraText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	MainExtraText:linkToElementModel(self, "mainExtraText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MainExtraText:setText(ToUpper(f3_local0))
		end
	end)
	self:addElement(MainExtraText)
	self.MainExtraText = MainExtraText
	local Desc = LUI.UIText.new(0, 0, 27, 527, 0, 0, 55.5, 73.5)
	Desc:setTTF("dinnext_regular")
	Desc:setLetterSpacing(1)
	Desc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Desc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Desc:linkToElementModel(self, "desc", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Desc:setText(f4_local0)
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	local Name = LUI.UIText.new(0, 0, 27, 527, 0, 0, 19.5, 49.5)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(4)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	self:mergeStateConditions({
		{
			stateName = "ButtonPrompts",
			condition = function(menu, element, event)
				local f6_local0
				if not MenuPropertyIsTrue(menu, "__hideSupplyChainDetailsButtons") then
					f6_local0 = CoD.BlackMarketUtility.ShowSupplyChainDetailsButtonPrompts(element, f1_arg1)
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "NoRarity",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[@"lootraritytype"][@"loot_rarity_type_count"]) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"specialist")
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
CoD.DiscountDetailsInfoPanel.__onClose = function(f14_arg0)
	f14_arg0.DotTiledBacking:close()
	f14_arg0.SubExtraText:close()
	f14_arg0.MainExtraText:close()
	f14_arg0.Desc:close()
	f14_arg0.Name:close()
end
