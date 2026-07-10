require("x64:7dacefed967e3df")
CoD.DirectorTierSkipNotificationAvailableInternal = InheritFrom(LUI.UIElement)
CoD.DirectorTierSkipNotificationAvailableInternal.__defaultWidth = 650
CoD.DirectorTierSkipNotificationAvailableInternal.__defaultHeight = 80
CoD.DirectorTierSkipNotificationAvailableInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTierSkipNotificationAvailableInternal)
	self.id = "DirectorTierSkipNotificationAvailableInternal"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.CommonBackingWithBrackets.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local Header = LUI.UIText.new(0, 0, 56, 642, 0, 0, 5, 29)
	Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Header:setText(LocalizeToUpperString(0x7AA3CA056EF6DC5))
	Header:setTTF("ttmussels_regular")
	Header:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Header:setLetterSpacing(3)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Header)
	self.Header = Header
	local Description = LUI.UIText.new(0, 0, 56, 642, 0, 0, 33.5, 49.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(CoD.WZUtility.TrialSpecificTierSkip(0x1F79A8E72177799))
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(1)
	Description:setLineSpacing(1)
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	self:mergeStateConditions({
		{
			stateName = "Korea15",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCKoreaUtility.ShowKorea15Plus()
			end,
		},
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
		{
			stateName = "RussianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageRussian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTierSkipNotificationAvailableInternal.__resetProperties = function(f5_arg0)
	f5_arg0.Description:completeAnimation()
	f5_arg0.Header:completeAnimation()
	f5_arg0.Description:setTopBottom(0, 0, 33.5, 49.5)
	f5_arg0.Description:setText(CoD.WZUtility.TrialSpecificTierSkip(0x1F79A8E72177799))
	f5_arg0.Header:setTopBottom(0, 0, 5, 29)
end
CoD.DirectorTierSkipNotificationAvailableInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Korea15 = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Description:completeAnimation()
			f7_arg0.Description:setText(CoD.WZUtility.TrialSpecificTierSkip(0xF8EF1BE7608E431))
			f7_arg0.clipFinished(f7_arg0.Description)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Header:completeAnimation()
			f8_arg0.Header:setTopBottom(0, 0, 11, 25)
			f8_arg0.clipFinished(f8_arg0.Header)
			f8_arg0.Description:completeAnimation()
			f8_arg0.Description:setTopBottom(0, 0, 35.5, 47.5)
			f8_arg0.clipFinished(f8_arg0.Description)
		end,
	},
	RussianLanguage = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.Header:completeAnimation()
			f9_arg0.Header:setTopBottom(0, 0, 11, 30)
			f9_arg0.clipFinished(f9_arg0.Header)
			f9_arg0.Description:completeAnimation()
			f9_arg0.Description:setTopBottom(0, 0, 35.5, 51.5)
			f9_arg0.clipFinished(f9_arg0.Description)
		end,
	},
}
CoD.DirectorTierSkipNotificationAvailableInternal.__onClose = function(f10_arg0)
	f10_arg0.Backing:close()
end
