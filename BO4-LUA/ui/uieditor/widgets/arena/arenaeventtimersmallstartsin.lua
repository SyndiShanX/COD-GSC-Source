CoD.ArenaEventTimerSmallStartsIn = InheritFrom(LUI.UIElement)
CoD.ArenaEventTimerSmallStartsIn.__defaultWidth = 140
CoD.ArenaEventTimerSmallStartsIn.__defaultHeight = 14
CoD.ArenaEventTimerSmallStartsIn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaEventTimerSmallStartsIn)
	self.id = "ArenaEventTimerSmallStartsIn"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EventStartsIn = LUI.UIText.new(0, 0, 0, 140, 0, 0, 0, 14)
	EventStartsIn:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EventStartsIn:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	EventStartsIn:setTTF("dinnext_regular")
	EventStartsIn:setLetterSpacing(1)
	EventStartsIn:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	EventStartsIn:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(EventStartsIn)
	self.EventStartsIn = EventStartsIn
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
CoD.ArenaEventTimerSmallStartsIn.__resetProperties = function(f4_arg0)
	f4_arg0.EventStartsIn:completeAnimation()
	f4_arg0.EventStartsIn:setTopBottom(0, 0, 0, 14)
end
CoD.ArenaEventTimerSmallStartsIn.__clipsPerState = {
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
			f6_arg0.EventStartsIn:completeAnimation()
			f6_arg0.EventStartsIn:setTopBottom(0, 0, 4, 14)
			f6_arg0.clipFinished(f6_arg0.EventStartsIn)
		end,
	},
	RussianLanguage = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.EventStartsIn:completeAnimation()
			f7_arg0.EventStartsIn:setTopBottom(0, 0, 4, 14)
			f7_arg0.clipFinished(f7_arg0.EventStartsIn)
		end,
	},
}
