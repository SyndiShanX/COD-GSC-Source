CoD.PlayerStatsDetailed = InheritFrom(LUI.UIElement)
CoD.PlayerStatsDetailed.__defaultWidth = 302
CoD.PlayerStatsDetailed.__defaultHeight = 21
CoD.PlayerStatsDetailed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerStatsDetailed)
	self.id = "PlayerStatsDetailed"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatHeaderText = LUI.UIText.new(0, 0, 107, 302, 0.5, 0.5, -9, 9)
	StatHeaderText:setText(LocalizeToUpperString(0x0))
	StatHeaderText:setTTF("ttmussels_demibold")
	StatHeaderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatHeaderText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(StatHeaderText)
	self.StatHeaderText = StatHeaderText
	local StatValue = LUI.UIText.new(0, 0, 0, 98, 0.5, 0.5, -10.5, 10.5)
	StatValue:setRGB(0.69, 0.56, 0.04)
	StatValue:setText("")
	StatValue:setTTF("ttmussels_demibold")
	StatValue:setLetterSpacing(1)
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(StatValue)
	self.StatValue = StatValue
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerStatsDetailed.__resetProperties = function(f3_arg0)
	f3_arg0.StatHeaderText:completeAnimation()
	f3_arg0.StatHeaderText:setTopBottom(0.5, 0.5, -9, 9)
	f3_arg0.StatHeaderText:setLetterSpacing(0)
end
CoD.PlayerStatsDetailed.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.StatHeaderText:completeAnimation()
			f5_arg0.StatHeaderText:setTopBottom(0.5, 0.5, -7, 7)
			f5_arg0.StatHeaderText:setLetterSpacing(1)
			f5_arg0.clipFinished(f5_arg0.StatHeaderText)
		end,
	},
}
