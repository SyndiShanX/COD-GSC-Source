require("x64:9fc49de026d9299")
CoD[0xAEBB28681A82F4D] = InheritFrom(LUI.UIElement)
CoD[0xAEBB28681A82F4D].__defaultWidth = 720
CoD[0xAEBB28681A82F4D].__defaultHeight = 180
CoD[0xAEBB28681A82F4D].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0xAEBB28681A82F4D])
	self.id = "CallingCards_LegendaryImage"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local CardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CardIcon:setImage(RegisterImage(0x434A15996B65B48))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local CallingCardsGoldFrame = CoD.CallingCards_GoldFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CallingCardsGoldFrame)
	self.CallingCardsGoldFrame = CallingCardsGoldFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0xAEBB28681A82F4D].__onClose = function(f2_arg0)
	f2_arg0.CallingCardsGoldFrame:close()
end
