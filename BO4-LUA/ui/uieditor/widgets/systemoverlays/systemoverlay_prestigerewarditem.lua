CoD.systemOverlay_PrestigeRewardItem = InheritFrom(LUI.UIElement)
CoD.systemOverlay_PrestigeRewardItem.__defaultWidth = 160
CoD.systemOverlay_PrestigeRewardItem.__defaultHeight = 175
CoD.systemOverlay_PrestigeRewardItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_PrestigeRewardItem)
	self.id = "systemOverlay_PrestigeRewardItem"
	self.soundSet = "default"
	local RewardImage = LUI.UIImage.new(0, 0, 10, 150, 0, 0, 0, 140)
	RewardImage:linkToElementModel(self, "rewardImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RewardImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(RewardImage)
	self.RewardImage = RewardImage
	local RewardLabel = LUI.UIText.new(0, 1, 0, 0, 0, 0, 142, 160)
	RewardLabel:setTTF("ttmussels_regular")
	RewardLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RewardLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RewardLabel:linkToElementModel(self, "rewardText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RewardLabel:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(RewardLabel)
	self.RewardLabel = RewardLabel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_PrestigeRewardItem.__onClose = function(f4_arg0)
	f4_arg0.RewardImage:close()
	f4_arg0.RewardLabel:close()
end
