CoD.PaintCanCost = InheritFrom(LUI.UIElement)
CoD.PaintCanCost.__defaultWidth = 480
CoD.PaintCanCost.__defaultHeight = 27
CoD.PaintCanCost.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintCanCost)
	self.id = "PaintCanCost"
	self.soundSet = "none"
	local PaintCanCost = LUI.UIText.new(0, 0, 0, 480, 0, 0, -5, 13)
	PaintCanCost:setRGB(0.8, 0.79, 0.78)
	PaintCanCost:setTTF("ttmussels_regular")
	PaintCanCost:setLetterSpacing(1)
	PaintCanCost:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PaintCanCost:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	PaintCanCost:linkToElementModel(self, "paintCanCost", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PaintCanCost:setText(LocalizeIntoString(0xDF564F24968E2DB, f2_local0))
		end
	end)
	self:addElement(PaintCanCost)
	self.PaintCanCost = PaintCanCost
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	if IsCurrentLanguageReversed() then
		ReverseChildrenOrder(self)
	end
	return self
end
CoD.PaintCanCost.__onClose = function(f3_arg0)
	f3_arg0.PaintCanCost:close()
end
