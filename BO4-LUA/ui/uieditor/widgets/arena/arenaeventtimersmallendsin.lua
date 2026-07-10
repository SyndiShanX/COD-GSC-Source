CoD.ArenaEventTimerSmallEndsIn = InheritFrom(LUI.UIElement)
CoD.ArenaEventTimerSmallEndsIn.__defaultWidth = 140
CoD.ArenaEventTimerSmallEndsIn.__defaultHeight = 14
CoD.ArenaEventTimerSmallEndsIn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaEventTimerSmallEndsIn)
	self.id = "ArenaEventTimerSmallEndsIn"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EventEndsIn = LUI.UIText.new(0, 0, 0, 140, 0, 0, 0, 14)
	EventEndsIn:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EventEndsIn:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	EventEndsIn:setTTF("dinnext_regular")
	EventEndsIn:setLetterSpacing(1)
	EventEndsIn:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EventEndsIn:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(EventEndsIn)
	self.EventEndsIn = EventEndsIn
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
CoD.ArenaEventTimerSmallEndsIn.__resetProperties = function(f4_arg0)
	f4_arg0.EventEndsIn:completeAnimation()
	f4_arg0.EventEndsIn:setTopBottom(0, 0, 0, 14)
end
CoD.ArenaEventTimerSmallEndsIn.__clipsPerState = {
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
			f6_arg0.EventEndsIn:completeAnimation()
			f6_arg0.EventEndsIn:setTopBottom(0, 0, 4, 14)
			f6_arg0.clipFinished(f6_arg0.EventEndsIn)
		end,
	},
	RussianLanguage = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.EventEndsIn:completeAnimation()
			f7_arg0.EventEndsIn:setTopBottom(0, 0, 4, 14)
			f7_arg0.clipFinished(f7_arg0.EventEndsIn)
		end,
	},
}
