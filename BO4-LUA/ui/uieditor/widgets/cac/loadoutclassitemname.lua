require("x64:13633ff3df9547a")
CoD.LoadoutClassItemName = InheritFrom(LUI.UIElement)
CoD.LoadoutClassItemName.__defaultWidth = 384
CoD.LoadoutClassItemName.__defaultHeight = 44
CoD.LoadoutClassItemName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Bottom)
	self:setClass(CoD.LoadoutClassItemName)
	self.id = "LoadoutClassItemName"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Mark2BonusExpBadge = CoD.Mark2BonusExpBadge.new(f1_arg0, f1_arg1, 0, 0, 26, 286, 0, 0, 26, 44)
	Mark2BonusExpBadge:setScale(1.2, 1.2)
	Mark2BonusExpBadge:linkToElementModel(self, nil, false, function(model)
		Mark2BonusExpBadge:setModel(model, f1_arg1)
	end)
	self:addElement(Mark2BonusExpBadge)
	self.Mark2BonusExpBadge = Mark2BonusExpBadge
	local itemName = LUI.UIText.new(0, 0, 0, 192, 0, 0, 0, 26)
	itemName:setRGB(0.92, 0.92, 0.92)
	itemName:setTTF("ttmussels_demibold")
	itemName:setLetterSpacing(4)
	itemName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	itemName:setBackingType(2)
	itemName:setBackingColor(0, 0, 0)
	itemName:setBackingAlpha(0.95)
	itemName:setBackingXPadding(4)
	itemName:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			itemName:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(itemName)
	self.itemName = itemName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadoutClassItemName.__onClose = function(f4_arg0)
	f4_arg0.Mark2BonusExpBadge:close()
	f4_arg0.itemName:close()
end
