CoD.SpecialEventRewardWidget = InheritFrom(LUI.UIElement)
CoD.SpecialEventRewardWidget.__defaultWidth = 150
CoD.SpecialEventRewardWidget.__defaultHeight = 56
CoD.SpecialEventRewardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 2, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.SpecialEventRewardWidget)
	self.id = "SpecialEventRewardWidget"
	self.soundSet = "default"
	local RewardIcon = LUI.UIImage.new(0, 0, 0, 56, 0, 0, 0, 56)
	RewardIcon:linkToElementModel(self, "rewardImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RewardIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(RewardIcon)
	self.RewardIcon = RewardIcon
	local RewardQuantityText = LUI.UIText.new(0, 0, 58, 144, 0, 0, 22, 36)
	RewardQuantityText:setTTF("dinnext_regular")
	RewardQuantityText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RewardQuantityText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	RewardQuantityText:linkToElementModel(self, "rewardText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RewardQuantityText:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(RewardQuantityText)
	self.RewardQuantityText = RewardQuantityText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialEventRewardWidget.__onClose = function(f4_arg0)
	f4_arg0.RewardIcon:close()
	f4_arg0.RewardQuantityText:close()
end
