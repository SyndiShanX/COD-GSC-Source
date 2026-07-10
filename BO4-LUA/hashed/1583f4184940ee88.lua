require("x64:19c1945d2e472b0")
CoD.WarzoneInventoryUnlockMissionReward = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryUnlockMissionReward.__defaultWidth = 310
CoD.WarzoneInventoryUnlockMissionReward.__defaultHeight = 52
CoD.WarzoneInventoryUnlockMissionReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryUnlockMissionReward)
	self.id = "WarzoneInventoryUnlockMissionReward"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -4, 2)
	bg:setRGB(0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 67, 0, 0, -4, 54)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local unlockableIcon = LUI.UIFixedAspectRatioImage.new(0, 0, -4, 72, 0, 0, -3, 49)
	unlockableIcon:setScale(1.2, 1.2)
	self:addElement(unlockableIcon)
	self.unlockableIcon = unlockableIcon
	local quote = LUI.UIText.new(0, 0, 70, 306, 0, 0, 2, 17)
	quote:setRGB(ColorSet.T8__BUTTON__UNSELECTED__HEADER.r, ColorSet.T8__BUTTON__UNSELECTED__HEADER.g, ColorSet.T8__BUTTON__UNSELECTED__HEADER.b)
	quote:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	quote:setTTF("ttmussels_regular")
	quote:setLetterSpacing(1)
	quote:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	quote:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(quote)
	self.quote = quote
	local rewardName = LUI.UIText.new(1, 1, -240, -4, 1, 1, -15, 0)
	rewardName:setRGB(ColorSet.T8__BUTTON__UNSELECTED__HEADER.r, ColorSet.T8__BUTTON__UNSELECTED__HEADER.g, ColorSet.T8__BUTTON__UNSELECTED__HEADER.b)
	rewardName:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	rewardName:setTTF("ttmussels_regular")
	rewardName:setLetterSpacing(1)
	rewardName:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	rewardName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(rewardName)
	self.rewardName = rewardName
	self:mergeStateConditions({
		{
			stateName = "AsianLanguages",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryUnlockMissionReward.__resetProperties = function(f3_arg0)
	f3_arg0.quote:completeAnimation()
	f3_arg0.rewardName:completeAnimation()
	f3_arg0.quote:setTopBottom(0, 0, 2, 17)
	f3_arg0.rewardName:setTopBottom(1, 1, -15, 0)
end
CoD.WarzoneInventoryUnlockMissionReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguages = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.quote:completeAnimation()
			f5_arg0.quote:setTopBottom(0, 0, 2, 13)
			f5_arg0.clipFinished(f5_arg0.quote)
			f5_arg0.rewardName:completeAnimation()
			f5_arg0.rewardName:setTopBottom(1, 1, -12, 0)
			f5_arg0.clipFinished(f5_arg0.rewardName)
		end,
	},
}
CoD.WarzoneInventoryUnlockMissionReward.__onClose = function(f6_arg0)
	f6_arg0.DotTiledBacking:close()
end
