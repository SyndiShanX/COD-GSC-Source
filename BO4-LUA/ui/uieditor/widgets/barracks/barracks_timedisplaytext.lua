CoD.Barracks_TimeDisplayText = InheritFrom(LUI.UIElement)
CoD.Barracks_TimeDisplayText.__defaultWidth = 250
CoD.Barracks_TimeDisplayText.__defaultHeight = 15
CoD.Barracks_TimeDisplayText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Barracks_TimeDisplayText)
	self.id = "Barracks_TimeDisplayText"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DailyTimerText = LUI.UIText.new(1, 1, -250, 0, 1, 1, -15, 0)
	DailyTimerText:setText(Engine[0xF9F1239CFD921FE](0xC0CE2452CF87DB1))
	DailyTimerText:setTTF("ttmussels_demibold")
	DailyTimerText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	DailyTimerText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(DailyTimerText)
	self.DailyTimerText = DailyTimerText
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
CoD.Barracks_TimeDisplayText.__resetProperties = function(f3_arg0)
	f3_arg0.DailyTimerText:completeAnimation()
	f3_arg0.DailyTimerText:setLeftRight(1, 1, -250, 0)
	f3_arg0.DailyTimerText:setTopBottom(1, 1, -15, 0)
	f3_arg0.DailyTimerText:setLetterSpacing(0)
end
CoD.Barracks_TimeDisplayText.__clipsPerState = {
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
			f5_arg0.DailyTimerText:completeAnimation()
			f5_arg0.DailyTimerText:setLeftRight(1, 1, -258, -8)
			f5_arg0.DailyTimerText:setTopBottom(1, 1, -12, 0)
			f5_arg0.DailyTimerText:setLetterSpacing(1)
			f5_arg0.clipFinished(f5_arg0.DailyTimerText)
		end,
	},
}
