CoD.ArenaDailyBonusLabel = InheritFrom(LUI.UIElement)
CoD.ArenaDailyBonusLabel.__defaultWidth = 133
CoD.ArenaDailyBonusLabel.__defaultHeight = 16
CoD.ArenaDailyBonusLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaDailyBonusLabel)
	self.id = "ArenaDailyBonusLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DailyBonusLabel = LUI.UIText.new(0, 0, 0, 133, 1, 1, -16, 0)
	DailyBonusLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DailyBonusLabel:setText(LocalizeToUpperString(@"hash_23A39A667C596A46"))
	DailyBonusLabel:setTTF("ttmussels_regular")
	DailyBonusLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DailyBonusLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(DailyBonusLabel)
	self.DailyBonusLabel = DailyBonusLabel
	self:mergeStateConditions({
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
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaDailyBonusLabel.__resetProperties = function(f4_arg0)
	f4_arg0.DailyBonusLabel:completeAnimation()
	f4_arg0.DailyBonusLabel:setTopBottom(1, 1, -16, 0)
end
CoD.ArenaDailyBonusLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DailyBonusLabel:completeAnimation()
			f6_arg0.DailyBonusLabel:setTopBottom(1, 1, -13, 0)
			f6_arg0.clipFinished(f6_arg0.DailyBonusLabel)
		end,
	},
	RussianLanguage = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.DailyBonusLabel:completeAnimation()
			f7_arg0.DailyBonusLabel:setTopBottom(1, 1, -14, 0)
			f7_arg0.clipFinished(f7_arg0.DailyBonusLabel)
		end,
	},
}
