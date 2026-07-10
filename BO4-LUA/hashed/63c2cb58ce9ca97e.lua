require("x64:c4df7352304aecf")
require("x64:3a8cddff5161637")
CoD.ContractRarityHeaderTile = InheritFrom(LUI.UIElement)
CoD.ContractRarityHeaderTile.__defaultWidth = 200
CoD.ContractRarityHeaderTile.__defaultHeight = 17
CoD.ContractRarityHeaderTile.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 27, true)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ContractRarityHeaderTile)
	self.id = "ContractRarityHeaderTile"
	self.soundSet = "none"
	local Background = CoD.ContractRarityTypeBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 0, 0, 0, 20)
	Background:setAlpha(0)
	Background:linkToElementModel(self, nil, false, function(model)
		Background:setModel(model, f1_arg1)
	end)
	self:addElement(Background)
	self.Background = Background
	local RarityLabel = LUI.UIText.new(0, 0, 0, 104, 0, 0, 0, 17)
	RarityLabel:setTTF("ttmussels_demibold")
	RarityLabel:setLetterSpacing(4)
	RarityLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RarityLabel:setBackingType(1)
	RarityLabel:setBackingWidget(CoD.ContractRarityBackground, f1_arg0, f1_arg1)
	RarityLabel:setBackingXPadding(15)
	RarityLabel:setBackingYPadding(2)
	RarityLabel:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RarityLabel:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f3_local0))
		end
	end)
	RarityLabel:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RarityLabel:setText(LocalizeToUpperString(CoD.BlackMarketUtility.LootRarityToString(f4_local0)))
		end
	end)
	RarityLabel:linkToElementModel(self, nil, false, function(model)
		RarityLabel:setBackingModel(model, f1_arg1)
	end)
	self:addElement(RarityLabel)
	self.RarityLabel = RarityLabel
	local Contract = LUI.UIText.new(0, 0, 133, 224, 0, 0, 0, 17)
	Contract:setAlpha(0.94)
	Contract:setText(LocalizeToUpperString(0x0))
	Contract:setTTF("ttmussels_regular")
	Contract:setLetterSpacing(4)
	Contract:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Contract)
	self.Contract = Contract
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractRarityHeaderTile.__onClose = function(f6_arg0)
	f6_arg0.Background:close()
	f6_arg0.RarityLabel:close()
end
