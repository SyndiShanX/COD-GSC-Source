require("x64:4e6143dbc749ffd")
CoD.AARClassRewardCACPreview_ZM = InheritFrom(LUI.UIElement)
CoD.AARClassRewardCACPreview_ZM.__defaultWidth = 380
CoD.AARClassRewardCACPreview_ZM.__defaultHeight = 182
CoD.AARClassRewardCACPreview_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARClassRewardCACPreview_ZM)
	self.id = "AARClassRewardCACPreview_ZM"
	self.soundSet = "default"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.64, 0.24, 0.24)
	Backing:setAlpha(0.04)
	self:addElement(Backing)
	self.Backing = Backing
	local rewardDesc = LUI.UIText.new(0, 0, 17, 364, 0, 0, 146, 164)
	rewardDesc:setRGB(0.75, 0.75, 0.75)
	rewardDesc:setAlpha(0)
	rewardDesc:setTTF("ttmussels_regular")
	rewardDesc:setLetterSpacing(1)
	rewardDesc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rewardDesc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	rewardDesc:linkToElementModel(self, "reward1Desc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			rewardDesc:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(rewardDesc)
	self.rewardDesc = rewardDesc
	local rewardIcon = LUI.UIFixedAspectRatioImage.new(0, 0, 120.5, 260.5, 0, 0, 9, 149)
	rewardIcon:linkToElementModel(self, "reward1Icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			rewardIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(rewardIcon)
	self.rewardIcon = rewardIcon
	local rewardTitle = LUI.UIText.new(0, 0, 17, 357, 0, 0, 149, 170)
	rewardTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	rewardTitle:setTTF("ttmussels_demibold")
	rewardTitle:setLetterSpacing(6)
	rewardTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rewardTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	rewardTitle:linkToElementModel(self, "reward1Title", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			rewardTitle:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(rewardTitle)
	self.rewardTitle = rewardTitle
	local Corner = CoD.AARRewardBrackets.new(f1_arg0, f1_arg1, 0, 0, -1, 381, 0, 0, -1, 183)
	Corner:setAlpha(0.4)
	self:addElement(Corner)
	self.Corner = Corner
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARClassRewardCACPreview_ZM.__onClose = function(f5_arg0)
	f5_arg0.rewardDesc:close()
	f5_arg0.rewardIcon:close()
	f5_arg0.rewardTitle:close()
	f5_arg0.Corner:close()
end
