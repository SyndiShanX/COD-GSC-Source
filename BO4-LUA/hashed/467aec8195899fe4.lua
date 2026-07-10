CoD.PlayerStatsMerits = InheritFrom(LUI.UIElement)
CoD.PlayerStatsMerits.__defaultWidth = 500
CoD.PlayerStatsMerits.__defaultHeight = 18
CoD.PlayerStatsMerits.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerStatsMerits)
	self.id = "PlayerStatsMerits"
	self.soundSet = "default"
	local TypeText = LUI.UIText.new(0, 0, 0, 116, 0, 0, 0, 18)
	TypeText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TypeText:setText("")
	TypeText:setTTF("ttmussels_demibold")
	TypeText:setLetterSpacing(1)
	TypeText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(TypeText)
	self.TypeText = TypeText
	local MeritsValue = LUI.UIText.new(0, 0, 191, 390, 0, 0, 0, 18)
	MeritsValue:setRGB(0.69, 0.56, 0.04)
	MeritsValue:setTTF("ttmussels_demibold")
	MeritsValue:setLetterSpacing(1)
	MeritsValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MeritsValue:linkToElementModel(self, "statMerits", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MeritsValue:setText(f2_local0)
		end
	end)
	self:addElement(MeritsValue)
	self.MeritsValue = MeritsValue
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerStatsMerits.__onClose = function(f3_arg0)
	f3_arg0.MeritsValue:close()
end
