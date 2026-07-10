require("x64:29187ea00d726c3")
CoD.BountyHunterBank = InheritFrom(LUI.UIElement)
CoD.BountyHunterBank.__defaultWidth = 277
CoD.BountyHunterBank.__defaultHeight = 33
CoD.BountyHunterBank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.BountyHunterBank)
	self.id = "BountyHunterBank"
	self.soundSet = "default"
	local Bank = LUI.UIText.new(0, 0, -2, 110, 0, 1, 0, 0)
	Bank:setRGB(0.07, 0.09, 0.04)
	Bank:setText(Engine[0xF9F1239CFD921FE](0x37A5FCCE8216B64))
	Bank:setTTF("ttmussels_regular")
	Bank:setLetterSpacing(8)
	Bank:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Bank)
	self.Bank = Bank
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 110, 130, 0, 1, 0, 0)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local DollarSign = LUI.UIText.new(0, 0, 130, 157, 0, 1, 0, 0)
	DollarSign:setRGB(0.76, 0.92, 0.59)
	DollarSign:setText(CoD.BaseUtility.AlreadyLocalized("$"))
	DollarSign:setTTF("ttmussels_regular")
	DollarSign:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DollarSign:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DollarSign)
	self.DollarSign = DollarSign
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 157, 163, 0, 1, 0, 0)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local Money = LUI.UIText.new(0, 0, 161, 279, -0, 1, 0, 0)
	Money:setRGB(0.76, 0.92, 0.59)
	Money:setTTF("ttmussels_regular")
	Money:setLetterSpacing(8)
	Money:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Money:linkToElementModel(self, "money", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Money:setText(f2_local0)
		end
	end)
	self:addElement(Money)
	self.Money = Money
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterBank.__onClose = function(f3_arg0)
	f3_arg0.VerticalListSpacer:close()
	f3_arg0.VerticalListSpacer2:close()
	f3_arg0.Money:close()
end
