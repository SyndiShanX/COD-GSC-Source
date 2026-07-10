require("x64:dbb04b55fa27ac6")
require("x64:c4df7352304aecf")
CoD.ContractRarityHeader = InheritFrom(LUI.UIElement)
CoD.ContractRarityHeader.__defaultWidth = 200
CoD.ContractRarityHeader.__defaultHeight = 26
CoD.ContractRarityHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 42, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ContractRarityHeader)
	self.id = "ContractRarityHeader"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RarityLabel = LUI.UIText.new(0, 0, 0, 104, 0, 0, 1, 21)
	RarityLabel:setTTF("ttmussels_demibold")
	RarityLabel:setLetterSpacing(4)
	RarityLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RarityLabel:setBackingType(1)
	RarityLabel:setBackingWidget(CoD.ContractRarityBackground, f1_arg0, f1_arg1)
	RarityLabel:setBackingXPadding(22)
	RarityLabel:setBackingYPadding(2)
	RarityLabel:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RarityLabel:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f2_local0))
		end
	end)
	RarityLabel:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RarityLabel:setText(LocalizeToUpperString(CoD.BlackMarketUtility.LootRarityToString(f3_local0)))
		end
	end)
	RarityLabel:linkToElementModel(self, nil, false, function(model)
		RarityLabel:setBackingModel(model, f1_arg1)
	end)
	self:addElement(RarityLabel)
	self.RarityLabel = RarityLabel
	local Category = LUI.UIText.new(0, 0, 146, 237, 0, 0, 1, 21)
	Category:setAlpha(0.94)
	Category:setTTF("ttmussels_regular")
	Category:setLetterSpacing(4)
	Category:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Category.__String_Reference = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			Category:setText(ToUpper(CoD.BlackMarketUtility.GetLootCategoryString(self:getModel(), f5_local0)))
		end
	end
	Category:linkToElementModel(self, "category", true, Category.__String_Reference)
	Category.__String_Reference_FullPath = function()
		local f6_local0 = self:getModel()
		if f6_local0 then
			f6_local0 = self:getModel()
			f6_local0 = f6_local0.category
		end
		if f6_local0 then
			Category.__String_Reference(f6_local0)
		end
	end
	self:addElement(Category)
	self.Category = Category
	local newIcon = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 0, 0, 279, 297, 0.5, 0.5, -11, 7)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
			end,
		},
	})
	newIcon:linkToElementModel(newIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	newIcon:linkToElementModel(self, "breadcrumb", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			newIcon:setModel(f9_local0, f1_arg1)
		end
	end)
	self:addElement(newIcon)
	self.newIcon = newIcon
	Category:linkToElementModel(self, "rarity", true, Category.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "NoRarity",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[@"lootraritytype"][@"loot_rarity_type_count"])
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
CoD.ContractRarityHeader.__resetProperties = function(f12_arg0)
	f12_arg0.RarityLabel:completeAnimation()
	f12_arg0.RarityLabel:setAlpha(1)
end
CoD.ContractRarityHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	NoRarity = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.RarityLabel:completeAnimation()
			f14_arg0.RarityLabel:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.RarityLabel)
		end,
	},
}
CoD.ContractRarityHeader.__onClose = function(f15_arg0)
	f15_arg0.RarityLabel:close()
	f15_arg0.Category:close()
	f15_arg0.newIcon:close()
end
