require("x64:29187ea00d726c3")
CoD.BountyHunterBagMoney = InheritFrom(LUI.UIElement)
CoD.BountyHunterBagMoney.__defaultWidth = 59
CoD.BountyHunterBagMoney.__defaultHeight = 16
CoD.BountyHunterBagMoney.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.BountyHunterBagMoney)
	self.id = "BountyHunterBagMoney"
	self.soundSet = "default"
	local DollarSign = LUI.UIText.new(0, 0, -1, 15, 0, 0, 0, 16)
	DollarSign:setRGB(0.07, 0.09, 0.04)
	DollarSign:setText(CoD.BaseUtility.AlreadyLocalized("$"))
	DollarSign:setTTF("ttmussels_demibold")
	DollarSign:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	DollarSign:setShaderVector(0, 0.68, 0, 0, 0)
	DollarSign:setShaderVector(1, 0, 0, 0, 0)
	DollarSign:setShaderVector(2, 0.07, 0.09, 0.04, 0.4)
	DollarSign:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DollarSign:setBackingType(1)
	DollarSign:setBackingXPadding(4)
	self:addElement(DollarSign)
	self.DollarSign = DollarSign
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 15, 17, 0, 1, 0, 0)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local MoneyValue = LUI.UIText.new(0, 0, 17, 60, 0, 0, 0, 16)
	MoneyValue:setRGB(0.07, 0.09, 0.04)
	MoneyValue:setTTF("ttmussels_demibold")
	MoneyValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	MoneyValue:setShaderVector(0, 0.68, 0, 0, 0)
	MoneyValue:setShaderVector(1, 0, 0, 0, 0)
	MoneyValue:setShaderVector(2, 0.07, 0.09, 0.04, 0.4)
	MoneyValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MoneyValue:setBackingType(1)
	MoneyValue:setBackingXPadding(4)
	MoneyValue:subscribeToGlobalModel(f1_arg1, "HUDItems", "bountyBagMoney", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MoneyValue:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(MoneyValue)
	self.MoneyValue = MoneyValue
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterBagMoney.__onClose = function(f3_arg0)
	f3_arg0.VerticalListSpacer:close()
	f3_arg0.MoneyValue:close()
end
